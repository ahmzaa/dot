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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function() require 'ahmza.catppuccin' end
  },

  {
    'tpope/vim-fugitive',
    name = "vim-fugitive"
  },

  {
    'junegunn/goyo.vim',
    config = function() require 'ahmza.goyo' end
  },

  { 'junegunn/limelight.vim' },
    config = function() require 'ahmza.limelight' end,
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function() require 'ahmza.nvim-tree' end
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
      {
        'nvim-treesitter/nvim-treesitter',
        config = function() require 'ahmza.treesitter' end
      },
    },
    config = function() require 'ahmza.telescope' end
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function() require 'ahmza.gitsigns' end
  },

  {
    'voldikss/vim-floaterm'
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function() require 'ahmza.lualine' end
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function() require 'ahmza.dashboard' end,
    dependencies = {'nvim-tree/nvim-web-devicons'}
  }
}

local opts = {}

require("lazy").setup(plugins, opt)
