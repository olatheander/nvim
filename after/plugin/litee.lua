-- configure the litee.nvim library
require("litee.lib").setup({
	panel = {
		orientation = "right",
	},
})
-- configure litee-calltree.nvim
require("litee.calltree").setup({
	on_open = "panel",
})
-- configure litee-symboltree.nvim
require("litee.symboltree").setup({
	on_open = "panel",
})
require("litee.filetree").setup({
	on_open = "panel",
})
-- require("litee.bookmarks").setup({
-- 	on_open = "panel",
-- })
