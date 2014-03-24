local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local volume = {}


volume["high"] = awful.util.getdir("config") .. "/icons/volume-high.png"
volume["medium"] = awful.util.getdir("config") .. "/icons/volume-medium.png"
volume["low"] = awful.util.getdir("config") .. "/icons/volume-low.png"
volume["muted"] = awful.util.getdir("config") .. "/icons/volume-muted.png"
volume["off"] = awful.util.getdir("config") .. "/icons/volume-off.png"

local function getvolume()
  return string.match(awful.util.pread("amixer -c0 get Master"), "(%d+)%%")
end

local function new(args)
  -- Using the layout scheme
  volume.widget = wibox.layout.fixed.horizontal()

  local textbox = wibox.widget.textbox()
  textbox:set_text(getvolume())
  volume.widget:add(textbox)

  local imagebox = wibox.widget.imagebox()
  imagebox:set_image(volume["high"])
  volume.widget:add(imagebox)

  return volume.widget
end

return setmetatable(volume, { __call = function(_, ...) return new(...) end })
