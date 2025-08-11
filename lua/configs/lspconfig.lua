require("nvchad.configs.lspconfig").defaults()
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = {
  "html",
  "cssls",
  "clangd",
  "gopls",
  "eslint",
  "stylelint_lsp",
  "tailwindcss",
  "nginx_language_server",
  "kotlin_language_server",
  "graphql",
}

local lspconfig = require "lspconfig"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values", "*.docker-compose.yml" },
  settings = {
    yaml = {
      ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*.docker-compose.yml",
    },
  },
}

lspconfig.cssmodules_ls.setup {
  on_attach = function(client)
    client.server_capabilities.implementationProvider = false
    client.server_capabilities.definitionProvider = false
    on_attach(client)
  end,
  capabilities = capabilities,
}

lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "html",
    "css",
    "sass",
    "scss",
    "less",
  },
}
