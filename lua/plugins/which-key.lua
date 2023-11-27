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
          f = {
            B = { "<cmd>Telescope file_browser<cr>", "File Browser" },
          },
          g = {
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
          },
        },
      },
    },
  },
}
