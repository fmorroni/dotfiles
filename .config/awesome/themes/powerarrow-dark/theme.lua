--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz

--]]

local helpers                                   = require("libs.helpers")

local gears                                     = require("gears")
local lain                                      = require("lain")
local awful                                     = require("awful")
local wibox                                     = require("wibox")
local dpi                                       = require("beautiful.xresources").apply_dpi

local os                                        = os
local my_table                                  = awful.util.table or gears.table -- 4.{0,1} compatibility
local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-dark"
theme.wallpaper                                 = theme.dir .. "/neon.png"
theme.font                                      = "Terminus 9"
theme.fg_normal                                 = "#DDDDFF"
theme.fg_focus                                  = "#EA6F81"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#1A1A1A"
theme.bg_focus                                  = "#313131"
theme.bg_urgent                                 = "#1A1A1A"
theme.tasklist_bg_focus                         = theme.bg_focus --"#1A1A1A"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.widget_bluetooth_on                       = theme.dir .. "/icons/bluetooth_on.png"
theme.widget_bluetooth_off                      = theme.dir .. "/icons/bluetooth_off.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

theme.useless_gap                               = dpi(4)
theme.border_width                              = dpi(2)
theme.border_normal                             = "#000000"
theme.border_focus                              = "#7fa2a3"
theme.border_marked                             = "#91231c"

theme.hotkeys_font                              = 'Sans 11'
theme.hotkeys_description_font                  = 'Sans 11'
theme.hotkeys_modifiers_fg                      = '#595959'
theme.hotkeys_group_margin                      = 50

local markup                                    = lain.util.markup
local separators                                = lain.util.separators

local keyboardlayout                            = awful.widget.keyboardlayout:new()

-- Textclock
-- local clockicon                                 = wibox.widget.imagebox(theme.widget_clock)
local clock                                     = awful.widget.watch(
  "date +'%a %d %b %R'", 60,
  function(widget, stdout)
    widget:set_markup(" " .. markup.font(theme.font, stdout))
  end
)

-- Calendar
theme.cal                                       = lain.widget.cal({
  attach_to = { clock },
  notification_preset = {
    font = "Monospace 10",
    fg   = theme.fg_normal,
    bg   = theme.bg_normal
  }
})

-- MEM
local memicon                                   = wibox.widget.imagebox(theme.widget_mem)
local mem                                       = lain.widget.mem({
  settings = function()
    widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
  end
})

-- CPU
local cpuicon                                   = wibox.widget.imagebox(theme.widget_cpu)
local cpu                                       = lain.widget.cpu({
  settings = function()
    widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
  end
})

-- Coretemp
local tempicon                                  = wibox.widget.imagebox(theme.widget_temp)
local temp                                      = lain.widget.temp({
  settings = function()
    widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
  end
})

