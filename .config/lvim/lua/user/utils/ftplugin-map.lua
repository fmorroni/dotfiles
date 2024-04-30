local M = {}
M.map = function(mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs,
    vim.tbl_extend('force', { noremap = true, silent = false }, opts))
end

return M
