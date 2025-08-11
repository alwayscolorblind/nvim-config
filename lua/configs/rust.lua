local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  default_settings = {
    ["rust-analyzer"] = {},
  },
}

local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

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