-- / fs
-- local fsicon = wibox.widget.imagebox(theme.widget_hdd)
-- -- commented because it needs Gio/Glib >= 2.54
-- theme.fs = lain.widget.fs({
--   notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
--   settings = function()
--     widget:set_markup(markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
--   end
-- })

-- Battery
local baticon                                   = wibox.widget.imagebox(theme.widget_battery)
local bat                                       = lain.widget.bat({
  settings = function()
    if bat_now.status and bat_now.status ~= "N/A" then
      if bat_now.ac_status == 1 then
        baticon:set_image(theme.widget_ac)
      elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
        baticon:set_image(theme.widget_battery_empty)
      elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
        baticon:set_image(theme.widget_battery_low)
      else
        baticon:set_image(theme.widget_battery)
      end
      widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
    else
      widget:set_markup(markup.font(theme.font, " AC "))
      baticon:set_image(theme.widget_ac)
    end
  end
})

-- ALSA volume
local volicon                                   = wibox.widget.imagebox(theme.widget_vol)
theme.volume                                    = lain.widget.alsa({
  notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
  settings = function()
    if volume_now.status == "off" then
      volicon:set_image(theme.widget_vol_mute)
    elseif tonumber(volume_now.level) == 0 then
      volicon:set_image(theme.widget_vol_no)
    elseif tonumber(volume_now.level) <= 50 then
      volicon:set_image(theme.widget_vol_low)
    else
      volicon:set_image(theme.widget_vol)
    end
    widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
  end
})
theme.volume.widget:buttons(awful.util.table.join(
  awful.button({}, 1, function()
    theme.volume.select_next_sink()
  end),
  awful.button({}, 3, function()
    theme.volume.select_prev_sink()
  end),
  awful.button({}, 4, function()
    awful.util.spawn("amixer set Master 1%+")
    theme.volume.update()
  end),
  awful.button({}, 5, function()
    awful.util.spawn("amixer set Master 1%-")
    theme.volume.update()
  end)
))

-- Net
-- local neticon = wibox.widget.imagebox(theme.widget_net)
-- local net     = lain.widget.net({
--   settings = function()
--     widget:set_markup(markup.font(theme.font,
--       markup("#7AC82E", " " .. string.format("%06.1f", net_now.received))
--       .. " " ..
--       markup("#46A8C3", " " .. string.format("%06.1f", net_now.sent) .. " ")))
--   end
-- })

-- Brightness
local brightness_icon = wibox.widget.textbox('☼')
brightness_icon.font  = 'Terminus 13'
theme.brightness      = lain.widget.brightness({
  settings = function()
    widget:set_markup(markup.font(theme.font, " " .. brightness_now .. "% "))
  end
})

-- Bluetooth
-- local bluetooth_icon  = wibox.widget.imagebox(theme.widget_bluetooth_off)
-- bluetooth_icon.font   = 'Terminus 13'
-- theme.bluetooth       = lain.widget.bluetooth({
--   settings = function()
--     if bluetooth_on then
--       volicon:set_image(theme.widget_bluetooth_on)
--     else
--       volicon:set_image(theme.widget_bluetooth_off)
--     end
--   end
-- })

-- Separators
local spr             = wibox.widget.textbox('  ')
local arrl_dl         = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld         = separators.arrow_left("alpha", theme.bg_focus)

local function right_widgets_apply_bg(widgets)
  local result = { layout = wibox.layout.fixed.horizontal }
  for i, element in ipairs(widgets) do
    if i % 2 == 0 then
      table.insert(result, arrl_ld)
      for _, sub_element in ipairs(element) do
        table.insert(result, wibox.container.background(sub_element, theme.bg_focus))
      end
      table.insert(result, arrl_dl)
    else
      for _, sub_element in ipairs(element) do
        table.insert(result, sub_element)
      end
    end
  end
  return result
end

function theme.at_screen_connect(s)
  -- Quake application
  s.quake = lain.util.quake({
    app = awful.util.terminal,
    argname = '--class %s',
    height = 0.35,
    followtag = true,
  })

  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  -- Tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(my_table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 2, function() awful.layout.set(awful.layout.layouts[1]) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })

  s.mywidgetbox = right_widgets_apply_bg({
    { spr,             spr,                wibox.widget.systray(), spr },
    { keyboardlayout },
    { volicon,         theme.volume.widget },
    { brightness_icon, spr,                theme.brightness.widget },
    -- { spr,             bluetooth_icon,     theme.bluetooth.widget },
    { memicon,         mem.widget },
    { cpuicon,         cpu.widget },
    { tempicon,        temp.widget },
    -- { fsicon,        theme.fs.widget },
    { baticon,         bat.widget },
    -- { neticon,       net.widget },
    { clock,           spr },
    { s.mylayoutbox },
  })
  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      -- spr,
      s.mytaglist,
      s.mypromptbox,
      spr,
    },
    s.mytasklist, -- Middle widget
    s.mywidgetbox,
  }
end

return theme
