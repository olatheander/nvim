return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          -- { "<leader>bB", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Buffers" }, -- Mapped to <leader>, by default
          { "<leader>bs", "<Cmd>BufferLinePick<Cr>", desc = "Select a Buffer" },
        },
      },
    },
  },
}
