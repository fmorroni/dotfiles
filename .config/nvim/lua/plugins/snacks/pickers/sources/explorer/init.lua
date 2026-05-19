---@type snacks.picker.Config
return {
  win = {
    list = {
      keys = {
        -- Disable --
        ["<Esc>"] = false,
        ["<c-l>"] = false,
        ["<c-h>"] = false,
        -------------
        ["y"] = "yank_relative_cwd",
        ["Y"] = "yank_relative_home",
        ["c"] = "copy_default",
      },
    },
  },
  actions = require("plugins.snacks.pickers.sources.explorer.actions"),
}
