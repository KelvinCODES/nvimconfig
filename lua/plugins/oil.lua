return	{
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = { keymaps = {
        ['<C-h>'] = false, -- Disables horizontal split
        ['<C-t>'] = false, -- Disables opening in a new tab
        ['<C-s>'] = false, -- Disables vertical split
    }},
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    --dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer
    lazy = false,
}
