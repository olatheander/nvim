-- Based on the "Code Folding in Neovim with Tree-sitter" article at https://www.jmaguire.tech/posts/treesitter_folding/

--local vim = vim
local opt = vim.opt
--
--opt.foldmethod = "expr"
--opt.foldexpr = "nvim_treesitter#foldexpr()"

--local group = vim.api.nvim_create_augroup("OpenFileUnfolded", { clear = true })
--vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
--	command = "zR",
--	desc = "Open files as unfolded",
--	group = group,
--})

local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
	return
end
ufo.setup({
	provider_selector = function(bufnr, filetype)
		return { "lsp", "indent" }
	end,
})

vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = -1
opt.foldenable = true

local icons = require("user.icons")
opt.fillchars = { foldopen = icons.ui.ArrowOpen, foldclose = icons.ui.ArrowClosed }
