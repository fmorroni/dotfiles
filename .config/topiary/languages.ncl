{
  languages = {
    livecalc = {
      extensions = ["lc"],

      grammar = {
        source = {
          git = {
            git = "https://github.com/fmorroni/tree-sitter-livecalc",
            rev = "main",
          },
        },
      },
      queries = { 
        formatting.source = {
          git = {
            git = "https://github.com/fmorroni/topiary-livecalc",
            rev = "main",
          },
          path = "queries/livecalc/formatting.scm",
        },
      }
    },
  },
}
