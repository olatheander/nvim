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

  { "f-person/git-blame.nvim" },

  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = "kevinhwang91/promise-async",
  --   config = function()
  --     vim.o.foldcolumn = "1" -- '0' is not bad
  --     vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  --     vim.o.foldlevelstart = 99
  --     vim.o.foldenable = true
  --
  --     -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  --     vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  --     vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  --
  --     -- Tell the server the capability of foldingRange,
  --     -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
  --     local capabilities = vim.lsp.protocol.make_client_capabilities()
  --     capabilities.textDocument.foldingRange = {
  --       dynamicRegistration = false,
  --       lineFoldingOnly = true,
  --     }
  --     local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
  --     for _, ls in ipairs(language_servers) do
  --       if ls == "clangd" then
  --         capabilities.offsetEncoding = { "utf-16" }
  --       end
  --       require("lspconfig")[ls].setup({
  --         capabilities = capabilities,
  --         -- you can add other fields for setting up lsp server in this table
  --       })
  --
  --       require("ufo").setup({
  --         provider_selector = function()
  --           return { "lsp", "indent" }
  --         end,
  --       })
  --     end
  --   end,
  -- },
}
