local whichkey = require("which-key")

local conf = {
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
	},
}
whichkey.setup(conf)

local opts = {
	mode = "n", -- Normal mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
	mode = "v", -- Visual mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local keymap = {
	b = {
		name = "Buffer",
		c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
		f = { "<Cmd>BDelete! this<Cr>", "Force Close Buffer" },
		D = { "<Cmd>BWipeout other<Cr>", "Delete All Buffers" },
		b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
		p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
		m = { "<Cmd>JABSOpen<Cr>", "Menu" },
	},

	f = {
		name = "Find",
		f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
		g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Grep" },
		b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Buffers" },
	},

	l = {
		name = "LSP",
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
	},
}

whichkey.register(keymap, opts)
