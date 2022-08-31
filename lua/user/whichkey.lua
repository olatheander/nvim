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

	c = {
		name = "Code",
		b = {
			"<CMD>lua require('Comment.api').toggle.blockwise.current()<CR>",
			"Comment Block",
		},
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		g = { "<cmd>Neogen func<Cr>", "Func Doc" },
		G = { "<cmd>Neogen class<Cr>", "Class Doc" },
		h = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
		l = {
			"<CMD>lua require('Comment.api').toggle.linewise.current()<CR>",
			"Comment Line",
		},
		I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
		r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		f = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Float" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
		T = { "<cmd>TodoTelescope<Cr>", "TODO" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Loc List" },
	},

	f = {
		name = "Find",
		f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
		g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Grep" },
		b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Buffers" },
	},

	g = {
		name = "Git",
		b = { "<cmd>GitBlameToggle<CR>", "Blame" },
		d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
		D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
		D = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		F = { "<cmd>Lspsaga lsp_finder<cr>", "Find" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		j = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Diagnostics prev" },
		k = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Diagnostics next" },
		K = { "<cmd>Lspsaga hover_doc<cr>", "Hover docs" },
		p = { "<cmd>Lspsaga preview_definition<cr>", "Preview" },
		r = { "<cmd>Lspsaga rename<cr>", "Rename" },
		s = { "<cmd>Lspsaga signature_help<cr>", "Signature" },
	},
}

local v_keymap = {
	c = {
		name = "Code",
		l = {
			"<ESC><CMD>lua require('Comment.api').locked('comment.linewise')(vim.fn.visualmode())<CR>",
			"Comment Line",
		},
		b = {
			"<ESC><CMD>lua require('Comment.api').locked('comment.blockwise')(vim.fn.visualmode())<CR>",
			"Comment Block",
		},
	},
}

whichkey.register(keymap, opts)
whichkey.register(v_keymap, v_opts)
