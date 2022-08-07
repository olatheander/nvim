local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local m_opts = {
	mode = "n", -- NORMAL mode
	prefix = "m",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local m_mappings = {
	a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
	c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
	b = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
	m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
	["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
	[","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
	l = { "<cmd>lua require('user.bfs').open()<cr>", "Buffers" },
	j = { "<cmd>silent BookmarkNext<cr>", "Next" },
	s = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
	k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
	S = { "<cmd>silent BookmarkShowAll<cr>", "Prev" },
	-- s = {
	--   "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
	--   "Show",
	-- },
	x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
	[";"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
}

local leader_opts = {
	mkde = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local leader_mappings = {
	-- ["1"] = "which_key_ignore",
	a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Action" },
	b = { "<cmd>Telescope buffers<cr>", "Buffers" },
	e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	v = { "<cmd>vsplit<cr>", "vsplit" },
	h = { "<cmd>split<cr>", "split" },
	w = { "<cmd>w<CR>", "Write" },
	-- h = { "<cmd>nohlsearch<CR>", "No HL" },
	q = { '<cmd>lua require("user.functions").smart_quit()<CR>', "Quit" },
	-- ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	C = { "<cmd>Bdelete!<CR>", "Close Buffer" },

	-- :lua require'lir.float'.toggle()
	-- ["f"] = {
	--   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
	--   "Find files",
	-- },
	-- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	-- P = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	-- ["R"] = { '<cmd>lua require("renamer").rename()<cr>', "Rename" },
	-- ["z"] = { "<cmd>ZenMode<cr>", "Zen" },
	["gy"] = "Link",

	c = {
		name = "Comment",
		l = {
			"<CMD>lua require('Comment.api').toggle_current_linewise()<CR>",
			"Line",
		},
		b = {
			"<CMD>lua require('Comment.api').toggle_current_blockwise()<CR>",
			"Block",
		},
		m = {
			name = "Multi...",

			l = {
				"<CMD>lua require('Comment.api').call('toggle_linewise_op')<CR>g@",
				"Line",
			},
			b = {
				"<CMD>lua require('Comment.api').call('toggle_blockwise_op')<CR>g@",
				"Block",
			},
		},
	},
	B = {
		name = "Browse",
		i = { "<cmd>BrowseInputSearch<cr>", "Input Search" },
		b = { "<cmd>Browse<cr>", "Browse" },
		d = { "<cmd>BrowseDevdocsSearch<cr>", "Devdocs" },
		f = { "<cmd>BrowseDevdocsFiletypeSearch<cr>", "Devdocs Filetype" },
		m = { "<cmd>BrowseMdnSearch<cr>", "Mdn" },
	},

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	o = {
		name = "Options",
		w = { '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap" },
		r = { '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', "Relative" },
		l = { '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', "Cursorline" },
		s = { '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell" },
		t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
	},

	-- s = {
	--   name = "Split",
	--   s = { "<cmd>split<cr>", "HSplit" },
	--   v = { "<cmd>vsplit<cr>", "VSplit" },
	-- },

	s = {
		name = "Session",
		s = { "<cmd>SaveSession<cr>", "Save" },
		r = { "<cmd>RestoreSession<cr>", "Restore" },
		x = { "<cmd>DeleteSession<cr>", "Delete" },
		f = { "<cmd>Autosession search<cr>", "Find" },
		d = { "<cmd>Autosession delete<cr>", "Find Delete" },
		-- a = { ":SaveSession<cr>", "test" },
		-- a = { ":RestoreSession<cr>", "test" },
		-- a = { ":RestoreSessionFromFile<cr>", "test" },
		-- a = { ":DeleteSession<cr>", "test" },
	},

	r = {
		name = "Replace",
		r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
		w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
		f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
	},

	d = {
		name = "Debug",
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
		O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
		l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
		u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
		x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
	},

	-- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
	-- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
	-- require("dapui").open()
	-- require("dapui").close()
	-- require("dapui").toggle()

	f = {
		name = "Find",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>Telescope find_files<cr>", "Find files" },
		g = { "<cmd>Telescope live_grep<cr>", "Find Text" },
		s = { "<cmd>Telescope grep_string<cr>", "Find String" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		H = { "<cmd>Telescope highlights<cr>", "Highlights" },
		i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
		l = { "<cmd>Telescope resume<cr>", "Last Search" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>GitBlameToggle<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
		w = { "<cmd>:DiffviewOpen<cr>", "Diffview" },
		G = {
			name = "Gist",
			a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
			d = { "<cmd>Gist -d<cr>", "Delete" },
			f = { "<cmd>Gist -f<cr>", "Fork" },
			g = { "<cmd>Gist -b<cr>", "Create" },
			l = { "<cmd>Gist -l<cr>", "List" },
			p = { "<cmd>Gist -b -p<cr>", "Create Private" },
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
		d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		--f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		f = { "<cmd>Format<cr>", "Format" },
		F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		h = { "<cmd>IlluminationToggle<cr>", "Toggle Doc HL" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
			"Prev Diagnostic",
		},
		K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
		v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		o = { "<cmd>SymbolsOutline<cr>", "Outline" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
		u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
	},

	n = {
		name = "Code Navigation",
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
		r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		f = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Float" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Loc List" },
	},
	-- s = {
	--   name = "Surround",
	--   ["."] = { "<cmd>lua require('surround').repeat_last()<cr>", "Repeat" },
	--   a = { "<cmd>lua require('surround').surround_add(true)<cr>", "Add" },
	--   d = { "<cmd>lua require('surround').surround_delete()<cr>", "Delete" },
	--   r = { "<cmd>lua require('surround').surround_replace()<cr>", "Replace" },
	--   q = { "<cmd>lua require('surround').toggle_quotes()<cr>", "Quotes" },
	--   b = { "<cmd>lua require('surround').toggle_brackets()<cr>", "Brackets" },
	-- },

	S = {
		-- name = "Session",
		-- s = { "<cmd>SaveSession<cr>", "Save" },
		-- l = { "<cmd>LoadLastSession!<cr>", "Load Last" },
		-- d = { "<cmd>LoadCurrentDirSession!<cr>", "Load Last Dir" },
		-- f = { "<cmd>Telescope sessions save_current=false<cr>", "Find Session" },
		name = "SnipRun",
		c = { "<cmd>SnipClose<cr>", "Close" },
		f = { "<cmd>%SnipRun<cr>", "Run File" },
		i = { "<cmd>SnipInfo<cr>", "Info" },
		m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
		r = { "<cmd>SnipReset<cr>", "Reset" },
		t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
		x = { "<cmd>SnipTerminate<cr>", "Terminate" },
	},

	t = {
		name = "Terminal",
		["1"] = { ":1ToggleTerm<cr>", "1" },
		["2"] = { ":2ToggleTerm<cr>", "2" },
		["3"] = { ":3ToggleTerm<cr>", "3" },
		["4"] = { ":4ToggleTerm<cr>", "4" },
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},

	T = {
		name = "Treesitter",
		h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
		p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
		r = { "<cmd>TSToggle rainbow<cr>", "Rainbow" },
	},
}

local v_opts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
local v_mappings = {
	s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
	c = {
		name = "Comment",
		l = {
			"<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
			"Line",
		},
		b = {
			"<ESC><CMD>lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>",
			"Block",
		},
	},
}

which_key.setup()
which_key.register(leader_mappings, leader_opts)
which_key.register(v_mappings, v_opts)
which_key.register(m_mappings, m_opts)
