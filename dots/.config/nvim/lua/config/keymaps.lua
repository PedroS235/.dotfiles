-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- keymap/Yank to clipboard
-- keymap("v", "<leader>y", '"+y', opts)
-- keymap("n", "<leader>y", '"+y', opts)

-- Do not replace current yank with substituted text
keymap("x", "p", [["_dP]], opts)

-- Indent line
keymap("v", "<", "<gv", opts) -- LEFT
keymap("v", ">", ">gv", opts) -- RIGHT
