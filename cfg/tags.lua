local awful = require("awful")
local tyranical = require("tyranical")

layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier
}

mytags = { "main", "www", "dev", "doc", "admin", "⚈", "⌘", "⌥" }

tyranical.tags = {
  {
    name = "main",
    init = true,
    layout = awful.layout.suit.tile,
    screen = 1
  },
  {
    name = "www",
    init = true,
    layout = awful.layout.suit.max,
    match = { "luakit" }
  },
  {
    name = "dev",
    init = true,
    layout = awful.layout.suit.tile.bottom
  },
  {
    name = "doc",
    init = true,
    layout = awful.layout.suit.tile
  },
  {
    name = "admin",
    init = true,
    layout = awful.layout.suit.tile
  },
  {
    name = "⚈",
    layout = awful.layout.suit.float
  },
  {
    name = "⌘",
    init = true,
    layout = awful.layout.suit.float
  },
  {
    name = "⌥",
    init = true,
    layout = awful.layout.suit.float
  }
}
