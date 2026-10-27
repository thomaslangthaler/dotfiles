-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Decorations Configuration                ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration

hl.config({
    decoration = {
        active_opacity = 1,
        rounding = 4,

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
        blur = {
            size = 15,
            passes = 2, -- more passes = more resource intensive.
            xray = true,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#shadow
        shadow = {
            enabled = false,
        },
    },
})
