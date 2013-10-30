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
    exec_once = { "luakit" },
    screen = 1
  },
  {
    name = "dev",
    init = true,
    layout = awful.layout.suit.tile.bottom
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
  },
  {
    name = "Misc",
    init = true,
    layout = awful.layout.suit.tile,
    screen = 2
  },
  {
    name = "Doc",
    init = true,
    layout = awful.layout.suit.tile,
    screen = 2
  },
  {
    name = "OpenSCAD",
    init = true,
    exclusive = true,
    layout = awful.layout.suit.max,
    class = { "OpenSCAD" },
    screen = 2,
  },
  {
    name = "Music",
    init = true,
    layout = awful.layout.suit.max,
    screen = 2,
    force_screen = 2
  }
}
