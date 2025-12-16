return {
  ---uncomment the event = and format_on_save if you want to enable format-on-save
  "stevearc/conform.nvim",
  ---event = { "BufWritePre" }, -- Load before saving to enable format-on-save
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "Confrom Format buffer",
    },
       {
      "<leader>cx",
      function()
        require("conform").format({ formatters = { "ruff_fix" } })
      end,
      desc = "Conform Ruff Fix (Delete unused/lint errors)",
    },
  },
  opts = {
    formatters_by_ft = {
      python = { "ruff_organize_imports", "ruff_format" },
      lua = { "stylua" },
    },
    ---format_on_save = {
      ---timeout_ms = 500,
      ---lsp_format = "fallback", -- Use LSP if no dedicated formatter is found
    ---},
  },
}

