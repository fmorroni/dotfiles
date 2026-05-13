local ft = { "sql", "mysql", "plsql" }
local ft_extended = vim.list_extend(vim.deepcopy(ft), { "dbout", "dbui" })

return {
  {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
      { "<leader>dd", "<CMD>DBUI<CR>", desc = "Start DBUI", ft = ft },
      { "<leader>dt", "<CMD>DBUIToggle<CR>", desc = "Toggle drawer", ft = ft_extended },
      { "<leader>db", "<CMD>DBUIFindBuffer<CR>", desc = "Connect DBUI to buffer", ft = ft },
      { "<leader>df", "<Plug>(DBUI_ExecuteQuery)", desc = "Run sql file", ft = ft },
      { "<leader>dq", "<CMD>'{,'}DB<CR>", desc = "Run query under cursor", ft = ft },
      {
        "<leader>dq",
        "<Plug>(DBUI_ExecuteQuery)",
        desc = "Run visually selected query",
        ft = ft,
        mode = "v",
      },
      {
        "<leader>dj",
        "<Plug>(DBUI_JumpToForeignKey)",
        desc = "Jump to foreign key",
        ft = "dbout",
        mode = { "n", "v" },
      },
    },
  },
}
