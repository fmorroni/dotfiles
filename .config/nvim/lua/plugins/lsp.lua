return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rubocop = {
          mason = false,
          enabled = true,
        },
        solargraph = {
          mason = false,
          enabled = true,
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    keys = {
      { "<c-f>", false },
      { "<c-b>", false },

      -- {
      --   "<a-j>",
      --   function()
      --     -- BUG: This is required so that `M-j` still moves line when not in scrollable window.
      --     -- It's not working for some reason though...
      --     if not require("noice.lsp").scroll(4) then return "<a-j>" end
      --   end,
      --   silent = true,
      --   expr = true,
      --   desc = "Scroll Forward",
      --   mode = { "i", "n", "s" },
      -- },
      -- {
      --   "<a-k>",
      --   function()
      --     if not require("noice.lsp").scroll(-4) then return "<a-k>" end
      --   end,
      --   silent = true,
      --   expr = true,
      --   desc = "Scroll Backward",
      --   mode = { "i", "n", "s" },
      -- },
    },
  },
}
