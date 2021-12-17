local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
vim.g.mapleader = " "

-- keymap(mode, keymap, command, options)

keymap('c','w!!','%!sudo tee > /dev/null %', opts)

keymap('n','<leader>ve',':e ~/.config/nvim/init.lua<cr>',opts)
keymap('n','<leader>vr',':so ~/.config/nvim/init.lua<cr>',opts)

keymap('n','<leader>h',':bprevious<cr>',opts)
keymap('n','<leader>l',':bnext<cr>',opts)

keymap('n','<C-j>','<C-W>j',opts)
keymap('n','<C-k>','<C-W>k',opts)
keymap('n','<C-h>','<C-W>h',opts)
keymap('n','<C-l>','<C-W>l',opts)

keymap('n','<leader>Q',':bufdo bdelete<cr>',opts)
keymap('n','<leader>q',':bd<cr>',opts)

keymap('n','<leader>n',':NERDTreeToggle<cr>',opts)
keymap('n','<leader>N',':NERDTreeFind<cr>',opts)
