return {
  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
      panel = { enabled = true, auto_refresh = true },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
