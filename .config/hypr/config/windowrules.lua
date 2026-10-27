-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Windowrules Configuration                ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- Windows Rules https://wiki.hypr.land/Configuring/Basics/Window-Rules/ #

-- Float Necessary Windows
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true })
hl.window_rule({ match = { class = "^()$", title = "^(Picture in picture)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "^(CachyOSHello)$" }, float = true })
hl.window_rule({ match = { class = "^(zenity)$" }, float = true })

-- Increase the opacity
hl.window_rule({ match = { class = "^(thunar|nemo)$" }, opacity = "0.92" })
hl.window_rule({ match = { class = "^(discord|armcord|webcord)$" }, opacity = "0.96" })
hl.window_rule({ match = { title = "^(QQ|Telegram)$" }, opacity = "0.95" })
hl.window_rule({ match = { title = "^(NetEase Cloud Music Gtk4)$" }, opacity = "0.95" })

-- General window rules
hl.window_rule({
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    size = { 960, 540 },
    move = { "monitor_w*0.25", "monitor_h*0.25" },
})
-- Media viewers (matched by class; their titles are the file name)
hl.window_rule({
    match = { class = "^(imv|mpv)$" },
    float = true,
    move = { "monitor_w*0.25", "monitor_h*0.25" },
    size = { 960, 540 },
})
-- Floating terminals (matched by the title they are launched with)
hl.window_rule({
    match = { title = "^(danmufloat|termfloat|ncmpcpp)$" },
    float = true,
    move = { "monitor_w*0.25", "monitor_h*0.25" },
    size = { 960, 540 },
})
hl.window_rule({ match = { title = "^(danmufloat)$" }, pin = true })
hl.window_rule({ match = { title = "^(danmufloat|termfloat)$" }, rounding = 5 })
hl.window_rule({ match = { class = "^(kitty|Alacritty)$" }, animation = "slide right" })
hl.window_rule({ match = { class = "^(org.mozilla.firefox)$" }, no_blur = true })

-- Assign autostarted apps to workspaces (class names from `hyprctl clients`)
hl.window_rule({ match = { class = "^(librewolf)$" }, workspace = "1 silent" })
hl.window_rule({ match = { class = "^(ferdium)$" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "^(org.signal.Signal)$" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "^(org.mozilla.Thunderbird)$" }, workspace = "3 silent" })
hl.window_rule({ match = { class = "^(Pulsar)$" }, workspace = "4 silent" })
hl.window_rule({ match = { class = "^(?i:logseq)$" }, workspace = "7 silent" })
hl.window_rule({ match = { class = "^(spotify)$" }, workspace = "8 silent" })
hl.window_rule({ match = { class = "^(bitwarden)$" }, workspace = "10 silent" })

-- Windows Rules End #

-- Workspaces Rules https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ #
-- Workspaces Rules End #
