local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
--keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)
--keymap("n", "<C-i>", "<C-i>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-w>", "<C-w>w", opts)

-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- nvim-tree
--keymap("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", opts)

-- Telescope
--keymap("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
--keymap("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", opts)
--keymap("n", "<leader>fb", "<CMD>Telescope buffers<CR>", opts)

-- LSP
--keymap("n", "<leader>lf", "<CMD>lua vim.lsp.buf.formatting()<CR>", opts)

-- DAP
--keymap("n", "<leader>db", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts)
--keymap("n", "<leader>dc", "<CMD>lua require'dap'.continue()<CR>", opts)
--keymap("n", "<leader>di", "<CMD>lua require'dap'.step_into()<CR>", opts)
--keymap("n", "<leader>do", "<CMD>lua require'dap'.step_over()<CR>", opts)
--keymap("n", "<leader>dO", "<CMD>lua require'dap'.step_out()<CR>", opts)
--keymap("n", "<leader>dr", "<CMD>lua require'dap'.repl.toogle()<CR>", opts)
--keymap("n", "<leader>dl", "<CMD>lua require'dap'.run_last()<CR>", opts)
--keymap("n", "<leader>du", "<CMD>lua require'dapui'.toggle()<CR>", opts)
--keymap("n", "<leader>dx", "<CMD>lua require'dap'.terminate()<CR>", opts)

-- Visual --
-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
