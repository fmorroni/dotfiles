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
        denols = {
          enabled = true,
        },
      },
    },
  },
}
