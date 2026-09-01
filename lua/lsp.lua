-- LSP server configuration (Neovim 0.12 native API)
-- nvim-lspconfig provides the base config (cmd, filetypes, root_markers).
-- This merges Neovim-specific settings on top.

local capabilities = require("blink.cmp").get_lsp_capabilities()

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        hint = { enable = true },
        telemetry = { enable = false },
      },
    },
  },
  pyright = {},
  bashls = {},
  ts_ls = {
    settings = {
      typescript = {
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true, showOnAllFunctions = true },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true, showOnAllFunctions = true },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  clangd = {},
  yamlls = {},
  jsonls = {},
  marksman = {},
  eslint = {},
  kotlin_language_server = {},
  sqls = {},
  groovyls = {},
}

for name, conf in pairs(servers) do
  conf.capabilities = capabilities
  vim.lsp.config(name, conf)
end

vim.lsp.enable(vim.tbl_keys(servers))
