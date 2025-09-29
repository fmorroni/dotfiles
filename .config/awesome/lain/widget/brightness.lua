local helpers              = require("lain.helpers")
local wibox                = require("wibox")
local my_helpers           = require("libs.helpers")

local function factory(args)
  args             = args or {}
  local brightness = { widget = args.widget or wibox.widget.textbox() }
  local timeout    = args.timeout or 10
  local settings   = args.settings or function() end
  brightness_now   = 0

  function brightness.update()
    widget = brightness.widget
    helpers.async(
      "brightnessctl -m",
      function(stdout)
        -- get 4th field (percentage)
        local percent = stdout:match("^[^,]+,[^,]+,[^,]+,([^,]+)")
        brightness_now = percent and percent:gsub("%%", "") or "0"
        settings()
      end
    )
  end

  brightness.update()
  helpers.newtimer("brightness", timeout, brightness.update)

  return brightness
end

return factory
