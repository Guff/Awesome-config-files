local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local volume = {}


volume["high"] = awful.util.getdir("config") .. "/volume-high.png"
volume["medium"] = awful.util.getdir("config") .. "/volume-medium.png"
volume["low"] = awful.util.getdir("config") .. "/volume-low.png"
volume["muted"] = awful.util.getdir("config") .. "/volume-muted.png"
volume["off"] = awful.util.getdir("config") .. "/volume-off.png"

local function getvolume()
   return string.match(awful.util.pread("amixer -c0 get \"Master\""), "(%d+)%%")
end
    )
local function new(args)
  return volume = {}
end

return setmetatable(__bat, { __call = function(_, ...) return new(...) end })
