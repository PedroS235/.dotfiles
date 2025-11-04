local M = {}

-- Your exact server configurations
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

	-- JSON with schema validation
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},

	-- YAML with schema validation
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	},

	-- Spell
	harper_ls = {
		settings = {
			["harper-ls"] = {
				userDictPath = "~/.config/nvim/spell/harper-dict.txt",
				linters = {
					SentenceCapitalization = false,
					SpellCheck = false,
				},
			},
		},
	},
}

-- Your exact formatters list
local formatters = {
	"stylua",
	"black",
	"prettier",
	"beautysh",
	"clang-format",
}

-- Setup function
function M.setup()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
	capabilities.offsetEncoding = { "utf-16" }

	vim.lsp.buf.signature_help({ border = "rounded" })
	vim.lsp.buf.hover({ border = "rounded" })

	-- Your exact ensure_installed logic
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, formatters or {})
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	-- Your exact mason-lspconfig setup
	require("mason-lspconfig").setup()

	-- Apply custom server settings
	for server_name, settings in pairs(servers) do
		vim.lsp.config(server_name, settings)
		if server_name == "harper_ls" then
			vim.lsp.enable(server_name, false)
		end
	end
end

-- Auto-setup
M.setup()

return M
