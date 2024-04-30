local wk = require("which-key")

wk.register({
  d = {
    name = "DadBod",
    t = { "<CMD>DBUIToggle<CR>", "Toggle drawer" },
    j = { '<Plug>(DBUI_JumpToForeignKey)', 'Jump to foreign key' }
  }
}, {
  prefix = "<leader>",
  mode = { "n", "v" },
  buffer = 0, -- This is the secret to having the mappings apply only to specific ft buffers and not globally.
})
