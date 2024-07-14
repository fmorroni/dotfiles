--[[

     Awesome WM configuration template
     github.com/lcpz

--]]

-- {{{ Required libraries

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget.new({
  width = 1800,
  height = 950,
  -- group_rules = require("awful.hotkeys_popup.keys"),
})
-- require("awful.hotkeys_popup.keys.vim")

local helpers       = require("libs.helpers")

local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility

local home          = os.getenv("HOME")
ScriptsDir          = home .. "/scripts/bin/"
local function runUserScript(scriptName, paramsTable, callback)
  local params = paramsTable and table.concat(paramsTable, ' ') or ''
  local retFunc
  if callback then
    retFunc = function() awful.spawn.easy_async(ScriptsDir .. scriptName .. " " .. params, callback) end
  else
    retFunc = function() awful.spawn(ScriptsDir .. scriptName .. " " .. params) end
  end
  return retFunc
end

-- }}}

-- {{{ Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify {
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  }
end

-- Handle runtime errors after startup
do
  local in_error = false

  awesome.connect_signal("debug::error", function(err)
    if in_error then return end

    in_error = true

    naughty.notify {
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    }

    in_error = false
  end)
end

-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    -- Necesary because process names for some reason remove all quotations... This may bring other problems in the future tho.
    local cmd_no_quotes = cmd:gsub('["\']', '')
    -- awful.spawn.easy_async_with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd_no_quotes, cmd),
    --   helpers.notifyCommandExitInfo(cmd))
    awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd_no_quotes, cmd))
  end
end

local lockTimeoutMins = 5
local suspendTimeoutMins = 7
local autolock = {
  cmd = string.format('%s %s %s %s %s %s',
    'xautolock',
    '-notify ' .. (suspendTimeoutMins - lockTimeoutMins) * 60,
    '-notifier "lockscreen"',
    '-time ' .. suspendTimeoutMins,
    '-locker "systemctl suspend"',
    '-detectsleep'
  ),
  on = true,
  state = 'enabled',
}

run_once({
  'setxkbmap latam',
  'setxkbmap -option caps:swapescape',
  'nm-applet',
  autolock.cmd,
  -- 'pasystray',
  'picom -b',
  'greenclip daemon'
})

-- This function implements the XDG autostart specification
--[[ awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
) ]]

-- }}}

-- {{{ Variable definitions

local theme         = "powerarrow-dark"
local modkey        = "Mod4"
local altkey        = "Mod1"
local shiftKey      = "Shift"
local ctrlKey       = "Control"
local terminal      = "kitty"
local editor        = os.getenv("EDITOR") or "nvim"
local editor_cmd    = terminal .. " -e " .. editor .. " "
local browser       = "brave"

awful.util.terminal = terminal
awful.util.tagnames = {}
for i = 1, 9 do
  table.insert(awful.util.tagnames, tostring(i))
end

awful.layout.layouts                   = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
}

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

-- Mouse button support for switching workspaces
awful.util.taglist_buttons             = mytable.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then client.focus:move_to_tag(t) end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then client.focus:toggle_tag(t) end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons            = mytable.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function() awful.client.focus.byidx(1) end),
  awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", home, theme))

-- }}}

-- {{{ Screen

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end)

-- No borders for maximized client
screen.connect_signal("arrange", function(s)
  for _, c in pairs(s.clients) do
    if c.maximized or c.fullscreen then
      c.border_width = 0
    else
      c.border_width = beautiful.border_width
    end
  end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- }}}

