vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight selection on yank",
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  callback = function() vim.hl.on_yank({ higroup = "IncSearch", timeout = 100 }) end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function(args)
    require("user.plugins.lsp.jdtls").setup({
      capabilities = require("blink.cmp").get_lsp_capabilities(),
      on_attach = function(client, bufNr)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufNr)
          require("nvim-navbuddy").attach(client, bufNr)
        end
      end,
    })
  end,
})
