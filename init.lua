require("configs.lazy")
require("options")
require("autocmds")
vim.schedule(function()
	require("mappings")
end)

require("configs.conform")
require("configs.cmp")
require("configs.ibl")
require("configs.rust")
require("configs.illuminate")
require("configs.typescript")
require("configs.spectre")
require("configs.image")
require("configs.lualine")

-- apply colorscheme
require("configs.gruvbox")

vim.cmd([[colorscheme gruvbox]])
