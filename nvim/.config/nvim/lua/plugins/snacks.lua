return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- snacks scans ~/dev and ~/projects by default; the work repos live
          -- in ~/Rimthan. Listed dirs are scanned one level deep for a repo
          -- marker (.git, package.json, Makefile, ...).
          projects = {
            dev = { "~/Rimthan", "~/Projects", "~/SequenceOperators" },
          },
        },
      },
    },
  },
}
