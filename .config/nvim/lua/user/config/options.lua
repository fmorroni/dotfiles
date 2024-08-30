-- Show ongoing command in statusline
vim.opt.showcmdloc = "statusline"

-- Yank/Paste to/from system clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.relativenumber = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5
