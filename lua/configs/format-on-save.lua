local format_on_save = require "format-on-save"
local formatters = require "format-on-save.formatters"

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
