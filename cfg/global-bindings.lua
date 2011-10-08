-- require("misc.dict")

globalkeys = awful.util.table.join(
    -- Special function keys
    awful.key({ }, "XF86MonBrightnessUp", brightness_up),
    awful.key({ }, "XF86MonBrightnessDown", brightness_down),
    awful.key({ }, "XF86ScreenSaver", function () awful.util.spawn("lualock -n") end),
    awful.key({ }, "XF86AudioLowerVolume", volume_down_and_update),
    awful.key({ }, "XF86AudioRaiseVolume", volume_up_and_update),
    awful.key({ }, "XF86AudioMute", volume_mute_and_update),
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'") end),
    
    -- MPD keys
    awful.key({ modkey, "Shift"   }, "Up", function () awful.util.spawn("ncmpcpp toggle") end),
    awful.key({ modkey, "Shift"   }, "Down", function () awful.util.spawn("ncmpcpp stop") end),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.util.spawn("ncmpcpp prev") end),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.util.spawn("ncmpcpp next") end),

    -- Shifty keys
    awful.key({ modkey, "Control" }, "t", function() shifty.add({ rel_index = 1 }) end),
    awful.key({ modkey, "Shift"   }, "t", function() shifty.add({ rel_index = 1, nopopup = true }) end),
    awful.key({ modkey, "Control" }, "g",           shifty.rename),
    awful.key({ modkey, "Control" }, "w",           shifty.del),
    
    -- Launch my terminal setup
    awful.key({ modkey,           }, "g",
        function()
            awful.util.spawn("sakura")
            awful.util.spawn("sakura -f \"Terminus (TTF) 9\"")
            awful.util.spawn("sakura -f \"Terminus (TTF) 9\"")
        end
    ),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "e", function () awful.util.spawn("thunar") end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    -- awful.key({ modkey,           }, ";",
        -- function ()
            -- awful.prompt.run({ prompt = "Dict: " }, mypromptbox[mouse.screen].widget,
            -- function(word)
                -- local definition = awful.util.pread("dict " .. word .. " 2>&1")
                -- naughty.notify({ text = definition, timeout = 13, title = word,
                    -- width = 400, font = "Sans 7" })
            -- end, dict_cb, awful.util.getdir("cache") .. "/dict")
        -- end
    -- ),
    -- awful.key({ modkey, "Control" }, ";",
        -- function ()
            -- if selection() then
                -- definition = awful.util.pread("dict " .. selection() .. " 2>&1")
                -- naughty.notify({ text = definition, timeout = 13,
                    -- title = selection(), width = 400, font = "Sans 7" })
            -- end
        -- end
    --),
    awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- all minimized clients are restored 
    awful.key({ modkey, "Shift"   }, "n", 
        function()
            local tags = awful.tag.selectedlist()
            for j=1, #tags do
                for i=1, #tags[j]:clients() do
                    tags[j]:clients()[i].minimized=false
                    tags[j]:clients()[i]:redraw()
                end
            end
        end),
    -- show desktop/unminimize
    awful.key({ modkey            }, "d", 
        function()
            local tag = awful.tag.selected()
            for i=1, #tag:clients() do
                tag:clients()[i].minimized = not tag:clients()[i].minimized
                if not tag:clients()[i].minimized then
                    tag:clients()[i]:redraw()
                end
            end
        end)
)

for i=1, ( shifty.config.maxtags or 9 ) do
  
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, i,
        function ()
            local t = awful.tag.viewonly(shifty.getpos(i))
        end))
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, i,
        function ()
            local t = shifty.getpos(i)
            t.selected = not t.selected
        end))
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control", "Shift" }, i,
        function ()
            if client.focus then
            awful.client.toggletag(shifty.getpos(i))
        end
    end))
    -- move clients to other tags
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, i,
    function ()
        if client.focus then
            local t = shifty.getpos(i)
            awful.client.movetotag(t)
            --awful.tag.viewonly(t)
        end
    end))
end

globalbuttons = awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)

shifty.config.globalkeys = globalkeys
