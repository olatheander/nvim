-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("options")
require("plugins")
require("treesitter")
require("keymaps")
require("autocmds")
require("commands")
require("lsp")

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
local diagnostic_signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
    },
  },
  update_in_insert = false,
  severity_sort = true,
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
})

vim.cmd.colorscheme("tokyonight")
