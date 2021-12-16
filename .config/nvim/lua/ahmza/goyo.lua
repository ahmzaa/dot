vim.g.goyo_width =  72
vim.g.goyo_height = 80
vim.g.goyo_linenr = 0

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap('n','<leader>gy',':Goyo<cr>',opts)
