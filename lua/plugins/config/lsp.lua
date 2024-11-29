-- plugins/config/lsp.lua

local lspconfig = require("lspconfig")

vim.diagnostic.config({
    virtual_text = false, -- Disable inline diagnostics
    signs = true,         -- Keep signs in the gutter
    underline = true,     -- Underline the text with diagnostics
    update_in_insert = false, -- Disable updates in insert mode
})

vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        -- Get diagnostics for the current line
        local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
        for _, diagnostic in ipairs(diagnostics) do
            -- Check if any diagnostic severity is Warning or Error
            vim.diagnostic.open_float(nil, {
                scope = "line",
                focusable = false,  -- Non-interactive float
                style = "minimal",
                border = "rounded",
            })
            return
        end
    end,
})

-- Enable LSP servers for Python, C++, LaTeX
lspconfig.pyright.setup({
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",  -- Disable type checking
                diagnosticMode = "openFilesOnly",  -- Only show diagnostics for open files
            }
        }
    }
})


lspconfig.clangd.setup({
    cmd = { "clangd" },
    init_options = {
        compilationDatabaseCommand = "c++",
        fallbackFlags = { "--std=c++17", "-DLOCAL" },
    },
})     -- C++ LSP
lspconfig.texlab.setup({})    -- LaTeX LSP
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Lua version
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Enable diagnostics for undefined globals like 'vim'
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim's runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            completion = {
                keywordSnippet = "Disable",
            },
        },
    },
})

