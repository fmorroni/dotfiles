-- local actions = require "telescope.actions"
local fb_actions = require("telescope").extensions.file_browser.actions
local fb_utils = require "telescope._extensions.file_browser.utils"
local zk_actions = require("user.telescope.zk_picker.actions")
local themes = require('telescope.themes')
local utils = require('user.telescope.zk_picker.utils')

local zk_opts = {
  prompt_title    = "Notes browser",
  hide_parent_dir = true,
  attach_mappings = function(prompt_bufnr, map)
    -- map({ "i", "n" }, "t", function(_prompt_bufnr)
    --   local current_picker = action_state.get_current_picker(prompt_bufnr)
    --   local finder = current_picker.finder
    --   P(get_target_dir(finder))
    -- end)
    -- fb_actions.remove:replace(function() end)
    -- fb_actions.create:replace(function() end)
    fb_actions.create_from_prompt:replace(zk_actions.create_note_from_prompt)
    fb_actions.goto_parent_dir:replace(zk_actions.goto_parent_dir)
    fb_actions.goto_cwd:replace(zk_actions.goto_cwd)
    return true
  end,
}

local zk_picker = function()
  -- require('telescope').extensions.file_browser._picker(zk_opts)
  zk_opts.cwd = utils.closest_notebook_root()
  if not zk_opts.cwd then
    fb_utils.notify(
      "zk_picker",
      { msg = "Can't open picker, no notebook found", level = "WARN" }
    )
    return
  end
  zk_opts.path = utils.get_note_dir()
  require('telescope').extensions.file_browser.file_browser(themes.get_dropdown(zk_opts))
end

return zk_picker
