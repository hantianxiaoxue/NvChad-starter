vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = ";"
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    dir = vim.fn.stdpath('config').."/NvChad",
    -- "https://github.com/hantianxiaoxue/NvChad.git",
    -- branch = "v2.5",
    lazy = false,
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

-- switch im
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = { "*" },
  callback = function()
    local input_status = tonumber(vim.fn.system "im-select.exe")
    if input_status == 2052 then
      vim.fn.system "im-select.exe 1033"
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = { "*" },
  callback = function()
    local input_status = tonumber(vim.fn.system "im-select.exe")
    if input_status == 1033 then
      vim.fn.system "im-select.exe 2052"
    end
  end,
})


vim.schedule(function()
  require "mappings"
end)
