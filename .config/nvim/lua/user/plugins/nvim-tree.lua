return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
  end,
  keys = {
    { '<leader>ee', '<CMD>NvimTreeToggle<CR>', mode = 'n', desc = 'Toggle nvim-tree' },
    { '<leader>ef', '<CMD>NvimTreeFindFile<CR>', mode = 'n', desc = 'Toggle nvim-tree' },
  }
}
