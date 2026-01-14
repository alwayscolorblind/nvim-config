local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.splitkeep = "screen"
o.clipboard = "unnamedplus"
o.cursorline = true

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false

opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

o.updatetime = 250

opt.whichwrap:append("<>[]hl")

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

g.matchup_enabled = 1
g.matchup_matchparen_enabled = 1
g.matchup_matchparen_deferred = 1
g.matchup_matchparen_timeout = 300
g.matchup_matchparen_insert_timeout = 60

g.matchup_matchparen_hi_surround_always = 1 -- Always highlight surrounding pair
g.matchup_matchparen_offscreen = { method = "popup" }

g.matchup_motion_enabled = 0
g.matchup_text_obj_enabled = 0

g.matchup_transmute_enabled = 1

vim.cmd([[
  hi MatchParen ctermbg=none ctermfg=magenta
  hi MatchWord cterm=underline ctermbg=none ctermfg=cyan
  hi MatchWordCur cterm=underline ctermbg=none ctermfg=yellow
]])

g.matchup_treesitter_enable_quotes = false

vim.diagnostic.config({
	virtual_text = {
		source = true,
	},
	signs = true,
	float = {
		header = "Diagnostics",
		source = true,
		border = "rounded",
	},
})

--windows.nvim
vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false
