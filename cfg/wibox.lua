-- widgets
vicious = require("vicious")
require("misc.notifications")
-- freedesktop menu
--require("cfg.menu")

local wibox = require("wibox")

--cputext = widget( { type = "textbox" })
--vicious.register(cputext, vicious.widgets.cpu, "$1%", 2) 
cpu_bar = awful.widget.progressbar()
cpu_bar:set_width(8):set_height(18):set_vertical(true)
cpu_bar:set_background_color("#494b4f"):set_border_color("#000000")
cpu_bar:set_color("#AD8488")--:set_gradient_colors({ "#AD8488", "#964C53", "#FF3548" })

cpu_info = {}
vicious.register(cpu_bar, vicious.widgets.cpu,
    function(widget, args)
        cpu_info.load1 = args[1]
        cpu_info.load2 = args[2]
        return (cpu_info.load1 + cpu_info.load2) / 2
    end, 2
)

volume_icon = wibox.widget.imagebox()
volume_icon:set_image(volume_get_icon(get_volume()))

function update_volume_icon(volume)
    volume_icon:set_image(volume_get_icon(volume))
end

function volume_up_and_update()
    local volume = volume_up()
    update_volume_icon(volume)
end

function volume_down_and_update()
    local volume = volume_down()
    update_volume_icon(volume)
end

function volume_mute_and_update()
    local volume = volume_mute()
    update_volume_icon(volume)
end

volume_icon:buttons(awful.util.table.join(
    awful.button({}, 1, function () awful.util.spawn("pavucontrol") end),
    awful.button({}, 2, volume_mute_and_update),
    awful.button({}, 4, volume_up_and_update),
    awful.button({}, 5, volume_down_and_update))
)

batt_info = {}
batt_text = wibox.widget.textbox()
vicious.register(batt_text, vicious.widgets.bat,
    function(widget, args)
        batt_info.state = args[1]
        batt_info.level = args[2]
        batt_info.remaining = args[3]
        --if batt_info.state == "-" or batt_info.state == "+" then
        return " " .. args[3]
          --return "Blah"
        --else
            --return nil
        --end
    end, 5, "BAT0"
)

batt_icon = wibox.widget.imagebox()
batt_icon:set_image(awful.util.getdir("config") .. "/icons/batticon.png")
-- surprised this isn't in lua's math library
local function round(x)
    if x - math.floor(x) >= 0.5 then return math.ceil(x) else return math.floor(x) end
end

function update_batt_icon()
    batt_icon.image = batt_icon_image
    local off_x, off_y = 1, { top = 3, bot = 1 }
    local w, h = batt_icon.width, batt_icon.height
    local color = beautiful.batt_ok
    if batt_info.level > 30 then color = beautiful.batt_ok
    elseif batt_info.level > 10 then color = beautiful.batt_danger
    else color = beautiful.batt_dying end
    
    local percent = batt_info.level / 100
    local rect_h = round((h - off_y.top - off_y.bot) * percent)
    batt_icon.image:draw_rectangle(off_x, h - rect_h, w - 2 * off_x, rect_h - off_y.bot, true, color)
    
    if batt_info.state ~= "-" then 
        batt_icon.image:insert(
            image(awful.util.getdir("config") .. "/icons/charging.png"))
    end
end

batt_timer = timer({ timeout = 5 })
batt_timer:connect_signal("timeout", update_batt_icon)
batt_timer:start()

local batt_buttons = awful.util.table.join(
    awful.button({ }, 1,
        function()
            run_or_raise("xfce4-power-information", { class = "xfce4-power-information" } )
        end
    ),
    awful.button({ }, 3,
        function()
            run_or_raise("xfce4-power-manager-settings", { class = "xfce4-power-manager-settings" } )
        end
    ),
    awful.button({ }, 4, 
        function()
            os.execute("xbacklight -inc 10 > /dev/null 2>&1")
            brightness_adjust(10)
        end
    ),
    awful.button({ }, 5,
        function()
            os.execute("xbacklight -dec 10 > /dev/null 2>&1")
            brightness_adjust(-10)
        end
    )
)

batt_text:buttons(batt_buttons)
batt_icon:buttons(batt_buttons)

local sysmon_buttons = awful.button({}, 1,
    function()
        run_or_raise("lxtask", { class = "lxtask" } )
    end
)

mem_bar:buttons(sysmon_buttons)
cpu_bar:buttons(sysmon_buttons)

awful.tooltip({ objects = { batt_icon, batt_text }, timer_function = function()
    return string.format("<big>Battery:</big>\n<b>Level:</b> %s%%\n<b>State:</b> %s\n<b>"
        .. "Time remaining:</b> %s", batt_info.level, batt_info.state, batt_info.remaining)
    end, timeout = 10
})

awful.tooltip({ objects = { mem_bar.widget, cpu_bar.widget }, timer_function = function()
    return string.format("<b>CPU0:</b> %s%%; <b>CPU1:</b> %s%%\n\n<b>Memory used:</b> "
        .. "%sMB, %s%% \n<b>Memory total:</b> %sMB\n<b>Swap used:</b> %sMB\n<b>Swap total:</b> "
        .. "%sMB\n\n<b>Filesystems</b>:\n<b>/:</b> size %sGB, free %sGB\n<b>/home:</b> size"
        .. " %sGB, free %sGB\n%s %s", cpu_info.load1, cpu_info.load2, mem_info.usage,
        mem_info.percent, mem_info.total, mem_info.swapused, mem_info.swaptotal,
        fs_info.rootsize, fs_info.rootfree, fs_info.homesize, fs_info.homefree,
        awful.util.pread('uptime | sed "s/\\(.*users\\).*/\\1/"'),
        awful.util.pread("cut -d\" \" -f1,2,3 /proc/loadavg"))
    end,
    timeout = 1
})

awful.tooltip({ objects = { wifi_icon, }, timer_function = function()
    return string.format("%s: %d%%", wifi_info.ssid, wifi_info.qual)
end, timeout = 1 })

awful.tooltip({ objects = { mytextclock, myweather, }, timer_function = function()
    return string.format("<big><b>%s, PT</b></big>\n<b>%s</b>\n<b>Sky:</b> %s\n<b>Weather:</b> %s\n"
        .. "<b>Temp:</b> %s°\n<b>Humidity:</b> %s%%", wdata.city, os.date("%a %b %d, %l:%M:%S %p"), wdata.sky,
        wdata.weather, wdata.tempc, wdata.humidity)
    end, timeout = 1 })
    
awful.tooltip({ objects = { volume_icon, }, timer_function = function()
    if get_muted() then return "Volume: " .. get_volume() .. "%," .. " muted"
    else return "Volume: " .. get_volume() .. "%" end
end, timeout = 1 })

-- Create a systray
mysystray = wibox.widget.systray()

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
    awful.button({ }, 1,
        function (c)
            if not c:isvisible() then awful.tag.viewonly(c:tags()[1]) end
            if client.focus == c then
                c.minimized = not c.minimized
            else
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
                if client.focus then client.focus:raise() end
        end
    ),
    awful.button({ }, 5,
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
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

--awful.widget.layout.margins[cpu_bar.widget] = { left = 5 }
--awful.widget.layout.margins[myweather] = { left = 5 }
--awful.widget.layout.margins[batt_icon] = { left = 2, right = 2 }
