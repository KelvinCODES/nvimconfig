--highlight on yank
local augroup = vim.api.nvim_create_augroup
local format_group = augroup('RemoveWhitespace', {})
local yank_group = augroup('HighlightYank', {})
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

--remove trailing whitespace on save
autocmd({"BufWritePre"}, {
    group = format_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.diagnostic.config {
    severity_sort = true,
    float = { focusable = false, style = "minimal", border = 'rounded', source = 'always', header = "", prefix = "" },
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.ERROR
        },
        source = 'always',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    }
}
