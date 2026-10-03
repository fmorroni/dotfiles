return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        livecalc = {
          command = "topiary",
          args = { "format", "--language", "livecalc" },
          stdin = true,
        },
        nickel = {
          command = "topiary",
          args = { "format", "--language", "nickel" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" },
        typescriptreact = { "prettierd" },
        typescript = { "prettierd" },
        javascript = { "prettierd" },
        http = { "kulala-fmt" },
        livecalc = { "livecalc" },
        nickel = { "nickel" },
      },
    },
  },
}
