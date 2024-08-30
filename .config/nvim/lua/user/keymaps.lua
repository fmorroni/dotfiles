local map = vim.keymap.set

-- Keybinds to make split navigation easier.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<leader>w', '<CMD>update<CR>', { desc = 'Save file' })
map('n', '<leader>o', 'o<ESC>0"_D', { desc = 'Newline beneath' })
map('n', '<leader>O', 'O<ESC>0"_D', { desc = 'Newline above' })
map('n', 'q', '<CMD>q<CR>', { desc = 'Quit' })
