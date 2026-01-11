local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.splitkeep = "screen"
o.clipboard = "unnamedplus"
o.cursorline = true

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- matchup config
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

-- Custom highlight colors (optional)
vim.cmd([[
  hi MatchParen ctermbg=none ctermfg=magenta
  hi MatchWord cterm=underline ctermbg=none ctermfg=cyan
  hi MatchWordCur cterm=underline ctermbg=none ctermfg=yellow
]])

g.matchup_treesitter_enable_quotes = false
