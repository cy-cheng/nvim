return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,

        config = function()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
                -- this is a comment
                on_highlights = function(hl, c)
                    hl.Comment = { fg = "#999999", italic = true }
                end,
            })
            require("tokyonight").load()
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    which_key = true,
                    mason = true,
                    notify = true,
                    lsp_trouble = true,
                },
            })
            -- vim.cmd.colorscheme "catppuccin"
        end,
    }
}
