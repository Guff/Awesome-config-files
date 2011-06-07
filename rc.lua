-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
require("awful.remote")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Misc. settings and tools
require("cfg.misc")
-- Load theme
require("cfg.theme")
-- Load layouts and tags
require("cfg.tags")
-- Load wibox
require("cfg.bar")

-- Key bindings
require("cfg.global-bindings")
require("cfg.client-bindings")

-- Set keys and buttons
root.keys(globalkeys)
root.buttons(globalbuttons)

require("cfg.rules")
shifty.init()
