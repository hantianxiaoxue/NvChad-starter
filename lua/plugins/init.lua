return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
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
      vim.g.lt_quickfix_list_toggle_map = "<A-q>"
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
    "easymotion/vim-easymotion",
    lazy = false,
    init = function()
      vim.g.EasyMotion_do_mapping = 0
      vim.keymap.set("n", "<Space>j", "<Plug>(easymotion-w)")
      vim.keymap.set("n", "<Space>k", "<Plug>(easymotion-b)")
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
      vim.keymap.set("v", "<A-s>", "<Plug>CtrlSFVwordExec", { desc = "Search current in all files" })
      vim.keymap.set("n", "<A-s>", "<Plug>CtrlSFPrompt", { desc = "Search in all files" })
      vim.keymap.set("n", "<A-d>", "<cmd>CtrlSFToggle<CR>", { desc = "Toggle search results" })
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_leader = ";"
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
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      local ots = require "nvchad.configs.nvimtree"
      return ots
    end,
    config = function(_, opts)
      local function my_on_attach(bufnr)
        local function ots(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local api = require "nvim-tree.api"
        -- api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "U", api.tree.change_root_to_parent, ots "Up")
        vim.keymap.set("n", "<A-[>", api.tree.change_root_to_parent, ots "Up")
        vim.keymap.set("n", "C", api.tree.change_root_to_node, ots "Close")
        vim.keymap.set("n", "<A-]>", api.tree.change_root_to_node, ots "Close")
        vim.keymap.set("n", "X", api.tree.collapse_all, ots "Collapse")
        vim.keymap.set("n", "?", api.tree.toggle_help, ots "Help")

        vim.keymap.set("n", "<C-k>", api.node.show_info_popup, ots "Info")
        vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, ots "Close Directory")
        vim.keymap.set("n", "<CR>", api.node.open.edit, ots "Open")
        vim.keymap.set("n", "o", api.node.open.preview, ots "Open Preview")
        vim.keymap.set("n", ".", api.node.run.cmd, ots "Run Command")
        vim.keymap.set("n", "a", api.fs.create, ots "Create File Or Directory")
        vim.keymap.set("n", "bd", api.marks.bulk.delete, ots "Delete Bookmarked")
        vim.keymap.set("n", "bm", api.marks.bulk.move, ots "Move Bookmarked")
        vim.keymap.set("n", "m", api.marks.toggle, ots "Toggle Bookmark")
        vim.keymap.set("n", "M", api.tree.toggle_no_bookmark_filter, ots "Toggle Filter: No Bookmark")
        vim.keymap.set("n", "c", api.fs.copy.node, ots "Copy")
        vim.keymap.set("n", "d", api.fs.remove, ots "Delete")
        vim.keymap.set("n", "e", api.fs.rename_basename, ots "Rename: Basename")
        vim.keymap.set("n", "gy", api.fs.copy.absolute_path, ots "Copy Absolute Path")
        vim.keymap.set("n", "ge", api.fs.copy.basename, ots "Copy Basename")
        vim.keymap.set("n", "J", api.node.navigate.sibling.last, ots "Last Sibling")
        vim.keymap.set("n", "K", api.node.navigate.sibling.first, ots "First Sibling")
        vim.keymap.set("n", "p", api.fs.paste, ots "Paste")
        vim.keymap.set("n", "P", api.node.navigate.parent, ots "Parent Directory")
        vim.keymap.set("n", "q", api.tree.close, ots "Close")
        vim.keymap.set("n", "r", api.fs.rename, ots "Rename")
        vim.keymap.set("n", "R", api.tree.reload, ots "Refresh")
        vim.keymap.set("n", "s", api.node.run.system, ots "Run System")
        vim.keymap.set("n", "u", api.fs.rename_full, ots "Rename: Full Path")
        vim.keymap.set("n", "x", api.fs.cut, ots "Cut")
        vim.keymap.set("n", "y", api.fs.copy.filename, ots "Copy Name")
        vim.keymap.set("n", "Y", api.fs.copy.relative_path, ots "Copy Relative Path")
        vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, ots "Open")
        vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, ots "CD")
      end
      opts.on_attach = my_on_attach

      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
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
