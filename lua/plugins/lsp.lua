 -- plugins/lsp.lu0
return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.config.lsp")  -- Separate config file for LSP settings
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()       -- Mason setup for managing LSPs
        end,
    },
}

