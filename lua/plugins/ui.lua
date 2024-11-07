-- plugins/ui.lua
return {
    {
        "nvim-lualine/lualine.nvim",     -- Status line
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight-moon",
                },
            })
        end,
    },
    {
        "folke/tokyonight.nvim",     -- Theme
        config = function()
            require("tokyonight").setup({
                transparent = true
            })
            vim.cmd("colorscheme tokyonight")  -- Apply theme
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional icons
        config = function()
            require("plugins.config.tree")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
			require("ibl").setup()
        end
    },
}

