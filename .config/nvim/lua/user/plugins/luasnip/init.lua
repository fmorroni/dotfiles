return {
  {
    'L3MON4D3/LuaSnip',
    version = '*',
    -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#config-options
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = { "./lua/user/plugins/luasnip/snippets" } })
      -- require('luasnip').setup {
      --   -- This one is cool cause if you have dynamic snippets, it updates as you type!
      --   update_events = "TextChanged,TextChangedI",
      --   -- -- Autosnippets:
      --   -- enable_autosnippets = true,
      --   -- -- Deletion is buggy without this.
      --   -- region_check_events = "InsertEnter",
      --   -- delete_check_events = "TextChanged,InsertLeave",
      --   -- ext_opts = {
      --   --   [types.choiceNode] = {
      --   --     active = {
      --   --       virt_text = { { " « ", "NonTest" } },
      --   --     },
      --   --   },
      --   -- },
      -- }
    end,
    keys = function()
      local ls = require("luasnip")
      local change_choice = function(dir)
        if ls.choice_active() then
          ls.change_choice(dir)
        end
      end
      return {
        { "<C-l>", mode = { "v", "i" }, function() ls.jump(1) end,        desc = "Jump forward" },
        { "<C-h>", mode = { "v", "i" }, function() ls.jump(-1) end,       desc = "Jump backward" },
        { "<C-p>", mode = { "v", "i" }, function() change_choice(1) end,  desc = "Change choice forward" },
        { "<C-o>", mode = { "v", "i" }, function() change_choice(-1) end, desc = "Change choice backward" },
      }
    end
  }
}

-- local types = require "luasnip.util.types"

-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/lvim/lua/user/luasnip_config/snippets" })

-- local jump = function(dir)
--   if luasnip.jumpable(dir) then
--     luasnip.jump(dir)
--   end
-- end
-- local jumpForward = function() jump(1) end
-- local jumpBackwards = function() jump(-1) end
