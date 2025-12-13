return {
  --- maybe keep, not sure
  "folke/zen-mode.nvim",
  opts = {},
  config = function()
      vim.keymap.set("n", "<leader>zz", "<CMD>ZenMode<CR>", {})
  end
}
