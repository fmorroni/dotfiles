local ls = require("user.plugins.luasnip.luasnip_nodes")

local fun = ls.s("function", ls.fmt([[
    ; -------------------------     FUNCTION     ----------------------------
    {description}{arguments}{ret}; -----------------------------------------------------------------------
    {name}:
      {body}
  ]],
  {
    description = ls.c(1, {
      ls.fmt([[
        ; Description: {}

      ]], ls.i(1)),
      ls.t("")
    }),
    arguments = ls.c(2, {
      ls.fmt([[
        ; Arguments
        ;  {}

      ]], ls.i(1)),
      ls.t("")
    }),
    ret = ls.c(3, {
      ls.fmt([[
        ; Return
        ;  {}

      ]], ls.i(1)),
      ls.t("")
    }),
    name = ls.i(4, "function name"),
    body = ls.i(5),
  })
)

return {
  fun
}
