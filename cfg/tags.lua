local awful = require("awful")

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

tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(
      { "main", "www", "dev", "admin", "⚈","⌘", "⌥", "☉", "♪"},
      s,
      {layouts[2], layouts[10], layouts[4], layouts[2], layouts[2] ,layouts[1], layouts[1], layouts[1], layouts[1]}
    )
end

