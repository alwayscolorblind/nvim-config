require("nvchad.configs.lspconfig").defaults()
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- deprecated
-- local servers = {
--   "html",
--   "cssls",
--   "clangd",
--   "gopls",
--   "eslint",
--   "stylelint_lsp",
--   "tailwindcss",
--   "nginx_language_server",
-- }

-- for _, lsp in ipairs(servers) do
--   vim.lsp.config[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end
--
vim.lsp.config("*", { capabilities = capabilities, on_attach = on_attach })

vim.lsp.config("sqlls", {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
  filetypes = { 'sql', 'mysql' },
  settings = {},
})

vim.lsp.config("yamlls", {
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values", "*.docker-compose.yml" },
  settings = {
    yaml = {
      ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
      "*.docker-compose.yml",
    },
  },
})

vim.lsp.config("cssmodules_ls", {
  on_attach = function(client)
    client.server_capabilities.implementationProvider = false
    client.server_capabilities.definitionProvider = false
    on_attach(client)
  end,
})

vim.lsp.config("emmet_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "html",
    "css",
    "sass",
    "scss",
    "less",
  },
})
