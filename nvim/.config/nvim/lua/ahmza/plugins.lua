local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- LSP stuff
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'L3MON4D3/LuaSnip'}, -- snippet engine
  {'saadparwaiz1/cmp_luasnip'}, -- lua autocompletion
  {'rafamadriz/friendly-snippets'}, -- snippets library
  {'mfussenegger/nvim-lint'},
  {'stevearc/conform.nvim'},

  {'nvim-treesitter/nvim-treesitter'},
  {'lewis6991/gitsigns.nvim'},
  {'voldikss/vim-floaterm'},
  {'tpope/vim-fugitive'},
  {'ThePrimeagen/harpoon', branch = 'harpoon2'},
  {'stevearc/oil.nvim'},


--  {
--    'mfussenegger/nvim-lint',
--    event = {'BufReadPre','BufNewFile'}
--  },

--  {
--    'stevearc/conform.nvim',
--    event = {'BufReadPre','BufNewFile'}
--  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  {
    'folke/zen-mode.nvim',
    dependencies = {'folke/twilight.nvim'},
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {'nvim-tree/nvim-web-devicons'},
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
  },


  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {'nvim-tree/nvim-web-devicons'}
  }
}

local opts = {}

require("lazy").setup(plugins, opt)
