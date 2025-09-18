local M = {}

-- Set up the LspAttach autocommand with your exact keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Your exact keymaps
		map("gd", "<cmd>FzfLua lsp_definitions<cr>", "[G]oto [D]efinition")
		map("gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Line diagnostics")
		map("gr", "<cmd>FzfLua lsp_references<cr>", "[G]oto [R]eferences")
		map("gI", "<cmd>FzfLua lsp_implementations<cr>", "[G]oto [I]mplementation")
		map("<leader>D", "<cmd>FzfLua lsp_typedefs<cr>", "Type [D]efinition")
		map("<leader>ds", "<cmd>FzfLua lsp_document_symbols<cr>", "[D]ocument [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", "[C]ode [A]ction", { "n", "x" })
		map("gD", "<cmd>FzfLua lsp_declarations<cr>", "[G]oto [D]eclaration")

		-- Document highlight functionality (your exact code)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and vim.lsp.client.supports_method(client, "textDocument/documentHighlight") then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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

		-- Toggle inlay hints (your exact code)
		if client and vim.lsp.client.supports_method(client, "textDocument/inlayHint") then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end

		-- Toggle virtual text (your exact code)
		map("<leader>tv", function()
			vim.g.virtual_text = not vim.g.virtual_text
			vim.diagnostic.config({ virtual_text = vim.g.virtual_text })
		end, "[T]oggle [V]irtual Text")
	end,
})

return M
