return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      -- 'nvim-java/nvim-java',
    }
  },
  {
    "mason-org/mason.nvim",
    opts = {},
    keys = {
      { "<leader>m", "<CMD>Mason<CR>", desc = "Open mason" }
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    version = '1.x',
    dependencies = { "mason-org/mason.nvim", 'saghen/blink.cmp', 'SmiteshP/nvim-navic' },
    config = function()
      local default_capabilities = require('blink.cmp').get_lsp_capabilities()
      local default_on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
          require("nvim-navbuddy").attach(client, bufnr)
        end
      end
      require("mason-lspconfig").setup({
        automatic_enable = {
          exclude = {
            "jdtls",
          }
        }
      })
      require("mason-lspconfig").setup_handlers({
        -- Default handler
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = default_capabilities,
            on_attach = default_on_attach
          })
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        clangd = function()
          require('lspconfig').clangd.setup({
            capabilities = default_capabilities,
            on_attach = default_on_attach,
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- exclude "proto".
          })
        end
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end
      })
      require('user.plugins.lsp.keymaps')
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {},
  },
  require('user.plugins.lsp.formatting'),
  { 'mfussenegger/nvim-jdtls' },
  -- require('user.plugins.lsp.java'),
}
