vim.opt.guicursor=""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')

vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

--replaced with lsp spell check
-- vim.opt.spell = true
-- vim.opt.spelllang = "en_gb"


vim.opt.list = true
vim.opt.listchars = "trail:-"
--vim.opt.clipboard = "unnamedplus"

-- Goyo
vim.g.goyo_width = 120

-- nvim-tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- floaterm settings
vim.g.floaterm_keymap_toggle = '<F1>'
vim.g.floaterm_keymap_next   = '<F2>'
vim.g.floaterm_keymap_prev   = '<F3>'
vim.g.floaterm_keymap_new    = '<F4>'

vim.g.floaterm_gitcommit='floaterm'
vim.g.floaterm_autoinsert=1
vim.g.floaterm_width=0.6
vim.g.floaterm_height=0.5
vim.g.floaterm_wintitle=1
vim.g.floaterm_titleposition='center'
vim.g.floaterm_autoclose=1
