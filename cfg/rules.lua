local awful = require("awful")
awful.rules = require("awful.rules")
local beautiful = require("beautiful")
local clientkeys, clientbuttons = require("cfg.client-bindings")

awful.rules.rules = {
  -- Rules to all the clients
  { rule = { },
    proprieties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys = clientkeys,
      buttons = clientbuttons
    }
  },
  -- TODO: Make Mplayer spawn centered
  { rule = { class = "MPlayer" },
    proprieties = {
      floating = true,
    }
  }
}
