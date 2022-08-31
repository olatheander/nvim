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
		b = { "<cmd>GitBlameToggle<CR>", "Toogle Git Blame" },
		d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
		D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		D = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		F = { "<cmd>Lspsaga lsp_finder<cr>", "Find" },
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
		L = {
			"<ESC><CMD>lua require('Comment.api').locked('uncomment.linewise')(vim.fn.visualmode())<CR>",
			"Uncomment Line",
		},
		b = {
			"<ESC><CMD>lua require('Comment.api').locked('comment.blockwise')(vim.fn.visualmode())<CR>",
			"Comment Block",
		},
		B = {
			"<ESC><CMD>lua require('Comment.api').locked('uncomment.blockwise')(vim.fn.visualmode())<CR>",
			"Uncomment Block",
		},
	},
}

-- File-type specific keymaps
local function ft_keymap()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			vim.schedule(FtRunner)
		end,
	})

	function FtRunner()
		local bufnr = vim.api.nvim_get_current_buf()
		local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
		local fname = vim.fn.expand("%:p:t")
		local keymap_ft = {} -- normal key map
		local keymap_ft_v = {} -- visual key map

		if ft == "python" then
			keymap_ft = {
				name = "Python",
				r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
				m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
			}
		elseif ft == "lua" then
			keymap_ft = {
				name = "Lua",
				r = { "<cmd>luafile %<cr>", "Run" },
			}
		elseif ft == "rust" then
			keymap_ft = {
				name = "Rust",
				r = { "<cmd>execute 'Cargo run' | startinsert<cr>", "Run" },
				D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
				h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
				R = { "<cmd>RustRunnables<cr>", "Runnables" },
			}
		elseif ft == "go" then
			keymap_ft = {
				name = "Go",
				r = { "<cmd>GoRun<cr>", "Run" },
			}
		elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
			keymap_ft = {
				name = "Typescript",
				o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
				r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
				i = { "<cmd>TypescriptAddMissingImports<cr>", "Import Missing" },
				F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
				u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
				R = { "<cmd>lua require('config.neotest').javascript_runner()<cr>", "Choose Test Runner" },
				-- s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
				-- t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
			}
		elseif ft == "java" then
			keymap_ft = {
				name = "Java",
				o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "Organize Imports" },
				v = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
				c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
				t = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
				n = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Test Nearest Method" },
			}
			keymap_ft_v = {
				name = "Java",
				v = { "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
				c = { "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
				m = { "<esc><cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
			}
		end

		if fname == "package.json" then
			keymap_ft = {
				name = "Npm/Yarn",
				c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" },
				v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" },
			}
			-- keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
			-- keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
		end

		if fname == "Cargo.toml" then
			keymap_ft = {
				name = "Cargo",
				u = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All Crates" },
			}
		end

		if next(keymap_ft) ~= nil then
			local k = { t = keymap_ft }
			local o = { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
			whichkey.register(k, o)
		end

		if next(keymap_ft_v) ~= nil then
			local k = { t = keymap_ft_v }
			local o = { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
			whichkey.register(k, o)
		end
	end
end

whichkey.register(keymap, opts)
whichkey.register(v_keymap, v_opts)
ft_keymap()
