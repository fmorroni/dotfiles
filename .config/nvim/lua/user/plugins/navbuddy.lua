return {
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>nn", "<CMD>Navbuddy<CR>", desc = "Open navbuddy" }
    },
  }
}
