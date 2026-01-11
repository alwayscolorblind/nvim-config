local on_attach = require("configs.lspconfig.utils").on_attach
local capabilities = require("configs.lspconfig.utils").capabilities

-- ts error codes to ignore
local ts_diagnostic_ignore_codes =
	{ 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8012, 8013, 8014, 8015, 8016, 8017 }

local function has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

require("typescript-tools").setup({
	on_attach = on_attach,
	capabilities = capabilities,
	handlers = {
		["textDocument/publishDiagnostics"] = function(_1, params, client_id)
			if params.diagnostics ~= nil then
				local idx = 1
				while idx <= #params.diagnostics do
					if has_value(ts_diagnostic_ignore_codes, params.diagnostics[idx].code) then
						table.remove(params.diagnostics, idx)
					else
						idx = idx + 1
					end
				end
			end
			vim.lsp.diagnostic.on_publish_diagnostics(_1, params, client_id)
		end,
	},
	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = "insert_leave",
		expose_as_code_action = {},
		tsserver_path = nil,
		tsserver_plugins = {},
		tsserver_max_memory = "auto",
		tsserver_format_options = {
			insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
			insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = true,
			insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = true,
		},
		tsserver_file_preferences = {
			quotePreference = "double",
			jsxAttributeCompletionStyle = "none",
		},
		tsserver_locale = "en",
		complete_function_calls = false,
		include_completions_with_insert_text = true,
		code_lens = "off",
		disable_member_code_lens = true,
		jsx_close_tag = {
			enable = true,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
	},
})
