local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
	local icons = require("user.icons")
	local signs = {

		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
			-- width = 40,
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
		width = 60,
		-- height = 30,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		width = 60,
		-- height = 30,
	})
end

local function lsp_highlight_document(client)
	-- if client.server_capabilities.document_highlight then
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
	-- end
end

local function attach_navic(client, bufnr)
	vim.g.navic_silence = true
	local status_ok, navic = pcall(require, "nvim-navic")
	if not status_ok then
		return
	end
	navic.attach(client, bufnr)
end

M.on_attach = function(client, bufnr)
	lsp_highlight_document(client)
	attach_navic(client, bufnr)

	-- setup formatting
	local ok, lsp_format = pcall(require, "lsp-format")
	if ok then
		lsp_format.on_attach(client)
	end

	-- if client.server_capabilities.inlayHintProvider then
	-- for tsserver
	if client.name == "tsserver" then
	-- TODO: This causes a module 'lsp_inlay_hints' not found error. Unclear why?
	--    require("lsp_inlay_hints").setup_autocmd(bufnr, "typescript/inlayHints")
	else
		--    require("lsp_inlay_hints").setup_autocmd(bufnr)
	end
	-- end

	if client.name == "jdt.ls" then
		-- TODO: instantiate capabilities in java file later
		M.capabilities.textDocument.completion.completionItem.snippetSupport = false
		vim.lsp.codelens.refresh()
		if JAVA_DAP_ACTIVE then
			require("jdtls").setup_dap({ hotcodereplace = "auto" })
			require("jdtls.dap").setup_dap_main_class_configs()
		end
	end

	--	if client.name == "sumneko_lua" then
	--	end
end

--function M.enable_format_on_save()
--	vim.cmd([[
--    augroup format_on_save
--      autocmd!
--      autocmd BufWritePre * lua vim.lsp.buf.format({ async = true })
--    augroup end
--  ]])
--	vim.notify("Enabled format on save")
--end

--function M.disable_format_on_save()
--	M.remove_augroup("format_on_save")
--	vim.notify("Disabled format on save")
--end

--function M.toggle_format_on_save()
--	if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
--		M.enable_format_on_save()
--	else
--		M.disable_format_on_save()
--	end
--end

function M.remove_augroup(name)
	if vim.fn.exists("#" .. name) == 1 then
		vim.cmd("au! " .. name)
	end
end

--vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]])

return M
