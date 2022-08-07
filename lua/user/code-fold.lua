-- Based on the "Code Folding in Neovim with Tree-sitter" article at https://www.jmaguire.tech/posts/treesitter_folding/

local vim = vim
local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

--local group = vim.api.nvim_create_augroup("OpenFileUnfolded", { clear = true })
--vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
--	command = "zR",
--	desc = "Open files as unfolded",
--	group = group,
--})
