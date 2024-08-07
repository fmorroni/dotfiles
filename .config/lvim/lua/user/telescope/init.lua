require('user.telescope.file_browser')

local actions = require "telescope.actions"
local actions_layout = require("telescope.actions.layout")

lvim.builtin.telescope.defaults.layout_config.scroll_speed = 1

lvim.builtin.telescope.defaults.file_ignore_patterns = { ".git/", "node_modules" }
lvim.builtin.telescope.defaults.find_command = { "fd", "-t=f", "-a" }
lvim.builtin.telescope.defaults.path_display = { "absolute" }
lvim.builtin.telescope.defaults.wrap_results = true

lvim.builtin.telescope.pickers.find_files.previewer = nil
lvim.builtin.telescope.pickers.find_files.theme = 'ivy'
lvim.builtin.telescope.pickers.find_files.hidden = true
lvim.builtin.telescope.pickers.find_files.no_ignore = true

lvim.builtin.telescope.pickers.live_grep.theme = 'ivy'
-- I don't think this actually work for live_grep
-- lvim.builtin.telescope.pickers.live_grep.hidden = true
-- lvim.builtin.telescope.pickers.live_grep.no_ignore = true

lvim.builtin.telescope.pickers.buffers.initial_mode = "insert"

lvim.builtin.telescope.on_config_done = function()
  lvim.builtin.telescope.defaults.mappings.n["<leader>q"] = actions.close
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
  lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev

  lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.n["<C-n>"] = actions.cycle_history_next
  lvim.builtin.telescope.defaults.mappings.n["<C-p>"] = actions.cycle_history_prev

  lvim.builtin.telescope.defaults.mappings.n["<C-d>"] = false
  lvim.builtin.telescope.defaults.mappings.n["<C-u>"] = false
  lvim.builtin.telescope.defaults.mappings.n["<M-k>"] = actions.preview_scrolling_up
  lvim.builtin.telescope.defaults.mappings.n["<M-j>"] = actions.preview_scrolling_down
  lvim.builtin.telescope.defaults.mappings.i["<C-d>"] = false
  lvim.builtin.telescope.defaults.mappings.i["<C-u>"] = false
  lvim.builtin.telescope.defaults.mappings.i["<M-k>"] = actions.preview_scrolling_up
  lvim.builtin.telescope.defaults.mappings.i["<M-j>"] = actions.preview_scrolling_down

  -- Not working bc lunarvim is outdated...
  -- lvim.builtin.telescope.defaults.mappings.n["<M-l>"] = actions.preview_scrolling_right
  -- lvim.builtin.telescope.defaults.mappings.n["<M-h>"] = actions.preview_scrolling_left
  -- lvim.builtin.telescope.defaults.mappings.i["<M-l>"] = actions.preview_scrolling_right
  -- lvim.builtin.telescope.defaults.mappings.i["<M-h>"] = actions.preview_scrolling_left

  lvim.builtin.telescope.defaults.mappings.n["p"] = actions_layout.toggle_preview
end
