return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("tokyonight").setup({
        on_highlights = function(hl, c)
          hl.DiagnosticUnnecessary = { fg = c.comment }
          hl.LineNr = { fg = '#555d81' }
          hl.LineNrAbove = { fg = '#555d81' }
          hl.LineNrBelow = { fg = '#555d81' }
        end,
      })

      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
}
