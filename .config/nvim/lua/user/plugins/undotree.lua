return {
  {
    "mbbill/undotree",
    init = function() vim.g.undotree_WindowLayout = 2 end,
    keys = {
      { "<leader>ut", "<CMD>UndotreeToggle<CR>", "Toggle undotree" },
    },
  },
}
