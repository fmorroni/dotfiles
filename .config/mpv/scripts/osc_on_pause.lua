function on_pause_change(name, value)
  if value == true then
    mp.commandv("script-message", "osc-visibility", "always", "no-osd")
  else
    mp.add_timeout(0.5, function() 
      mp.commandv("script-message", "osc-visibility", "auto", "no-osd")
   end)
  end
end
mp.observe_property("pause", "bool", on_pause_change)
