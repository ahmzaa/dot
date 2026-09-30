-- Install lazy.nvim. Check for its entrypoint rather than only the directory:
-- an interrupted clone can leave a directory that is not a usable checkout.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_entrypoint = lazypath .. "/lua/lazy/init.lua"
if vim.fn.filereadable(lazy_entrypoint) == 0 then
	vim.fn.delete(lazypath, "rf")

	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
	{ "lewis6991/gitsigns.nvim" }, -- Add git related signs to the gutter
	{ "folke/which-key.nvim", event = "VeryLazy" }, -- Shows pending keybinds
	{ "folke/zen-mode.nvim", dependencies = { "folke/twilight.nvim" } }, -- Focus mode for typing
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- fancy status line
	{ "folke/lazydev.nvim", ft = "lua" }, -- configures the LSP for neovim config
	{
		"nvim-telescope/telescope.nvim", -- fuzzy finder
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			{ "debugloop/telescope-undo.nvim" },
		},
	},
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by blink.cmp
			{
				"saghen/blink.cmp",
				build = "cargo build --release",
			},
		},
	},
	{
		"stevearc/conform.nvim", -- Autoformat
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
	},
	{
		"saghen/blink.cmp", -- Autocompletion
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				-- build step required to enable regex support in snippets
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"folke/lazydev.nvim",
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- Loaded before all other start plugins
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"echasnovski/mini.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
	},
}

local opt = {}

require("lazy").setup(plugins, opt)
