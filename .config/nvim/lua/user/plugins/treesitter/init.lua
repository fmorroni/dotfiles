return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "java",
        "javascript",
        "lua",
        "make",
        "printf",
        "python",
        "regex",
        "rust",
        "sql",
        "toml",
        "typescript",
        "xml",
        "yaml",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        -- enable = true,
        -- keymaps = {
        --   -- set to `false` to disable one of the mappings
        --   init_selection = "gs",
        --   node_incremental = "gsi",
        --   scope_incremental = "gss",
        --   node_decremental = "gsd",
        -- },
      },
      textobjects = require("user.plugins.treesitter.textobjects"),
    },
    ---@param opts TSConfig
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
}
