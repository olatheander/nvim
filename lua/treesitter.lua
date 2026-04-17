-- [[ Treesitter Parser Management ]]

local ts_parsers = {
  "bash",
  "c",
  "html",
  "java",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "scala",
  "sql",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

local ts_installed = require("nvim-treesitter").get_installed()
local ts_missing = vim.tbl_filter(function(lang)
  return not vim.list_contains(ts_installed, lang)
end, ts_parsers)

if #ts_missing > 0 then
  require("nvim-treesitter").install(ts_missing)
end
