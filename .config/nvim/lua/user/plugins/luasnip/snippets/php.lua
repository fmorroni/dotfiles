local ls = require("user.plugins.luasnip.luasnip_nodes")

local php = ls.s("php", ls.fmt([[
    <?{} {} ?>
  ]],
  {
    ls.c(1, {ls.t("php"), ls.t('=')}),
    ls.i(2),
  })
)

return {
  php,
}
