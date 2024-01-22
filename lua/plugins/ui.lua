return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2000,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { focusable = false }) -- Avoid focus on notification when navigating with <C-w> (https://github.com/rcarriga/nvim-notify/issues/182)
      end,
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

  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<F2>",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Start/Continue",
      },
      {
        "<F7>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<S-F7>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<F8>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<F9>",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run To Cursor",
      },
    },
  },
}
