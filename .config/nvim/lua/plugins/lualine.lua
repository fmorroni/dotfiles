return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Insert project name at start of `b` section.
      table.insert(opts.sections.lualine_b, 1, {
        function()
          local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
          return vim.fs.basename(root)
        end,
        icon = "󰉋",
      })

      -- Remove breadcrumbs component from statusline
      local breadcrumbs = table.remove(opts.sections.lualine_c)

      -- Move it to winbar
      opts.winbar = {
        lualine_c = {
          { "filename" },
          breadcrumbs,
        },
      }

      opts.inactive_winbar = {
        lualine_c = { "filename" },
      }

      opts.options = opts.options or {}
      opts.options.disabled_filetypes = opts.options.disabled_filetypes or {}
      opts.options.disabled_filetypes.winbar = opts.options.disabled_filetypes.winbar or {}
      vim.list_extend(opts.options.disabled_filetypes.winbar, {
        "snacks_picker_list", -- Not really working
        "snacks_dashboard",
        "help",
      })
    end,
  },
}
