return {
  {
    "lewis6991/gitsigns.nvim",
    keys = function()
      local gitsigns = require('gitsigns')
      return {
        { "<leader>gj", function() gitsigns.nav_hunk('next') end,                                   desc = "Next hunk" },
        { "<leader>gk", function() gitsigns.nav_hunk('prev') end,                                   desc = "Prev hunk" },
        { '<leader>gs', gitsigns.stage_hunk,                                                        desc = "Stage hunk" },
        { '<leader>gs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = "Stage hunk",                       mode = 'v' },
        { '<leader>gS', gitsigns.stage_buffer,                                                      desc = "Stage buffer" },
     -- These seem dangerous... Need testing.
     -- { '<leader>gr', gitsigns.reset_hunk,                                                        desc = "Reset hunk" },
     -- { '<leader>gs', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = "Reset hunk",                       mode = 'v' },
     -- { '<leader>gR', gitsigns.reset_buffer,                                                      desc = "Reset buffer" },
        { '<leader>gp', gitsigns.preview_hunk,                                                      desc = "Preview hunk" },
        { '<leader>gi', gitsigns.preview_hunk_inline,                                               desc = "Preview hunk inline" },
        { '<leader>gb', function() gitsigns.blame_line({ full = true }) end,                        desc = "Blame line" },
        { '<leader>gd', gitsigns.diffthis,                                                          desc = "Diff this" },
        { '<leader>gD', function() gitsigns.diffthis('~') end,                                      desc = "Diff this (not sure what changes)" },
        { '<leader>gw', gitsigns.toggle_word_diff,                                                  desc = "Toggle word diff" },
      }
      -- map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
      -- map('n', '<leader>hq', gitsigns.setqflist)
      --
      -- -- Toggles
      -- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      --
      -- -- Text object
      -- map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
    end
  }
}
