-- lsp.lua — language servers (native vim.lsp.config), completion, formatting, treesitter

-- Servers Mason installs and mason-lspconfig enables automatically.
local servers = { "pyright", "ruff", "clangd", "ts_ls", "tinymist", "lua_ls" }

-- Discover Python import roots for a project: the project root itself plus any
-- immediate child dir that holds a package (has a subdir with __init__.py).
-- pyright never runs `sys.path.insert(...)`, so feed it those roots statically.
local PY_SKIP_DIRS = { node_modules = true, __pycache__ = true }
local function py_extra_paths(root)
    local paths = { root }
    for name, ty in vim.fs.dir(root) do
        if ty == "directory" and not name:match("^%.") and not PY_SKIP_DIRS[name] then
            local child = root .. "/" .. name
            for sub, subty in vim.fs.dir(child) do
                if subty == "directory" and vim.uv.fs_stat(child .. "/" .. sub .. "/__init__.py") then
                    table.insert(paths, child)
                    break
                end
            end
        end
    end
    return paths
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
            "mason-org/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

            vim.lsp.config("pyright", {
                -- pyright pulls settings after start (workspace/configuration), so
                -- extend the live client's settings and tell it they changed.
                on_init = function(client)
                    local root = client.root_dir
                    if type(root) ~= "string" then return end -- single file, no project
                    client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
                        python = { analysis = { extraPaths = py_extra_paths(root) } },
                    })
                    client:notify("workspace/didChangeConfiguration", { settings = client.settings })
                end,
            })
            -- ruff handles lint + format; pyright handles types/navigation.
            vim.lsp.config("ruff", {
                on_attach = function(client) client.server_capabilities.hoverProvider = false end,
            })

            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_enable = true,
            })

            vim.diagnostic.config({
                virtual_text = true,
                float = { border = "rounded" },
                update_in_insert = false,
                severity_sort = true,
            })
            -- Show the line's diagnostics in a float when the cursor rests.
            vim.api.nvim_create_autocmd("CursorHold", {
                callback = function()
                    vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
                end,
            })

            -- `K` is gk (see keymaps.lua), so hover lives on ,k
            vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover docs" })
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
            vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
        end,
    },

    -- Lua LSP knows about the Neovim API while editing this config.
    { "folke/lazydev.nvim", ft = "lua", opts = {} },

    {
        "saghen/blink.cmp",
        version = "1.*",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = { "L3MON4D3/LuaSnip" },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "enter",
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
            },
            appearance = { nerd_font_variant = "mono" },
            snippets = { preset = "luasnip" },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                menu = { border = "rounded" },
            },
            cmdline = {
                keymap = { preset = "cmdline" },
                sources = function()
                    local t = vim.fn.getcmdtype()
                    if t == "/" or t == "?" then return { "buffer" } end
                    if t == ":" then return { "cmdline" } end
                    return {}
                end,
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },

    {
        "stevearc/conform.nvim",
        cmd = "ConformInfo",
        opts = {
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                python = { "ruff_organize_imports", "ruff_format" },
                lua = { "stylua" },
                typst = { "typstyle" },
            },
            formatters = {
                stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" } },
            },
        },
    },

    {
        -- `main` branch (the archived `master` breaks on 0.12). Needs the tree-sitter CLI.
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local langs = {
                "bash", "c", "cpp", "python", "lua", "vim", "vimdoc", "query",
                "javascript", "typescript", "tsx", "json", "yaml", "toml",
                "markdown", "markdown_inline", "typst", "latex", "bibtex",
                "regex", "diff", "gitcommit", "git_rebase",
            }
            if vim.fn.executable("tree-sitter") == 1 then
                require("nvim-treesitter").install(langs)
            end
            -- Start treesitter highlighting for any buffer that has a parser.
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
            })
        end,
    },
}
