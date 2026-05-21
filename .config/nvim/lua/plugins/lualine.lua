return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
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
