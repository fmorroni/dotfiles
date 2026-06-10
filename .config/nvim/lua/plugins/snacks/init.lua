return {
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-config
      picker = require("plugins.snacks.pickers"),

      -- Sub-plugin specific configs
      explorer = {
        -- your explorer configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      lazygit = {
        win = {
          -- style = "float",
          style = {
            height = 0.95,
            width = 0.95,
          },
        },
      },
      notifier = {
        width = { max = 0.9 },
      },
      dashboard = {
        preset = {
          keys = {},
        },
      },
    },
    keys = {
      -- Disable --
      { "<leader>:", false },
      -------------
      {
        "<leader>ghg",
        function() Snacks.picker.git_grep_hunks() end,
        desc = "Git grep hunks",
      },
    },
  },
}
