require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

-- dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
vim.opt.relativenumber = true
vim.g.neovide_bgblend = true
vim.g.neovide_transparency = 0.9
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 20
vim.g.neovide_floating_blur_amount_x = 10.0
vim.g.neovide_floating_blur_amount_y = 10.0
vim.opt.foldenable = true
vim.o.guifont = "SFMono Nerd Font:h13"
require "plugins"
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[colorscheme gruvbox]])

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'graphql',
  callback = function(ev)
    vim.lsp.start({
      name = 'apollo-language-server',

      -- If you're using a profile, you can append `'--profile', 'default'`
      -- to this list (substitute `default` for your profile name)
      cmd = { 'rover', 'lsp', '--supergraph-config', 'supergraph.yaml' },

      -- Set the "root directory" to the parent directory of the file in the
      -- current buffer (`ev.buf`) that contains a `supergraph.yaml` file.
      root_dir = vim.fs.root(ev.buf, { 'supergraph.yaml' }),
    })
  end,
})
