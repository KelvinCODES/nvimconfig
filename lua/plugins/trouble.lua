return {
  -- I have no idea what this is, I might not even use it
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
        { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        { "<leader>tS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
        { "<leader>tL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
        { "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        {
          "[t",
          function()
            if require("trouble").is_open() then
              require("trouble").prev({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cprev)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end,
          desc = "Previous Trouble/Quickfix Item",
        },
        {
          "]t",
          function()
            if require("trouble").is_open() then
              require("trouble").next({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cnext)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end,
          desc = "Next Trouble/Quickfix Item",
        },
      },
}
