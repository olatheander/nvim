local saga = require("lspsaga")

-- saga.init_lsp_saga({
-- 	server_filetype_map = {
-- 		typescript = "typescript",
-- 	},
-- })
saga.init_lsp_saga({
	-- Winbar does not yet work but can replace navic eventually.
	-- symbol_in_winbar = {
	-- 	in_custom = true,
	-- 	enable = true,
	-- 	separator = " ",
	-- 	show_file = true,
	-- 	click_support = false,
	-- },
})
