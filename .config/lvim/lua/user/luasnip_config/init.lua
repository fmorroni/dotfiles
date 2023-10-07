local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then return end

local types = require "luasnip.util.types"

luasnip.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection.
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Deletion is buggy without this.
  region_check_events = "InsertEnter",
  delete_check_events = "TextChanged,InsertLeave",

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « ", "NonTest" } },
      },
    },
  },
}

require("luasnip.loaders.from_lua").load({ paths = "~/.config/lvim/lua/user/luasnip_config/snippets" })

local jump = function(dir)
  if luasnip.jumpable(dir) then
    luasnip.jump(dir)
  end
end
local jumpForward = function() jump(1) end
local jumpBackwards = function() jump(-1) end

lvim.keys.insert_mode["<c-l>"] = jumpForward
lvim.keys.visual_mode["<c-l>"] = jumpForward

lvim.keys.insert_mode["<c-h>"] = jumpBackwards
lvim.keys.visual_mode["<c-h>"] = jumpBackwards

local changeChoice = function(val)
  if luasnip.choice_active() then
    luasnip.change_choice(val)
  end
end
local choiceForward = function() changeChoice(1) end
local choiceBackwards = function() changeChoice(-1) end

lvim.keys.insert_mode["<c-p>"] = choiceForward
lvim.keys.visual_mode["<c-p>"] = choiceForward

lvim.keys.insert_mode["<c-o>"] = choiceBackwards
lvim.keys.visual_mode["<c-o>"] = choiceBackwards

lvim.builtin.cmp.mapping["<Tab>"] = nil
lvim.builtin.cmp.mapping["<S-Tab>"] = nil

local cmp = require("cmp")
lvim.builtin.cmp.mapping["<C-D>"] = cmp.mapping(cmp.mapping.scroll_docs(1))
lvim.builtin.cmp.mapping["<C-U>"] = cmp.mapping(cmp.mapping.scroll_docs(-1))
lvim.builtin.cmp.mapping["<C-F>"] = nil
lvim.builtin.cmp.mapping["<C-P>"] = nil
