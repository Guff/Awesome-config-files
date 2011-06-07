-- freedesktop menu
require("vicious")
--require("delightful.widgets.weather")
require("cfg.menu")

mytextclock = widget({ type = "textbox" })
vicious.register(mytextclock, vicious.widgets.date, "%a %b %d, %l:%M %p")

weathericon = widget({ type = "imagebox" })

myweather = widget({ type = "textbox" })
wdata = {}
vicious.register(myweather, vicious.widgets.weather,
    function(widget, args)
        if args["{tempf}"] ~= "N/A" then
            wdata.tempf = args["{tempf}"]
        end
        wdata.weather = args["{weather}"]
        wdata.sky = args["{sky}"]
        wdata.city = args["{city}"]
        wdata.wind = args["{windmph}"]
        wdata.wind_dir = args["{wind}"]
        wdata.humidity = args["{humid}"]
        return wdata.tempf .. "° "
    end, 600, "KGIF")

fsstuff = {}
fsdummy = widget({ type = "textbox" })
vicious.register(fsdummy, vicious.widgets.fs, function(widget, args)
    fsstuff.rootsize = args["{/ size_gb}"]
    fsstuff.homesize = args["{/home size_gb}"]
    fsstuff.rootfree = args["{/ avail_gb}"]
    fsstuff.homefree = args["{/home avail_gb}"]
end, 60)

mem_bar = awful.widget.progressbar()
-- Progressbar properties
mem_bar:set_width(8)
mem_bar:set_height(18)
mem_bar:set_vertical(true)
mem_bar:set_background_color("#494B4F")
mem_bar:set_border_color("#000000")
mem_bar:set_color("#AECF96")
mem_bar:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })

memstuff = {}
vicious.register(mem_bar, vicious.widgets.mem, function(widget, args)
    memstuff.percent = args[1]
    memstuff.usage = args[2]
    memstuff.total = args[3]
    memstuff.swapused = args[6]
    memstuff.swaptotal = args[7]
    return memstuff.percent
    end, 10)

--cputext = widget( { type = "textbox" })
--vicious.register(cputext, vicious.widgets.cpu, "$1%", 2) 
cpu_bar = awful.widget.progressbar()
cpu_bar:set_width(8):set_height(18):set_vertical(true)
cpu_bar:set_background_color("#494b4f"):set_border_color("#000000")
cpu_bar:set_color("#AD8488"):set_gradient_colors({ "#AD8488", "#964C53", "#FF3548" })

cpustuff = {}
vicious.register(cpu_bar, vicious.widgets.cpu, function(widget, args)
    cpustuff.load1 = args[1]
    cpustuff.load2 = args[2]
    return (cpustuff.load1 + cpustuff.load2) / 2
    end, 2)

batt_bar = awful.widget.progressbar()
batt_bar:set_width(8):set_height(18):set_vertical(true)
batt_bar:set_background_color("#494b4f"):set_border_color("#1E8815")
batt_bar:set_color("#1BC600")
battstuff = {}
vicious.register(batt_bar, vicious.widgets.bat, function(widget, args)
    battstuff.state = args[1]
    battstuff.level = args[2]
    battstuff.remaining = args[3]
    if battstuff.level > 30 then batt_bar:set_color("#79B94A")
    elseif battstuff.level > 10 then batt_bar:set_color("#CBF045")
    else batt_bar:set_color("#FC5D44") end
    return battstuff.level
end, 5, "BAT0")

batt_text = widget({ type = "textbox" })
vicious.register(batt_text, vicious.widgets.bat, function(widget, args)
    if battstuff.state == "-" or battstuff.state == "+" then
        return " " .. args[3]
    else
        return nil
    end
end, 10, "BAT0")

local batt_buttons = awful.util.table.join(
    awful.button({}, 1, function()
        run_or_raise("xfce4-power-information", { class = "xfce4-power-information" } )
    end),
    awful.button({}, 3, function()
        run_or_raise("xfce4-power-manager-settings", { class = "xfce4-power-manager-settings" } )
    end),
    awful.button({}, 4, function()
        awful.util.spawn("xbacklight -inc 10")
    end),
    awful.button({}, 5, function()
        awful.util.spawn("xbacklight -dec 10")
    end)
)

