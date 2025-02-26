return {
  {
    "folke/noice.nvim",
    opts = {
      -- routes = {
      --   {
      --     filter = {
      --       event = "lsp",
      --       kind = "progress",
      --     },
      --     view = "messages",
      --     opts = { skip = true }, -- Don't show LSP progress messages, it's very intrusive.
      --   },
      -- },
      lsp = {
        progress = {
          -- enabled = false, -- Don't show LSP progress messages, it's very intrusive. Perhaps a lualine progress bar would be better.
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = false },
      styles = {
        notification = {
          focusable = true, -- Disable focus on the messages panel.
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, "g:metals_status")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<S-h>", false },
      { "<S-l>", false },
    },
    opts = { options = { always_show_bufferline = true } },
  },

  {
    "folke/flash.nvim",
    keys = {
      -- disable the default flash keymap
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "x", "o" }, false },
      {
        "<M-s>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<M-S>",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
}
