-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Bufferline
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true, desc = "Next Buffer" })
vim.keymap.set(
  "n",
  "<M-Tab>",
  "<cmd>BufferLineCyclePrev<cr>",
  { noremap = true, silent = true, desc = "Previous Buffer" }
) -- Use Meta/Alt not to break CTRL+i (since CTRL+i and Tab is the same thing in terminals)
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting yanked text" }) -- paste without overwriting yanked text (deleted text to void registry)

vim.keymap.set({ "n", "v" }, "<leader>z", [["_d]], { desc = "Delete to void registry" }) -- delete to void registry

-- Better window navigation
vim.keymap.set("n", "<m-w>", "<C-w>w", { noremap = true, silent = true, desc = "Next window" })
vim.keymap.set("t", "<m-w>", [[<Cmd>wincmd w<CR>]], { noremap = true, silent = true, desc = "Next window" })