batt_text:buttons(batt_buttons)
batt_bar.widget:buttons(batt_buttons)

local sysmon_buttons = awful.button({}, 1, function()
    run_or_raise("lxtask", { class = "lxtask" } )
end)

mem_bar.widget:buttons(sysmon_buttons)
cpu_bar.widget:buttons(sysmon_buttons)

awful.tooltip({ objects = { batt_bar.widget, batt_text }, timer_function = function()
    return string.format("<big>Battery:</big>\n<b>Level:</b> %s%%\n<b>State:</b> %s\n<b>"
        .. "Time remaining:</b> %s", battstuff.level, battstuff.state, battstuff.remaining)
    end, timeout = 10
})

awful.tooltip({ objects = { mem_bar.widget, cpu_bar.widget }, timer_function = function()
    return string.format("<b>CPU0:</b> %s%%; <b>CPU1:</b> %s%%\n\n<b>Memory used:</b> "
        .. "%sMB, %s%% \n<b>Memory total:</b> %sMB\n<b>Swap used:</b> %s\n<b>Swap total:</b> "
        .. "%sMB\n\n<b>Filesystems</b>:\n<b>/:</b> size %sGB, free %sGB\n<b>/home:</b> size"
        .. " %sGB, free %sGB\n%s\n%s", cpustuff.load1, cpustuff.load2, memstuff.usage,
        memstuff.percent, memstuff.total, memstuff.swapused, memstuff.swaptotal,
        fsstuff.rootsize, fsstuff.rootfree, fsstuff.homesize, fsstuff.homefree,
        awful.util.pread("uptime | cut -d, -f 1,2"),
        awful.util.pread("uptime | cut -d, -f 4,5,6"))
    end,
    timeout = 1
})

awful.tooltip({ objects = { mytextclock, myweather }, timer_function = function()
    return string.format("<big><b>Winter Haven, FL</b></big>\n<b>%s</b>\n<b>Sky:</b> %s\n%s,"
        .. "%s°\n<b>Humidity:</b> %s%%", os.date("%a %b %d, %l:%M %p"), wdata.sky,
        wdata.weather, wdata.tempf, wdata.humidity)
    end, timeout = 1 })

myseparator = widget({ type = "textbox" })
myseparator.text = " "

local calendar = nil
local offset = 0

function remove_calendar()
    if calendar ~= nil then
        naughty.destroy(calendar)
        calendar = nil
        offset = 0
    end
end

function add_calendar(inc_offset)
    local save_offset = offset
    remove_calendar()
    offset = save_offset + inc_offset
    local datespec = os.date("*t")
    local today = datespec.day
    datespec = datespec.year * 12 + datespec.month - 1 + offset
    datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
    local cal = awful.util.pread("cal -m " .. datespec)
    cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")
    cal = string.gsub(cal, today .. "[ \n]",
        '<span bgcolor="white" fgcolor="#61645B">%1</span>', 1)
    calendar = naughty.notify({
        text = string.format('<span font_desc="%s">%s</span>', "monospace",
            os.date("%a, %d %B %Y") .. "\n" .. cal),
        timeout = 0, hover_timeout = 0.5,
        width = 160,
    })
end

mytextclock:add_signal("mouse::leave", remove_calendar)

mytextclock:buttons(awful.util.table.join(
    awful.button({ }, 1, function()
        if calendar ~= nil then
            remove_calendar()
        else
            add_calendar(0)
        end
    end),
    awful.button({ }, 4, function()
        add_calendar(1)
    end),
    awful.button({ }, 5, function()
        add_calendar(-1)
    end)
))

-- Create a systray
mysystray = widget({ type = "systray" })

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
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

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
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.noempty, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height="18", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        
        mylayoutbox[s],
        batt_text,
        batt_bar.widget,
        s == 1 and mysystray or nil,
        mem_bar.widget,
        cpu_bar.widget,
        myseparator,
        mytextclock,
        myweather,
        myseparator,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
        
    }
end

shifty.taglist = mytaglist
