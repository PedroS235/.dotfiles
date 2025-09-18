-- LSP configuration
return {
	{
		"neovim/nvim-lspconfig",
		enabled = true,

		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},

		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", "<cmd>FzfLua lsp_definitions<cr>", "[G]oto [D]efinition")
					map("gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Line diagnostics")
					map("gr", "<cmd>FzfLua lsp_references<cr>", "[G]oto [R]eferences")
					map("gI", "<cmd>FzfLua lsp_implementations<cr>", "[G]oto [I]mplementation")
					map("<leader>D", "<cmd>FzfLua lsp_typedefs<cr>", "Type [D]efinition")
					map("<leader>ds", "<cmd>FzfLua lsp_document_symbols<cr>", "[D]ocument [S]ymbols")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", "[C]ode [A]ction", { "n", "x" })
					-- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", "<cmd>FzfLua lsp_declarations<cr>", "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and vim.lsp.client.supports_method(client, "textDocument/documentHighlight") then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Toggle of Inlay Hints keymap
					if client and vim.lsp.client.supports_method(client, "textDocument/inlayHint") then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end

					map("<leader>tv", function()
						vim.g.virtual_text = not vim.g.virtual_text
						vim.diagnostic.config({ virtual_text = vim.g.virtual_text })
					end, "[T]oggle [V]irtual Text")
				end,
			})

			if vim.g.have_nerd_font then
				local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
				local diagnostic_signs = {}
				for type, icon in pairs(signs) do
					diagnostic_signs[vim.diagnostic.severity[type]] = icon
				end
				vim.diagnostic.config({
					signs = { text = diagnostic_signs },
					virtual_text = vim.g.virtual_text or false,
					update_in_insert = false,
					underline = true,
					severity_sort = true,
					float = {
						focusable = true,
						style = "minimal",
						border = "rounded",
						header = "",
						prefix = "",
					},
				})
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
			capabilities.offsetEncoding = { "utf-16" }

			vim.lsp.buf.signature_help({ border = "rounded" })
			vim.lsp.buf.hover({ border = "rounded" })

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							format = {
								enable = false,
							},
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },

							hint = {
								enable = true,
							},
						},
					},
				},

				pyright = {
					settings = {
						autoImportCompletions = true,
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "OpenFilesOnly",
								typeCheckingMode = "standard",
							},
						},
					},
				},
				ruff = {},
				marksman = {},
				bashls = {},
				clangd = {},
				ts_ls = {},

				-- Spell
				harper_ls = {
					settings = {
						["harper-ls"] = {
							userDictPath = "~/.config/nvim/spell/harper-dict.txt",
							filetypes = { "markdown" },
						},
					},
				},
			}

			local formatters = {
				"stylua",
				"black",
				"prettier",
				"beautysh",
				"clang-format",
			}

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, formatters or {})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						vim.lsp.config(server_name, server)
						vim.lsp.enable(server_name)
						-- require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{
		"mason-org/mason.nvim",
		enabled = true,
		keys = {
			{ "<leader>cm", "<cmd>Mason<cr>", "Open Mason" },
		},
		opts = {},
	},

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		enabled = true,
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"mfussenegger/nvim-ansible",
		enabled = true,
		name = "ansible",
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = true,
		name = "render-markdown",
		opts = {},
	},
}
