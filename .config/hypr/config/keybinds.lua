
-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                         Keybinds                            ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local d = require("config.defaults")

local mainMod = "SUPER"
local step = d.resizeStep
local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

-- https://wiki.hypr.land/Configuring/Basics/Binds/
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(d.terminal), { description = "Opens your preferred terminal emulator (" .. d.terminal .. ")" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(d.filemanager), { description = "Opens your preferred filemanager (" .. d.filemanager .. ")" })
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Closes (not kill) current window" })
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd([[loginctl terminate-user ""]]), { description = "Exits Hyprland by terminating the user sessions" })
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Switches current window between floating and tiling mode" })
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(d.applauncher), { description = "Runs your application launcher" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(), { description = "Toggles current window fullscreen mode" })
hl.bind(mainMod .. " + Y", hl.dsp.window.pin(), { description = "Pin current window (shows on all workspaces)" })
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"), { description = "Toggles current window split mode" })

hl.bind("Print", hl.dsp.exec_cmd(d.shot_region), { description = "Creates a screenshot of an area" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd(d.shot_window), { description = "Creates a screenshot of the active window" })
hl.bind("ALT + Print", hl.dsp.exec_cmd(d.shot_screen), { description = "Creates a screenshot of the active display" })

-- ======= Grouping Windows =======

-- hl.bind(mainMod .. " + K", hl.dsp.group.toggle(), { description = "Toggles current window group mode (ungroup all related)" })
-- hl.bind(mainMod .. " + Tab", hl.dsp.group.next(), { description = "Switches to the next window in the group" })

-- ======= Toggle Gaps =======

hl.bind(mainMod .. " + SHIFT + G", function()
    hl.config({ general = { gaps_out = 5, gaps_in = 3 } })
end, { description = "Set CachyOS default gaps" })
hl.bind(mainMod .. " + G", function()
    hl.config({ general = { gaps_out = 0, gaps_in = 0 } })
end, { description = "Remove gaps between window" })

-- ======= Volume Control =======

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scripts .. "/volume.sh up"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scripts .. "/volume.sh down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(scripts .. "/volume.sh mute"), { locked = true })

-- ======= Playback Control =======

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Toggles play/pause" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { description = "Next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { description = "Previous track" })

-- ======= Screen Brightness =======

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(d.locker), { description = "Lock the screen" })
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("killall -SIGUSR2 waybar"), { description = "Reload/restarts Waybar" })

-- ======= Window Actions =======

-- Move window towards a direction
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "left" }), { description = "Move active window to the left" })
hl.bind(mainMod .. " + SHIFT + semicolon", hl.dsp.window.move({ direction = "right" }), { description = "Move active window to the right" })
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "up" }), { description = "Move active window upwards" })
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "down" }), { description = "Move active window downwards" })
-- Move focus with mainMod + vim keys shifted one right (j k l ;)
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "left" }), { description = "Move focus to the left" })
hl.bind(mainMod .. " + semicolon", hl.dsp.focus({ direction = "right" }), { description = "Move focus to the right" })
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "up" }), { description = "Move focus upwards" })
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "down" }), { description = "Move focus downwards" })

