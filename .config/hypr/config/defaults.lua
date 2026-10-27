-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                     Defaults Configuration                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

local d = {
    -- General
    filemanager = "nemo",
    applauncher = "wofi",
    terminal    = "alacritty",
    locker      = "pidof hyprlock || hyprlock",

    -- Pixels per keypress when resizing windows
    resizeStep = 80,

    -- Screenshots
    shot_region = scripts .. "/screenshot area",
    shot_window = scripts .. "/screenshot window",
    shot_screen = scripts .. "/screenshot output",
}

-- Lock after 5 min idle, turn the screens off after 10 min (and back on at the first input)
d.idlehandler = "swayidle -w timeout 300 '" .. d.locker .. "'"
    .. " timeout 600 '" .. scripts .. "/dpms.sh off'"
    .. " resume '" .. scripts .. "/dpms.sh on'"
    .. " before-sleep '" .. d.locker .. "'"

return d
