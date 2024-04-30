return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  { "slint-ui/vim-slint", lazy = false },
  {
    "phaazon/hop.nvim",
    lazy = false,
    config = function()
      vim.keymap.set({ "n", "v" }, "<A-e>", "<cmd>HopWord<CR>")
      require("hop").setup()
    end,
  },
  {
    "andymass/vim-matchup",
    lazy = false,
    init = function()
      vim.g.matchup_surround_enabled = 1
    end,
  },
  { "mfussenegger/nvim-jdtls" },
  {
    "wellle/visual-split.vim",
    lazy = false,
    init = function()
      vim.keymap.set("n", "vp", "<cmd>vsplit<CR>")
      vim.keymap.set("v", "sp", "<Plug>(Visual-Split-VSSplitAbove)", { noremap = true, silent = true })
      vim.keymap.set("n", "sp", "<cmd>split<CR>", { noremap = true, silent = true })
      vim.keymap.set("v", "sb", "<Plug>(Visual-Split-VSSplitBelow)", { noremap = true, silent = true })
    end,
  },
  {
    "jlanzarotta/bufexplorer",
    lazy = false,
    init = function()
      vim.keymap.set({ "n", "i" }, "<A-f>", "<cmd>ToggleBufExplorer<CR>")
      vim.g.bufExplorerDetailedHelp = 0
      vim.g.bufExplorerDefaultHelp = 0
    end,
  },
  {
    "liuchengxu/vista.vim",
    lazy = false,
    init = function()
      vim.g.vista_default_executive = "nvim_lsp"
      vim.g.vista_disable_statusline = 1
      vim.g.vista_echo_cursor = 0
      vim.keymap.set("n", "<A-H>", "<cmd>Vista!!<CR>", { noremap = true, silent = true })
    end,
  },

  {
    "mtth/locate.vim",
    lazy = false,
    init = function()
      vim.g.locate_focus = 1
    end,
  },
  {
    "Valloric/ListToggle",
    lazy = false,
    init = function()
      vim.g.lt_quickfix_list_toggle_map = "<Space>q"
    end,
  },
  {
    "terryma/vim-expand-region",
    lazy = false,
  },
  {
    "mbbill/undotree",
    lazy = false,
    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.keymap.set({ "n", "i", "v" }, "<A-u>", "<cmd>UndotreeToggle<CR>")
    end,
  },
  {
    "MattesGroeger/vim-bookmarks",
    lazy = false,
    init = function()
      vim.g.bookmark_show_toggle_warning = 0
      vim.g.bookmark_center = 1
      -- vim.g.bookmark_no_default_key_mappings = 1
      vim.g.bookmark_auto_close = 1
    end,
  },
  {
    "rhysd/clever-f.vim",
    lazy = false,
  },
  {
    "dyng/ctrlsf.vim",
    lazy = false,
    init = function()
      vim.g.ctrlsf_ackprg = "rg"
      vim.g.ctrlsf_auto_focus = { at = "start" }
      vim.g.ctrlsf_default_view_mode = "normal"
      vim.g.ctrlsf_mapping = { next = "<A-j>", prev = "<A-k>", nfile = "J", pfile = "K" }
      vim.g.ctrlsf_position = "bottom"
      vim.g.ctrlsf_highlight_mode = 1
      vim.keymap.set("v", "<Space>s", "<Plug>CtrlSFVwordExec", { desc = "Search current in all files" })
      vim.keymap.set("n", "<Space>s", "<Plug>CtrlSFPrompt", { desc = "Search in all files" })
      vim.keymap.set("n", "<Space>d", "<cmd>CtrlSFToggle<CR>", { desc = "Toggle search results" })
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_leader = ";"
      vim.g.VM_theme = "sand"
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        keymaps = {
          normal = "s",
          normal_cur = "ss",
          normal_line = "S",
          normal_cur_line = "SS",
          visual = "s",
          visual_line = "S",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      }
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
}
