local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "


-- keymap(mode, keymap, command, options)

-- Move Highlighted Block
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv'", opts)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv'", opts)

-- Append Lower Line to Current Line, Keep Cursor in Place
vim.keymap.set('n', 'J', 'mzJ`z', opts)

-- Move Half Page, Keep Cursor in Place
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- When Searching, Keep Cursor in Place While Cycling
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Copy to System Clipboard
vim.keymap.set('n', '<leader>y', "\"+y", opts)
vim.keymap.set('v', '<leader>y', "\"+y", opts)
vim.keymap.set('n', '<leader>Y', "\"+Y", opts)

-- Launch tmux-sessionizer.
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', opts)

-- LSP Format
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format() end, opts)

-- Navigate Buffers
keymap('n', '<leader>h', ':bprevious<cr>', opts)
keymap('n', '<leader>l', ':bnext<cr>', opts)

-- Quick Find and Replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Make Current File Executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

-- Edit/Source init.lua
vim.keymap.set('n', '<leader>ve', ':e ~/.config/nvim/init.lua<cr>', opts)
vim.keymap.set('n', '<leader>vr', ':so ~/.config/nvim/init.lua<cr>', opts)
vim.keymap.set('n', '<leader><leader>', function() vim.cmd('so') end, opts)

-- Navigate Panes
--keymap('n','<C-j>','<C-W>j',opts)
--keymap('n','<C-k>','<C-W>k',opts)
--keymap('n','<C-h>','<C-W>h',opts)
--keymap('n','<C-l>','<C-W>l',opts)

-- Delete single/all buffers
keymap('n', '<leader>Q', '<nop>', opts)
keymap('n', '<leader>q', ':bd<cr>', opts)
