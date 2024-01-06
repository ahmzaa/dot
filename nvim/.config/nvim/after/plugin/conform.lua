local conform = require('conform')

conform.setup({
    formatters_by_ft = {
        markdown = {'prettierd', 'prettier'},
        python = {'black'},
        go = {'gofumpt'},
    },
})

vim.keymap.set({'n','v'}, '<leader>f', function()
    conform.format({
        lsp_format = true,
        async = false,
        -- timeout_ms = 500,
    })
end, {desc = 'Format file or range (in visual mode)'})
