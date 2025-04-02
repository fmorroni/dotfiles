local ls = require("user.plugins.luasnip.luasnip_nodes")

local M = {}

M[1] = ls.s("select", ls.fmt([[
    select {columns} from {table}
  ]],
  {
    columns = ls.i(2, "columns"),
    table = ls.i(1, "table"),
  })
)

M[2] = ls.s("searchpath", ls.fmt([[
    set search_path to {};
  ]],
  {
    ls.i(1, "<schema>"),
  })
)

M[3] = ls.s("insert", ls.fmt([[
    insert into {table}{columns} values ( {values} );
  ]],
  {
    table = ls.i(1, "<table>"),
    columns = ls.c(2, {
      ls.sn(nil, { ls.t(" ( "), ls.i(1, "<columns>"), ls.t(" )") }),
      ls.t(""),
    }),
    values = ls.d(3, function(args)
      local nodes = {}
      local string = table.concat(args[1]):gsub("[() ]", "")
      local argCount = 0
      local keys = {}
      for match in string:gmatch("([^,]+)") do
        argCount = argCount + 1
        table.insert(keys, match)
      end
      P(keys)
      if argCount == 0 then
        table.insert(nodes, ls.i(1, "<values>"))
      end
      for j, key in ipairs(keys) do
        table.insert(nodes, ls.i(j, key))
        if j < argCount then
          table.insert(nodes, ls.t(", "))
        end
      end
      return ls.sn(1, nodes)
    end, 2),
  })
)

return M