-- Resizing windows
-- Activate keyboard window resize mode
-- https://wiki.hypr.land/Configuring/Basics/Binds/#submaps
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"), { description = "Activates window resizing mode" })
hl.define_submap("resize", function()
    local function resize(x, y)
        return hl.dsp.window.resize({ x = x, y = y, relative = true })
    end
    hl.bind("right",     resize(step, 0),  { description = "Resize to the right (resizing mode)" })
    hl.bind("left",      resize(-step, 0), { description = "Resize to the left (resizing mode)" })
    hl.bind("up",        resize(0, -step), { description = "Resize upwards (resizing mode)" })
    hl.bind("down",      resize(0, step),  { description = "Resize downwards (resizing mode)" })
    hl.bind("semicolon", resize(step, 0),  { description = "Resize to the right (resizing mode)" })
    hl.bind("j",         resize(-step, 0), { description = "Resize to the left (resizing mode)" })
    hl.bind("l",         resize(0, -step), { description = "Resize upwards (resizing mode)" })
    hl.bind("k",         resize(0, step),  { description = "Resize downwards (resizing mode)" })
    hl.bind("escape",    hl.dsp.submap("reset"), { description = "Ends window resizing mode" })
end)
-- Quick resize window with keyboard
-- !!! added mainMod here because CTRL + SHIFT is used for word selection in various text editors
local quick = mainMod .. " + CTRL + SHIFT + "
hl.bind(quick .. "right",     hl.dsp.window.resize({ x = step,  y = 0,     relative = true }), { description = "Resize to the right" })
hl.bind(quick .. "left",      hl.dsp.window.resize({ x = -step, y = 0,     relative = true }), { description = "Resize to the left" })
hl.bind(quick .. "up",        hl.dsp.window.resize({ x = 0,     y = -step, relative = true }), { description = "Resize upwards" })
hl.bind(quick .. "down",      hl.dsp.window.resize({ x = 0,     y = step,  relative = true }), { description = "Resize downwards" })
hl.bind(quick .. "semicolon", hl.dsp.window.resize({ x = step,  y = 0,     relative = true }), { description = "Resize to the right" })
hl.bind(quick .. "j",         hl.dsp.window.resize({ x = -step, y = 0,     relative = true }), { description = "Resize to the left" })
hl.bind(quick .. "l",         hl.dsp.window.resize({ x = 0,     y = -step, relative = true }), { description = "Resize upwards" })
hl.bind(quick .. "k",         hl.dsp.window.resize({ x = 0,     y = step,  relative = true }), { description = "Resize downwards" })
-- Resize window with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
-- Resizing Windows End #

-- Move active window to a workspace with mainMod + CTRL + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = true }),
        { description = "Move window and switch to workspace " .. i })
end
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ workspace = "-1", follow = true }), { description = "Move window and switch to the previous workspace" })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ workspace = "+1", follow = true }), { description = "Move window and switch to the next workspace" })
-- Same as above, but doesn't switch to the workspace
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }),
        { description = "Move window silently to workspace " .. i })
end
-- Window actions End #

-- ======= Workspace Actions =======

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Switch to workspace " .. i })
end
-- Scroll through existing workspaces with mainMod + , or .
hl.bind(mainMod .. " + PERIOD", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll through workspaces incrementally" })
hl.bind(mainMod .. " + COMMA",  hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll through workspaces decrementally" })
-- With mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll through workspaces incrementally" })
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll through workspaces decrementally" })
hl.bind(mainMod .. " + slash", hl.dsp.focus({ workspace = "previous" }), { description = "Switch to the previous workspace" })
-- Special workspaces (scratchpads)
hl.bind(mainMod .. " + minus", hl.dsp.window.move({ workspace = "special:special", follow = true }), { description = "Move active window to Special workspace" })
hl.bind(mainMod .. " + equal", hl.dsp.workspace.toggle_special("special"), { description = "Toggles the Special workspace" })
hl.bind(mainMod .. " + F1", hl.dsp.workspace.toggle_special("scratchpad"), { description = "Call special workspace scratchpad" })
hl.bind(mainMod .. " + ALT + SHIFT + F1", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }), { description = "Move active window to special workspace scratchpad" })

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("(" .. d.locker .. ") & sleep 1 && systemctl suspend"), { description = "suspend" })

-- ======= Monitor Actions =======

-- Send the current workspace to the monitor in that direction
hl.bind(mainMod .. " + CTRL + j",         hl.dsp.workspace.move({ monitor = "l" }), { description = "Send workspace to the left monitor" })
hl.bind(mainMod .. " + CTRL + semicolon", hl.dsp.workspace.move({ monitor = "r" }), { description = "Send workspace to the right monitor" })
hl.bind(mainMod .. " + CTRL + l",         hl.dsp.workspace.move({ monitor = "u" }), { description = "Send workspace to the monitor above" })
hl.bind(mainMod .. " + CTRL + k",         hl.dsp.workspace.move({ monitor = "d" }), { description = "Send workspace to the monitor below" })

-- ======= Additional Settings =======

-- https://wiki.hypr.land/Configuring/Basics/Binds
hl.config({
    binds = {
        allow_workspace_cycles = true,
        workspace_back_and_forth = true,
        workspace_center_on = 1,
        movefocus_cycles_fullscreen = true,
        window_direction_monitor_fallback = true,
    },
})
