vim.g.mapleader = ";"
local map = vim.keymap.set
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({

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
				local indentationFound = vim.fn.mode():find("V")
				if not indentationFound then
					return
				end
				vim.cmd.normal({ "<", bang = true })
				local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
				local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
				vim.cmd(tostring(endBorderLn) .. " delete")
				vim.cmd(tostring(startBorderLn) .. " delete")
			end, { desc = "Delete Surrounding Indentation" })
		end,
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
	{
		"phaazon/hop.nvim",
		lazy = false,
		config = function()
			vim.keymap.set({ "n", "v" }, "<Space>e", "<cmd>HopWordMW<CR>")
			vim.keymap.set({ "n", "v" }, "?", "<cmd>HopChar2<CR>")
			require("hop").setup()
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
			require("nvim-surround").setup({
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
			})
		end,
	},
	{
		"rhysd/clever-f.vim",
		lazy = false,
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
		},
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},
	{ "romainl/vim-cool", lazy = false },
}, lazy_config)
-- keymap

map("n", "vv", "^v$h", { desc = "Select current line" })
map("n", "<leader>y", '"ayiw', { desc = "Copy current word" })
map("n", "<leader>p", 'viw"ap', { desc = "Paste current word" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("v", "H", "<Home>", { desc = "Move Left" })
map("v", "L", "<End>", { desc = "Move Right" })
map("n", "H", "<Home>", { desc = "Move Down" })
map("n", "L", "<End>", { desc = "Move Up" })

map("n", "<Space>w", "<cmd>noh<CR>", { desc = "General Clear highlights" })

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "File Save" })
map("v", "<C-c>", '"+y<Esc>', { desc = "Copy" })
map("i", "<C-c>", '<Esc>"+y', { desc = "Copy" })
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste" })
map("i", "<C-v>", '<Esc>"+p', { desc = "Paste" })
map("v", "<C-x>", '"+d', { desc = "Cute" })
map("i", "<C-x>", '<Esc>"+d', { desc = "Cute" })
map({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", { desc = "Select all" })
map({ "n", "i", "v" }, "<C-z>", "<Esc>u", { desc = "Undo" })

--------------
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle Line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle Relative number" })

map("n", "<Space>", "")
map("n", "q", "")
map({ "v", "i" }, "<A-c>", '"+y<Esc>')
map({ "n", "i" }, "<A-v>", '"+p')

map("n", "<A-o>", "<Cmd>lua require('vscode-neovim').call('workbench.action.navigateBack')<CR><Esc>")
map("n", "<A-i>", "<Cmd>lua require('vscode-neovim').call('workbench.action.navigateForward')<CR><Esc>")
map({ "n", "i", "v" }, "<A-s>", "<Cmd>lua require('vscode-neovim').call('workbench.action.files.save')<CR><Esc>")
map({ "n", "i", "v" }, "<A-q>", "<Cmd>lua require('vscode-neovim').call('workbench.action.closeActiveEditor')<CR>")
map({ "n" }, "<leader>w", "<Cmd>lua require('vscode-neovim').call('workbench.action.closeActiveEditor')<CR>")
map({ "n" }, "<A-e>", "<Cmd>lua require('vscode-neovim').call('workbench.view.explorer')<CR>")
-- map({ "n" }, "<tab>", "<Cmd>lua require('vscode-neovim').call('workbench.action.nextEditorInGroup')<CR>")
map({ "n", "i" }, "<A-Enter>", "<Cmd>lua require('vscode-neovim').call('workbench.action.previousEditorInGroup')<CR>")
map({ "n", "i" }, "<A-F>", "<Cmd>lua require('vscode-neovim').call('editor.action.formatDocument')<CR>")
map({ "n", "i" }, "<A-r>", "<Cmd>lua require('vscode-neovim').call('editor.action.rename')<CR>")
map("n", "gi", "<Cmd>lua require('vscode-neovim').call('editor.action.goToImplementation')<CR>")
map("n", "gd", "<Cmd>lua require('vscode-neovim').call('editor.action.revealDefinition')<CR>")
map("n", "gt", "<Cmd>lua require('vscode-neovim').call('editor.action.goToTypeDefinition')<CR>")
map("n", "gr", "<Cmd>lua require('vscode-neovim').call('editor.action.goToReferences')<CR>")
map("n", "gh", "<Cmd>lua require('vscode-neovim').call('editor.action.showHover')<CR>")

map("n", "sp", "<Cmd>lua require('vscode-neovim').call('workbench.action.splitEditorDown')<CR>")
map("n", "vp", "<Cmd>lua require('vscode-neovim').call('workbench.action.splitEditorRight')<CR>")
map("n", "<A-=>", "<Cmd>lua require('vscode-neovim').call('workbench.action.increaseViewHeight')<CR>")
map("n", "<A-->", "<Cmd>lua require('vscode-neovim').call('workbench.action.decreaseViewHeight')<CR>")
map("n", "<A-+>", "<Cmd>lua require('vscode-neovim').call('workbench.action.increaseViewWidth')<CR>")
map("n", "<A-_>", "<Cmd>lua require('vscode-neovim').call('workbench.action.decreaseViewWidth')<CR>")

map("n", "<A-w>", "<Cmd>lua require('vscode-neovim').call('workbench.action.focusNextPart')<CR>")
map("n", "<A-h>", "<Cmd>lua require('vscode-neovim').call('workbench.action.navigateLeft')<CR>")
map("n", "<A-l>", "<Cmd>lua require('vscode-neovim').call('workbench.action.navigateRight')<CR>")
map("n", "<A-k>", "<Cmd>lua require('vscode-neovim').call('workbench.action.navigateUp')<CR>")
map("n", "<A-j>", "<Cmd>lua require('vscode-neovim').call('workbench.action.navigateDown')<CR>")

-- switch im
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	pattern = { "*" },
	callback = function()
		if vim.fn.executable("AIMSwitcher.exe") == 1 then
			vim.fn.system("AIMSwitcher.exe --imm 0")
		elseif vim.fn.executable("fcitx5-remote") == 1 then
			vim.fn.system("fcitx5-remote -c")
		end
	end,
})
