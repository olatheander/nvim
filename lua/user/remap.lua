local opts = { noremap = true, silent = true }

vim.g.mapleader = " " --Remap space as leader key
vim.g.maplocalleader = " " --Remap space as leader key

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move command; move a block of highlighted text up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Append line at the end without moving cursor
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Append line at the end without moving cursor. This is a bit more intuitive.
vim.keymap.set("n", "J", "mzJ`z")

-- Enable half-page jumping while keeping cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search while stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]) -- paste without overwriting yanked text (deleted text to void registry)

vim.keymap.set({"n", "v"}, "<leader>z", [["_d]]) -- delete to void registry

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- sed prompt for replacing word under cursor
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- make the current file executable

-- Better window navigation
vim.keymap.set("n", "<m-h>", "<C-w>h", opts)
vim.keymap.set("n", "<m-j>", "<C-w>j", opts)
vim.keymap.set("n", "<m-k>", "<C-w>k", opts)
vim.keymap.set("n", "<m-l>", "<C-w>l", opts)
vim.keymap.set("n", "<m-w>", "<C-w>w", opts)
vim.keymap.set("t", "<m-h>", [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set("t", "<m-j>", [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set("t", "<m-k>", [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set("t", "<m-l>", [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set("t", "<m-w>", [[<Cmd>wincmd w<CR>]], opts)
--
-- Resizing panes
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Bufferline
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCycleNext<cr>", opts)
vim.keymap.set("n", "<M-Tab>", "<cmd>BufferLineCyclePrev<cr>", opts) -- Use Meta/Alt not to break CTRL+i (since CTRL+i and Tab is the same thing in terminals)
