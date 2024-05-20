require "nvchad.mappings"
local runners = require "configs.runner"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

map(
  { "n", "v", "i" },
  "<leader>a",
  '<cmd>lua require("nvchad.tabufline").closeAllBufs()<CR>',
  { desc = "Close all buffers" }
)
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
if not vim.g.neovide then
  vim.keymap.set({ "v", "i" }, "<C-c>", "<Plug>OSCYankVisual<CR>", { desc = "Copy" })
end
map("n", "<F5>", function()
  local filename = vim.fn.expand "%:t"
  local cword = vim.fn.expand "<cword>"
  local filetype = vim.filetype.match { filename = filename }
  if filetype == nil then
    return
  end
  local runner = runners[filetype]
  if runner == nil then
    return
  end

  local opts = runner_exists()
  if opts and opts.buf and vim.api.nvim_buf_is_valid(opts.buf) and vim.fn.bufwinid(opts.buf) ~= -1 then
    vim.api.nvim_win_close(opts.win, true)
  end
  local cmd = runner(vim.fn.expand "%:p", cword)
  require("nvchad.term").toggle { pos = "sp", id = "runner" }
  vim.api.nvim_chan_send(vim.bo.channel, cmd .. "\r")
end)

function runner_exists()
  if vim.g.nvchad_terms then
    for _, opts in pairs(vim.g.nvchad_terms) do
      if opts.id == "runner" then
        return opts
      end
    end
  end
end
