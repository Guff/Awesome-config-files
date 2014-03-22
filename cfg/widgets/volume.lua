local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local __volume = {}
local function new(args)
  return __volume = {}
end

return setmetatable(__bat, { __call = function(_, ...) return new(...) end })
