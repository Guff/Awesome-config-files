require("shifty")

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

mytags = { "☉", "⌨", "☐", "☷", "♪", "⚈", "⌿", }

shifty.config.tags = {
    [mytags[1]] = { position = 1, init = true, layout = "floating", },
    [mytags[2]] = { position = 2, layout = "floating", },
    [mytags[3]] = { position = 3, init = true, layout = "tilebottom",
                    mwfact = 0.7, },
    [mytags[4]] = { position = 4, init = true, layout = "tiletop", },
    [mytags[5]] = { position = 5, init = true, },
    [mytags[6]] = { position = 6, init = true, },
    [mytags[7]] = { position = 7, mwfact = 0.1943359375, spawn = "gimp",
                    init = true,  layout = "tileleft",},
    
}

local tags = shifty.config.tags

shifty.config.apps = {
    { match = { "Firefox.*" }, tag = mytags[1], },
    { match = { "geany" }, tag = mytags[2], },
    { match = { "gimp%-image%-window" }, tag = mytags[7], slave = true, },
    { match = { "gimp%-toolbox" }, float = false, tag = mytags[7], slave = false, },
    { match = { "banshee", "totem" }, tag = mytags[5], },
    { match = { "Pidgin", "File Operation Progress", "pinentry", }, float = true, },
    { match = { "" }, buttons = awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize)) },
}

shifty.config.defaults = {
  layout = "floating", 
  run = function(tag) naughty.notify({ text = "Created " .. tag.name }) end,
}

shifty.config.layouts = layouts
shifty.config.guess_name = false


--tags = {}
--for s = 1, screen.count() do
     --Each screen has its own tag table.
    --tags[s] = awful.tag({ "", "", "", "", "", "" }, s,
    --tags[s] = awful.tag({ "☉", "⌨", "☐", "☷", "♪", "⚈", "♖" }, s,
        --{layouts[2], layouts[1], layouts[4], layouts[2], layouts[1], layouts[1], layouts[2]})
--end


--icon_path = "/home/kevin/.config/awesome/icons/"
--awful.tag.seticon(icon_path .. "applications-internet.png", tags[1][1])
--awful.tag.seticon(icon_path .. "keyboard.png", tags[1][2])
--awful.tag.seticon(icon_path .. "utilities-terminal.png", tags[1][3])
--awful.tag.seticon(icon_path .. "vim.png", tags[1][4])
--awful.tag.seticon(icon_path .. "applications-multimedia.png", tags[1][5])
--awful.tag.seticon(icon_path .. "applications-other.png", tags[1][6])
