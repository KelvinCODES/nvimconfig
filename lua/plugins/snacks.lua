-- lazy.nvim
return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			enabled = true,
			ui_select = true,
			formatters = {
				file = {
					filename_first = true,
				},
			},
		},
		-- maybe delete gh later and the key map below to open PRs
		-- decide between gh and octo
		gh = { enabled = true },
		gitbrowse = { enabled = true },
		-- status column disabled, not sure if I like how this looks
		-- statuscolumn = {
		-- 	enabled = true,
		-- 	left = { "mark", "git" },
		-- 	right = { "sign", "fold" },
		-- },
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
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
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
				Snacks.picker.gh_pr()
			end,
			desc = "GH Pull Requests",
		},
		{
			"<leader>oy",
			function()
				Snacks.gitbrowse({
					open = function(url)
						vim.fn.setreg("+", url) -- Copy to system clipboard
						vim.defer_fn(function()
							vim.notify("Copied Git link to clipboard")
						end, 0)
					end,
					notify = false,
				})
			end,
			desc = "Git Browse (copy link)",
			mode = { "n", "v" },
			silent = true,
		},
		{
			"<leader>oo",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Open in Browser",
		},
	},
}
