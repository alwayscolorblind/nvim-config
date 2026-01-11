require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
		typescript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
		typescript_react = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},

	default_format_opts = {
		lsp_format = "fallback",
	},
})
