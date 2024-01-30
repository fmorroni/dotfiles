-- Put luasnips first in the list of recommendations.
local sources = lvim.builtin.cmp.sources
for i, source in pairs(sources) do
  if source.name == "luasnip" or source.name == "nvim_lsp" then
    table.remove(sources, i)
  end
end
table.insert(sources, 1, { name = "nvim_lsp" })
table.insert(sources, 2, { name = "luasnip" })
