local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap('n','<leader>gl',':Limelight!!<cr>',opts)
keymap('n','<leader>q',':bd<cr>',opts)

vim.cmd([[
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
]])

