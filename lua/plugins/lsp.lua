return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "eslint-lsp",
        "java-debug-adapter",
        "java-test",
        -- "jdtls",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "prettier",
        "typescript-language-server",
        "yaml-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              format = {
                enable = false,
              },
            },
          },
        },
        jdtls = {},
      },
      setup = {
        jdtls = function()
          return true -- avoid duplicate servers
        end,
      },
    },
  },
}
