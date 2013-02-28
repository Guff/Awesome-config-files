local awful = require("awful")
local naught = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor
browser = "luakit"

modkey = "Mod4"

-- Start theme
beautiful.init(awful.util.getdir("config") .. "/theme/theme.lua")

-- Misc. settings and tools
require("cfg.misc")
-- Load layouts and tags
require("cfg.tags")
require("cfg.rules")
require("misc.notifications")
-- Load wibox
require("cfg.wibox")
require("cfg.signals")

-- Key bindings
require("cfg.global-bindings")
