# neovim configuration
list of plugins and aliases for neovim

## Requirements
- ripgrep (For telescope find string)
- fd-find (For Telescope)

## Plugin Manager
- [lazy.nvim](https://github.com/folke/lazy.nvim)

## Plugins
- [Catppuccin](https://github.com/dracula/vim) - Theme
- [floaterm](https://github.com/voldikss/vim-floaterm) - maybe replace with [toggleterm](https://github.com/akinsho/toggleterm.nvim)
- [fugitive](https://github.com/tpope/vim-fugitive)
- [goyo](https://github.com/junegunn/goyo.vim)
  - [limelight](https://github.com/junegunn/limelight.vim)
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
  - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [telescope](https://github.com/nvim-telescope/telescope.nvim)
  - [plenary](https://github.com/nvim-lua/plenary.nvim)
  - [popup](https://github.com/nvim-lua/popup.nvim)
  - [telescope-fzy-native](https://github.com/nvim-telescope/telescope-fzy-native.nvim)
- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [gitsigns](lewis6991/gitsigns.nvim)
- [lualine](https://github.com/nvim-lualine/lualine.nvim)
- [dashboard](https://github.com/nvimdev/dashboard-nvim)

---

## Keymaps
leader = space

Capital letter = shift

### Floaterm
| Keymap | Function        |
|--------|-----------------|
| F1     | Toggle floaterm |
| F2     | Next floaterm   |
| F3     | Prev floaterm   |
| F4     | New floaterm    |

### Goyo
| Keymap      | Function    |
|-------------|-------------|
| leader + gy | Toggle goyo |

### Nvim-Tree
| Keymap     | Function        |
|------------|-----------------|
| leader + n | Toggle nerdtree |
| leader + N | Nerdtree find   |

### Telescope
| Keymap      | Function       |
|-------------|----------------|
| leader + fs | Find string    |
| leader + ff | Find file      |
| leader + fb | Find buffer    |
| leader + fh | Find help      |
| Ctrl + p    | Find Git Files |
