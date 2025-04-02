local ls = require("user.plugins.luasnip.luasnip_nodes")

local sharedSnips = require("user.plugins.luasnip.shared_snips")

local include = ls.s("inc", ls.fmt([[
    #include {}
  ]],
  {
    ls.c(1, {
      ls.sn(nil, { ls.t("<"), ls.i(1), ls.t(">") }),
      ls.sn(nil, { ls.t("\""), ls.i(1), ls.t("\"") }),
    })
  })
)

local matrix = ls.s({ trig = "matrix" }, ls.fmt([[
    {} {}[{}][{}] = {{
      {}
    }};
  ]],
  {
    ls.c(1, { ls.t("int"), ls.t("char") }),
    ls.i(2, "varName"),
    ls.i(3, "1"),
    ls.i(4, "1"),
    ls.d(5, function(args)
      local rows = tonumber(args[2][1])
      local cols = tonumber(args[3][1])
      local placeholder = (args[1][1] == "int") and "1" or "A";
      local mat = {}
      for row = 1, rows, 1 do
        local index = 1
        local rowNode = {}
        table.insert(rowNode, ls.t("{"))
        for col = 1, cols, 1 do
          local eleNode
          if placeholder == "1" then
            eleNode = ls.i(index, placeholder)
          else
            eleNode = ls.sn(index, { ls.t("'"), ls.i(1, placeholder), ls.t("'") })
          end
          table.insert(rowNode, eleNode)
          if col < cols then table.insert(rowNode, ls.t(", ")) end
          index = index + 1
        end
        if row < rows then
          table.insert(rowNode, ls.t({ "},", "" }))
        else
          table.insert(rowNode, ls.t({ "}" }))
        end
        table.insert(mat, ls.sn(row, rowNode))
      end
      return ls.isn(1, mat, "  $PARENT_INDENT")
    end, { 1, 3, 4 }),
  })
)

local functionSnip = ls.s("fun", ls.fmt([[
    {type} {functionName}({args}) {{
      {body}{}
    }}
  ]],
  {
    type = ls.i(1, "type"),
    functionName = ls.i(2, "name"),
    args = ls.i(3, "args..."),
    body = ls.i(4),
    ls.d(5, function(args)
      local node
      if args[1][1] ~= "void" then
        node = ls.sn(nil, { ls.t({ "", "", "  return " }), ls.i(1, args[1][1]), ls.t(";") })
      else
        node = ls.sn(nil, ls.t(""))
      end
      return node
    end, 1),
  })
)

local struct = ls.s("struct", ls.fmt([[
    typedef struct {{
      {}
    }} {};
  ]],
  {
    ls.i(2),
    ls.i(1, "StructName"),
  })
)

local enum = ls.s("enum", ls.fmt([[
    typedef enum {{
      {}
    }} {};
  ]],
  {
    ls.i(2),
    ls.i(1, "EnumName"),
  })
)

local main = ls.s("main", ls.fmt([[
    int main() {{
      {}

      return 0;
    }}
  ]],
  {
    ls.i(1),
  })
)

local forStatement = ls.s("for", ls.fmt([[
    for (int {} = {}; {}; {}) {{
      {}
    }}
  ]],
  {
    ls.i(1, "i"),
    ls.i(2, "0"),
    ls.c(3, {
      ls.fmt("{} < {}", { ls.rep(ls.ai[1]), ls.i(1, "len") }),
      ls.i(nil, "condition"),
    }),
    ls.d(4, function(args)
      return ls.sn(nil, ls.i(1, "++" .. args[1][1]))
    end, 1),
    ls.i(5),
  })
)

function pascalToScreamingSnake(filename)
    local snake_case = filename:gsub("(%u)", "_%1"):gsub("^_", "")
    snake_case = snake_case:gsub("%.", "_")
    return snake_case:upper()
end

local guard = ls.s("guard", ls.fmt([[
    #ifndef {}
    #define {}

    {}

    #endif
  ]],
  {
    ls.f(function(_, snip)
      return pascalToScreamingSnake(snip.env.TM_FILENAME)
    end, _, {key = "guardName"}),
    ls.rep(require("luasnip.nodes.key_indexer").new_key("guardName")),
    ls.i(1),
  }
  )
)

return {
  sharedSnips.printf("printf"),
  sharedSnips.ternary_c,
  sharedSnips.while_c,
  sharedSnips.if_c,
  matrix,
  functionSnip,
  struct,
  enum,
  forStatement,
  include,
  main,
  guard,
}
