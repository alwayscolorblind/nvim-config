---@type LazySpec
return {
	{
		"mikavilpas/yazi.nvim",
		version = "*", -- use the latest stable version
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>e",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
			yazi_floating_window_border = "none",
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- mark netrw as loaded so it's not loaded at all.
			--
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	{
		-- example: a yazi plugin monorepo which provides multiple plugins for
		-- yazi. To use it, you need to specify the sub_dir for the plugin you want
		-- to install.
		-- example: include multiple plugins from a monorepo. There are lots of
		-- plugins available in e.g. https://github.com/yazi-rs/plugins
		"yazi-rs/plugins",
		name = "yazi-rs-plugins",
		lazy = true,
    -- stylua: ignore
    build = function(plugin)
      require("yazi.plugin").build_plugin(plugin, { sub_dir = "git.yazi" })
      require("yazi.plugin").build_plugin(plugin, { sub_dir = "vcs-files.yazi" })
    end,
	},
}
