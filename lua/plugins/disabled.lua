-- disabling unwanted plugins
return {
  -- {
  --   "folke/trouble.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "folke/noice.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   enabled = false,
  -- },
  -- {
  --   "rcarriga/nvim-notify",
  --   enabled = false,
  -- },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "nvimdev/dashboard-nvim",
  --   enabled = false,
  -- },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   enabled = false,
  -- },
  {
    "mfussenegger/nvim-jdtls", -- Disabled since it it's a big penalty opening the flink project.
    enabled = false,
  },
}