-- {{{ Mouse bindings

root.buttons(mytable.join(
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

-- }}}

-- {{{ Key bindings

local globalkeys = mytable.join(
  awful.key({ modkey }, "space", function() naughty.destroy_all_notifications() end,
    { description = ": Destroy all notifications", group = "hotkeys" }),
  awful.key({ modkey }, "s", function() hotkeys_popup:show_help() end,
    { description = ": Show help", group = "awesome" }),

  -- Tag browsing
  awful.key({ modkey }, "Left", awful.tag.viewprev,
    { description = ": View previous", group = "tag" }),
  awful.key({ modkey }, "Right", awful.tag.viewnext,
    { description = ": View next", group = "tag" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore,
    { description = ": Go back", group = "tag" }),

  -- Client focus
  awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end,
    { description = ": Focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end,
    { description = ": Focus previous by index", group = "client" }),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto,
    { description = ": Jump to urgent client", group = "client" }),
  awful.key({ modkey }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = ": Go back", group = "client" }),
  awful.key({ modkey, ctrlKey }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = ": Restore minimized", group = "client" }),
  awful.key({ modkey, shiftKey }, "m", function()
      client.focus = awful.client.getmaster()
      client.focus:raise()
    end,
    { description = ": Focus master", group = "client" }),


  -- By-direction client focus
  -- awful.key({ modkey }, "j",
  --   function()
  --     awful.client.focus.global_bydirection("down")
  --     if client.focus then client.focus:raise() end
  --   end,
  --   { description = ": Focus down", group = "client" }),
  -- awful.key({ modkey }, "k",
  --   function()
  --     awful.client.focus.global_bydirection("up")
  --     if client.focus then client.focus:raise() end
  --   end,
  --   { description = ": Focus up", group = "client" }),
  -- awful.key({ modkey }, "h",
  --   function()
  --     awful.client.focus.global_bydirection("left")
  --     if client.focus then client.focus:raise() end
  --   end,
  --   { description = ": Focus left", group = "client" }),
  -- awful.key({ modkey }, "l",
  --   function()
  --     awful.client.focus.global_bydirection("right")
  --     if client.focus then client.focus:raise() end
  --   end,
  --   { description = ": Focus right", group = "client" }),

  -- Layout manipulation
  awful.key({ modkey, shiftKey }, "j", function() awful.client.swap.byidx(1) end,
    { description = ": Swap with next client by index", group = "client" }),
  awful.key({ modkey, shiftKey }, "k", function() awful.client.swap.byidx(-1) end,
    { description = ": Swap with previous client by index", group = "client" }),
  awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.01) end,
    { description = ": Increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.01) end,
    { description = ": Decrease master width factor", group = "layout" }),
  awful.key({ modkey, shiftKey }, "h", function() awful.tag.incnmaster(1, nil, true) end,
    { description = ": Increase the number of master clients", group = "layout" }),
  awful.key({ modkey, shiftKey }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = ": Decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, ctrlKey }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = ": Increase the number of columns", group = "layout" }),
  awful.key({ modkey, ctrlKey }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = ": Decrease the number of columns", group = "layout" }),
  awful.key({ modkey, altkey }, "space", function() awful.layout.inc(1) end,
    { description = ": Select next", group = "layout" }),
  awful.key({ modkey, altkey, shiftKey }, "space", function() awful.layout.inc(-1) end,
    { description = ": Select previous", group = "layout" }),

  -- Screen focus
  awful.key({ modkey, ctrlKey }, "j", function() awful.screen.focus_relative(1) end,
    { description = ": Focus the next screen", group = "screen" }),
  awful.key({ modkey, ctrlKey }, "k", function() awful.screen.focus_relative(-1) end,
    { description = ": Focus the previous screen", group = "screen" }),

  -- Show/hide wibox
  awful.key({ modkey }, "z", function()
      for s in screen do
        s.mywibox.visible = not s.mywibox.visible
        if s.mybottomwibox then
          s.mybottomwibox.visible = not s.mybottomwibox.visible
        end
      end
    end,
    { description = ": Toggle wibox", group = "awesome" }),

  -- On-the-fly useless gaps change
  awful.key({ modkey, altkey, ctrlKey }, "+", function() lain.util.useless_gaps_resize(1) end,
    { description = ": Increment useless gaps", group = "tag" }),
  awful.key({ modkey, altkey, ctrlKey }, "-", function() lain.util.useless_gaps_resize(-1) end,
    { description = ": Decrement useless gaps", group = "tag" }),

  -- Dynamic tagging
  -- awful.key({ modkey, shiftKey }, "n", function() lain.util.add_tag() end,
  --   { description = ": Add new tag", group = "tag" }),
  -- awful.key({ modkey, shiftKey }, "r", function() lain.util.rename_tag() end,
  --   { description = ": Rename tag", group = "tag" }),
  -- awful.key({ modkey, shiftKey }, "Left", function() lain.util.move_tag(-1) end,
  --   { description = ": Move tag to the left", group = "tag" }),
  -- awful.key({ modkey, shiftKey }, "Right", function() lain.util.move_tag(1) end,
  --   { description = ": Move tag to the right", group = "tag" }),
  -- awful.key({ modkey, shiftKey }, "d", function() lain.util.delete_tag() end,
  --   { description = ": Delete tag", group = "tag" }),

  -- Standard program
  awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
    { description = ": Open a terminal", group = "launcher" }),
  awful.key({ modkey, ctrlKey }, "r", awesome.restart,
    { description = ": Reload awesome", group = "awesome" }),
  awful.key({ modkey, shiftKey }, "e", function()
      awful.spawn(editor_cmd .. " " .. awesome.conffile)
    end,
    { description = ": Edit config", group = "awesome" }),
  -- awful.key({ modkey, shiftKey }, "q", awesome.quit,
  --   { description = ": Quit awesome", group = "awesome" }),

  -- Dropdown application
  awful.key({ modkey }, "q", function() awful.screen.focused().quake:toggle() end,
    { description = ": Dropdown application", group = "launcher" }),

  -- Screen brightness
  awful.key({}, "XF86MonBrightnessUp", runUserScript("brightnessIncBy", { 1 }, beautiful.brightness.update),
    { description = ": +1% screen brightness", group = "hotkeys" }),
  awful.key({}, "XF86MonBrightnessDown", runUserScript("brightnessIncBy", { -1 }, beautiful.brightness.update),
    { description = ": -1% screen brightness", group = "hotkeys" }),
  awful.key({ shiftKey }, "XF86MonBrightnessUp", runUserScript("brightnessIncBy", { 10 }, beautiful.brightness.update),
    { description = ": +10% screen brightness", group = "hotkeys" }),
  awful.key({ shiftKey }, "XF86MonBrightnessDown", runUserScript("brightnessIncBy", { -10 }, beautiful.brightness.update),
    { description = ": -10% screen brightness", group = "hotkeys" }),
  -- awful.key({}, "XF86MonBrightnessDown", function() os.execute("xbacklight -dec 2 -time 20 -steps 10") end,
  --   { description = ": Decrease screen brightness", group = "hotkeys" }),

  -- ALSA volume control
  awful.key({}, "XF86AudioRaiseVolume",
    function()
      awful.spawn.easy_async("amixer -q set " .. beautiful.volume.channel .. " 1%+", beautiful.volume.update)
    end,
    { description = ": Volume up", group = "hotkeys" }),
  awful.key({}, "XF86AudioLowerVolume",
    function()
      awful.spawn.easy_async("amixer -q set " .. beautiful.volume.channel .. " 1%-", beautiful.volume.update)
    end,
    { description = ": Volume down", group = "hotkeys" }),
  awful.key({}, "XF86AudioMute",
    function()
      -- helpers.debug_print("Muting")
      awful.spawn.easy_async(
        "amixer -q set " .. (beautiful.volume.togglechannel or beautiful.volume.channel) .. " toggle",
        beautiful.volume.update)
    end,
    { description = ": Toggle mute", group = "hotkeys" }),

  -- User programs
  awful.key({ modkey }, "b", function() awful.spawn(browser) end,
    { description = ": Open browser", group = "launcher" }),
  awful.key({ modkey, shiftKey }, "b", function() awful.util.spawn(browser .. " --new-window --incognito") end,
    { description = ": Open browser in incognito", group = "launcher" }),
  awful.key({ modkey, shiftKey }, "s", function() awful.util.spawn("flameshot gui") end,
    { description = ": Snipping tool", group = "launcher" }),
  awful.key({ modkey, shiftKey, ctrlKey }, "s", function() awful.util.spawn("flameshot gui --delay 2000") end,
    { description = ": Snipping tool 2s delay", group = "launcher" }),
  awful.key({ modkey }, "r", runUserScript("rofi_launcher"),
    { description = ": Run rofi", group = "launcher" }),
  awful.key({ modkey }, "x", runUserScript("lockscreen"),
    { description = ": Lock screen", group = "launcher" }),
  awful.key({ modkey }, "v", runUserScript("rofi_clipboard"),
    { description = ": Open clipboard", group = "launcher" }),
  awful.key({ modkey }, "p", runUserScript("rofi_power_menu"),
    { description = ": Power menu", group = "launcher" }),
  awful.key({ modkey, shiftKey }, "r", runUserScript("screenrecording"),
    { description = ": Power menu", group = "launcher" }),
  awful.key({ modkey, shiftKey }, "x", function()
      if autolock.on then
        awful.spawn("xautolock -exit")
        autolock.on = false
        autolock.state = 'disabled'
      else
        awful.spawn(autolock.cmd)
        autolock.on = true
        autolock.state = 'enabled'
      end
      naughty.notify({ text = "Autolock " .. autolock.state, timeout = 2 })
    end,
    { description = ": Toggle autolock", group = "launcher" })
)

local clientkeys = mytable.join(
  awful.key({ modkey }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = ": Toggle fullscreen", group = "client" }),
  awful.key({ modkey, shiftKey }, "c", function(c) c:kill() end,
    { description = ": Close", group = "client" }),
  -- awful.key({ modkey, ctrlKey }, "space", awful.client.floating.toggle,
  --   { description = ": Toggle floating", group = "client" }),
  awful.key({ modkey, ctrlKey }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = ": Move to master", group = "client" }),
  awful.key({ modkey }, "o", function(c) c:move_to_screen() end,
    { description = ": Move to screen", group = "client" }),
  awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end,
    { description = ": Toggle keep on top", group = "client" }),
  awful.key({ modkey }, "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = ": Minimize", group = "client" }),
  awful.key({ modkey }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = ": (un)maximize", group = "client" }),
  awful.key({ modkey, ctrlKey }, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = ": (un)maximize vertically", group = "client" }),
  awful.key({ modkey, shiftKey }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = ": (un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = mytable.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = ": View tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, ctrlKey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = ": Toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, shiftKey }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = ": Move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, ctrlKey, shiftKey }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = ": Toggle focused client on tag #" .. i, group = "tag" })
  )
end

local clientbuttons = mytable.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

-- Rules to apply to new clients (through the "manage" signal).
-- `xprop` command to find class (WM_CLASS second value), instance (WM_CLASS first value)
-- or name (WM_NAME). Clients can be identified by any of this values.
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      callback = awful.client.setslave,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false
    }
  },

  {
    rule = { name = 'Brave-browser' },
    properties = { maximize = true },
  },

  -- Floating clients.
  {
    rule_any = {
      class = { "Qemu-system-x86_64", "PomodoroTimer" },
      instance = {},
      name = { "Picture in picture" },
    },
    properties = { floating = true, ontop = true }
  },
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- switch to parent after closing child window
local function backham()
  local s = awful.screen.focused()
  local c = awful.client.focus.history.get(s, 0)
  if c then
    client.focus = c
    c:raise()
  end
end

-- attach to minimized state
client.connect_signal("property::minimized", backham)
-- attach to closed state
client.connect_signal("unmanage", backham)
-- ensure there is always a selected client during tag switching or logins
tag.connect_signal("property::selected", backham)

-- }}}
