-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "sqlls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

local lsp_config = require("lspconfig")

lsp_config.sqls.setup({
  single_file_support = true,
  on_attach = function(client, bufnr)
    require('sqls').on_attach(client, bufnr)
  end,
})
-- require('lspconfig').sqls.setup{
--     on_attach = function(client, bufnr)
--         require('sqls').on_attach(client, bufnr)
--     end
-- }
