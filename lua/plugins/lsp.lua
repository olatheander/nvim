return {
  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
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
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy",
        "typescript-language-server",
        "yaml-language-server",
        "lemminx",
        -- "typst-lsp",
        -- "tinymist",
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
