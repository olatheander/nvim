local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvim_tree.setup({
	--  disable_netrw = true,
	--  hijack_netrw = true,
	view = {
		number = true,
		relativenumber = true,
		adaptive_size = true,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
	update_focused_file = { enable = true },
})
