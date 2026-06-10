---@type snacks.picker.Config
return {
  win = {
    input = {
      keys = {
        -- Disable --
        ["<Esc>"] = false,
        ["q"] = false,
        ["<c-l>"] = false,
        -------------
      },
    },
    list = {
      keys = {
        -- Disable --
        ["<Esc>"] = false,
        ["q"] = false,
        ["<c-l>"] = false,
        -------------
        ["y"] = "yank_relative_cwd",
        ["Y"] = "yank_relative_home",
        ["c"] = "copy_default",
      },
    },
  },
  actions = require("plugins.snacks.pickers.sources.explorer.actions"),
}
