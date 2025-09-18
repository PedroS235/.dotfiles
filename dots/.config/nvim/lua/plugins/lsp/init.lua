return {
	-- Mason package manager - loads early to install tools
	{
		"mason-org/mason.nvim",
		event = "VeryLazy", -- Load after UI, but before files
		cmd = "Mason",
		keys = {
			{ "<leader>cm", "<cmd>Mason<cr>", desc = "Open Mason" },
		},
		build = ":MasonUpdate",
		opts = {},
	},

	-- Mason LSP config - also loads early to install servers
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim", "b0o/schemastore.nvim" },
		config = function()
			require("plugins.lsp.servers")
		end,
	},

	-- Core LSP - loads when opening files, but servers already installed
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Load our modular configurations
			require("plugins.lsp.diagnostics")
			require("plugins.lsp.keymaps")
		end,
	},

	-- LazyDev - only for Lua files
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- Ansible plugin - only for YAML files
	{
		"mfussenegger/nvim-ansible",
		ft = { "yaml", "yml" },
		config = function()
			-- Auto-detect Ansible files and set filetype
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = {
					"*/playbooks/*.yml",
					"*/playbooks/*.yaml",
					"*/roles/*/tasks/*.yml",
					"*/roles/*/handlers/*.yml",
					"*/group_vars/*",
					"*/host_vars/*",
					"*/ansible/*.yml",
				},
				callback = function()
					vim.bo.filetype = "yaml.ansible"
				end,
			})
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		opts = {
			heading = {
				sign = false,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
			bullet = {
				icons = { "●", "○", "◆", "◇" },
			},
		},
	},
}
