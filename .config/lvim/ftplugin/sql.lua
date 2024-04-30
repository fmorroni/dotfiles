local wk = require("which-key")

wk.register({
  d = {
    name = "DadBod",
    d = { "<CMD>DBUI<CR>", "Start DBUI" },
    t = { "<CMD>DBUIToggle<CR>", "Toggle drawer" },
    b = { "<CMD>DBUIFindBuffer<CR>", "Connect DBUI to buffer" },
    f = { "<Plug>(DBUI_ExecuteQuery)", "Run sql file" },
    q = { "<CMD>'{,'}DB<CR>", "Run query under cursor" },
  }
}, {
  prefix = "<leader>",
  mode = "n",
  buffer = 0, -- This is the secret to having the mappings apply only to specific ft buffers and not globally.
})

wk.register({
  d = {
    name = "DadBod",
    q = { "<Plug>(DBUI_ExecuteQuery)", "Run visually selected query" },
  }
}, {
  prefix = "<leader>",
  mode = "v",
  buffer = 0, -- This is the secret to having the mappings apply only to specific ft buffers and not globally.
})

require("cmp").setup.buffer({
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "luasnip" },
    { name = "buffer" },
  }
})
