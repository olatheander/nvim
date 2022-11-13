-- Shorten function name
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-w>", "<C-w>w", opts)
keymap("t", "<m-h>", [[<Cmd>wincmd h<CR>]], opts)
keymap("t", "<m-j>", [[<Cmd>wincmd j<CR>]], opts)
keymap("t", "<m-k>", [[<Cmd>wincmd k<CR>]], opts)
keymap("t", "<m-l>", [[<Cmd>wincmd l<CR>]], opts)
keymap("t", "<m-w>", [[<Cmd>wincmd w<CR>]], opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Bufferline
keymap("n", "<S-Tab>", "<cmd>BufferLineCycleNext<cr>", opts)
keymap("n", "<M-Tab>", "<cmd>BufferLineCyclePrev<cr>", opts) -- Use Meta/Alt not to break CTRL+i (since CTRL+i and Tab is the same thing in terminals)

-- Greatest remap ever (ThePrimagen) https://www.youtube.com/watch?v=qZO9A5F6BZs
keymap("x", "<leader>p", '"_dP', opts)
