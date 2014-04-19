-- Show fancy notifications for backlight and volume hotkeys
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

