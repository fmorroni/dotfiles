local helpers              = require("lain.helpers")
local wibox                = require("wibox")
local my_helpers           = require("libs.helpers")

local function factory(args)
  args            = args or {}
  local bluetooth = { widget = args.widget or wibox.widget.textbox() }
  local timeout   = args.timeout or 10
  local settings  = args.settings or function() end
  bluetooth_on    = false

  function bluetooth.update()
    widget = bluetooth.widget
    helpers.async("systemctl status bluetooth.service", function(stdout)
      if string.match(stdout, "Active: active") then
        bluetooth_on = true
      else
        bluetooth_on = false
      end
      settings()
    end)
  end

  -- function bluetooth.show()
  --   bluetooth.hide()
  --   bluetooth.update()
  --   bluetooth.sinks_update(function()
  --     bluetooth.notification_preset.screen = bluetooth.followtag and focused() or scr or 1
  --     bluetooth.notification = naughty.notify {
  --       preset  = bluetooth.notification_preset,
  --       timeout = type(seconds) == "number" and seconds or 5
  --     }
  --   end)
  -- end

  -- function bluetooth.hide()
  --   if not bluetooth.notification then return end
  --   naughty.destroy(bluetooth.notification)
  --   bluetooth.notification = nil
  -- end

  -- bluetooth.widget:connect_signal('mouse::enter', function() bluetooth.show() end)
  -- bluetooth.widget:connect_signal('mouse::leave', function() bluetooth.hide() end)
  helpers.newtimer("bluetooth", timeout, bluetooth.update)
  bluetooth.update()

  return bluetooth
end

return factory
