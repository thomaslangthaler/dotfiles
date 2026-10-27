-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                     Monitor Configuration                   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Desk layout: HDMI-A-1 sits above DP-4, DP-1 to the right of DP-4
hl.monitor({ output = "DP-4",     mode = "1920x1080@60", position = "0x0",     scale = 1 })
hl.monitor({ output = "DP-1",     mode = "1920x1080@60", position = "1920x0",  scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x-1080", scale = 1 })

-- Fallback for any other monitor
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- If you need to scale things like steam etc, please uncomment these lines.
-- hl.config({
--     xwayland = {
--         force_zero_scaling = true, -- Unscale XWayland
--     },
-- })

-- Adjust GDK_SCALE accordingly to your liking.
-- hl.env("GDK_SCALE", "2") -- GDK Scaling Factor (no fractional scaling)
