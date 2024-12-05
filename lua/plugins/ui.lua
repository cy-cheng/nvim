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
    {
        'romgrk/barbar.nvim',
        dependencies = {
          'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
          'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
          -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
          -- animation = true,
          -- insert_at_start = true,
          -- …etc.
        },
    },
}

