return {
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        layout = {
          -- preset = "ivy",
        },
        matcher = {
          -- Doesn't seem to be working.
          frecency = true,
        },
        win = {
          input = {
            keys = {
              -- Disable --
              ["<Esc>"] = false,
              ["<c-b>"] = false,
              ["<c-f>"] = false,
              -------------
              ["<M-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<M-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<M-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
              ["<M-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
            },
          },
        },
        sources = {
          explorer = {
            win = {
              list = {
                keys = {},
              },
            },
          },
        },
      },

      -- Sub-plugin specific configs
      explorer = {
        -- your explorer configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
  },
}
