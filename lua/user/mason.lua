local mason = require("mason")
local lspconfig = require("mason-lspconfig")

mason.setup({})

lspconfig.setup({
	ensure_installed = { "sumneko_lua", "dockerls", "yamlls", "tsserver", "jdtls", "jsonls", "gopls" },
})
