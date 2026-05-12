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
              ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
              ["<C-p>"] = { "history_back", mode = { "i", "n" } },
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
                  ["c"] = "explorer_copy_default",
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
              explorer_copy_default = function(picker, item)
                if not item then return end
                local Tree = require("snacks.explorer.tree")
                local actions = require("snacks.explorer.actions")
                local uv = vim.uv or vim.loop
                ---@type string[]
                local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected())
                -- Copy selection
                if #paths > 0 then
                  local dir = picker:dir()
                  Snacks.picker.util.copy(paths, dir)
                  picker.list:set_selected() -- clear selection
                  Tree:refresh(dir)
                  Tree:open(dir)
                  actions.update(picker, { target = dir })
                  return
                end
                Snacks.input({
                  prompt = "Copy to",
                  default = vim.fn.fnamemodify(item.file, ":t"),
                }, function(value)
                  if not value or value:find("^%s$") then return end
                  local dir = vim.fs.dirname(item.file)
                  local to = svim.fs.normalize(dir .. "/" .. value)
                  if uv.fs_stat(to) then
                    Snacks.notify.warn("File already exists:\n- `" .. to .. "`")
                    return
                  end
                  Snacks.picker.util.copy_path(item.file, to)
                  Tree:refresh(vim.fs.dirname(to))
                  actions.update(picker, { target = to })
                end)
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
    keys = {
      { "<leader>:", false },
    },
  },
}
