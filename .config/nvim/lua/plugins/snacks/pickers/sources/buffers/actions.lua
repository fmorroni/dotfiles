---@type table<string, snacks.picker.Action.spec> actions used by keymaps
return {
  toggle_cwd = function(picker)
    -- NOTE: `filter.all` is computed during `filter:init` and won't be
    -- updated when `picker.opts.filter.cwd` changes
    picker.input.filter.all = false
    picker.opts.filter.cwd = not picker.opts.filter.cwd
    -- NOTE: Preserve the cursor position
    picker.list:set_target()
    picker:find()
  end,
}
