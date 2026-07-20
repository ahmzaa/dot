# neovim configuration

Personal Neovim config built on [lazy.nvim](https://github.com/folke/lazy.nvim).
Plugin specs live in `lua/ahmza/plugins.lua`; per-plugin setup is in
`after/plugin/`.

## Requirements

- [ripgrep](https://github.com/BurntSushi/ripgrep) (Telescope live grep)
- [fd](https://github.com/sharkdp/fd) (Telescope find files)
- a C compiler + `make` (telescope-fzf-native, treesitter)
- `cargo` (blink.cmp release build)

lazy.nvim bootstraps itself on first launch; Mason installs LSPs/formatters.

## Plugins

- [catppuccin](https://github.com/catppuccin/nvim) — theme
- [telescope](https://github.com/nvim-telescope/telescope.nvim) — fuzzy finder
  (fzf-native, ui-select, undo)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason](https://github.com/williamboman/mason.nvim) + mason-tool-installer + [fidget](https://github.com/j-hui/fidget.nvim)
- [blink.cmp](https://github.com/saghen/blink.cmp) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip) — completion
- [conform.nvim](https://github.com/stevearc/conform.nvim) — formatting on save
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) — file explorer
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim) + [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [lualine](https://github.com/nvim-lualine/lualine.nvim) — status line
- [which-key](https://github.com/folke/which-key.nvim)
- [zen-mode](https://github.com/folke/zen-mode.nvim) + [twilight](https://github.com/folke/twilight.nvim)
- [todo-comments](https://github.com/folke/todo-comments.nvim)
- [mini.nvim](https://github.com/echasnovski/mini.nvim), [lazydev](https://github.com/folke/lazydev.nvim), [vim-sleuth](https://github.com/tpope/vim-sleuth)

## Keymaps

`leader` = space. Capital = shift.

### Telescope
| Keymap | Function |
|--------|----------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fw` | Find current word |
| `<leader>fh` | Find help |
| `<leader>fk` | Find keymaps |
| `<leader>fj` | Find git files |
| `<leader>fn` | Find in nvim config |
| `<leader>u`  | Undo tree |
| `<leader><leader>` | Find buffers |
| `<leader>/`  | Fuzzy search in current buffer |

### Neo-tree
| Keymap | Function |
|--------|----------|
| `\`    | Reveal current file in tree |

### General
| Keymap | Function |
|--------|----------|
| `<leader>y` / `<leader>Y` | Yank to system clipboard |
| `<leader>ts` | Launch tmux-sessionizer in a new window |
| `<leader>x`  | Make current file executable |
| `<leader>ve` | Edit `init.lua` |
| `<leader>vr` | Reload `init.lua` |
| `<leader>q`  | Close buffer |
| `<Esc>`      | Clear search highlight |
