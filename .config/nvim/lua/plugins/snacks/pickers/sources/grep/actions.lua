---@type table<string, snacks.picker.Action.spec> actions used by keymaps
return {
  switch_files = function(picker)
    require("plugins.snacks.reopen_picker").reopen_picker(
      picker,
      "files",
      { pattern = picker:filter().search }
    )
  end,
}
