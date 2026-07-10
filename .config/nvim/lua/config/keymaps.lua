-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", "<leader>o", 'o<ESC>0"_D', { desc = "Newline beneath" })
map("n", "<leader>O", 'O<ESC>0"_D', { desc = "Newline above" })

map("n", "<leader>:", "q:", { desc = "Open advanced command line" })

-- Better paste
map("v", "p", "p:let @+=@0<CR>", { silent = true })
-- In select mode make p insert letter p instead of pasting.
map("s", "p", "p")

map("n", "<c-p>", "<c-i>")
map("n", "<tab>", ">>")
map("n", "<s-tab>", "<<")
map("v", "<tab>", ">gv")
map("v", "<s-tab>", "<gv")

map("i", ";;", "<ESC>A;<ESC>")

map("n", "<leader>Th", function()
  local result = vim.treesitter.get_captures_at_cursor(0)
  vim.notify(vim.inspect(result))
end, { desc = "Show capture groups at cursor" })

local yank_paht_line = function(expand_str)
  local path = vim.fn.expand(expand_str)
  local line = vim.fn.line(".")
  local result = path .. ":" .. line
  vim.fn.setreg("+", result)
  vim.notify(('Yanked "%s"'):format(result, vim.log.levels.INFO))
end

-- Copy path with line number to clipboard
map(
  "n",
  "<leader>yp",
  function() yank_paht_line("%:.") end,
  { desc = "Copy `<relative path>:<line>` to clipboard" }
)
map(
  "n",
  "<leader>Yp",
  function() yank_paht_line("%") end,
  { desc = "Copy `<absolute path>:<line>` to clipboard" }
)

-- From: /home/franco/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua:25
-- Move Lines
map("n", "<Plug>(my-move-down)", "<cmd>execute 'move .+' . v:count1<cr>==")
map("i", "<Plug>(my-move-down)", "<esc><cmd>m .+1<cr>==gi")
map("v", "<Plug>(my-move-down)", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv")
map("n", "<Plug>(my-move-up)", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==")
map("i", "<Plug>(my-move-up)", "<esc><cmd>m .-2<cr>==gi")
map("v", "<Plug>(my-move-up)", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv")

-- Scroll LSP docs, otherwise move lines
map({ "n", "i", "v", "s" }, "<A-j>", function()
  if require("noice.lsp").scroll(4) then
    return ""
  end
  return "<Plug>(my-move-down)"
end, {
  expr = true,
  remap = true,
  silent = true,
  desc = "Scroll docs / Move Down",
})

map({ "n", "i", "v", "s" }, "<A-k>", function()
  if require("noice.lsp").scroll(-4) then
    return ""
  end
  return "<Plug>(my-move-up)"
end, {
  expr = true,
  remap = true,
  silent = true,
  desc = "Scroll docs / Move Up",
})


---- Disable ----

-- Disable tabline toggle
unmap("n", "<leader>uA")
-- Disable tabs
unmap("n", "<leader><tab>l")
unmap("n", "<leader><tab>o")
unmap("n", "<leader><tab>f")
unmap("n", "<leader><tab><tab>")
unmap("n", "<leader><tab>]")
unmap("n", "<leader><tab>d")
unmap("n", "<leader><tab>[")
