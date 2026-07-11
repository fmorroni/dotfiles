---@type LazyPluginSpec[]
return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    config = function(_, opts)
      local state = require("noice.ui.state")
      local og_skip = state.skip

      state.skip = function(event, kind, ...)
        if event == "msg_show" then
          state.set(event, kind, ...)
          return false
        end

        return og_skip(event, kind, ...)
      end

      require("noice").setup(opts)
    end,
    keys = {
      { "<c-f>", false },
      { "<c-b>", false },
    },
  },
}
