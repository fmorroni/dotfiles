vim.opt.shell = "/bin/bash"
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.wrap = true
vim.opt.nrformats.append(vim.opt.nrformats, 'alpha')
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 1
