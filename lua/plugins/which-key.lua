return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>"] = {
          b = {
            B = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
            s = { "<Cmd>BufferLinePick<Cr>", "Select a Buffer" },
          },
        },
      },
    },
  },
}
