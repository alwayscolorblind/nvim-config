require("configs.lazy")
require("options")
require("autocmds")
require("mappings")

require("configs.conform")
require("configs.cmp")
require("configs.ibl")
require("configs.rust")
require("configs.illuminate")
require("configs.typescript")
require("configs.spectre")
require("configs.image")
require("configs.lualine")
require("configs.windows")

-- apply colorscheme
require("configs.gruvbox")

vim.cmd([[colorscheme gruvbox]])
