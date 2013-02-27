-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
require("awful.rules")
require("awful.remote")
-- Theme handling library
local beautiful = require("beautiful")
beautiful.init(awful.util.getdir("config") .. "/theme/theme.lua")
-- Notification library
local naughty = require("naughty")

-- Misc. settings and tools
require("cfg.misc")
-- Load layouts and tags
require("cfg.tags")
require("misc.notifications")
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
