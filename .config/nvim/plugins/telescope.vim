Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

"lua require("ahmza/_telescope")

nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for string > ")})<cr>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>ff :lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh :lua require('telescope.builtin').help_tags()<cr>
