local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	completion = { completeopt = "menu,menuone" },
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "async_path" },
	},

	formatting = {
		format = function(entry, vim_item)
			local lk_format = lspkind.cmp_format({
				menu = {
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[Latex]",
				},
			})

			local formatted = lk_format(entry, vim_item)

			add_rust_completion(formatted, entry)

			return formatted
		end,

		fields = { "abbr", "kind", "menu" },
	},
})

function add_rust_completion(vim_item, entry)
	local item = entry:get_completion_item()

	local use_label_detail = false

	if item.data ~= nil and item.data.imports ~= nil then
		if #item.data.imports == 1 then
			vim_item.abbr = vim_item.abbr .. "(" .. item.data.imports[1].full_import_path .. ")"
		-- to remove unnecessary imports use other method of import detection
		elseif #item.data.imports > 1 then
			use_label_detail = true
		end
	end

	if item.labelDetails then
		-- add type
		if item.labelDetails.description ~= nil then
			vim_item.menu = vim_item.menu .. " " .. item.labelDetails.description
		end

		-- TODO: use text formatting instead of two detections
		if use_label_detail == true then
			if item.labelDetails.detail ~= nil then
				local import_path = item.labelDetails.detail
				vim_item.abbr = vim_item.abbr .. " " .. import_path
			end
		end
	end
end
