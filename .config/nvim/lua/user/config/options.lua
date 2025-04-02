-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Show ongoing command in statusline
vim.opt.showcmdloc = "statusline"

-- Yank/Paste to/from system clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.relativenumber = true
-- Absolute number for current line
vim.opt.number = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Confirm to save changes before exiting modified buffer.
vim.opt.confirm = true

-- Use spaces instead of tabs.
vim.opt.expandtab = true
-- Size of an indent.
vim.opt.shiftwidth = 2
-- Round indent to multiple of `shiftwidth`.
vim.opt.shiftround = true
-- Number of spaces tabs count for.
vim.opt.tabstop = 2
-- Insert indents automatically.
vim.opt.smartindent = true

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldlevel = 5

-- Enable line wrap.
vim.opt.wrap = true
-- Wrap lines at convenient points.
vim.opt.linebreak = true

-- Automatically saves undo history to an undo file.
vim.opt.undofile = true

-- Allow cursor to move where there is no text in visual block mode.
vim.opt.virtualedit = "block"

-- Can increment letters.
vim.opt.nrformats:append('alpha')

-- Add code breadcrumbs to winbar.
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
