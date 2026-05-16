---@type table<string, snacks.picker.Action.spec> actions used by keymaps
return {
  switch_grep = function(picker)
    require("plugins.snacks.reopen_picker").reopen_picker(
      picker,
      "grep",
      { search = picker:filter().pattern }
    )
  end,
}
