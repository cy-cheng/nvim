-- plugins/config/lsp.lua

local lspconfig = require("lspconfig")

-- Enable LSP servers for Python, C++, LaTeX
lspconfig.pyright.setup{}    -- Python LSP
lspconfig.clangd.setup{}     -- C++ LSP
lspconfig.texlab.setup{}     -- LaTeX LSP

