return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set('n', '<leader>u', ":UndotreeToggle<CR>:UndotreeFocus<CR>", {
            noremap = true,
            silent = true,
            desc = "Toggle Undo Tree and Focus"
        })
    end
}
