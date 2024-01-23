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
        },
      },
    },
  },
}
