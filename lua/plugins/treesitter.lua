return {
    "nvim-treesitter/nvim-treesitter",
    ensure_installed = {"lua", "python", "javascript"},
    auto_install = true,
    highlight = {enable = true},
    indent = {enable = true},
    branch = 'master',
    lazy = false,
    build = ":TSUpdate"
  }
