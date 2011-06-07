require("misc.dict")

globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, ";",      function ()
        awful.prompt.run({ prompt = "Dict: " }, mypromptbox[mouse.screen].widget,
        function(word)
            local definition = awful.util.pread("dict " .. word .. " 2>&1")
            naughty.notify({ text = definition, timeout = 13, title = word,
                width = 400, font = "Sans 7" })
        end, dict_cb, awful.util.getdir("cache") .. "/dict")
    end),
    awful.key({ modkey, "Control" }, ";",      function ()
        if selection() then
            definition = awful.util.pread("dict " .. selection() .. " 2>&1")
            naughty.notify({ text = definition, timeout = 13,
                title = selection(), width = 400, font = "Sans 7" })
        end
    end),
    awful.key({ modkey,           }, "c",      function ()
        awful.prompt.run({  text = val and tostring(val),
        selectall = true,
        fg_cursor = "black",bg_cursor="orange",
        prompt = "<span color='#00A5AB'>Calc:</span> " }, mypromptbox[mouse.screen].widget,
        function(expr)
          val = awful.util.eval(expr)
          naughty.notify({ text = expr .. ' = <span color="white">' .. val .. "</span>",
                           timeout = 0,
                           run = function() io.popen("echo ".. val .. " | xsel -i"):close() end, })
        end,
        nil, awful.util.getdir("cache") .. "/calc")
    end),
    awful.key({ }, "XF86ScreenSaver", function () awful.util.spawn("slimlock") end),
	awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'") end),
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
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

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
            local tag = awful.tag.selected()
                for i=1, #tag:clients() do
                    tag:clients()[i].minimized=false
                    tag:clients()[i]:redraw()
            end
        end),
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

-- Compute the maximum number of digit we need, limited to 9


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
--for i=1, ( shifty.config.maxtags or 9 ) do
    --globalkeys = awful.util.table.join(globalkeys,
        --awful.key({ modkey }, "#" .. i + 9,
                  --function ()
                        --local screen = mouse.screen
                        --if tags[screen][i] then
                            --awful.tag.viewonly(tags[screen][i])
                        --end
                  --end),
        --awful.key({ modkey, "Control" }, "#" .. i + 9,
                  --function ()
                      --local screen = mouse.screen
                      --if tags[screen][i] then
                          --awful.tag.viewtoggle(tags[screen][i])
                      --end
                  --end),
        --awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  --function ()
                      --if client.focus and tags[client.focus.screen][i] then
                          --awful.client.movetotag(tags[client.focus.screen][i])
                      --end
                  --end),
        --awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  --function ()
                      --if client.focus and tags[client.focus.screen][i] then
                          --awful.client.toggletag(tags[client.focus.screen][i])
                      --end
                  --end))
--end

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
