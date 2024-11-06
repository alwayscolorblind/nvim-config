---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    -- gitsigns
    ["<leader>gh"] = { "<cmd> Gitsigns preview_hunk <CR>", "Preview hunk" }
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- more keybinds!

return M
