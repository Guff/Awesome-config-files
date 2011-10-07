-- Show fancy notifications for backlight and volume hotkeys

function fancy_notify(percent, icon_function, notification)
    local img = image.argb32(200, 50, nil)
    img:draw_rectangle(0, 0, img.width, img.height, true, beautiful.bg_normal)
    img:insert(image(icon_function(percent)), 0, 1)
    img:draw_rectangle(60, 20, 130, 10, true, beautiful.bg_focus)
    img:draw_rectangle(62, 22, 126 * percent / 100, 6, true, beautiful.fg_focus)
    
    local id = nil
    if notification then id = notification.id end
    return naughty.notify({ icon = img, replaces_id = id,
                            text = "\n" .. math.ceil(percent) .. "%",
                            font = "Sans Bold 10" })
end

-- Brightness notifications
function brightness_down()
    brightness_adjust(-10)
end

function brightness_up()
    brightness_adjust(10)
end

local bright_notification = nil
function brightness_adjust(inc)
    -- Uncomment if your backlight keys don't work automatically
    --os.execute("xbacklight -inc " .. inc .. " > /dev/null 2>&1")
    local brightness = tonumber(awful.util.pread("xbacklight -get"))
    bright_notification =
        fancy_notify(brightness, brightness_get_icon, bright_notification)
end

function brightness_get_icon(brightness)
    return awful.util.getdir("config") .. "/icons/brightness.png"
end

-- Volume notifications

-- Each of these functions returns the current volume, so that it can be used
-- by my volume icon widget to update its icon. It's not necessary for the
-- notifications alone, however
function volume_down()
    return volume_adjust(-5)
end

function volume_up()
    return volume_adjust(5)
end

function volume_mute()
    return volume_adjust(0)
end

function get_volume()
    return tonumber(
        string.match(awful.util.pread("amixer -c0 get \"Master Front\""), "(%d+)%%")
    )
end

function get_muted()
    return string.find(awful.util.pread("amixer -c0 get \"Master Front\""),
                       '%[on%]') == nil
end

local vol_notification = nil
function volume_adjust(inc)
    if inc < 0 then inc = math.abs(inc) .. "%-"
    elseif inc > 0 then inc = inc .. "%+"
    else inc = "toggle" end
    local volume, is_muted =
		string.match(awful.util.pread("amixer -c0 set Master Front" .. inc),
					 "(%d+)%%.*%[(%a+)%]")
	is_muted = is_muted == "off"
	volume = tonumber(volume)
    --local volume = get_volume()
    --local is_muted = get_muted()
    if is_muted then volume = 0 end
    vol_notification = fancy_notify(volume, volume_get_icon, vol_notification)
    return volume
end

function volume_get_icon(volume)
    local is_muted = get_muted()
    local icon_str = nil
    if volume > 70 then icon_str = "high.png"
    elseif volume > 30 then icon_str = "medium.png"
    elseif volume > 0 then icon_str = "low.png"
    elseif volume == 0 then icon_str = "off.png" end
    if is_muted then icon_str = "muted.png" end
    return awful.util.getdir("config") .. "/icons/volume-" .. icon_str
end
