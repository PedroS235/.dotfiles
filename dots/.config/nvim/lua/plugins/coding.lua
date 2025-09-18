return {
	{
		"saghen/blink.cmp",
		enabled = true,
		event = { "InsertEnter", "CmdlineEnter" },
		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },

			appearance = {
				nerd_font_variant = "mono",
			},

			cmdline = {
				enabled = false,
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "emoji" },

				providers = {
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15, -- Tune by preference
						opts = { insert = true }, -- Insert emoji (default) or complete its name
						should_show_items = function()
							return vim.tbl_contains(
								-- Enable emoji completion only for git commits and markdown.
								-- By default, enabled for all file-types.
								{ "gitcommit", "markdown" },
								vim.o.filetype
							)
						end,
					},
				},
			},

			signature = { enabled = true },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },

		dependencies = { "rafamadriz/friendly-snippets", "moyiz/blink-emoji.nvim" },
	},

	-- NOTE: mini.nvim family
	{
		-- NOTE: Extend and create `a`/`i` text-objects
		{
			"nvim-mini/mini.ai",
			enabled = true,
			event = "VeryLazy", -- Text objects are used frequently, load early but not immediately
			opts = {
				n_lines = 500,
			},
		},
		-- NOTE: Surround actions
		{
			"nvim-mini/mini.surround",
			enabled = true,
			event = "VeryLazy", -- Surround operations are common editing tasks
			opts = {},
		},
		-- NOTE: Splits and joins arguments
		{
			"nvim-mini/mini.splitjoin",
			enabled = true,
			keys = { "gS" }, -- Only load when the mapping is actually used
			opts = {
				mappings = {
					toggle = "gS",
					split = "",
					join = "",
				},
			},
		},
	},

	-- NOTE: Enhancement of comment types
	{
		"folke/todo-comments.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {
			signs = false,
		},
	},
}
