return {
  -- Main Copilot Plugin for inline suggestions
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth", -- Command to run after installation to authenticate
    event = "InsertEnter",   -- Lazy load the plugin when entering insert mode
    opts = {
      suggestion = {
        auto_trigger = true,
        debounce = 100,
        keymap = {
          -- Keymap to accept the suggestion. <C-l> is a common choice.
          accept = "<C-l>",
          -- You might need to disable the default TAB map if it conflicts with other plugins
          -- tab = false,
        },
      },
    },
  },

  -- Copilot Chat Plugin for full AI interaction
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" }, -- A common Neovim utility library
      { "folke/snacks.nvim", opts = { picker = { enabled = true, ui_select = true } } }, -- Enable the snacks picker UI
    },
    build = "make tiktoken", -- Compiles a token counter for better chat performance
    opts = {
      model = "claude-haiku-4.5", -- Specify your preferred model
      temperature = 0.1, -- Lower temperature for more focused responses
      window = {
        layout = 'float', -- Use a floating window for the chat UI
        width = 0.5,
      },
      auto_insert_mode = true, -- Automatically enter insert mode when chat window opens
    },
    keys = {
      -- Keymap to open the chat window
      { "<leader>cc", function() require("CopilotChat").toggle() end, desc = "Toggle Copilot Chat" },
      -- Quick chat command
      { "<leader>cq", function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat with buffer context"
      },
    },
  },
}

