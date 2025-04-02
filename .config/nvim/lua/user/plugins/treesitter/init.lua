return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- vim.wo.foldmethod = "expr"
      -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- vim.wo.foldlevel = 5

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", "c", "html", "java", "javascript", "lua", "make",
          "printf", "python", "regex", "rust", "sql", "toml",
          "typescript", "xml", "yaml"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            -- set to `false` to disable one of the mappings
            init_selection = "gs",
            node_incremental = "gsi",
            scope_incremental = "gss",
            node_decremental = "gsd",
          },
        },
      })
    end
  },
  require('user.plugins.treesitter.textobjects'),
}
