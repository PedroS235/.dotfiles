return {

	-- NOTE: File Tree Navigator
	{
		"stevearc/oil.nvim",
		enabled = false,
		-- Lazy loading not recommended
		lazy = false,

		keys = {
			{ "<leader>e", "<cmd>Oil<cr>", desc = "File Tree" },
		},

		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
	},
	{
		"A7Lavinraj/fyler.nvim",
		enabled = false,
		keys = {
			{
				"<leader>e",
				function()
					require("fyler").toggle({
						kind = "split_left_most", -- (Optional) Use custom window layout
					})
				end,
				desc = "File Tree",
			},
		},
		dependencies = { "nvim-mini/mini.icons" },
		branch = "stable",
		opts = {},
	},

	-- NOTE: Fuzzy Finder (Replaced Telescope)
	{
		"ibhagwan/fzf-lua",
		enabled = true,
		lazy = false,

		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Git Files" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Search All Files" },
			{ "<leader>fs", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search Current Buffer" },
			{ "<leader>fdb", "<cmd>FzfLua diagnostics_document<cr>", desc = "Find Diagnostics in Buffer" },
			{ "<leader>fda", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Find Diagnostics in Workspace" },
			{ "<leader><leader>", "<cmd>FzfLua buffers<cr>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>FzfLua history<cr>", desc = "Find Command History" },
			{ "<leader>f.", "<cmd>FzfLua oldfiles<cr>", desc = "Find Recent Files" },
		},

		opts = {},
	},

	{
		-- NOTE: Keymap helper
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "Rename" },
				{ "<leader>s", group = "Find" },
				{ "<leader>t", group = "Toggle" },
			},
		},
	},

	-- NOTE: Treesitter is a language parser for providing syntax, better highlight and more
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = true,
		event = { "VeryLazy", "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",

		opts = {
			ensure_installed = {
				"vim",
				"vimdoc",
				"markdown",
				"lua",
				"python",
				"c",
				"cpp",
			},
			sync_install = false,
			auto_install = true,

			highlight = { enable = true },
			indent = { enable = true },
			-- autotag = { enable = true },
			autopairs = { enable = true },
		},

		dependencies = {
			-- NOTE: Auto closes xml/html like tags
			{
				"windwp/nvim-ts-autotag",
				enabled = true,
				event = "InsertEnter",
				opts = {},
			},

			-- NOTE: Auto closes pairs
			{
				"windwp/nvim-autopairs",
				enabled = true,
				event = "InsertEnter",
				opts = {},
			},

			-- NOTE: Better commentstring using treesitter
			{
				"folke/ts-comments.nvim",
				event = "VeryLazy",
				enabled = true,
				opts = {},
			},
		},
	},

	{

		-- NOTE: Sets current tab-width according to current file tab-width
		-- and/or other files in the workspace
		-- Not in use for now.
		"tpope/vim-sleuth",
		enabled = false,
	},
}
