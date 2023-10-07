local helpers              = require("lain.helpers")
local wibox                = require("wibox")
local gmatch, lines, floor = string.gmatch, io.lines, math.floor
local my_helpers           = require("libs.helpers")

local function factory(args)
  args                 = args or {}
  local brightness     = { widget = args.widget or wibox.widget.textbox() }
  local timeout        = args.timeout or 10
  local settings       = args.settings or function() end
  brightness_now       = 0

  function brightness.update()
    widget = brightness.widget
    helpers.async(
      ScriptsDir .. 'brightnessIncBy 0',
      function(stdout)
        brightness_now = stdout:gsub('\n', '')
        settings()
      end
    )
  end

  brightness.update()
  helpers.newtimer("brightness", timeout, brightness.update)

  return brightness
end

return factory
