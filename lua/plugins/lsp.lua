return {
    {
        'saghen/blink.cmp',
        version = '*',
        event = 'InsertEnter', -- or a more specific event
        config = function()
            require('blink.cmp').setup()
        end,
    },
    {
        'j-hui/fidget.nvim',
        event = 'LspAttach', -- Only loads when an LSP starts up
        config = function()
            require('fidget').setup({
                -- Optional: configure fidget display options here if you like
            })
        end,
    },
    {"neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp",
    },
    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        vim.lsp.config('*', {
            capabilities = capabilities,
        })
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "ts_ls", "basedpyright" },
        })

        --lsp attach, some of these keymaps suck, I'll probably remove them later, theres default bindings already for alot of these
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('LspAttach', {}),
            callback = function(e)
                local opts = { buffer = e.buf }
                vim.keymap.set("n", "grd", function() vim.lsp.buf.definition() end,  { desc = "vim.lsp.buf.definition()"})
                vim.keymap.set("n", "grD", function() vim.lsp.buf.declaration() end, { desc = "vim.lsp.buf.declaration()"})
                vim.keymap.set("n", "grw", function() vim.lsp.buf.workspace_symbol() end, { desc = "vim.lsp.buf.workspace_symbol()"})

                -- show diagnostics for line
                vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, { desc = "show diagnostics for line"})
                --help on parameter signatures when calling a method
                vim.keymap.set("i", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
                --help on word hovered
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "vim.lsp.buf.hover()", nowait = true })

                --Unused configs, might delete later
                -- view smart suggestions on how to fix warnings/errors
                --vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                -- see all references
                --vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                --vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                --vim.keymap.set("n", "gri", function() vim.lsp.buf.implementation() end, opts)
            end
        })
    end,
}
}
