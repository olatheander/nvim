local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local navic = require("nvim-navic")
local lsp_format = require("lsp-format")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- format on save
	-- if client.server_capabilities.documentFormattingProvider then
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		group = vim.api.nvim_create_augroup("Format", { clear = true }),
	-- 		buffer = bufnr,
	-- 		callback = function()
	-- 			vim.lsp.buf.formatting_seq_sync()
	-- 		end,
	-- 	})
	-- end

	navic.attach(client, bufnr)
	lsp_format.on_attach(client)

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.dockerls.setup({})
nvim_lsp.gopls.setup({})
nvim_lsp.yamlls.setup({})
nvim_lsp.jsonls.setup({
	-- settings = {
	-- 	json = {
	-- 		schemas = require("schemastore").json.schemas(),
	-- 		validate = { enable = true },
	-- 	},
	-- },
})

local function add_missing_imports()
	local params = {
		command = "_typescript.addMissingImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities,
	commands = {
		AddMissingImport = {
			add_missing_imports,
			description = "Add missing Imports",
		},
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

nvim_lsp.sumneko_lua.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},

			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
	severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
