return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "SmiteshP/nvim-navic",
    },
    config = function()
      local default_capabilities = require("blink.cmp").get_lsp_capabilities()
      local default_on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
          require("nvim-navbuddy").attach(client, bufnr)
        end
      end

      vim.lsp.config("*", {
        root_markers = { ".git" },
      })

      vim.lsp.config("*", {
        capabilities = default_capabilities,
        on_attach = default_on_attach,
      })

      vim.lsp.config("clangd", {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- exclude "proto".
      })

      -- I had to add `capabilities` and `on_attach` again here because for some reason it didn't use the
      -- ones configured with wildcard...
      -- TODO: Check what should be disabled in order for ruff and basedpyright to work correctly together
      vim.lsp.config("basedpyright", {
        capabilities = default_capabilities,
        on_attach = default_on_attach,
        settings = {
          basedpyright = {
            -- allowedUntypedLibraries = { "matplotlib" },
            typeCheckingMode = "standard",
          },
        },
      })

      vim.lsp.config("denols", {
        root_markers = { "deno.json" },
        workspace_required = true,
      })
      -- INFO: `ts_ls` includes a `root_dir` function in nvim-lspconfig which overrides `root_markers`,
      -- but as of the lastest nvim-lspconfig version deno.json and deno.lock are excluded from matching
      -- so it's not necessary to set it up manually.
      -- vim.lsp.config("ts_ls", {
      --   root_markers = { "tsconfig.json" },
      --   workspace_required = true,
      -- })

      -- INFO: nvm, actually doesn't really work. It works if I reinstall them every time I change ruby version,
      -- which sucks... But I'm not planning on changing versions oftem so good enough for now.
      -- -- WARNING: this is a hack to make it work. Make an issue on mason gh so they fix it.
      -- -- Also see: https://github.com/mason-org/mason.nvim/pull/1894 and https://github.com/mason-org/mason.nvim/issues/1292
      -- vim.lsp.config("solargraph", {
      --   cmd = {
      --     "/usr/bin/chruby-exec",
      --     "ruby-3.4.7",
      --     "--",
      --     "solargraph",
      --     "stdio",
      --   },
      -- })
      -- vim.lsp.config("rubocop", {
      --   cmd = {
      --     "/usr/bin/chruby-exec",
      --     "ruby-3.4.7",
      --     "--",
      --     "rubocop",
      --     "stdio",
      --   },
      -- })

      require("user.plugins.lsp.keymaps")
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {},
    keys = {
      { "<leader>m", "<CMD>Mason<CR>", desc = "Open mason" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = {
          exclude = {
            "jdtls",
            -- "ruff",
          },
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {},
  },
  require("user.plugins.lsp.formatting"),
  { "mfussenegger/nvim-jdtls" },
  -- require('user.plugins.lsp.java'),
}
