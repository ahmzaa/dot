local lint = require('lint')
local lint_augroup = vim.api.nvim_create_augroup('lint', {clear = true})

lint.linters_by_ft = {
    markdown = {'vale'},
    python = {'pylint'},
    go = {'golangcilint'},
}

vim.api.nvim_create_autocmd({'BufEnter', 'BufWritePost', 'InsertLeave'}, {
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})

vim.keymap.set('n', '<leader>tl', function()
    lint.try_lint()
end, {desc = 'Trigger linting in current file'})
