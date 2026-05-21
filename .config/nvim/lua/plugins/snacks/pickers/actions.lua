---@param picker snacks.Picker
---@param win string
local function focus_normal_mode(picker, win)
  picker:focus(win)
  vim.api.nvim_input("<Esc>") -- set to normal mode
end

---@type table<string, snacks.picker.Action.spec> actions used by keymaps
return {
  toggle_only_preview = function(picker)
    ---@class snacks.Picker.only_preview : snacks.Picker
    ---@field only_preview boolean
    ---@field prev_layout snacks.picker.layout.Config
    ---@field prev_focus string?

    ---@cast picker snacks.Picker.only_preview

    local fullscreen = picker.layout.opts.fullscreen
    picker.only_preview = not picker.only_preview
    if picker.only_preview then
      picker.prev_layout = picker.resolved_layout
      picker.prev_focus = picker:current_win()
      -- Modify layout (shallow)
      local new = vim.deepcopy(picker.resolved_layout)
      for i = #new.layout, 1, -1 do
        local widget = new.layout[i]
        if widget.win == "preview" then
          widget.width = 0
        else
          -- table.remove(new.layout, i)

          -- Better than removing completely because I can still scroll trhough list.
          widget.width = 0.1
        end
      end
      picker:focus("preview")
      picker:set_layout(new)
    else
      picker:set_layout(picker.prev_layout)
      focus_normal_mode(picker, picker.prev_focus)
    end
    if fullscreen then picker.layout:maximize() end
  end,
  toggle_help_preview = function(picker) picker.preview.win:toggle_help() end,
  focus_input_normal_mode = function(picker) focus_normal_mode(picker, "input") end,
}
