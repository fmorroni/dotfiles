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
        path = "~/projects/livecalc/tree-sitter-livecalc",
        generate = true,
        queries = "queries",
      },
    }
  end,
})

return {
  {
    dir = "~/projects/livecalc/livecalc.nvim/",
    ft = "livecalc",
    opts = {},
  },
}
