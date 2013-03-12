local awful = require("awful")
awful.rules = require("awful.rules")
local beautiful = require("beautiful")
local clientbinds = require("cfg.client-bindings")
local tyranical = require("tyranical")

awful.rules.rules = {
  -- Rules to all the clients
  { rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys = clientbinds.keys,
      buttons = clientbinds.buttons
    }
  },
}

tyranical.properties.floating = {
  "mplayer2", "Xephyr"
}

tyranical.properties.centered = {
  "mplayer2", "Xephyr"
}
