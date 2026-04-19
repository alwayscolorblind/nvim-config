return {
	-- nvim tree
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			return require("configs.nvimtree")
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },

	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
	},

	-- formatting
	{
		"stevearc/conform.nvim",
		opts = {},
	},

	-- lsp stuff
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = function()
			return require("configs.mason")
		end,
		config = function(_, opts)
			require("mason").setup(opts)

			-- custom cmd to install all mason binaries listed
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				if opts.ensure_installed and #opts.ensure_installed > 0 then
					vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
				end
			end, {})

			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "User FilePost",
		config = function()
			require("configs.lspconfig")
		end,
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	},

	-- themes
	{ "alwayscolorblind/gruvbox.nvim", priority = 1000, config = true },
	{ "lspkind.nvim", event = { "InsertEnter", "CmdlineEnter" } },

	-- cmp
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- autopairing of (){}[] etc
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
				end,
			},

			-- cmp sources plugins
			{
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"https://codeberg.org/FelipeLema/cmp-async-path.git",
			},
		},
	},

	-- git
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
	},

	-- other
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		opts = function()
			return require("configs.telescope")
		end,
	},

	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
		lazy = false,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		main = "ibl",
	},

	{
		"andymass/vim-matchup",
		event = "User FilePost",
		opts = {
			treesitter = {
				stopline = 500,
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
	},
	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>ll", require("nvim-emmet").wrap_with_abbreviation)
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"MunifTanjim/prettier.nvim",
	},
	{ "RRethy/vim-illuminate" },
	{ "nvim-pack/nvim-spectre" },
	{ "RRethy/vim-illuminate" },
	{ "nvim-pack/nvim-spectre" },
	{
		"3rd/image.nvim",
		build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
		opts = {
			processor = "magick_cli",
		},
	},
	{
		"rebelot/terminal.nvim",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			enabled = true,
			smear_between_buffers = true,
			stiffness = 0.9,
			trailing_stiffness = 0.8,
			distance_stop_animating = 0.3,
		},
		lazy = false,
	},
}
