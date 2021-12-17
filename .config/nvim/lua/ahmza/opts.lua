vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "/home/ahmza/.vim/undodir"
vim.opt.undofile = true

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.spell = true
vim.opt.spelllang = "en_gb"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.colorcolumn = "72"
vim.opt.signcolumn = "yes"

vim.opt.exrc = true
vim.opt.guicursor=""
vim.opt.hlsearch = false
vim.opt.errorbells = false
vim.opt.hidden = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = { space = '•', tab = '>~' }
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.clipboard = "unnamedplus"

vim.cmd([[hi DraculaBoundry NONE]])
vim.cmd([[hi DraculaDiffDelete NONE]])
vim.cmd([[hi DraculaComment cterm=italic gui=italic]])

vim.g.goyo_width = 120
