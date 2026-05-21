local ls = require("plugins.luasnip.luasnip_nodes")

return {
  ls.s(
    "newsnip",
    ls.fmt(
      [=[
        ls.s("{name}",
          ls.fmt(
            [[
              {body}
            ]],
            {{
              {args}
            }}
          )
        )
      ]=],
      {
        name = ls.i(1, "name"),
        body = ls.i(2, "snip body"),
        args = ls.d(3, function(args)
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
            if key ~= "" then table.insert(node, ls.t(key .. " = ")) end
            table.insert(node, ls.i(1, "node_" .. j))
            if j < snipBodyArgCount then
              table.insert(node, ls.t({ ",", "" }))
            else
              table.insert(node, ls.t(","))
            end
            table.insert(nodes, ls.isn(j, node, "    $PARENT_INDENT"))
          end

          return ls.sn(1, nodes)
        end, 2),
      }
    )
  ),

  ls.s(
    "?:", -- Ternary operator
    ls.fmt(
      [[
        ({}) and {} or {}
      ]],
      {
        ls.i(1, "condition"),
        ls.i(2, "then"),
        ls.i(3, "else"),
      }
    )
  ),

  ls.s(
    "fun",
    ls.fmt(
      [[
        {header}({args})
          {body}
        end
      ]],
      {
        header = ls.c(1, {
          ls.t("function"),
          ls.fmt("local {} = function", {
            ls.i(1, "name"),
          }),
          ls.fmt("{} = function", {
            ls.i(1, "name"),
          }),
          ls.fmt("local function {}", {
            ls.i(1, "name"),
          }),
          ls.fmt("function {}", {
            ls.i(1, "name"),
          }),
        }),
        args = ls.i(2, "args"),
        body = ls.i(3, "body"),
      }
    )
  ),
}
