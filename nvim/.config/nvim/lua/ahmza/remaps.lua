local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- keymap(mode, keymap, command, options)

-- Copy to System Clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "[Y]ank to Sys Clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[Y]ank to Sys Clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "[Y]ank to Sys Clipboard" })

-- fugitive (git)
vim.keymap.set("n", "<leader>gp", function()
	vim.cmd("Git pull")
	vim.cmd("Git push")
end, opts)

-- Launch tmux-sessionizer.
vim.keymap.set("n", "<leader>ts", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "[T]mux Sessionizer" })

-- LSP Format
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end, opts)

-- Navigate Buffers
--keymap("n", "<leader>h", ":bprevious<cr>", opts)
--keymap("n", "<leader>l", ":bnext<cr>", opts)

-- Make Current File Executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

-- Edit/Source init.lua
vim.keymap.set("n", "<leader>ve", ":e ~/.config/nvim/init.lua<cr>", opts)
vim.keymap.set("n", "<leader>vr", ":so ~/.config/nvim/init.lua<cr>", opts)
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end, opts)

-- Navigate Panes
--keymap('n','<C-j>','<C-W>j',opts)
--keymap('n','<C-k>','<C-W>k',opts)
--keymap('n','<C-h>','<C-W>h',opts)
--keymap('n','<C-l>','<C-W>l',opts)

-- Delete single/all buffers
keymap("n", "<leader>Q", "<nop>", opts)
keymap("n", "<leader>q", ":bd<cr>", opts)

-- from kickstart

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
