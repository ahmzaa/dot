-- Autocmd group
vim.api.nvim_create_augroup('custom_buffer', {clear=true})

-- start terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
    group = 'custom_buffer',
    pattern = '*',
    command = 'startinsert | set winfixheight'
})

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'custom_buffer',
    pattern = '*',
    callback = function() vim.highlight.on_yank {timeout = 200} end
})
