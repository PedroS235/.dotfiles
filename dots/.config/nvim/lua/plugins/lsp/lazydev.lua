-- lua/plugins/lsp/lazydev.lua
-- LazyDev configuration for Lua development

return {
	library = {
		-- Load the wezterm types when the `wezterm` module is required
		{ path = "wezterm-types", mods = { "wezterm" } },
		-- Load the `vim.uv` typing from the `luv` library
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		-- Add any other libraries here
	},
	enabled = function(root_dir)
		-- Only enable in Neovim config directories or when developing Neovim plugins
		return vim.g.lazydev_enabled ~= false
			and (
				root_dir:find(vim.fn.stdpath("config"), 1, true)
				or vim.fs.find(".luarc.json", { path = root_dir, upward = true })[1]
				or vim.fs.find("lua", { path = root_dir, type = "directory" })[1]
			)
	end,
}
