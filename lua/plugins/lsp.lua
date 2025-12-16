return {
	{
		"saghen/blink.cmp",
		version = "*",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("blink.cmp").setup({
				snippets = { preset = "luasnip" },
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				cmdline = {
					keymap = {
						preset = "cmdline",
						["<CR>"] = { "fallback" },
						["<C-y>"] = { "select_and_accept" },

						["<Tab>"] = { "show", "select_next", "fallback" },
						["<S-Tab>"] = { "select_prev", "fallback" },

						["<C-e>"] = { "hide", "fallback" },
					},
					sources = function()
						local type = vim.fn.getcmdtype()
						if type == "/" or type == "?" then
							return { "buffer" }
						end
						if type == ":" then
							return { "cmdline" }
						end
						return {}
					end,
					completion = { menu = { auto_show = true } },
				},
				completion = {
					menu = {
						draw = {
							columns = {
								{ "kind_icon", "label", "label_description", "source_name", gap = 1 },
							},
							components = {
								source_name = {
									text = function(ctx)
										return "[" .. ctx.source_name .. "]"
									end,
								},
							},
						},
					},
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets", -- Now correctly listed as a dependency
		},
		config = function()
			-- Load the snippets first
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Setup LuaSnip configuration
			require("luasnip").setup({
				enable_autosnippets = true,
			})

			local ls = require("luasnip")

			vim.keymap.set({ "i" }, "<C-l>", function()
				ls.expand()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-;>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-,>", function()
				ls.jump(-1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach", -- Only loads when an LSP starts up
		config = function()
			require("fidget").setup({
				-- Optional: configure fidget display options here if you like
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "basedpyright", "ruff" },
			})

			vim.lsp.config("*", { capabilities = capabilities })

			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							diagnosticSeverityOverrides = {
								reportUnusedImport = "none",
								reportUnusedVariable = "none",
							},
						},
					},
				},
			})

			vim.lsp.enable({ "lua_ls", "ts_ls", "basedpyright", "ruff" })

			--lsp attach, some of these keymaps suck, I'll probably remove them later, theres default bindings already for alot of these
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspAttach", {}),
				callback = function(e)
					local opts = { buffer = e.buf }
					local client = vim.lsp.get_client_by_id(e.data.client_id)

					if client and client.name == "ruff" then
						client.server_capabilities.hoverProvider = false
					end

					--ruff organize imports
					vim.keymap.set("n", "<leader>ri", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { "source.organizeImports" },
								diagnostics = {},
							},
						})
					end, { buffer = e.buf, desc = "Organize Imports" })

					vim.keymap.set("n", "grd", function()
						vim.lsp.buf.definition()
					end, { desc = "vim.lsp.buf.definition()" })
					vim.keymap.set("n", "grD", function()
						vim.lsp.buf.declaration()
					end, { desc = "vim.lsp.buf.declaration()" })
					vim.keymap.set("n", "grw", function()
						vim.lsp.buf.workspace_symbol()
					end, { desc = "vim.lsp.buf.workspace_symbol()" })

					-- show diagnostics for line
					vim.keymap.set("n", "<leader>d", function()
						vim.diagnostic.open_float()
					end, { desc = "show diagnostics for line" })
					--help on parameter signatures when calling a method
					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, opts)
					--help on word hovered
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, { desc = "vim.lsp.buf.hover()", nowait = true })
					--code actions
					vim.keymap.set("n", "grc", vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = e.buf, desc = "Code Action" })

					--Unused configs, might delete later
					-- view smart suggestions on how to fix warnings/errors
					--vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
					-- see all references
					--vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
					--vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
					--vim.keymap.set("n", "gri", function() vim.lsp.buf.implementation() end, opts)
				end,
			})
		end,
	},
}
