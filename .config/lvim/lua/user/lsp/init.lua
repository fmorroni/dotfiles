vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
lvim.builtin.which_key.mappings['d']['a'] = {
  "<cmd>lua require('jdtls.dap').setup_dap_main_class_configs()<cr>",
  "Setup dap configuration"
}

-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "intelephense" })
-- -- remove `phpactor` from `skipped_servers` list
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "phpactor"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier",
    -- This takes precedence over project specific configs for some reason...
    -- extra_args = { "--no-semi", "--single-quote", "--print-width=100" },
    filetypes = { "javascript", "typescript" },
  },
  { command = "google_java_format", filetypes = { "java" } },
  -- {
  --   name = "/usr/local/bin/php-cs-fixer",
  --   filetypes = { "php" },
  --   extra_args = { "--config=.php-cs-fixer.dist.php" },
  -- },
}
