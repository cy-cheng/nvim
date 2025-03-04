-- plugins/ui.lua
return {
    {
        "nvim-lualine/lualine.nvim", -- Status line
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight-moon",
                },
            })
        end,
    },
    {
        "folke/tokyonight.nvim", -- Theme
        config = function()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    float = "transparent",
                }
            })
            vim.cmd("colorscheme tokyonight") -- Apply theme
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("plugins.config.tree")
        end,
    },
    --  {
    --      "nvim-tree/nvim-tree.lua",
    --      dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional icons
    --      config = function()
    --          require("plugins.config.tree")
    --      end,
    --  },
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
            'lewis6991/gitsigns.nvim',   -- OPTIONAL: for git status
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
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "bash" },
                highlight = { enable = true },
            })
        end,
    },
--    {
--        "folke/noice.nvim",
--        event = "VeryLazy",
--        config = function()
--            require("plugins.config.popup")
--        end,
--        opts = {
--            -- add any options here
--        },
--        dependencies = {
--            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
--            "MunifTanjim/nui.nvim",
--            -- OPTIONAL:
--            --   `nvim-notify` is only needed, if you want to use the notification view.
--            --   If not available, we use `mini` as the fallback
--            "rcarriga/nvim-notify",
--        }
--    },
}


