-- Show fancy notifications for backlight and (eventually) volume hotkeys

function brightness_down()
	brightness_adjust(-10)
end

function brightness_up()
	brightness_adjust(10)
end

function brightness_adjust(inc)
	--os.execute("xbacklight -inc " .. inc .. " > /dev/null 2>&1")
	local brightness = tonumber(awful.util.pread("xbacklight -get"))
	brightness_notify(brightness)
end

local bright_notification = nil
local bright_icon = image(awful.util.getdir("config") .. "/icons/brightness.png")
local bright_img = image.argb32(200, 50, nil)
bright_img:draw_rectangle(0, 0, bright_img.width, bright_img.height, true,
	beautiful.bg_normal)
bright_img:insert(bright_icon, 0, 1)

function brightness_notify(brightness)
	local img = bright_img
	img:draw_rectangle(60, 20, 130, 10, true, beautiful.bg_focus)
	img:draw_rectangle(62, 22, 126 * brightness / 100, 6, true, beautiful.fg_focus)
	
	local id = nil
	if bright_notification then id = bright_notification.id end
	bright_notification = naughty.notify(
		{ icon = img, replaces_id = id, text = "\n" .. math.ceil(brightness) .. "%",
		  font = "Sans Bold 10" }
	)
end

function volume_down()
	volume_adjust(-5)
end

function volume_up()
	volume_adjust(5)
end

function volume_mute()
	volume_adjust(0)
end

function volume_adjust(inc)
	if inc < 0 then inc = math.abs(inc) .. "%-"
	elseif inc > 0 then inc = inc .. "%+"
	else inc = "toggle" end
	os.execute("amixer set Master " .. inc .. " > /dev/null 2>&1")

	local volume = tonumber(
		awful.util.pread("amixer get Master | grep -om1 '[[:digit:]]*%' | tr -d %")
	)
	local is_muted = string.find(awful.util.pread("amixer get Master"),
								 '%[on%]') == nil
	if is_muted then volume_notify(0) else volume_notify(volume) end
end

function volume_get_icon()
	local volume = tonumber(
		awful.util.pread("amixer get Master | grep -om1 '[[:digit:]]*%' | tr -d %")
	)
	local is_muted = string.find(awful.util.pread("amixer get Master"),
								 '%[on%]') == nil
	local icon_str = nil
	if volume > 70 then icon_str = "high.png"
	elseif volume > 30 then icon_str = "medium.png"
	elseif volume > 0 then icon_str = "low.png"
	elseif volume == 0 then icon_str = "off.png" end
	if is_muted then icon_str = "muted.png" end
	return awful.util.getdir("config") .. "/icons/volume-" .. icon_str
end

local vol_notification = nil
local vol_img = image.argb32(200, 50, nil)

function volume_notify(volume)
	local img = vol_img
	img:draw_rectangle(0, 0, vol_img.width, vol_img.height, true,
		beautiful.bg_normal)
	local vol_icon = image(volume_get_icon())
	img:insert(vol_icon, 0, 1)
	img:draw_rectangle(60, 20, 130, 10, true, beautiful.bg_focus)
	img:draw_rectangle(62, 22, 126 * volume / 100, 6, true, beautiful.fg_focus)
	
	local id = nil
	if vol_notification then id = vol_notification.id end
	vol_notification = naughty.notify(
		{ icon = img, replaces_id = id, text = "\n" .. math.ceil(volume) .. "%",
		  font = "Sans Bold 10" }
	)
	img = vol_img
end
