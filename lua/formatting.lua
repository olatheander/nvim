local prettier_ft = { "prettierd", "prettier", stop_after_first = true }
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = prettier_ft,
    javascriptreact = prettier_ft,
    typescript = prettier_ft,
    typescriptreact = prettier_ft,
    json = prettier_ft,
    jsonc = prettier_ft,
    html = prettier_ft,
    css = prettier_ft,
    scss = prettier_ft,
    less = prettier_ft,
    yaml = prettier_ft,
    markdown = prettier_ft,
    graphql = prettier_ft,
    vue = prettier_ft,
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})
