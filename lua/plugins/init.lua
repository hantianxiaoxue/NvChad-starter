return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = { useDefaultKeymaps = false },
    init = function()
      vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
      vim.keymap.set({ "o", "x" }, "an", '<cmd>lua require("various-textobjs").number("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "in", '<cmd>lua require("various-textobjs").number("inner")<CR>')
      vim.keymap.set({ "o", "x" }, "|", '<cmd>lua require("various-textobjs").column()<CR>')
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    init = function()
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
    end,
  },
  { "slint-ui/vim-slint", lazy = false },
  {
    "phaazon/hop.nvim",
    lazy = false,
    config = function()
      vim.keymap.set({ "n", "v" }, "<A-e>", "<cmd>HopWordMW<CR>")
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
    init = function()
      vim.keymap.set("v", "<Space>", "<Plug>(expand_region_expand)", { desc = "Expand region" })
    end,
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
      vim.diagnostic.config {
        virtual_text = false,
      }
    end,
  },
  {
    "luckasRanarison/clear-action.nvim",
    lazy = false,
    opts = {
      signs = {
        show_count = false,
        show_label = true,
        combine = true,
      },
      popup = {
        hide_cursor = true,
      },
      mappings = {
        code_action = { "<A-.>", "Code action" },
        apply_first = { "<A-L>", "Apply" },
        quickfix = { "<Space>r", "Quickfix" },
        actions = {
          ["rust_analyzer"] = {
            ["Import"] = { "<A-I>", "Import" },
          },
        },
      },
      quickfix_filters = {
        ["rust_analyzer"] = {
          ["E0412"] = "Import",
          ["E0425"] = "Import",
          ["E0433"] = "Import",
          ["unused_imports"] = "remove",
        },
      },
    },
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
