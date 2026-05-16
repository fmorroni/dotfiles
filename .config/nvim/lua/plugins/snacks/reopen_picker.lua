---@class snacks.Picker
---@field skip_reset boolean

local M = {}

---@type table<string, snacks.picker.Config>
M.reopen_state = {}

---@param picker snacks.Picker
---@param source string
---@param opts? snacks.picker.Config
M.reopen_picker = function(picker, source, opts)
  local on_close = picker.opts.on_close
  picker.opts.on_close = function(picker) ---@diagnostic disable-line
    if not picker.skip_reset then M.reopen_state = {} end
    if type(on_close) == "function" then on_close(picker) end
  end
  local from_source = picker.opts.source
  if from_source then
    M.reopen_state[from_source] = picker.opts
    M.reopen_state[from_source].pattern = picker:filter().pattern
    M.reopen_state[from_source].search = picker:filter().search
  end
  picker.skip_reset = true
  picker:close()
  Snacks.picker.pick(source, vim.tbl_extend("force", M.reopen_state[source] or {}, opts or {}))
end

return M
