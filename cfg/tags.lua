local awful = require("awful")

layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.magnifier
}

mytags = { "main", "www", "dev", "doc", "admin", "⚈", "⌘", "⌥" }

-- All have init = true, because trying to move a client to a not-yet-created
-- tag seems to be problematic, i.e. takes two attempts
shifty.config.tags = {
    [mytags[1]] = { position = 1, init = true, layout = "tile", },
    [mytags[2]] = { position = 2, layout = "tile", },
    [mytags[3]] = { position = 3, layout = "tilebottom",
                    mwfact = 0.7, },
    [mytags[4]] = { position = 4, layout = "tiletop", },
    [mytags[5]] = { position = 5, layout = "tile" },
    [mytags[6]] = { position = 6, layout = "tile" },
    [mytags[7]] = { position = 7, mwfact = 0.1943359375, layout = "tileleft", },
    [mytags[8]] = { position = 8, },
    
}

local tags = shifty.config.tags

