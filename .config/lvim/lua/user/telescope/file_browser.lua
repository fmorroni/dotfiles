local actions = require "telescope.actions"
local fb_actions = require("telescope").extensions.file_browser.actions
local action_state = require "telescope.actions.state"
-- local utils = require('user.utils.general')
local fb_utils = require "telescope._extensions.file_browser.utils"
local Job = require('plenary.job')
local Path = require("plenary.path")

local function trashy_remove(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder
  local quiet = current_picker.finder.quiet
  local selections = fb_utils.get_selected_files(prompt_bufnr, true)
  if vim.tbl_isempty(selections) then
    fb_utils.notify("actions.remove", { msg = "No selection to be removed!", level = "WARN", quiet = quiet })
    return
  end

  -- local files = vim.tbl_map(function(sel)
  --   return sel.filename:sub(#sel:parent().filename + 2)
  -- end, selections)

  for _, sel in ipairs(selections) do
    if sel:is_dir() then
      local abs = sel:absolute()
      local msg
      if finder.files and Path:new(finder.path):parent():absolute() == abs then
        msg = "Parent folder cannot be deleted!"
      end
      if not finder.files and Path:new(finder.cwd):absolute() == abs then
        msg = "Current folder cannot be deleted!"
      end
      if msg then
        fb_utils.notify("actions.remove", { msg = msg .. " Prematurely aborting.", level = "WARN", quiet = quiet })
        return
      end
    end
  end

  local removed = {}

  for _, p in ipairs(selections) do
    -- clean up opened buffers
    if p:is_dir() then
      fb_utils.delete_dir_buf(p:absolute())
    else
      fb_utils.delete_buf(p:absolute())
    end
    Job:new({
      command = 'trashy',
      args = { 'put', p:absolute() },
      on_exit = function(_j, return_val)
        if (return_val == 0) then
          table.insert(removed, p.filename:sub(#p:parent().filename + 2))
        else
          fb_utils.notify(
            "actions.remove",
            { msg = "Error removing: " .. p.filename, level = "ERROR", quiet = quiet }
          )
        end
      end,
    }):sync()
  end
  fb_utils.notify(
    "actions.remove",
    { msg = "Removed: " .. table.concat(removed, ", "), level = "INFO", quiet = quiet }
  )
  current_picker:refresh(current_picker.finder)
end

local mappings = {
  i = {
    ["<bs>"] = false,
    -- c-w is really buggy for reason. By default it will erase a word as intended, but also move into
    -- cwd. But it's also case sensitive to set it (none of the other keybinds are), and it doesn't get
    -- deactivated when set to 'false'.
    ["<C-W>"] = function() P('hola') end,
    -- ['<c-a>'] = fb_actions.create,
  },
  n = {
    ['<s-l>'] = actions.select_default,
    ['<s-h>'] = fb_actions.goto_parent_dir,
    h = false,
    ['<c-a>'] = fb_actions.create,
    c = false,
    ['<c-d>'] = fb_actions.remove,
    d = false,
    ['.'] = fb_actions.toggle_hidden,
    [','] = fb_actions.toggle_respect_gitignore,
  },
}

require("telescope").setup({
  extensions = {
    file_browser = {
      theme = "ivy",
      hide_parent_dir = true,
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      initial_mode = 'normal',
      mappings = mappings,
      attach_mappings = function(prompt_bufnr, map)
        map({ 'i', 'n' }, '<M-k>', actions.preview_scrolling_up)
        map({ 'i', 'n' }, '<M-j>', actions.preview_scrolling_down)
        fb_actions.remove:replace(trashy_remove)
        return true
      end,
      layout_config = { scroll_speed = 1 },
    },
  },
})

require("telescope").load_extension("file_browser")
