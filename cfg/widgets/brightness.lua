local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local notify = require("lib.notify")

local brightness = {}

brightness["icon"] = awful.util.getdir("config") .. "/icons/brightness.png"

local function notify_brightness()
  -- Volume notification bar
  -- Passing it trough avoids pop spaming
  brightness_notification = notify:fancy(brightness:get(), brightness["icon"] , brightness_notification)
end

function brightness:get()
  local brightness = math.floor(tonumber(awful.util.pread("xbacklight -display :0 -get")))
  if brightness == nil then
    naughty.notify({
      text = "Error: Could not get screen light brightness",
      title = "Brightness"
    })
    return 0
  end
  return brightness
end

function brightness:up(increment)
  awful.util.pread("xbacklight -display :0 -inc " .. increment)
  notify_brightness()

  return nil
end

function brightness:down(decrement)
  awful.util.pread("xbacklight -display :0 -dec " .. decrement)
  notify_brightness()

  return nil
end

local function new(args)
  if not args then
    args = {}
  end

  -- Using the layout scheme
  brightness.widget = wibox.layout.fixed.horizontal()

  local textbox = wibox.widget.textbox()
  textbox:set_text(brightness.get())
  brightness.widget:add(textbox)

  local imagebox = wibox.widget.imagebox()
  imagebox:set_image(brightness["icon"])
  brightness.widget:add(imagebox)

  local brightness_timer = timer ({timeout = 10})
  brightness_timer:connect_signal("timeout",
    function()
      textbox:set_text(brightness:get())
      imagebox:set_image(brightness["icon"])
    end
  )
  brightness_timer:start()

  return brightness
end

return setmetatable(brightness, { __call = function(_, ...) return new(...) end })
