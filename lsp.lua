-- LSP server configuration (Neovim 0.12 native API)
-- nvim-lspconfig provides the base config (cmd, filetypes, root_markers).
-- This merges Neovim-specific settings on top.
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      -- diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "bashls",
  "ts_ls",
  "gopls",
  "clangd",
})
