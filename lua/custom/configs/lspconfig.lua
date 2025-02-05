local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "clangd", "gopls", "eslint", "stylelint_lsp", "tailwindcss", "kotlin_language_server" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values', "*.docker-compose.yml" },
  settings = {
    yaml = {
      ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*.docker-compose.yml",
    }
  }
}

lspconfig.cssmodules_ls.setup {
  on_attach = function(client)
    client.server_capabilities.implementationProvider = false
    client.server_capabilities.definitionProvider = false
    on_attach(client)
  end,
  capabilities = capabilities
}

local ts_diagnostic_ignore_codes = { 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8012, 8013, 8014, 8015, 8016, 8017 }

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

-- works bad :(
lspconfig.flow.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "",  -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})

require("typescript-tools").setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = {
    ['textDocument/publishDiagnostics'] = function(_1, params, client_id, _2, config)
      if params.diagnostics ~= nil then
        local idx = 1
        while idx <= #params.diagnostics do
          if has_value(ts_diagnostic_ignore_codes, params.diagnostics[idx].code) then
            table.remove(params.diagnostics, idx)
          else
            idx = idx + 1
          end
        end
      end
      vim.lsp.diagnostic.on_publish_diagnostics(_1, params, client_id, _2, config)
    end
  },
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
    },
    tsserver_file_preferences = {
      quotePreference = "double",
      jsxAttributeCompletionStyle = "none",
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

local format_on_save = require "format-on-save"
local formatters = require "format-on-save.formatters"
local vim_notify = require("format-on-save.error-notifiers.vim-notify")

format_on_save.setup {
  exclude_path_patterns = {
    "/node_modules/",
    ".local/share/nvim/lazy",
  },
  formatter_by_ft = {
    -- css = formatters.lsp,
    html = formatters.lsp,
    java = formatters.lsp,
    json = formatters.lsp,
    lua = formatters.lsp,
    markdown = formatters.prettier,
    openscad = formatters.lsp,
    scad = formatters.lsp,
    scss = formatters.lsp,
    sh = formatters.shfmt,
    terraform = formatters.lsp,
    typescriptreact = {
      formatters.if_file_exists {
        pattern = { ".eslintrc", ".eslintrc.*", "eslint.config.*" },
        formatter = formatters.eslint_d_fix,
      },
      formatters.if_file_exists {
        pattern = { ".prettierrc", ".prettierrc.*", "prettier.config.*" },
        formatter = formatters.prettierd,
      },
    },
    yaml = formatters.lsp,
    -- Add conditional formatter that only runs if a certain file exists
    -- in one of the parent directories.
    javascript = {
      formatters.if_file_exists {
        pattern = { ".eslintrc", ".eslintrc.*", "eslint.config.*" },
        formatter = formatters.eslint_d_fix,
      },
      formatters.if_file_exists {
        pattern = { ".prettierrc", ".prettierrc.*", "prettier.config.*" },
        formatter = formatters.prettierd,
      },
    },
    typescript = {
      formatters.if_file_exists {
        pattern = { ".eslintrc", ".eslintrc.*", "eslint.config.*" },
        formatter = formatters.eslint_d_fix,
      },
      formatters.if_file_exists {
        pattern = { ".prettierrc", ".prettierrc.*", "prettier.config.*" },
        formatter = formatters.prettierd,
      },
    },
  },

  -- Optional: fallback formatter to use when no formatters match the current filetype
  -- fallback_formatter = {
  --   formatters.remove_trailing_whitespace,
  --   formatters.remove_trailing_newlines,
  --   formatters.prettierd,
  -- },

  -- By default, all shell commands are prefixed with "sh -c" (see PR #3)
  -- To prevent that set `run_with_sh` to `false`.
  run_with_sh = true,
}

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

-- default configuration
require('illuminate').configure({
  -- providers: provider used to get references in the buffer, ordered by priority
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  -- delay: delay in milliseconds
  delay = 100,
  -- filetype_overrides: filetype specific overrides.
  -- The keys are strings to represent the filetype while the values are tables that
  -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
  filetype_overrides = {},
  -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
  filetypes_denylist = {
    'dirbuf',
    'dirvish',
    'fugitive',
  },
  -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
  -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
  filetypes_allowlist = {},
  -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
  -- See `:help mode()` for possible values
  modes_denylist = {},
  -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
  -- See `:help mode()` for possible values
  modes_allowlist = {},
  -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
  -- Only applies to the 'regex' provider
  -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
  providers_regex_syntax_denylist = {},
  -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
  -- Only applies to the 'regex' provider
  -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
  providers_regex_syntax_allowlist = {},
  -- under_cursor: whether or not to illuminate under the cursor
  under_cursor = true,
  -- large_file_cutoff: number of lines at which to use large_file_config
  -- The `under_cursor` option is disabled when this cutoff is hit
  large_file_cutoff = nil,
  -- large_file_config: config to use for large files (based on large_file_cutoff).
  -- Supports the same keys passed to .configure
  -- If nil, vim-illuminate will be disabled for large files.
  large_file_overrides = nil,
  -- min_count_to_highlight: minimum number of matches required to perform highlighting
  min_count_to_highlight = 2,
  -- should_enable: a callback that overrides all other settings to
  -- enable/disable illumination. This will be called a lot so don't do
  -- anything expensive in it.
  should_enable = function(bufnr) return true end,
  -- case_insensitive_regex: sets regex case sensitivity
  case_insensitive_regex = false,
})

local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

-- Setup nvim-autopairs with default configuration
npairs.setup({
  check_ts = true, -- Enable treesitter support for more precision
})

npairs.add_rule(Rule('<', '>', {
  -- if you use nvim-ts-autotag, you may want to exclude these filetypes from this rule
  -- so that it doesn't conflict with nvim-ts-autotag
}):with_pair(
-- regex will make it so that it will auto-pair on
-- `a<` but not `a <`
-- The `:?:?` part makes it also
-- work on Rust generics like `some_func::<T>()`
  cond.before_regex('%a+:?:?$', 3)
):with_move(function(opts)
  return opts.char == '>'
end))

local spectre = require("spectre")

spectre.setup({ is_block_ui_break = true })
