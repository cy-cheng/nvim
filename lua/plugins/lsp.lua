-- plugins/lsp_completion.lua
-- LSP + autocompletion for C++, Python, TypeScript (ts_ls) with error popup on cursor hover

-- Discover Python import roots for a project: the project root itself,
-- plus any immediate child directory that holds a package (a subdir with
-- __init__.py). pyright never runs a script's `sys.path.insert(...)`, so
-- this feeds it those roots statically -- packages kept in nested dirs
-- then resolve in any repo with no per-project pyrightconfig.json.
local PY_SKIP_DIRS = { node_modules = true, __pycache__ = true }
local function py_extra_paths(root)
	local paths = { root }
	for name, ty in vim.fs.dir(root) do
		if ty == "directory" and not name:match("^%.") and not PY_SKIP_DIRS[name] then
			local child = root .. "/" .. name
			for sub, subty in vim.fs.dir(child) do
				if subty == "directory"
					and vim.uv.fs_stat(child .. "/" .. sub .. "/__init__.py") then
					table.insert(paths, child)
					break
				end
			end
		end
	end
	return paths
end

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

			-- pyright resolves imports statically; hand it each project's
			-- import roots (root + nested package dirs) so subdir packages
			-- resolve everywhere without a per-project pyrightconfig.json.
			vim.lsp.config("pyright", {
				capabilities = capabilities,
				before_init = function(init_params, config)
					local root = config.root_dir
						or (init_params.rootUri and vim.uri_to_fname(init_params.rootUri))
					if not root then
						return
					end
					config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
						python = { analysis = { extraPaths = py_extra_paths(root) } },
					})
				end,
			})

			-- Show diagnostics in a floating window on CursorHold
			vim.api.nvim_create_autocmd("CursorHold", {
				pattern = "*",
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
				end,
			})

			-- Diagnostic configuration
			vim.diagnostic.config({
				virtual_text = true,
				float = { border = "rounded" },
				update_in_insert = false,
				severity_sort = true,
			})

			-- Useful LSP keymaps
			-- `K` is remapped to `gk` in config/keymaps.lua, so hover lives on <leader>k.
			vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go Definition" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		-- The legacy `master` branch is archived and crashes on Neovim 0.12
		-- (broken `set-lang-from-info-string!` directive). `main` is the
		-- supported branch for Neovim 0.11+.
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- The `main` branch compiles parsers with the `tree-sitter` CLI.
			-- Skip the install when it is missing so startup stays error-free;
			-- `markdown`/`markdown_inline` already ship with Neovim.
			if vim.fn.executable("tree-sitter") == 1 then
				require("nvim-treesitter").install({ "yaml", "json" })
			end

			-- The `main` branch no longer auto-enables highlighting;
			-- opt in per filetype via `vim.treesitter.start()`.
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "yaml", "json", "markdown" },
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}
