require "nvchad.options"

--options
vim.o.relativenumber = true
vim.o.number = true
vim.o.cursorline = true

-- diagnostics
vim.diagnostic.config({ virtual_text = true })

-- lsp
-- vim.lsp.inlay_hint.enable(true)
