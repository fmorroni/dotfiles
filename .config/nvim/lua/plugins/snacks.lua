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
              ["<a-i>"] = false,
              -------------
              ["<a-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<a-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<a-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
              ["<a-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
              ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            },
          },
        },
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["y"] = "yank_relative_cwd",
                  ["Y"] = "yank_relative_home",
                },
              },
            },
            actions = {
              yank_relative_cwd = function(_, item)
                local path = vim.fn.fnamemodify(item.file, ":.")
                vim.fn.setreg("+", path)
                vim.fn.setreg('"', path)
                vim.notify("Yanked: " .. path)
              end,
              yank_relative_home = function(_, item)
                local path = vim.fn.fnamemodify(item.file, ":~")
                vim.fn.setreg("+", path)
                vim.fn.setreg('"', path)
                vim.notify("Yanked: " .. path)
              end,
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
    },
  },
}
