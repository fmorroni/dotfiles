return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sr",
        function()
          require("grug-far").open({ prefills = { paths = vim.fn.fnameescape(vim.fn.expand("%")) } })
        end,
        mode = { "n", "x" },
        desc = "Search and Replace current file",
      },
      {
        "<leader>sR",
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
