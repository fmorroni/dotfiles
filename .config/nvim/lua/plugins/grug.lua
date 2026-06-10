return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>srr",
        function()
          require("grug-far").open({ prefills = { paths = vim.fn.fnameescape(vim.fn.expand("%")) } })
        end,
        mode = { "n", "x" },
        desc = "Search and Replace current file",
      },
      {
        "<leader>srw",
        function() require("grug-far").open({ visualSelectionUsage = "operate-within-range" }) end,
        mode = { "x" },
        desc = "Search and Replace current selection",
      },
      {
        "<leader>sre",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "x" },
        desc = "Search and Replace all files with same extension",
      },
    },
  },
}
