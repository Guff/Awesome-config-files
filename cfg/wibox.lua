-- widgets
require("misc.notifications")
-- freedesktop menu
--require("cfg.menu")

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}

mytaglist.buttons = awful.util.table.join(
  awful.button({ }, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscrren(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
  awful.button({ }, 1,
    function (c)
      if client.focus == c then
        c.minimized = true
      else
        -- Without this, the following :ivisible() makes no sense
        c.minimized = false
        if not c:visible() then
          awful.tag.viewonly(c:tags()[1])
        end
        -- This will also un-minimize the client, if needed
        client.focus = c
        c:raise()
      end
    end
  ),
  awful.button({ }, 2, function (c) c:kill() end),
  awful.button({ }, 3,
    function ()
      if instance then
        instance:hide()
        instance = nil
      else
        instance = awful.menu.clients({ width=250 })
      end
    end
  ),
  awful.button({ }, 4,
    function ()
      awful.client.focus.byidx(1)
      if client.focus then
        client.focus:raise()
      end
    end
  ),
  awful.button({ }, 5,
    function ()
      awful.client.focus.byidx(-1)
      if client.focus then
        client.focus:raise()
      end
    end
  )
)

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end))
    )
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.noempty, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(
        function(c)
            return awful.widget.tasklist.label.currenttags(c, s)
        end, mytasklist.buttons
    )
    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height="18", screen = s })
    -- Space out a few widgets
    
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            --mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        
        mylayoutbox[s],
        batt_text,
        batt_icon,
        wifi_icon,
        volume_icon,
        s == 1 and mysystray or nil,
        mem_bar.widget,
        cpu_bar.widget,
        mytextclock,
        myweather,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
        
    }
end

shifty.taglist = mytaglist
shifty.promptbox = mypromptbox
