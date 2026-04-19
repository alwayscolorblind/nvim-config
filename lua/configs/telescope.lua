return {
	defaults = {
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
		cache_pickers = {
			num_pickers = 5,
			ignore_empty_prompt = true,
		},
	},

	extensions_list = { "themes", "terms" },
	extensions = {},
}
