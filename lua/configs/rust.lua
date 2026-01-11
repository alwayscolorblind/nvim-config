local on_attach = require("configs.lspconfig.utils").on_attach
local capabilities = require("configs.lspconfig.utils").capabilities

vim.g.rustaceanvim = {
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
	default_settings = {
		["rust-analyzer"] = {},
	},
}

local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

npairs.setup({
	check_ts = true, -- Enable treesitter support for more precision
})

npairs.add_rule(Rule("<", ">", {}):with_pair(
	-- regex will make it so that it will auto-pair on
	-- `a<` but not `a <`
	-- The `:?:?` part makes it also
	-- work on Rust generics like `some_func::<T>()`
	cond.before_regex("%a+:?:?$", 3)
):with_move(function(opts)
	return opts.char == ">"
end))
