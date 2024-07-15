lvim.leader = "space"

---- Which key ----
-- By default <leader>w was mapped to :w! which is fucking stupid...
lvim.builtin.which_key.mappings["w"] = { "<CMD>w<CR>", "Save" }
lvim.builtin.which_key.mappings["q"] = { "<CMD>confirm quit<CR>", "Quit" }
lvim.builtin.which_key.mappings["f"] = { function()
  local themes = require('telescope.themes')
  require("lvim.core.telescope.custom-finders").find_project_files(themes.get_dropdown({ previewer = false }))
end, "Find File" }
lvim.builtin.which_key.mappings["d"]["x"] = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear Breakpoints" }
lvim.builtin.which_key.mappings["z"] = {
  name = "zk",
  -- n = { "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "New note" },
  n = { require('user.telescope.zk_picker'), "Browser and create notes" },
  o = { "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Open note from list" },
  t = { "<Cmd>ZkTags<CR>", "List tags, then notes with selected tag" },
  f = { "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", "Find notes matching query" },
}
lvim.builtin.which_key.vmappings["z"] = {
  name = "zk",
  f = { ":'<,'>ZkMatch<CR>", "Find notes matching current selection" },
}
-- lvim.builtin.which_key.mappings["e"] = { require("tfm").open, "File explorer" }
lvim.builtin.which_key.mappings["e"] = {
  ":Telescope file_browser follow_symlinks=true path=%:p:h select_buffer=true hide_parent_dir=true<CR>",
  "File browser",
}

lvim.keys.normal_mode["<C-a>"] = require('user.utils.general').get_telescope_chosen_file_action

lvim.builtin.which_key.mappings["s"]["w"] = { "<cmd>Telescope grep_string<cr>", "Telescope live grep on current word" }

---- General ----
lvim.keys.normal_mode["<c-p>"] = "<c-i>"
lvim.keys.normal_mode["<tab>"] = ">>"
lvim.keys.normal_mode["<s-tab>"] = "<<"
lvim.keys.normal_mode["<leader>o"] = { 'o<ESC>0"_D', { desc = 'Newline beneath' } }
lvim.keys.normal_mode["<leader>O"] = { 'O<ESC>0"_D', { desc = 'Newline above' } }
lvim.keys.normal_mode["|"] = "$"
lvim.keys.visual_mode["|"] = "$"
-- lvim.keys.normal_mode[";;"] = "<ESC>A;<ESC>"
lvim.keys.insert_mode[";;"] = "<ESC>A;<ESC>"
-- lvim.keys.insert_mode[",z"] = "<"
-- lvim.keys.insert_mode[",Z"] = ">"
-- Remember to swap capslock for esc!!!
-- setxkbmap -option caps:swapescape
-- lvim.keys.insert_mode["jk"] = "<ESC>"
lvim.keys.visual_mode["<tab>"] = ">gv"
lvim.keys.visual_mode["<s-tab>"] = "<gv"
-- Let j and k move through a wrapped line as if it was multiple lines
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"
-- Better paste
-- (need to use the vim api because the lvim api assigns the same mapping to visual and select modes)
-- vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("v", "p", "p:let @+=@0<CR>", { silent = true })
-- In select mode make p insert letter p instead of pasting.
vim.keymap.set("s", "p", "p")

lvim.keys.normal_mode["<c-s>"] = "yiw:%s/\\v<<c-r>\">"
lvim.keys.visual_mode["<c-s>"] = "y:%s/\\v<c-r>=escape(@\", '/\\.*$^~[')<CR>/"

-- Re-run previous command-line command
lvim.keys.normal_mode["<M-.>"] = "@:"
lvim.keys.normal_mode["<leader>:"] = "q:"

-- I never use U and this is a lot more comfortable for redoing.
lvim.keys.normal_mode["U"] = "<c-r>"

-- Doesn't work right for some reason
-- vim.keymap.set("n", "<c-k>", "[m")
-- vim.keymap.set("n", "<M-j>", "]m")
