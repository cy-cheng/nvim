--@diagnostic disable: undefined-global
-- plugins/lsp_completion.lua
-- LSP + autocompletion for C++, Python, TypeScript (ts_ls) with error popup on cursor hover

return {
	-- LSP and completion plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- "hrsh7th/nvim-cmp",
			-- "hrsh7th/cmp-nvim-lsp",
			{
			  'saghen/blink.cmp',
			  -- optional: provides snippets for the snippet source
			  -- dependencies = { 'rafamadriz/friendly-snippets' },

			  -- use a release tag to download pre-built binaries
			  version = '1.*',
			  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
			  -- build = 'cargo build --release',
			  -- If you use nix, you can build from source using latest nightly rust with:
			  -- build = 'nix run .#build-plugin',

			  ---@module 'blink.cmp'
			  ---@type blink.cmp.Config
			  opts = {
				-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
				-- 'super-tab' for mappings similar to vscode (tab to accept)
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- All presets have the following mappings:
				-- C-space: Open menu or open docs if already open
				-- C-n/C-p or Up/Down: Select next/previous item
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				keymap = { 
					preset = 'enter',
					['<S-Tab>'] = { 'select_prev', 'fallback' },
					['<Tab>'] = { 'select_next', 'fallback' },
				},

				appearance = {
				  -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				  -- Adjusts spacing to ensure icons are aligned
				  nerd_font_variant = 'mono'
				},

				-- (Default) Only show the documentation popup when manually triggered
				completion = { documentation = { auto_show = false } },

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
				  default = { 'lsp', 'path', 'snippets', 'buffer' },
				},

				-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
				-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
				-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
				--
				-- See the fuzzy documentation for more information
				fuzzy = { implementation = "prefer_rust_with_warning" }
			  },
			  opts_extend = { "sources.default" }
			},
			"L3MON4D3/LuaSnip",
		},
		config = function()
			-- Mason setup
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "clangd", "ts_ls", "tinymist" },
			})

			-- nvim-cmp setup
			--[[ local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{
					name = 'path',
					option = {
						pathMappings = {
							['@'] = '${folder}/src',
							['/'] = '/',
							['./'] = '${folder}/',
							-- ['~@'] = '${folder}/src',
							-- ['/images'] = '${folder}/src/images',
							-- ['/components'] = '${folder}/src/components',
						},
					},
					},
					{ name = 'buffer' },
					{ name = 'luasnip' },
				},
			}) ]]

			-- LSP setup
			-- vim.lsp.config()
			local lspconfig = require("lspconfig")
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("pyright", {
				settings = {

				},
			})
			vim.lsp.config("clangd", {
				settings = {

				},
			})
			vim.lsp.config("ts_ls", {
				settings = {

				},
			})
			vim.lsp.config("tinymist", {
				settings = {

				},
			})


			-- Show diagnostics in a floating window on CursorHold
			vim.api.nvim_create_autocmd("CursorHold", {
				pattern = "*",
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
				end,
			})

			-- Recommended for faster CursorHold events
			vim.o.updatetime = 300

			-- Diagnostic configuration (optional)
			vim.diagnostic.config({
				virtual_text = false,
				float = { border = "rounded" },
				update_in_insert = false,
				severity_sort = true,
			})

			-- Useful LSP keymaps (optional)
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
