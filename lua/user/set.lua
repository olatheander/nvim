vim.opt.number = true
vim.opt.relativenumber = true -- set relative numbered lines

vim.opt.mouse = "a" -- allow the mouse to be used in neovim

vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.fileencoding = "utf-8" -- the encoding written to a file

vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.smartcase = true -- smart case
vim.opt.cursorline = true -- highlight the current line

vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false -- creates a backup file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.incsearch = true
vim.opt.ignorecase = true -- ignore case in search patterns

vim.opt.termguicolors = true -- set term gui colors (most terminals support this)

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"
