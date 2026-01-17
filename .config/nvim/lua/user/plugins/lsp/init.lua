local default_on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
    require("nvim-navbuddy").attach(client, bufnr)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    default_on_attach(client, ev.buf)
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "SmiteshP/nvim-navic",
    },
    config = function()
      local default_capabilities = require("blink.cmp").get_lsp_capabilities()

      -- NOTE: setting `on_attach` here is basically useless when using nvim-lspconfig as
      -- most if not all configs there already set `on_attach`, and that one will be used instead
      -- of `default_on_attach` because it has more priority. This may change if the proposal
      -- on [this commit](https://github.com/neovim/neovim/issues/33577) gets implemented.
      -- For now `on_attach` will be set instead using the `LspAttach` autocmd.
      -- Also, most configs also set `root_dir` so the `root_markers` gets ignored.
      vim.lsp.config("*", {
        root_markers = { ".git" },
        capabilities = default_capabilities,
        -- on_attach = default_on_attach,
      })

      vim.lsp.config("clangd", {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- exclude "proto".
      })

      -- TODO: Check what should be disabled in order for ruff and basedpyright to work correctly together
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            -- allowedUntypedLibraries = { "matplotlib" },
            typeCheckingMode = "standard",
          },
        },
      })

      -- HACK: I use `root_dir` here instead of `root_markers` because the nvim-lspconfig config
      -- for `denols` already sets `root_dir` and there isn't a way to disable it from here yet.
      vim.lsp.config("denols", {
        root_dir = function(bufnr, on_dir)
          local root_markers = { "deno.json" }
          local project_root = vim.fs.root(bufnr, root_markers)
          if project_root then on_dir(project_root) end
        end,
        workspace_required = true,
      })

      -- INFO: `ts_ls` includes a `root_dir` function in nvim-lspconfig which overrides `root_markers`,
      -- but as of the lastest nvim-lspconfig version deno.json and deno.lock are excluded from matching
      -- so it's not necessary to set it up manually.
      vim.lsp.config("ts_ls", {
        -- root_markers = { "tsconfig.json" },
        workspace_required = false,
      })
      -- vim.lsp.config("ts_ls", {
      --   root_markers = { "tsconfig.json" },
      --   workspace_required = true,
      -- })

      -- NOTE: must install rubocop with `gem`
      vim.lsp.enable('rubocop')
      vim.lsp.config['rubocop'] = {
        capabilities = default_capabilities,
        cmd = { "rubocop", "--lsp" },
        filetypes = { "ruby" },
        root_markers = { "Gemfile", ".ruby-version", ".git" },
        workspace_required = true,
      }

      -- NOTE: must install solargraph with `gem`
      vim.lsp.enable('solargraph')
      vim.lsp.config('solargraph', {
        capabilities = default_capabilities,
        cmd = { "env", "BUNDLE_GEMFILE=~/.rbenv/Gemfile", "solargraph", "stdio" },
        filetypes = { "ruby" },
        root_markers = { "Gemfile", ".ruby-version", ".git" },
        workspace_required = true,
        init_options = { formatting = true },
        settings = {
          solargraph = {
            autoformat = false,
            formatting = false,
            completion = true,
            diagnostic = true,
            folding = true,
            references = true,
            rename = true,
            symbols = true
          }
        }
      })

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
