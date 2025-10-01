local function parse_delay(delay)
  local default = 10
  if not delay then return default end -- Default to 10 seconds

  local unit = string.sub(delay, -1)
  local value = tonumber(string.sub(delay, 1, -2))

  if not value then
    mp.osd_message("Invalid delay format. Using default of " .. default .. " seconds.")
    return default
  end

  if unit == "s" then
    return value
  elseif unit == "m" then
    return value * 60   -- Convert minutes to seconds
  elseif unit == "h" then
    return value * 3600 -- Convert hours to seconds
  else
    mp.osd_message("Unknown unit '" .. unit .. "'. Using default of " .. default .. " seconds.")
    return default
  end
end

local function quit_after_timeout(delay)
  local timeout = parse_delay(delay)
  mp.osd_message("Quitting in " .. timeout .. " seconds...")
  mp.add_timeout(timeout, function()
    mp.command("quit-watch-later")
  end)
end

-- mp.add_key_binding("T", "quit_after_timeout", quit_after_timeout)
mp.register_script_message("quit-after-timeout", quit_after_timeout)
