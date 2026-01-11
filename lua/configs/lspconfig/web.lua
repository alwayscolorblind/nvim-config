local on_attach = require("configs.lspconfig.utils").on_attach
local capabilities = require("configs.lspconfig.utils").on_attach

vim.lsp.config("cssmodules_ls", {
	on_attach = function(client)
		client.server_capabilities.implementationProvider = false
		client.server_capabilities.definitionProvider = false
		on_attach(client)
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreac",
	},
})
vim.lsp.enable("cssmodules_ls")

vim.lsp.config("emmet_ls", {
	filetypes = {
		"html",
		"css",
		"sass",
		"scss",
		"less",
	},
})
vim.lsp.enable("emmet_ls")

vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("stylelint_lsp")
vim.lsp.enable("tailwindcss")
