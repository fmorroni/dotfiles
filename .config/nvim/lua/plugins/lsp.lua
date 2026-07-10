---@type LazyPluginSpec[]
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gk", false },
            {
              "gk",
              function() return vim.lsp.buf.signature_help() end,
              desc = "Signature Help",
              has = "signatureHelp",
            },
          },
        },
        rubocop = {
          mason = false,
          enabled = true,
        },
        solargraph = {
          mason = false,
          enabled = true,
        },
        denols = {
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
    },
  },
}
