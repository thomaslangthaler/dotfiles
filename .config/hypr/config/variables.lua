-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Variables Configuration                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local c = require("config.colors")

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 5,
        border_size = 3,
        col = {
            active_border = c.cachylgreen,
            inactive_border = c.cachymblue,
        },
        layout = "dwindle", -- master|dwindle

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#snap
        snap = {
            enabled = true,
        },
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#group
    group = {
        col = {
            border_active = c.cachydgreen,
            border_inactive = c.cachylgreen,
            border_locked_active = c.cachymgreen,
            border_locked_inactive = c.cachydblue,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#groupbar
        groupbar = {
            font_family = "Fira Sans",
            text_color = c.cachydblue,
            col = {
                active = c.cachydgreen,
                inactive = c.cachylgreen,
                locked_active = c.cachymgreen,
                locked_inactive = c.cachydblue,
            },
        },
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
    misc = {
        font_family = "Fira Sans",
        splash_font_family = "Fira Sans",
        disable_hyprland_logo = true,
        col = {
            splash = c.cachylgreen,
        },
        background_color = c.cachydblue,
        enable_swallow = true,
        swallow_regex = "^(nautilus|nemo|thunar|btrfs-assistant)$",
        focus_on_activate = true,
        vrr = 2,
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#render
    render = {
        direct_scanout = true,
    },

    -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
    dwindle = {
        special_scale_factor = 0.8,
        preserve_split = true,
    },

    -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
    master = {
        new_status = "master",
        special_scale_factor = 0.8,
    },
})

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Gestures                                 ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- 4-finger horizontal swipe to switch workspaces
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })

-- 3-finger swipe down closes active window
hl.gesture({ fingers = 3, direction = "down", action = "close" })

-- 3-finger swipe up toggles fullscreen
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen" })

-- 3-finger swipe left toggles float/tile
hl.gesture({ fingers = 3, direction = "left", action = "float" })
