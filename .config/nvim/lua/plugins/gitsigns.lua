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
          vim.cmd.diffoff({ bang = true })
          gs.diffthis("origin/HEAD")
        end, "Diff This (origin)")
      end
    end,
  },
}
