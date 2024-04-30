local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
-- local fb_actions = require("telescope").extensions.file_browser.actions
local transform_mod = require("telescope.actions.mt").transform_mod
local Path = require "plenary.path"
local fb_utils = require "telescope._extensions.file_browser.utils"
local zk = require('zk')
local utils = require('user.telescope.zk_picker.utils')

local zk_actions = {}

zk_actions.create_note_from_prompt = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local input = current_picker:_get_prompt()
  local finder = current_picker.finder
  local dir = utils.get_finder_path(finder)
  actions.close(prompt_bufnr)
  zk.new({ title = input, dir = dir })
end

-- https://github.com/nvim-telescope/telescope-file-browser.nvim/blob/3bece973c5d80e7da447157822d5b0e73558d361/lua/telescope/_extensions/file_browser/actions.lua#L34
---@param prompt_bufnr number: The prompt bufnr
zk_actions.goto_parent_dir = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder
  local parent_dir = Path:new(finder.path):parent():absolute()
  local current_dir = finder.path

  local root_dir = Path:new(current_picker.cwd):normalize()
  local current_path = Path:new(finder.path):normalize()
  if root_dir == current_path then
    fb_utils.notify(
      "action.goto_parent_dir",
      { msg = "You cannot bypass the current working directory!", level = "WARN", quiet = finder.quiet }
    )
    return
  end

  finder.path = parent_dir
  fb_utils.redraw_border_title(current_picker)
  fb_utils.selection_callback(current_picker, current_dir)
  current_picker:refresh(
    finder,
    { new_prefix = fb_utils.relative_path_prefix(finder), reset_prompt = true, multi = current_picker._multi }
  )
end

---@param prompt_bufnr number: The prompt bufnr
zk_actions.goto_cwd = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder
  finder.path = current_picker.cwd

  fb_utils.redraw_border_title(current_picker)
  current_picker:refresh(
    finder,
    { new_prefix = fb_utils.relative_path_prefix(finder), reset_prompt = true, multi = current_picker._multi }
  )
end

-- This doesn't work, I need a pure function to pass action:replace, not another action.
-- And isn't necessary anyways.
-- zk_actions = transform_mod(zk_actions)

return zk_actions
