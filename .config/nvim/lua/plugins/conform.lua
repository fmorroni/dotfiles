local livecalc_ts_dir = vim.fn.expand("~/projects/livecalc/tree-sitter-livecalc")

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        livecalc = {
          command = vim.fn.expand("~/.local/share/cargo/bin/topiary"),
          args = {
            "format",
            "--configuration",
            livecalc_ts_dir .. "/topiary.ncl",
            "--language",
            "livecalc",
          },
          env = {
            TOPIARY_LANGUAGE_DIR = livecalc_ts_dir .. "/queries/topiary",
          },
          stdin = true,
        },
      },
      formatters_by_ft = {
        markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" },
        typescriptreact = { "prettierd" },
        typescript = { "prettierd" },
        javascript = { "prettierd" },
        livecalc = { "livecalc" },
        nickel = { "prettierd" },
      },
    },
  },
}
