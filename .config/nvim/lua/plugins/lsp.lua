---@type LazyPluginSpec[]
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
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
        zigscient = {
          enabled = true,
          cmd = { vim.fn.exepath("zigscient") },
          filetypes = { "zig", "zir" },
          root_markers = { "build.zig", "build.zig.zon", ".git" },
          settings = {
            enable_build_on_save = false,
          },
        },
      },
    },
  },
}
