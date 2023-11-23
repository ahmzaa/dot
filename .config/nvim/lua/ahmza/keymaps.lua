local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
vim.g.mapleader = " "

-- keymap(mode, keymap, command, options)

-- Force save without opening file as sudo
keymap('c','w!!','%!sudo tee > /dev/null %', opts)

-- Edit/Source init.lua
keymap('n','<leader>ve',':e ~/.config/nvim/init.lua<cr>',opts)
keymap('n','<leader>vr',':so ~/.config/nvim/init.lua<cr>',opts)

-- Navigate Buffers
keymap('n','<leader>h',':bprevious<cr>',opts)
keymap('n','<leader>l',':bnext<cr>',opts)

-- Navigate Panes
keymap('n','<C-j>','<C-W>j',opts)
keymap('n','<C-k>','<C-W>k',opts)
keymap('n','<C-h>','<C-W>h',opts)
keymap('n','<C-l>','<C-W>l',opts)

-- Delete single/all buffers
keymap('n','<leader>Q',':bufdo bdelete<cr>',opts)
keymap('n','<leader>q',':bd<cr>',opts)

-- NvimTree Toggle
keymap('n','<leader>n',':NvimTreeToggle<cr>',opts)
keymap('n','<leader>N',':NvimTreeFind<cr>',opts)

keymap('n','<leader>b','require("nvterm.terminal").new "horizontal"',opts)
