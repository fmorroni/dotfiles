-- Put luasnips first in the list of recommendations.
local sources = lvim.builtin.cmp.sources
for i, source in pairs(sources) do
  if source.name == "luasnip" then
    table.remove(sources, i)
  end
end
table.insert(sources, 1, { name = "luasnip" })
