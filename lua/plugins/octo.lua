return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		use_local_fs = true, -- Use local files on the right side of reviews
		picker = "snacks", -- Explicitly set snacks as the picker
		-- default_merge_method = "squash", -- options: "merge", "rebase", "squash"
		-- default_delete_branch = true, -- automatically deletes the branch after merge
	},
	keys = {
		{ "<leader>op", "<cmd>Octo pr list<cr>", desc = "Octo PR List" },
		{ "<leader>oP", "<cmd>Octo pr create<cr>", desc = "Create Pull Request" }, -- Added this

		--- remove later if still unused
		---{ "<leader>oi", "<cmd>Octo issue list<cr>", desc = "Octo Issue List" },
		---{ "<leader>os", "<cmd>Octo search<cr>", desc = "Octo Search" },
		-- Buffer-local maps for PRs (only active in octo filetypes)
		{ "<localleader>oc", "<cmd>Octo comment add<cr>", desc = "Add Comment", ft = "octo" },
		{ "<localleader>or", "<cmd>Octo review start<cr>", desc = "Start Review", ft = "octo" },
		{ "<localleader>os", "<cmd>Octo review submit<cr>", desc = "Submit Review", ft = "octo" },
	},
}
