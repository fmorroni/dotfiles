local ls = require("plugins.luasnip.luasnip_nodes")

local sharedSnips = require("plugins.luasnip.shared_snips")

local M = {}

M[1] = ls.s("breakpoint", ls.t("require 'debug'; binding.b"))

return M
