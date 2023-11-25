-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Bufferline
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCycleNext<cr>", opts)
vim.keymap.set("n", "<M-Tab>", "<cmd>BufferLineCyclePrev<cr>", opts) -- Use Meta/Alt not to break CTRL+i (since CTRL+i and Tab is the same thing in terminals)
