function on_pause_show_progress_bar(name, value)
  if value == true then
    mp.commandv("script-message", "osc-visibility", "always", "no-osd")
  else
    mp.add_timeout(0.5, function() 
      mp.commandv("script-message", "osc-visibility", "auto", "no-osd")
   end)
  end
end
mp.observe_property("pause", "bool", on_pause_show_progress_bar)

-- function on_seek_show_progress_bar()
--   print("seek")
--   mp.commandv("script-message", "osc-visibility", "always", "no-osd")
--   mp.add_timeout(0.5, function() 
--     mp.commandv("script-message", "osc-visibility", "auto", "no-osd")
--   end)
-- end
-- mp.observe_property("playback-time", "native", on_seek_show_progress_bar)
