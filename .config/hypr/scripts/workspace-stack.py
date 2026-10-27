#!/usr/bin/env python3
"""i3-style workspace stacking for Hyprland.

When a workspace is moved to another monitor, Hyprland leaves the source
monitor on a fresh empty workspace. i3 instead shows the workspace that was
visible there before. This daemon restores that behaviour: it keeps a
most-recently-used list of workspaces per monitor and, after a workspace
leaves a monitor, switches that monitor back to its previous workspace.

Run it once per session (see autostart.conf). Set WS_STACK_DEBUG=1 to log.
"""
import json
import os
import select
import socket
import subprocess
import sys
import time

MAX_HISTORY = 16
# Events after which the per-monitor history is brought up to date.
REFRESH_EVENTS = {
    "workspacev2", "focusedmonv2", "moveworkspacev2",
    "createworkspacev2", "destroyworkspacev2",
    "monitoraddedv2", "monitorremoved",
}
# Seconds to wait for more events after one arrives, and the cap on that wait.
SETTLE = 0.03
MAX_BATCH_WAIT = 0.1
DEBUG = bool(os.environ.get("WS_STACK_DEBUG"))

# monitor name -> workspace ids, most recently shown first
mru: dict[str, list[int]] = {}


def log(*args):
    if DEBUG:
        print("[workspace-stack]", *args, file=sys.stderr, flush=True)


def hyprctl(*args):
    out = subprocess.run(["hyprctl", *args], capture_output=True, text=True, check=True)
    return out.stdout


def query(what):
    return json.loads(hyprctl("-j", what))


def push(monitor, ws):
    lst = mru.setdefault(monitor, [])
    if lst and lst[0] == ws:
        return
    if ws in lst:
        lst.remove(ws)
    lst.insert(0, ws)
    del lst[MAX_HISTORY:]


def refresh():
    for m in query("monitors"):
        ws = m["activeWorkspace"]["id"]
        if ws > 0:
            push(m["name"], ws)


def on_move(ws, dest):
    """Workspace `ws` was moved to monitor `dest`."""
    # History as it was before the move; Hyprland has already picked its own
    # fallback workspace on the source monitor by the time we refresh.
    before = {name: list(history) for name, history in mru.items()}
    time.sleep(0.05)  # let Hyprland finish the move before looking at it
    refresh()
    monitors = {m["name"]: m for m in query("monitors")}
    workspaces = {w["id"]: w for w in query("workspaces")}
    log(f"move: workspace {ws} -> {dest}; history before {before}")
    if workspaces.get(ws, {}).get("monitor") != dest:
        log(f"workspace {ws} is on {workspaces.get(ws, {}).get('monitor')}, not {dest}; ignoring")
        return

    for name, history in before.items():
        if name == dest or name not in monitors:
            continue
        if not history or history[0] != ws:
            continue  # `ws` was not what this monitor was showing
        target = next(
            (w for w in history[1:]
             if w != ws and w in workspaces and workspaces[w]["monitor"] == name),
            None,
        )
        if target is None:
            log(f"{name}: no earlier workspace to return to in {history}")
            continue
        if monitors[name]["activeWorkspace"]["id"] == target:
            continue  # Hyprland already chose the right one

        focused = next((n for n, m in monitors.items() if m["focused"]), name)
        cmds = [f"hl.dispatch(hl.dsp.focus({{ workspace = {target} }}))"]
        if focused != name:
            cmds = [f'hl.dispatch(hl.dsp.focus({{ monitor = "{name}" }}))', *cmds,
                    f'hl.dispatch(hl.dsp.focus({{ monitor = "{focused}" }}))']
        log(f"{name}: workspace {ws} left for {dest}, showing {target}")
        hyprctl("eval", " ".join(cmds))


def process(lines):
    """Handle a batch of events that arrived together.

    On a workspace move Hyprland first announces its own fallback workspace on
    the source monitor and only then the move itself. Handling moves before
    refreshing keeps the history as it was before Hyprland's choice.
    """
    events = []
    for line in lines:
        log("event:", line)
        event, _, data = line.partition(">>")
        events.append((event, data))

    for event, data in events:
        if event == "moveworkspacev2":
            # data: WORKSPACEID,WORKSPACENAME,MONNAME
            parts = data.split(",")
            on_move(int(parts[0]), parts[-1])
    if any(event in REFRESH_EVENTS and event != "moveworkspacev2" for event, _ in events):
        refresh()


def main():
    runtime = os.environ["XDG_RUNTIME_DIR"]
    signature = os.environ["HYPRLAND_INSTANCE_SIGNATURE"]
    path = f"{runtime}/hypr/{signature}/.socket2.sock"

    refresh()
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
        sock.connect(path)
        buffer = b""
        while True:
            chunk = sock.recv(4096)
            if not chunk:
                return  # Hyprland went away
            buffer += chunk
            # Collect events that follow closely so a move and the fallback
            # switch before it are processed as one batch.
            deadline = time.monotonic() + MAX_BATCH_WAIT
            while time.monotonic() < deadline and select.select([sock], [], [], SETTLE)[0]:
                chunk = sock.recv(4096)
                if not chunk:
                    return
                buffer += chunk
            *lines, buffer = buffer.split(b"\n")
            try:
                process([raw.decode(errors="replace") for raw in lines])
            except Exception as exc:  # keep running on transient errors
                log("error:", exc)


if __name__ == "__main__":
    main()
