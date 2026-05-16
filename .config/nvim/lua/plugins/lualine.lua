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

      -- Keep inactive winbar height stable
      opts.inactive_winbar = {
        lualine_c = { "filename" },
      }
    end,
  },
}
