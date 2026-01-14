local on_attach = require("configs.lspconfig.utils").on_attach
local capabilities = require("configs.lspconfig.utils").capabilities

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		on_attach(_, args.buf)
	end,
})

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.enable("sqls")

vim.lsp.config("yamlls", {
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values", "*.docker-compose.yml" },
	settings = {
		yaml = {
			["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*.docker-compose.yml",
		},
	},
})
vim.lsp.enable("yamlls")

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = "vim" },
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					"${3rd}/luv/library",
				},
			},
		},
	},
})
vim.lsp.enable("lua_ls")

require("configs.lspconfig.web")
