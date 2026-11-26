return {
  {
    import = "nvchad.blink.lazyspec",
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.per_filetype = opts.sources.per_filetype or {}
      opts.sources.per_filetype.tex = { "lsp", "snippets", "buffer", "path", "omni" }
      opts.sources.per_filetype.plaintex = { "lsp", "snippets", "buffer", "path", "omni" }
      return opts
    end,
  },
}
