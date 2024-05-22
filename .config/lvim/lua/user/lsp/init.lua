require('user.lsp.formatters')
-- require('user.lsp.javascript')
require('user.lsp.vue')
-- require('user.lsp.sql')

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
