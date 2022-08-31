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
keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", opts)
keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", opts)
