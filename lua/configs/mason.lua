return {
	PATH = "skip",
	max_concurrent_installers = 10,

	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- js, html, css ... web
		"css-lsp",
		"html-lsp",
		"css-variables-language-server",
		"typescript-language-server",
		"emmet-ls",
		"tailwindcss-language-server",
		"stylelint-lsp",
		"cssmodules-language-server",

		-- rust
		"rust-analyzer",

		-- configs
		"nginx-language-server",
		"yaml-language-server",

		-- c/cpp stuff
		"clangd",
		"clang-format",

		-- sql
		"sqls",

		-- sh
		"shfmt",
	},
}
