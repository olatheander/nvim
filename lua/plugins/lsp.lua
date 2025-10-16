return {
  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "debugpy",
        "eslint-lsp",
        "haskell-debug-adapter",
        "haskell-language-server",
        "java-debug-adapter",
        "java-test",
        "js-debug-adapter",
        "json-lsp",
        "lemminx",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "mypy",
        "prettier",
        "pyright",
        "ruff",
        "shellcheck",
        "shfmt",
        "stylua",
        "typescript-language-server",
        "yaml-language-server",
        -- "jdtls",
        -- "tinymist",
        -- "typst-lsp",
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
        pyright = {},
        gdscript = {},
      },
      setup = {
        jdtls = function()
          return true -- avoid duplicate servers
        end,
        -- typst_lsp = function(_, opts)
        --   opts.offset_encoding = "utf-8"
        -- end,
        -- tinymist = function(_, opts)
        --   opts.offset_encoding = "utf-8"
        -- end,
      },
    },
  },
}
