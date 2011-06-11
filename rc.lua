-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
require("awful.remote")
-- Theme handling library
require("beautiful")
beautiful.init(awful.util.getdir("config") .. "/theme/theme.lua")
-- Notification library
require("naughty")

-- Misc. settings and tools
require("cfg.misc")
-- Load layouts and tags
require("cfg.tags")
-- Load wibox
require("cfg.wibox")

-- Key bindings
require("cfg.global-bindings")
require("cfg.client-bindings")

-- Set keys and buttons
root.keys(globalkeys)
root.buttons(globalbuttons)

require("cfg.rules")

shifty.init()
