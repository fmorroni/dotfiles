lvim.plugins = {
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>q",
          insert_line = "<C-g>Q",
          normal = "yq",
          normal_cur = "yqq",
          normal_line = "yQ",
          normal_cur_line = "yQQ",
          visual = "Q",
          visual_line = "gQ",
          delete = "dq",
          change = "cq",
        }
      })
    end,
  },
  "tpope/vim-repeat",
  {
    "ggandor/leap.nvim",
    event = "BufRead",
    config = function()
      lvim.lsp.buffer_mappings.normal_mode["gs"] = nil
      require("leap").add_default_mappings(true)
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    end,
  },
  -- {
  --   "Wansmer/sibling-swap.nvim",
  --   requires = { 'nvim-treesitter' },
  --   config = function()
  --     require('sibling-swap').setup({
  --       use_default_keymaps = true,
  --       keymaps = {
  --         ['<a-l>'] = 'swap_with_right',
  --         ['<a-h>'] = 'swap_with_left',
  --       },
  --       allow_interline_swaps = false,
  --     })
  --   end,
  -- },
  "mfussenegger/nvim-jdtls",
  "jidn/vim-dbml",
  {
    "drybalka/tree-climber.nvim",
    config = function()
      local keyopts = { noremap = true, silent = true }
      -- vim.keymap.set({ 'n', 'v', 'o' }, '<a-k>', require('tree-climber').goto_parent, keyopts)
      vim.keymap.set('n', '<a-h>', require('tree-climber').swap_prev, keyopts)
      vim.keymap.set('n', '<a-l>', require('tree-climber').swap_next, keyopts)
    end
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<leader>u",
        "<cmd>Telescope undo<cr>",
        desc = "undo history",
      },
    },
    opts = {
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = { preview_height = 0.6, height = 0.95, width = 0.8 }
        },
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },
  -- "sakhnik/nvim-gdb",
  -- {
  --   'glacambre/firenvim',

  --   -- Lazy load firenvim
  --   -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  --   lazy = not vim.g.started_by_firenvim,
  --   build = function()
  --     vim.fn["firenvim#install"](0)
  --   end
  -- }
  -- "MattesGroeger/vim-bookmarks",
}
