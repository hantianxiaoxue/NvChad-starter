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
    dir = vim.fn.stdpath "config" .. "/NvChad",
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

-- jdtls
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    require("configs.jdtls").setup()
  end,
})

-- switch im
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = { "*" },
  callback = function()
    if vim.fn.executable "AIMSwitcher.exe" == 1 then
     local ai vim.fn.system "switch.bat"
    elseif vim.fn.executable "fcitx5-remote" == 1 then
      vim.fn.system "fcitx5-remote -c"
    end
  end,
})

-- termimal start in insert mode
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd ":startinsert"
    end
  end,
})

require "mappings"
--[[ vim.schedule(function()
  require "mappings"
end) ]]
