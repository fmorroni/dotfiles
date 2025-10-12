return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>ft", "<CMD>TodoTelescope<CR>", desc = "Find TODO comments" },
    },
  },
}
