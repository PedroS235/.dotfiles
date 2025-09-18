return {
	-- INFO: Icons
	{
		"nvim-tree/nvim-web-devicons",
		enabled = vim.g.have_nerd_font,
	},

	{
		"folke/snacks.nvim",
		enabled = true,
		priority = 1000,
		lazy = false,
		keys = { { "<leader>lz", "<cmd>lua Snacks.lazygit.open()<CR>", desc = "LazyGit" } },
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			lazygit = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
		},
	},

	{
		-- Plugin which shows useful git info
		"lewis6991/gitsigns.nvim",
		enabled = true,
		opts = {
			signcolumn = true,
		},
	},

	{
		-- Shows current open buffers as tabs
		"akinsho/nvim-bufferline.lua",
		version = "4.9.1",
		enabled = true,
		opts = {},
	},
	{
		-- Breadcrumb top bar display
		"Bekaboo/dropbar.nvim",
		version = "v14.2.1",
		enabled = true,
		opts = {},
	},
	{
		-- Bottom bar customization
		"nvim-lualine/lualine.nvim",
		commit = "b8c2315",
		enabled = true,
		opts = function(_, opts)
			local ok, noice = pcall(require, "noice")
			local lualine_x = {}

			if ok then
				table.insert(lualine_x, {
					noice.api.status.mode.get,
					cond = noice.api.status.mode.has,
					color = { fg = "#ff9e64" },
				})
			end

			opts.sections = {
				lualine_x = lualine_x,
			}
		end,
	},
	{
		-- A replacement to cmd messages and notifications
		"folke/noice.nvim",
		version = "v4.10.0",
		enabled = true,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
	},
}
