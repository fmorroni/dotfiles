--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luca CPZ
      * (c) 2010, Adrian C. <anrxc@sysphere.org>

--]]

local helpers = require("lain.helpers")
local shell   = require("awful.util").shell
local wibox   = require("wibox")
local string  = string
local naughty = require("naughty")
local focused = require("awful.screen").focused

-- ALSA volume
-- lain.widget.alsa

local function factory(args)
  args                     = args or {}
  local alsa               = { widget = args.widget or wibox.widget.textbox() }
  local timeout            = args.timeout or 5
  local settings           = args.settings or function() end

  alsa.cmd                 = args.cmd or "amixer"
  alsa.channel             = args.channel or "Master"
  alsa.togglechannel       = args.togglechannel
  alsa.notification_preset = args.notification_preset
  alsa.sinks_info          = {}
  alsa.sink_selected       = nil

  if not alsa.notification_preset then
    alsa.notification_preset = {
      font = "Monospace 10",
      fg   = "#FFFFFF",
      bg   = "#000000"
    }
  end

  local format_cmd

  if alsa.togglechannel then
    format_cmd = { shell, "-c", string.format("%s get %s; %s get %s",
      alsa.cmd, alsa.channel, alsa.cmd, alsa.togglechannel) }
  else
    format_cmd = string.format("%s get %s", alsa.cmd, alsa.channel)
  end

  alsa.last = {}

  function alsa.hide()
    if not alsa.notification then return end
    naughty.destroy(alsa.notification)
    alsa.notification = nil
  end

  -- local inspect = require('libs.inspect')
  function alsa.show(seconds, scr)
    alsa.hide()
    alsa.update()
    alsa.sinks_update(function()
      alsa.notification_preset.screen = alsa.followtag and focused() or scr or 1
      alsa.notification = naughty.notify {
        preset  = alsa.notification_preset,
        timeout = type(seconds) == "number" and seconds or 5
      }
    end)
  end

  function alsa.update()
    helpers.async(format_cmd, function(mixer)
      local l, s = string.match(mixer, "([%d]+)%%.*%[([%l]*)")
      l = tonumber(l)
      if alsa.last.level ~= l or alsa.last.status ~= s then
        volume_now = { level = l, status = s }
        widget = alsa.widget
        settings()
        alsa.last = volume_now
      end
    end)
  end

  function alsa.sinks_update(callback)
    alsa.sinks_info = {}
    helpers.async("pactl get-default-sink", function(default_sink_name)
      default_sink_name = default_sink_name:gsub("\n$", "")
      helpers.async(ScriptsDir .. "sink_info",
        function(sink_info)
          local i = 1
          alsa.notification_preset.text = ''
          for line in sink_info:gmatch("[^\n]+") do
            local idx, name, description = line:match("([^,]+),([^,]+),([^,]+)")
            local default = (name == default_sink_name)
            table.insert(alsa.sinks_info,
              { idx = idx, name = name, description = description, default = default })
            if default then
              alsa.sink_selected = i
            end
            i = i + 1
            local sink_str = string.format("%s\t%s", (default) and "(•)" or "", description)
            alsa.notification_preset.text = alsa.notification_preset.text .. sink_str .. "\n"
          end
          if callback then callback() end
        end)
    end)
  end

  local function select_sink(idx, callback)
    helpers.async("pactl set-default-sink " .. idx, callback)
  end

  function alsa.select_next_sink()
    local i = (alsa.sink_selected % #alsa.sinks_info) + 1
    select_sink(alsa.sinks_info[i].idx, function() end)
    alsa.show(0)
  end

  function alsa.select_prev_sink()
    local i = (alsa.sink_selected - 2 + #alsa.sinks_info) % #alsa.sinks_info + 1
    select_sink(alsa.sinks_info[i].idx, function() end)
    alsa.show(0)
  end

  alsa.widget:connect_signal('mouse::enter', function() alsa.show() end)
  alsa.widget:connect_signal('mouse::leave', function() alsa.hide() end)
  helpers.newtimer(string.format("alsa-%s-%s", alsa.cmd, alsa.channel), timeout, alsa.update)

  return alsa
end

return factory
