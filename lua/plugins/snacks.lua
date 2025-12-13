-- lazy.nvim
return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    keys = {
        { "<leader>ff", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        --{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sw", function()
            local word = vim.fn.expand("<cword>")
            Snacks.picker.grep_word({search = word})
        end,
        desc = "Seach for word under cursor", mode = { "n", "x" } },
        { "<leader>sW", function()
            local word = vim.fn.expand("<cWORD>")
            Snacks.picker.grep_word({search = word})
        end,
        desc = "Search for word under cursor until spaces", mode = { "n", "x" } },
        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    }
}
