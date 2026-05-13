return {
  {
    "L3MON4D3/LuaSnip",
    -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#config-options
    config = function()
      require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua/plugins/luasnip/snippets" } })

      require("luasnip").setup({
        exit_roots = false,
        update_events = "TextChanged,TextChangedI",
        region_check_events = "CursorHold",
        delete_check_events = "TextChanged",
      })
    end,
    keys = function()
      local ls = require("luasnip")
      local change_choice = function(dir)
        if ls.choice_active() then ls.change_choice(dir) end
      end
      local jump = function(dir)
        if ls.jumpable(dir) then ls.jump(dir) end
      end
      return {
        {
          "<C-l>",
          mode = { "v", "i" },
          function() jump(1) end,
          desc = "Jump forward",
        },
        {
          "<C-h>",
          mode = { "v", "i" },
          function() jump(-1) end,
          desc = "Jump backward",
        },
        {
          "<C-n>",
          mode = { "v", "i" },
          function() change_choice(1) end,
          desc = "Change choice forward",
        },
        {
          "<C-p>",
          mode = { "v", "i" },
          function() change_choice(-1) end,
          desc = "Change choice backward",
        },
      }
    end,
  },
}
