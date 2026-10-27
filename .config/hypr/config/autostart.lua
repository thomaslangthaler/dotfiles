-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Autostart Configuration                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- Autostart wiki https://wiki.hypr.land/Configuring/Basics/Autostart/
-- hl.exec_cmd already runs each command detached, so no trailing & is needed.

local defaults = require("config.defaults")

hl.on("hyprland.start", function()
    -- ## Environment for D-Bus activated and systemd user services (first, so
    -- ## everything started below sees it; fixes slow app launches)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE HYPRLAND_INSTANCE_SIGNATURE")

    -- ## Desktop services
    hl.exec_cmd([[swaybg -o \* -i /usr/share/wallpapers/cachyos-wallpapers/Metal.png -m fill]])
    hl.exec_cmd("waybar")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("mako")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

    -- ## OSD for volume (see scripts/volume.sh): wob reads levels from this FIFO
    hl.exec_cmd([[sh -c 'f=/tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob; rm -f "$f"; mkfifo "$f" && tail -f "$f" | wob']])

    -- ## Clipboard history
    hl.exec_cmd("wl-paste --type text --watch cliphist store")  -- Stores only text
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only images

    -- ## Idle configuration
    hl.exec_cmd(defaults.idlehandler)

    -- ## i3-style workspace stacking (see scripts/workspace-stack.py)
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/workspace-stack.py")

    -- ## My autostarts (workspace assignment lives in windowrules.lua)
    hl.exec_cmd("librewolf")
    hl.exec_cmd("flatpak run org.ferdium.Ferdium")
    hl.exec_cmd("flatpak run org.signal.Signal")
    hl.exec_cmd("thunderbird")
    hl.exec_cmd("flatpak run dev.pulsar_edit.Pulsar")
    -- hl.exec_cmd("flatpak run com.logseq.Logseq")
    hl.exec_cmd("flatpak run com.spotify.Client")
    hl.exec_cmd("flatpak run com.bitwarden.desktop")
end)
