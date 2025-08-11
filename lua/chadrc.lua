-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

-- local grub = require "lua.gruvbox"

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvbox",
  -- hl_override = grub.get_groups()
  hl_override = {
    -- TODO: rewrite from grubox
  }
}

M.colorify = {
  mode = "virtual",
}

M.ui = {
  statusline = {
    theme = "vscode",
    separator_style = "default",
  },
  telescope = {
    style = "borderless"
  },
}

return M
