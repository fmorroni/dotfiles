-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local group_cdpwd = vim.api.nvim_create_augroup("group_cdpwd", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = group_cdpwd,
  callback = function()
    local arg = vim.fn.argv(0)

    if arg == "" then return end

    local cwd

    if vim.fn.isdirectory(arg) == 1 then
      cwd = vim.fn.fnamemodify(arg, ":p")
    else
      cwd = vim.fn.fnamemodify(arg, ":p:h")
    end

    vim.cmd.cd(vim.fn.fnameescape(cwd))
  end,
})
