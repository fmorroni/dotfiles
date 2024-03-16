lvim.plugins = {
  "tpope/vim-repeat",
  "mfussenegger/nvim-jdtls",
  "jidn/vim-dbml",

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

  {
    "ggandor/leap.nvim",
    event = "BufRead",
    config = function()
      lvim.lsp.buffer_mappings.normal_mode["gs"] = nil
      require("leap").add_default_mappings(true)
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    end,
  },

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

  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        -- can be "telescope", "fzf", "fzf_lua" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope", "fzf" or "fzf_lua"
        picker = "telescope",

        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = function(client, bufNr)
            --   vim.api.nvim_cmd({ cmd = 'setf', args = { 'zk' } }, {})
            --   P('lololo')
            -- end
            -- etc, see `:h vim.lsp.start_client()`
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })
    end
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
