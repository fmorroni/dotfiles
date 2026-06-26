return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" },
        typescriptreact = { "prettierd" },
        typescript = { "prettierd" },
        javascript = { "prettierd" },
      },
    },
  },
}
