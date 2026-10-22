---@param picker snacks.Picker
---@param win string
local function focus_normal_mode(picker, win)
  picker:focus(win)
  vim.api.nvim_input("<Esc>") -- set to normal mode
end

-- Line in the real file that corresponds to the preview cursor, or nil if unknown.
---@param picker snacks.Picker
---@param item snacks.picker.Item
---@return number[]? pos
local function preview_cursor_pos(picker, item)
  local win = picker.preview.win.win
  if not win or not vim.api.nvim_win_is_valid(win) then return end
  local cursor = vim.api.nvim_win_get_cursor(win)
  -- The fancy diff preview stores per-row info: `{ diff = { side, file, line } }`.
  local buf = vim.api.nvim_win_get_buf(win)
  local meta = Snacks.picker.highlight.meta(buf)
  if meta then
    -- Deleted lines only have an old ("left") line number, so take the next line that
    -- has a new one. Stop if it belongs to a different file than the item.
    for row = cursor[1], vim.api.nvim_buf_line_count(buf) do
      local diff = meta[row] and meta[row].diff
      if diff and diff.file ~= item.file then return end
      if diff and diff.side == "right" then return { diff.line, 0 } end
    end
    return
  end
  local preview = picker.opts.preview
  if preview == nil or preview == "file" then return cursor end
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
  print_file_name = function(_, item) vim.notify(item.file, "info") end,
  -- Like `confirm`, but jumps to the line under the cursor in the preview.
  confirm_preview_cursor = function(picker, item)
    local pos = item and preview_cursor_pos(picker, item)
    if not pos then return picker:action("confirm") end
    local prev = item.pos
    item.pos = pos
    picker:action("confirm")
    item.pos = prev
  end,
  grep_list = function(picker)
    local picked = picker:selected({ fallback = false })
    local items = #picked > 0 and picked or picker:items()

     -- `Snacks.picker.grep()` toggles off an already-open grep picker,
     -- so close before opening.
     for _, p in ipairs(Snacks.picker.get({ source = "grep" })) do
       p:close()
     end

    local glob = vim.iter(items):map(function(item) return item.file end):totable()
    Snacks.picker.grep({ glob = glob, title = ("Grep list (%d selected)"):format(#glob) })
  end,
}
