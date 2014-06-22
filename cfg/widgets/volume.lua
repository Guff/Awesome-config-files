local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local notify = require("lib.notify")

local volume = {}


volume["high"] = awful.util.getdir("config") .. "/icons/volume-high.png"
volume["medium"] = awful.util.getdir("config") .. "/icons/volume-medium.png"
volume["low"] = awful.util.getdir("config") .. "/icons/volume-low.png"
volume["muted"] = awful.util.getdir("config") .. "/icons/volume-muted.png"
volume["off"] = awful.util.getdir("config") .. "/icons/volume-off.png"

local function get_mute()
  return string.find(awful.util.pread("amixer -c0 get \"Master\""), '%[on%]') == nil
end

local function get_icon()
  local percentage = volume:get()
  if get_mute() then
    icon = volume["muted"]
  elseif percentage == 0 then
    icon = volume["off"]
  elseif percentage < 30 then
    icon = volume["low"]
  elseif percentage > 30 and percentage < 70 then
    icon = volume["medium"]
  elseif percentage > 70 then
    icon = volume["high"]
  end
  return icon
end

local function notify_volume()
  -- Volume notification bar
  -- Passing it trough avoids pop spaming
  vol_notification = notify:fancy(volume:get(), get_icon() , vol_notification)
end

function volume:get()
  local volume = tonumber(string.match(awful.util.pread("amixer get Master"), "(%d+)%%"))
  if volume == nil then
    return 0
  end
  return volume
end

function volume:set(increment)
  local amixer_param = ""
  if increment < 0 then
    amixer_param = math.abs(increment) .. "%-"
  elseif increment > 0 then
    amixer_param = math.abs(increment) .. "%+"
  end

  awful.util.pread("amixer set Master " .. amixer_param)
  notify_volume()

  return nil
end

function volume:mute()
  if get_mute() then
    awful.util.pread("amixer set Master unmute")
  else
    awful.util.pread("amixer set Master mute")
  end
  notify_volume()
end

local function new(args)
  if not args then
    args = {}
  end

  -- Using the layout scheme
  volume.widget = wibox.layout.fixed.horizontal()

  local textbox = wibox.widget.textbox()
  textbox:set_text(volume.get())
  volume.widget:add(textbox)

  local imagebox = wibox.widget.imagebox()
  imagebox:set_image(get_icon())
  volume.widget:add(imagebox)

  local volume_timer = timer ({timeout = 10})
  volume_timer:connect_signal("timeout",
    function()
      textbox:set_text(volume:get())
      imagebox:set_image(get_icon())
    end
  )
  volume_timer:start()


  return volume
end

return setmetatable(volume, { __call = function(_, ...) return new(...) end })
