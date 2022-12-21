-- Based on the "Code Folding in Neovim with Tree-sitter" article at https://www.jmaguire.tech/posts/treesitter_folding/

local ufo = require("ufo")
ufo.setup({
	provider_selector = function(bufnr, filetype)
		return { "lsp", "indent" }
	end,
})

vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = -1
vim.opt.foldenable = true

local icons = require("user.icons")
vim.opt.fillchars = { foldopen = icons.ui.ArrowOpen, foldclose = icons.ui.ArrowClosed }
