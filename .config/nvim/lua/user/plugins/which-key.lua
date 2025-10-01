return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f",  group = "Finders" },
        { "<leader>l",  group = "LSP" },
        { "<leader>le", group = "Jump to error" },
        { "<leader>lw", group = "Jump to warning" },
        { "<leader>d",  group = "DadBod" },
        { "<leader>h",  group = "Gitsigns" },
      }
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
