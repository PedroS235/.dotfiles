return {
	{
		"epwalsh/obsidian.nvim",
		enabled = false,
		lazy = false,
		ft = "markdown",

		config = function()
			local obsidian = require("obsidian")

			if not os.getenv("SECOND_BRAIN_VAULT") then
				return
			end

			local vault_path = os.getenv("SECOND_BRAIN_VAULT") or ""

			obsidian.setup({
				ui = { enable = false },
				workspaces = {
					{
						name = "Second Brain",
						path = vault_path,
					},
				},

				notes_subdir = "0_Inbox",

				daily_notes = {
					folder = "4_DailyNotes",
					template = "DailyNoteTemplate.md",
				},

				templates = {
					folder = "99_Templates",
				},

				attachments = {
					img_folder = "98_Assets",
				},

				mappings = {
					["gf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					-- Toggle check-boxes.
					-- ["<leader>ch"] = {
					-- 	action = function()
					-- 		return require("obsidian").util.toggle_checkbox()
					-- 	end,
					-- 	opts = { buffer = true },
					-- },
				},

				---@return table
				note_frontmatter_func = function(note)
					local out = { id = note.id, tags = note.tags }

					-- `note.metadata` contains any manually added fields in the frontmatter.
					-- So here we just make sure those fields are kept in the frontmatter.
					if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
						for k, v in pairs(note.metadata) do
							out[k] = v
						end
					end

					return out
				end,
			})
		end,
	},

	{
		-- Plugin which makes seamless integration with tmux movement between panes
		"christoomey/vim-tmux-navigator",
		enabled = true,
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",

		keys = {
			{ "<leader>e", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},

		opts = {
			commands = {
				-- If item is a file close neotree after opening it.
				open_and_close_neotree = function(state)
					require("neo-tree.sources.filesystem.commands").open(state)

					local tree = state.tree
					local success, node = pcall(tree.get_node, tree)

					if not success then
						return
					end

					if node.type == "file" then
						require("neo-tree.command").execute({ action = "close" })
					end
				end,
			},
			filesystem = {
				window = {
					mappings = {
						["<leader>e"] = "close_window",
						["<CR>"] = "open_and_close_neotree",
						["<S-CR>"] = "open",
					},
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--              -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		enabled = false,
		config = function()
			local actions = require("telescope.actions")
			local icons = require("config.icons")

			require("telescope").setup({
				defaults = {
					prompt_prefix = icons.ui.Telescope .. " ",
					selection_caret = icons.ui.Forward .. " ",
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
				pickers = {
					find_files = { previewer = true },
					live_grep = { theme = "dropdown", previewer = true },
					grep_string = { theme = "dropdown", previewer = true },
					buffers = {
						theme = "dropdown",
						previewer = false,
						initial_mode = "normal",
						mappings = {
							i = {
								["<C-d>"] = actions.delete_buffer,
							},
							n = {
								["dd"] = actions.delete_buffer,
							},
						},
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")

			-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			-- vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Find Git Files" })
			-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Grep" })
			-- vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Find String" })
			-- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			-- vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
			-- vim.keymap.set("n", "<leader>fh", builtin.command_history, { desc = "Find command History" })
			-- vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
			-- vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume" })
			-- vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
			-- vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = 'Find Recent Files ("." for repeat)' })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		enabled = false,

		build = "make",

		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	-- { "nvim-telescope/telescope-ui-select.nvim" },
}
