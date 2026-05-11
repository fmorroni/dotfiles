return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- ["markdown"] = { { "prettierd", "prettier" }, "markdown-toc" },
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        -- ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      },
    },
  },
}
