-- lazy.nvim
return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			enabled = true,
			ui_select = true,
		},
		gh = { enabled = true },
		gitbrowse = { enabled = true },
        --- status column disabled, not sure if I like how this looks
		---statuscolumn = {
		---	enabled = true,
		---	left = { "mark", "sign" },
		---	right = { "git", "fold", "lnum" },
		---},
	},
	---@type snacks.Config
	keys = {
		{
			"<leader>ff",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		--{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				local word = vim.fn.expand("<cword>")
				Snacks.picker.grep_word({ search = word })
			end,
			desc = "Seach for word under cursor",
			mode = { "n", "x" },
		},
		{
			"<leader>sW",
			function()
				local word = vim.fn.expand("<cWORD>")
				Snacks.picker.grep_word({ search = word })
			end,
			desc = "Search for word under cursor until spaces",
			mode = { "n", "x" },
		},
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},

		---git commands
		{
			"<leader>gp",
			function()
				Snacks.gh.prs()
			end,
			desc = "GH Pull Requests",
		},
		{
			"<leader>gy",
			function()
				Snacks.gitbrowse({
					open = function(url)
						vim.fn.setreg("+", url) -- Copy to system clipboard
						vim.notify("Copied Git link to clipboard")
					end,
				})
			end,
			desc = "Git Browse (copy link)",
			mode = { "n", "v" }, -- Works for single lines or visual selections
		},
		{
			"<leader>gb",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Open in Browser",
		},
	},
}
