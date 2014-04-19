local awful = require("awful")
local cairo = require("lgi").cairo
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")


local notify = {}

function notify:fancy(percent, icon, notification)
  local img = cairo.ImageSurface(cairo.Format.ARGB32, 200, 50)
  local cr = cairo.Context(img)
  cr:set_source(gears.color(beautiful.bg_normal)) cr:paint()
  cr:set_source_surface(gears.surface.load(icon, 0, 1))
  cr:paint()
  cr:set_source(gears.color(beautiful.bg_focus))
  cr:rectangle(60, 20, 130, 10)
  cr:fill()
  cr:set_source(gears.color(beautiful.fg_focus))
  cr:rectangle(62, 22, 126 * percent / 100, 6)
  cr:fill()

  local id = nil
  if notification then
    id = notification.id
  end
  return naughty.notify({ icon = img, replaces_id = id,
                          text = "\n" .. math.ceil(percent) .. "%",
                          font = "Sans Bold 10" })
end

function new()
  -- nothing to here yet
end


return setmetatable(notify, { __call = function(_, ...) return new(...) end })
