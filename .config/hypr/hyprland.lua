-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                 CachyOS Hyprland Configuration              ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- Shared definitions first: colors (cachy*) and defaults (terminal, locker, ...)
require("config.colors")
require("config.defaults")

require("config.animations")
require("config.autostart")
require("config.decorations")
require("config.environment")
require("config.input")
require("config.keybinds")
require("config.monitor")
require("config.variables")
require("config.windowrules")

-- Modifying these configs can be done by creating a user defined config, e.g.
-- ~/.config/hypr/config/user-config.lua
-- require("config.user-config")
