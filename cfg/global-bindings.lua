local awful = require("awful")
-- require("misc.dict")

globalkeys = awful.util.table.join(
    -- Special function keys
    -- Briteness is controled by hardware on this laptop
    -- awful.key({ }, "XF86MonBrightnessUp", brightness_up),
    -- awful.key({ }, "XF86MonBrightnessDown", brightness_down),
    awful.key({ }, "XF86ScreenSaver", function () awful.util.spawn("lualock -n") end),
    awful.key({ modkey,           }, "F7", volume_down),
    awful.key({ modkey,           }, "F8", volume_up),
    awful.key({ modkey,           }, "F9", volume_mute),
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'") end),

    -- MPD keys
    awful.key({ modkey, "Shift"   }, "Up", function () awful.util.spawn("ncmpcpp toggle") end),
    awful.key({ modkey, "Shift"   }, "Down", function () awful.util.spawn("ncmpcpp stop") end),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.util.spawn("ncmpcpp prev") end),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.util.spawn("ncmpcpp next") end),

    -- Launch my terminal setup
    awful.key({ modkey,           }, "Return", function() awful.util.spawn("urxvt") end ),
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
