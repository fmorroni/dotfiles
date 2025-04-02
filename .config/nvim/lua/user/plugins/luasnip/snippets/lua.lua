local ls = require("user.plugins.luasnip.luasnip_nodes")

local newsnip = ls.s("newsnip", ls.fmt([[
    local {} = ls.s("{}", ls.fmt([[
        {}
    ]]
  .. "  ]]" .. [[,
      {{
        {}
      }})
    )]],
  {
    ls.i(1, "var"),
    ls.d(2, function(args)
      return ls.sn(1, ls.i(1, args[1][1]))
    end, 1),
    ls.i(3, "snip body"),
    ls.d(4, function(args)
      local snipBodyArgs = table.concat(args[1])
      local nodes = {}
      local keys = {}
      local snipBodyArgCount = 0
      for match in snipBodyArgs:gmatch("{([^{}]*)}") do
        snipBodyArgCount = snipBodyArgCount + 1
        table.insert(keys, match)
      end
      for j, key in ipairs(keys) do
        local node = {}
        if key ~= "" then
          table.insert(node, ls.t(key .. " = "))
        end
        table.insert(node, ls.i(1, "node_" .. j))
        if j < snipBodyArgCount then
          table.insert(node, ls.t({ ",", "" }))
        else
          table.insert(node, ls.t(","))
        end
        table.insert(nodes, ls.isn(j, node, "    $PARENT_INDENT"))
      end

      return ls.sn(1, nodes)
    end, 3),
  })
)

local ternary = ls.s("?:", ls.fmt([[
    ({}) and {} or {}
  ]],
  {
    ls.i(1, "condition"),
    ls.i(2, "then"),
    ls.i(3, "else")
  })
)

local fun = ls.s("fun", ls.fmt([[
    {}function({})
      {}
    end
  ]],
  {
    ls.c(1, {
      ls.t(""),
      ls.sn(nil, { ls.t("local "), ls.i(1, 'name'), ls.t(" = ") }),
      ls.sn(nil, { ls.i(1, 'name'), ls.t(" = ") }),
    }),
    ls.i(2, "args"),
    ls.i(3, "body"),
  })
)

return {
  newsnip,
  ternary,
  fun,
}
