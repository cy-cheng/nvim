-- plugins/lsp_completion.lua
-- LSP + autocompletion for C++, Python, TypeScript (ts_ls) with error popup on cursor hover

return {
	-- LSP and completion plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"saghen/blink.cmp",
				version = "1.*",
				---@module 'blink.cmp'
				---@type blink.cmp.Config
				opts = {
					keymap = {
						preset = "enter",
						["<S-Tab>"] = { "select_prev", "fallback" },
						["<Tab>"] = { "select_next", "fallback" },
					},

					appearance = {
						nerd_font_variant = "mono",
					},

					completion = {
						documentation = {
							auto_show = true,
							auto_show_delay_ms = 200
						}
					},

					cmdline = {
						keymap = { preset = "cmdline" },
						sources = function()
							local type = vim.fn.getcmdtype()
							if type == "/" or type == "?" then return { "buffer" } end
							if type == ":" then return { "cmdline" } end
							return {}
						end,
					},

					sources = {
						default = { "lsp", "path", "snippets", "buffer" },
					},

					fuzzy = { implementation = "prefer_rust_with_warning" },
				},
				opts_extend = { "sources.default" },
			},
			"L3MON4D3/LuaSnip",
		},
		config = function()
			-- Mason setup
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "clangd", "ts_ls", "tinymist" },
			})

			-- CRITICAL: Get capabilities from blink.cmp to enable LSP completion
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Setup all LSPs cleanly in a loop using Neovim 0.11+ native API
			local servers = { "pyright", "clangd", "ts_ls", "tinymist" }
			for _, server in ipairs(servers) do
				-- 1. Apply capabilities via native config
				vim.lsp.config(server, {
					capabilities = capabilities,
				})
				-- 2. Enable the server natively
				vim.lsp.enable(server)
			end

			-- Show diagnostics in a floating window on CursorHold
			vim.api.nvim_create_autocmd("CursorHold", {
				pattern = "*",
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
				end,
			})

			vim.o.updatetime = 300

			-- Diagnostic configuration
			vim.diagnostic.config({
				virtual_text = true,
				float = { border = "rounded" },
				update_in_insert = false,
				severity_sort = true,
			})

			-- Useful LSP keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go Definition" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "yaml", "json" },
			})
		end,
	},
}
