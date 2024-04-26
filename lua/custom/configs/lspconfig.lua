local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "clangd", "gopls", "eslint" }

-- local eslint = require "eslint"
-- local null_ls = require "null-ls"
--
-- local prettier = require "prettier"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require("typescript-tools").setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = {},
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {
      insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = true,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = true,
      semicolons = "insert",
    },
    tsserver_file_preferences = {
      quotePreference = "single",
    },
    -- locale of all tsserver messages, supported locales you can find here:
    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
    tsserver_locale = "en",
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    -- CodeLens
    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    code_lens = "off",
    -- by default code lenses are displayed on all referencable values and for some of you it can
    -- be too much this option reduce count of them by removing member references from lenses
    disable_member_code_lens = true,
    -- JSXCloseTag
    -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
    -- that maybe have a conflict if enable this feature. )
    jsx_close_tag = {
      enable = true,
      filetypes = { "javascriptreact", "typescriptreact" },
    },
  },
}

-- local root_has_file = function(files)
--   return function(utils)
--     return utils.root_has_file(files)
--   end
-- end
--
-- local eslint_root_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
-- local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }
-- local stylua_root_files = { "stylua.toml", ".stylua.toml" }
-- local elm_root_files = { "elm.json" }
--
-- local opts = {
--   eslint_formatting = {
--     condition = function(utils)
--       local has_eslint = root_has_file(eslint_root_files)(utils)
--       local has_prettier = root_has_file(prettier_root_files)(utils)
--       return has_eslint and not has_prettier
--     end,
--   },
--   eslint_diagnostics = {
--     condition = root_has_file(eslint_root_files),
--   },
--   prettier_formatting = {
--     condition = root_has_file(prettier_root_files),
--   },
--   stylua_formatting = {
--     condition = root_has_file(stylua_root_files),
--   },
--   elm_format_formatting = {
--     condition = root_has_file(elm_root_files),
--   },
-- }
--
-- null_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   sources = {
--     null_ls.builtins.diagnostics.eslint_d.with(opts.eslint_diagnostics),
--     null_ls.builtins.formatting.eslint_d.with(opts.eslint_formatting),
--     null_ls.builtins.formatting.prettier.with(opts.prettier_formatting),
--     null_ls.builtins.formatting.stylua.with(opts.stylua_formatting),
--     null_ls.builtins.formatting.elm_format.with(opts.elm_format_formatting),
--     null_ls.builtins.code_actions.eslint_d.with(opts.eslint_diagnostics),
--   },
-- }
--
-- eslint.setup {
--   bin = "eslint", -- or `eslint_d`
--   on_attach = on_attach,
--   capabilities = capabilities,
--   code_actions = {
--     enable = true,
--     apply_on_save = {
--       enable = true,
--       types = { "directive", "problem", "suggestion", "layout" },
--     },
--     disable_rule_comment = {
--       enable = true,
--       location = "separate_line", -- or `same_line`
--     },
--   },
--   diagnostics = {
--     enable = true,
--     report_unused_disable_directives = false,
--     run_on = "type", -- or `save`
--   },
-- }
--
-- prettier.setup {
--   bin = "prettier",
--   filetypes = {
--     "css",
--     "graphql",
--     "html",
--     "javascript",
--     "javascriptreact",
--     "json",
--     "less",
--     "markdown",
--     "scss",
--     "typescript",
--     "typescriptreact",
--     "yaml",
--   },
--   ["null-ls"] = {
--     condition = function()
--       return prettier.config_exists {
--         -- if `false`, skips checking `package.json` for `"prettier"` key
--         check_package_json = true,
--       }
--     end,
--     runtime_condition = function(params)
--       -- return false to skip running prettier
--       return true
--     end,
--     timeout = 5000,
--   },
--   cli_options = {
--     arrow_parens = "always",
--     bracket_spacing = true,
--     bracket_same_line = false,
--     embedded_language_formatting = "auto",
--     end_of_line = "lf",
--     html_whitespace_sensitivity = "css",
--     -- jsx_bracket_same_line = false,
--     jsx_single_quote = false,
--     print_width = 110,
--     prose_wrap = "preserve",
--     quote_props = "as-needed",
--     semi = true,
--     single_attribute_per_line = false,
--     single_quote = true,
--     tab_width = 2,
--     trailing_comma = "es5",
--     use_tabs = false,
--     vue_indent_script_and_style = false,
--
--     config_precedence = "prefer-file", -- or "cli-override" or "file-override"
--   },
-- }

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

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
    },
  },
}

-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   init_options = {
--     preferences = {
--       disableSuggestions = true,
--       quotePreference = "single",
--     },
--   },
--   settings = {
--     typescript = {
--       inlayHints = {
--         includeInlayParameterNameHints = "all",
--         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayVariableTypeHints = true,
--         includeInlayVariableTypeHintsWhenTypeMatchesName = true,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayEnumMemberValueHints = true,
--       },
--       format = {
--         insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
--         insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = true,
--         insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = true,
--         semicolons = "insert",
--       },
--       implementationsCodeLens = {
--         enabled = true,
--       },
--       referencesCodeLens = {
--         enabled = true,
--         showOnAllFunctions = true,
--       },
--     },
--     javascript = {
--       inlayHints = {
--         includeInlayParameterNameHints = "all",
--         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayVariableTypeHints = true,
--         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayEnumMemberValueHints = true,
--       },
--     },
--   },
-- }

-- rustaceanvim
vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  default_settings = {
    ["rust-analyzer"] = {},
  },
}

--
-- lspconfig.pyright.setup { blabla}
