return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
      vim.keymap.set("n", "<A-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<A-l>", require("smart-splits").move_cursor_right)

      vim.keymap.set("n", "<A-->", require("smart-splits").resize_up)
      vim.keymap.set("n", "<A-=>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<A-_>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<A-+>", require("smart-splits").resize_right)
    end,
  },
  { "ojroques/vim-oscyank", lazy = false },
  {
    "stevearc/oil.nvim",
    opts = {},
    init = function()
      local oil = require "oil"
      oil.setup {
        use_default_keymaps = false,
        float = {
          padding = 2,
          max_width = 50,
          max_height = 40,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        view_options = {
          show_hidden = false,
        },
        --[[ win_options = {
          winbar = "%{v:lua.require('oil').get_current_dir()}",
        }, ]]
        keymaps = {
          ["g?"] = "actions.show_help",
          ["gh"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["vp"] = "actions.select_vsplit",
          ["sp"] = "actions.select_split",
          ["<C-p>"] = "actions.preview",
          ["q"] = "actions.close",
          ["R"] = "actions.refresh",
          ["<A-[>"] = "actions.parent",
          ["<A-]>"] = "actions.select",
          ["<Space>c"] = "actions.cd",
          ["gy"] = {
            callback = function()
              local entry = oil.get_cursor_entry()
              local dir = oil.get_current_dir()
              if not entry or not dir then
                return
              end
              local path = dir .. entry.name
              vim.fn.setreg("*", path)
              vim.notify(string.format("Copied: '%s'", path), vim.log.levels.INFO)
            end,
            desc = "Copy full path",
          },
          ["ge"] = {
            callback = function()
              local entry = oil.get_cursor_entry()
              if not entry then
                return
              end
              vim.fn.setreg("*", entry.name)
              vim.notify(string.format("Copied: '%s'", entry.name), vim.log.levels.INFO)
            end,
            desc = "Copy file name",
          },
          ["gs"] = {
            callback = function()
              local entry = oil.get_cursor_entry()
              local dir = oil.get_current_dir()
              if not entry or not dir then
                return
              end
              if entry.type == "file" then
                require("oil.actions").open_external.callback()
              elseif vim.fn.has "win32" == 1 then
                local opts = {
                  args = { dir .. entry.name },
                  stdio = { nil, nil, vim.loop.new_pipe(false) },
                  detached = true,
                }
                vim.loop.spawn("explorer.exe", opts)
              end
            end,
            desc = "Open external",
          },
        },
      }
      vim.keymap.set("n", "<A-N>", "<CMD>Oil --float<CR>", { desc = "Open oil directory" })
    end,
  },
  { "romainl/vim-cool", lazy = false },
  {
    "mateuszwieloch/automkdir.nvim",
    lazy = false,
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
    config = function()
      require("trouble").setup()
    end,
  },
  {
    -- TODO FIX HACK WARN PERF NOTE TEST
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      vim.keymap.set("n", "<A-T>", "<cmd>TodoQuickFix<CR>", { noremap = true, silent = true }),
    },
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    dependencies = { "michaeljsmith/vim-indent-object" },
    lazy = false,
    opts = { useDefaultKeymaps = false },
    init = function()
      vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
      vim.keymap.set({ "o", "x" }, "ae", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "ie", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
      vim.keymap.set({ "o", "x" }, "an", '<cmd>lua require("various-textobjs").number("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "in", '<cmd>lua require("various-textobjs").number("inner")<CR>')
      vim.keymap.set({ "o", "x" }, "am", '<cmd>lua require("various-textobjs").chainMember("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "im", '<cmd>lua require("various-textobjs").chainMember("inner")<CR>')
      vim.keymap.set({ "o", "x" }, "al", '<cmd>lua require("various-textobjs").url("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "il", '<cmd>lua require("various-textobjs").url("inner")<CR>')
      vim.keymap.set({ "o", "x" }, "aq", '<cmd>lua require("various-textobjs").anyQuote("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "iq", '<cmd>lua require("various-textobjs").anyQuote("inner")<CR>')
      vim.keymap.set({ "o", "x" }, "|", '<cmd>lua require("various-textobjs").column()<CR>')
      vim.keymap.set("n", "dsi", function()
        require("various-textobjs").indentation("outer", "outer")
        local indentationFound = vim.fn.mode():find "V"
        if not indentationFound then
          return
        end
        vim.cmd.normal { "<", bang = true }
        local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
        local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
        vim.cmd(tostring(endBorderLn) .. " delete")
        vim.cmd(tostring(startBorderLn) .. " delete")
      end, { desc = "Delete Surrounding Indentation" })
    end,
  },
  {
    "rhysd/clever-f.vim",
    lazy = false,
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
      vim.keymap.set({ "n", "v" }, "<Space>e", "<cmd>HopWordMW<CR>")
      vim.keymap.set({ "n", "v" }, "?", "<cmd>HopChar2MW<CR>")
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
      vim.keymap.set({ "n", "i" }, "<A-f>", function()
        if vim.fn.expand "%" == "NvimTree_1" then
          vim.api.nvim_feedkeys(vim.api.nvim_eval '"\\<C-w>w"', "x", true)
        end
        vim.cmd "ToggleBufExplorer"
      end)
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
      vim.g.vista_executive_for = {
        vimwiki = "markdown",
        pandoc = "markdown",
        markdown = "toc",
      }
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
      vim.g.lt_location_list_toggle_map = "<Space>ql"
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
      vim.g.ctrlsf_mapping = { next = "<A-J>", prev = "<A-K>", nfile = "J", pfile = "K" }
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
      vim.g.VM_set_statusline = 0
      vim.g.VM_silent_exit = 1
      vim.g.VM_show_warnings = 0
      vim.g.VM_case_setting = "sensitive"
      vim.g.VM_maps = {
        ["Reselect Last"] = ";gv",
      }
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
  {
    "s1n7ax/nvim-window-picker",
    lazy = true,
    event = { "WinNew" },
    config = function()
      local picker = require "window-picker"
      picker.setup {
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          bo = {
            filetype = { "neo-tree", "NvimTree", "neo-tree-popup", "notify", "quickfix" },
            buftype = { "terminal" },
          },
        },
        other_win_hl_color = "#e35e4f",
      }
      -- Swap two windows using the awesome window picker
      local function swap_windows()
        local window = picker.pick_window {
          include_current_win = false,
        }
        local target_buffer = vim.fn.winbufnr(window)
        -- Set the target window to contain current buffer
        if window then
          vim.api.nvim_win_set_buf(window, 0)
          -- Set current window to contain target buffer
          vim.api.nvim_win_set_buf(0, target_buffer)
        end
      end

      vim.keymap.set("n", "<A-\\>", swap_windows, { desc = "Swap windows" })
    end,
  },
  {
    "ethanholz/nvim-lastplace",
    lazy = false,
    event = { "User FileOpened" },
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      }
    end,
  },
}
