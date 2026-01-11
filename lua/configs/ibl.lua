require("ibl").setup({
	indent = { char = "▏" },
	scope = {
		enabled = true,
		show_start = false, -- Don't show the start of the scope
		show_end = false, -- Don't show the end of the scope
		char = "▏", -- Character for scope lines
		highlight = { "Function", "Label" },
		priority = 500,
		injected_languages = false,
		show_exact_scope = true,
		include = { node_type = { ["*"] = { "*" } } },
	},
})
