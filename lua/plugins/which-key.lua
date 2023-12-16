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
            C = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", "File Browser (cwd)" },
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
