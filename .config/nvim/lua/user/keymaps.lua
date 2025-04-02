local map = vim.keymap.set

-- Keybinds to make split navigation easier.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<leader>w', '<CMD>update<CR>', { desc = 'Save file' })
map('n', '<leader>c', '<CMD>bdelete<CR>', {desc = "Close current buffer"})
map('n', '<leader>q', '<CMD>q<CR>', { desc = 'Quit' })

map('n', '<leader>o', 'o<ESC>0"_D', { desc = 'Newline beneath' })
map('n', '<leader>O', 'O<ESC>0"_D', { desc = 'Newline above' })
map("n", "<leader>h", "<CMD>noh<CR>", { desc = "Clear search highlight" })

map('n', "<c-p>", "<c-i>")
map('n', "<tab>", ">>")
map('n', "<s-tab>", "<<")
map('v', "<tab>", ">gv")
map('v', "<s-tab>", "<gv")

map('i', ";;", "<ESC>A;<ESC>")

-- Let j and k move through a wrapped line as if it was multiple lines
map('n', "j", "gj")
map('n', "k", "gk")

-- Better paste
-- map("v", "p", '"_dP')
map("v", "p", "p:let @+=@0<CR>", { silent = true })
-- In select mode make p insert letter p instead of pasting.
map("s", "p", "p")

-- Search and replace
map('n', "<c-s>", "yiw:%s/\\v<<c-r>\">", { desc = 'Search and replace word under cursor in whole file' })
map('v', "<c-s>", "y:%s/\\v<c-r>=escape(@\", '/\\.*$^~[')<CR>/", { desc = 'Search and replace selection in whole file' })

map('n', "<A-.>", "@:", { desc = 'Re-run previous command-line command' })

map('n', "<leader>:", "q:", { desc = 'Open advanced command line' })

-- I never use U and this is a lot more comfortable for redoing.
map('n', "U", "<c-r>")

-- Move line down/up
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

map('n', '<leader>lp', '<CMD>Lazy<CR>')
map('n', '<leader>li', '<CMD>LspInfo<CR>')
