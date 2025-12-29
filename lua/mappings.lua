require "nvchad.mappings"

-- disable defaults
vim.keymap.del("n", "<leader>ff") -- default telescope finder
vim.keymap.del("n", "<leader>fa") -- default telescope finder

-- add yours here

local map = vim.keymap.set

map("n", "<leader>i", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 });
end)

local better_find_files = function(b_opts)
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local sorters = require "telescope.sorters"
  local make_entry = require "telescope.make_entry"
  local conf = require("telescope.config").values

  local colors = function()
    local opts = {}

    pickers.new(opts, {
      prompt_title = b_opts.title,
      finder = finders.new_job(function(prompt)
          if not prompt or prompt == "" then
            return nil
          end

          if b_opts.no_ignore == true then
            return { "fd", "-p", "-I", prompt }
          end

          return { "fd", "-p", prompt }
        end,
        make_entry.gen_from_file()
      ),
      sorter = sorters.highlighter_only(opts),
      previewer = conf.grep_previewer(opts),
    }):find()
  end

  -- to execute the function
  colors()
end

local create_better_find_files = function(opts)
  return function()
    better_find_files(opts)
  end
end

map("n", "<leader>ff", create_better_find_files({ title = "Find files" }))
map(
  "n",
  "<leader>fa",
  create_better_find_files({ title = "Funder", no_ignore = true })
)
map("n", "<leader>fq", "<cmd> Telescope resume <CR>")

-- gitsigns
map("n", "<leader>ph", function()
  require("gitsigns").preview_hunk()
end)
map("n", "<leader>rh", function()
  require("gitsigns").reset_hunk()
end)
map("n", "<leader>td", function()
  require("gitsigns").reset_hunk()
end)
map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { expr = true })
map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { expr = true })
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end)


--fuck betterescape
-- vim.keymap.del("v", "jk")
-- vim.keymap.del("v", "jj")
