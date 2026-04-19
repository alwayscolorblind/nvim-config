require("nvim-treesitter-textobjects").setup({
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
			["]m"] = "@function.outer",
			["]]"] = "@class.outer",
			["]f"] = "@function.outer",
		},
		goto_next_end = {
			["]M"] = "@function.outer",
			["]["] = "@class.outer",
			["]F"] = "@function.outer",
		},
		goto_previous_start = {
			["[m"] = "@function.outer",
			["[["] = "@class.outer",
			["[f"] = "@function.outer",
		},
		goto_previous_end = {
			["[M"] = "@function.outer",
			["[]"] = "@class.outer",
			["[F"] = "@function.outer",
		},
		goto_next = {
			["]/"] = "@comment.outer",
			["]*"] = "@comment.outer",
		},
		goto_previous = {
			["[/"] = "@comment.outer",
			["[*"] = "@comment.outer",
		},
	},
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",

			["ac"] = "@class.outer",
			["ic"] = { query = "@class.inner", desc = "Inside a class/definition" },

			["g/"] = "@comment.outer",

			["ia"] = "@parameter.inner",
			["aa"] = "@parameter.outer",

			["at"] = "@tag.outer",
			["it"] = "@tag.inner",

			["aI"] = "@block.outer",
			["ai"] = "@indent.outer",
			["ii"] = "@indent.inner",

			["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },

			["[x"] = "@scope.outer",
			["]x"] = "@statement.outer",
		},
		selection_modes = {
			["@parameter.outer"] = "v",
			["@function.outer"] = "V",
			["@class.outer"] = "<c-v>",
			["@comment.outer"] = "V",
			["@tag.outer"] = "v",
		},
		include_surrounding_whitespace = true,
	},

	swap = {
		enable = true,
		swap_next = {
			["<leader>a"] = "@parameter.inner",
		},
		swap_previous = {
			["<leader>A"] = "@parameter.inner",
		},
	},

	lsp_interop = {
		enable = true,
		border = "none",
		peek_definition_code = {
			["<leader>df"] = "@function.outer",
			["<leader>dF"] = "@class.outer",
		},
	},
})
