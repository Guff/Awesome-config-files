local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local bat = {}
local base_string = "/sys/class/power_supply/BAT0"

local function worker(args)
  local args = args or {}

  function update()
    -- Battery status
    local status = assert(io.open(base_string .. "/status"):read())
    local charge = assert(io.open(base_string .. "/energy_now"):read("*all"))
    local capacity = assert(io.open(base_string .. "/energy_full"):read("*all"))

    -- Calculate charge
    percentage = ((charge * 100) / capacity)

    naughty.notify({ title = "Status", text = status, timeout = 20})
    naughty.notify({ title = "Charge", text = charge, timeout = 20})
    naughty.notify({ title = "Capacity", text = capacity, timeout = 20})
    naughty.notify({ title = "Percentage", text = percentage, timeout = 20})

  end
    
  local battery_timer = timer ({timeout = 10})
  battery_timer:connect_signal("timeout", update)
  battery_timer:start()

end

return setmetatable(bat, { __call = function(_, ...) return worker(...) end })
