local ls = require("luasnip")

local M = {}

M.s = ls.snippet
M.t = ls.text_node
M.c = ls.choice_node
M.i = ls.insert_node

M.f = ls.function_node
M.d = ls.dynamic_node
M.sn = ls.snippet_node
M.isn = ls.indent_snippet_node
M.k = require("luasnip.nodes.key_indexer").new_key

M.fmt = require("luasnip.extras.fmt").format_nodes
M.rep = require("luasnip.extras").rep
M.l = require("luasnip.extras").lambda

M.ai = require("luasnip.nodes.absolute_indexer")

return M
