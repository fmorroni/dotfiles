local action_state = require "telescope.actions.state"
local zk = require("zk")
local Path = require "plenary.path"

local M = {}

M.new_if_title_not_empty = function(opts)
  if opts.title == '' or opts.title == nil then
    print('Note creation aborted. No title provided.')
  else
    return zk.new(opts)
  end
end

M.new_ask_for_title = function(opts)
  local title = vim.fn.input('Title: ')
  if title == '' or title == nil then
    print('Note creation aborted. No title provided.')
  else
    return zk.new(vim.tbl_extend('force', opts, { title = title }))
  end
end

M.new_current_dir = function(opts)
  return M.new_ask_for_title(vim.tbl_extend('force', opts, { dir = vim.fn.expand('%:p:h') }))
end

M.get_finder_path = function(finder)
  local entry_path
  if finder.files == false then
    local entry = action_state.get_selected_entry()
    entry_path = entry and entry.value or finder.cwd
  end
  return entry_path or finder.path
end

M.get_note_dir = function()
  local path = Path:new(require("zk.util").resolve_notebook_path(0))
  if path:is_dir() then
    return path:absolute()
  else
    return path:parent():absolute()
  end
end

---@param notebook_path string
---@return string? root
local function notebook_root(notebook_path)
  return require("zk.root_pattern_util").root_pattern(".zk")(notebook_path)
end

M.closest_notebook_root = function()
  local root = notebook_root(vim.api.nvim_buf_get_name(0))
  if not root then
    root = notebook_root(vim.fn.getcwd(0))
    if not root and vim.env.ZK_NOTEBOOK_DIR then
      root = vim.env.ZK_NOTEBOOK_DIR
    end
  end
  return root
end

return M
