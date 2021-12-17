vim.cmd([[
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

let g:NERDTreeDirArrowExpandable = '▹'
let g:NERDTreeDirArrowCollapsible = '▿'

let g:plug_window = 'noautocmd vertical topleft new'

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
]])

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap('n','<leader>fs',':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for string → ")})<cr>',opts)
keymap('n','<C-p>',':lua require("telescope.builtin").git_files()<cr>',opts)
keymap('n','<leader>ff',':lua require("telescope.builtin").find_files()<cr>',opts)
keymap('n','<leader>fb',':lua require("telescope.builtin").buffers()<cr>',opts)
keymap('n','<leader>fh',':lua require("telescope.builtin").help_tags()<cr>',opts)
