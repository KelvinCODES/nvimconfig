return {
    "lewis6991/gitsigns.nvim",
    opts = {},
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        })
        vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview Git Hunk" })

         -- Navigation Keymaps
        vim.keymap.set("n", "]c", "<cmd>Gitsigns nav_hunk next<CR>", { desc = "Next Git Hunk" })
        vim.keymap.set("n", "[c", "<cmd>Gitsigns nav_hunk prev<CR>", { desc = "Previous Git Hunk" })
    end
}
