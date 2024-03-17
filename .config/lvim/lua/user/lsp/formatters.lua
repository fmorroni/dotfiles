-- set a formatter, this will override the language server formatting capabilities (if it exists).
-- null-ls servers are checked on startup, for lazy loading see:
-- https://www.lunarvim.org/docs/configuration/language-features/linting-and-formatting#lazy-loading-the-linterformattercode_actions-setup
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier",
    -- This takes precedence over project specific configs for some reason...
    -- extra_args = { "--no-semi", "--single-quote", "--print-width=100" },
    filetypes = { "javascript", "typescript", "css" },
  },
  { command = "google_java_format", filetypes = { "java" } },
  { command = "shfmt",              filetypes = { "sh", "bash", "mksh" } },
  { command = "mdformat",           filetypes = { "markdown" } },
}
