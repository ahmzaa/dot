# neovim configuration

This will go over all the config options that I have decided on.

## Plugin Manager

- [Packer](https://github.com/wbthomason/packer.nvim)
- [Vim-Plug](https://github.com/junegunn/vim-plug) (For old plugins not yet migrated to Packer)

## Plugins

- [airline](https://github.com/vim-airline/vim-airline)
- [dracula](https://github.com/dracula/vim)
- [floaterm](https://github.com/voldikss/vim-floaterm)
- [fugitive](https://github.com/tpope/vim-fugitive)
- [goyo](https://github.com/junegunn/goyo.vim)
  - [limelight](https://github.com/junegunn/limelight.vim)
- [NERDTree](https://github.com/preservim/nerdtree) replace with [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
  - [devicons](https://github.com/ryanoasis/vim-devicons)
  - [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin)
- [telescope](https://github.com/nvim-telescope/telescope.nvim)
  - [plenary](https://github.com/nvim-lua/plenary.nvim)
  - [popup](https://github.com/nvim-lua/popup.nvim)
  - [telescope-fzy-native](https://github.com/nvim-telescope/telescope-fzy-native.nvim)
- [undotree](https://github.com/mbbill/undotree)

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

### NERDTree

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

### UndoTree

| Keymap      | Function        |
|-------------|-----------------|
| leader + ut | Toggle undotree |
