lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "denols"
end, lvim.lsp.automatic_configuration.skipped_servers)

local lsp_config = require("lspconfig")

lsp_config.tsserver.setup({
  root_dir = lsp_config.util.root_pattern("package.json"),
  single_file_support = false,
})

lsp_config.denols.setup({
  root_dir = lsp_config.util.root_pattern("deno.json"),
})
