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

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable Treesitter highlighting, indentation, and folding",
  group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
  callback = function(args)
    local ok = pcall(vim.treesitter.start, args.buf)
    if not ok then
      return
    end
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo[0][0].foldmethod = "expr"
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldlevel = 99
  end,
})
