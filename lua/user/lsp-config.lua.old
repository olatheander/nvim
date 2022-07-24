local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.setup({
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

local status_lsp_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_lsp_ok then
	return
end

-- Configure diagnostics gutter icons
local icons = require("user.icons")
local signs = { Error = icons.diagnostics.Error, Warn = icons.diagnostics.Warning, Hint = icons.diagnostics.Hint, Info = icons.diagnostics.Information }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

nvim_lsp.sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
