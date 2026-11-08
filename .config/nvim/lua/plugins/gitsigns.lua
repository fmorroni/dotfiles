return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local old_on_attach = opts.on_attach

      opts.on_attach = function(buffer)
        old_on_attach(buffer)

        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
        end

        map("n", "<leader>ghi", function()
          vim.cmd.diffoff({ bang = true })
          gs.diffthis()
        end, "Diff This (index)")

        map("n", "<leader>ghd", function()
          vim.cmd.diffoff({ bang = true })
          gs.diffthis("~")
        end, "Diff This (HEAD~1)")

        map("n", "<leader>ghD", function()
          local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(buffer))
          local base, upstream = require("util.git").upstream_merge_base(dir)
          if not base then
            vim.notify("No merge-base with " .. upstream, vim.log.levels.WARN)
            return
          end
          vim.cmd.diffoff({ bang = true })
          gs.diffthis(base)
        end, "Diff This (upstream)")
      end
    end,
  },
}
