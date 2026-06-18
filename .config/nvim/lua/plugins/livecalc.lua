vim.filetype.add({
  extension = {
    lc = "livecalc",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "livecalc",
  callback = function() vim.bo.commentstring = "// %s" end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").livecalc = {
      install_info = {
        url = "https://github.com/fmorroni/tree-sitter-livecalc",
        queries = "queries",
      },
    }
  end,
})

return {
  {
    "fmorroni/livecalc.nvim",
    branch = "livecalc-dsl",
    ft = "livecalc",
    opts = {},
  },
}
