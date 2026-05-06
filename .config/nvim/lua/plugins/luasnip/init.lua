-- TODO: snippets exit after reaching final node, which means you can't go back after that.
-- That seems to be fine but if it gets annoying see `https://github.com/L3MON4D3/LuaSnip/pull/1162/files`.
return {
  {
    "L3MON4D3/LuaSnip",
    version = "*",
    -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#config-options
    config = function()
      require("luasnip.loaders.from_lua").load({
        paths = { "./lua/plugins/luasnip/snippets" },
      })
      require("luasnip").setup({
        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        update_events = "TextChanged,TextChangedI",
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
