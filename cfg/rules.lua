local awful = require("awful")
awful.rules = require("awful.rules")
local beautiful = require("beautiful")
local clientbinds = require("cfg.client-bindings")

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
  { rule = { class = "mpv" },
    properties = {
      floating = true,
      centered = true
    }
  },
  { rule = { class = "Xephyr" },
    properties = {
      floating = true,
      centered = true
    }
  }
}

