local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local __bat = {}
local base_string = "/sys/class/power_supply/BAT0"

local function worker(args)
  local args = args or {}

  -- A layout widget that contains the 3 widgets for the diferent
  __bat.widget = wibox.layout.fixed.horizontal()
  local textbox = wibox.widget.textbox()
  local imagebox = wibox.widget.imagebox()
  local progressbar = awful.widget.progressbar()
  __bat.widget:add(textbox)
  __bat.widget:add(imagebox)
  __bat.widget:add(progressbar)

  function update()
    -- Battery status
    local status = assert(io.open(base_string .. "/status"):read())
    local charge = assert(io.open(base_string .. "/energy_now"):read())
    local capacity = assert(io.open(base_string .. "/energy_full"):read())

    -- Calculate charge
    percentage = math.floor((charge * 100) / capacity)

    naughty.notify({ title = "Status", text = status, timeout = 20})
    naughty.notify({ title = "Charge", text = charge, timeout = 20})
    naughty.notify({ title = "Capacity", text = capacity, timeout = 20})
    naughty.notify({ title = "Percentage", text = percentage, timeout = 20})
    textbox:set_text(percentage)

  end
    
  local battery_timer = timer ({timeout = 10})
  battery_timer:connect_signal("timeout", update)
  battery_timer:start()

  return __bat.widget
end

return setmetatable(__bat, { __call = function(_, ...) return worker(...) end })
