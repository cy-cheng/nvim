-- return {
--     {
--         "folke/tokyonight.nvim",
--         lazy = false, -- Load it during startup, make sure to disable lazy loading
--         priority = 1000, -- Ensure this loads early to avoid other themes overriding it
--         config = function()
--             -- Set your preferred style
--             require("tokyonight").setup({
--                 style = "night", -- Available options: storm, night, day, moon
--                 transparent = true, -- Enable transparent background
--                 terminal_colors = true, -- Enable terminal colors
--                 styles = {
--                     comments = { italic = true },
--                     keywords = { italic = true },
--                     functions = {},
--                     variables = {},
--                     sidebars = "transparent", -- Make sidebars transparent
--                     floats = "transparent", -- Make floating windows transparent
--                 },
--             })
--         end,
--     },
-- }
--

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false, -- Ensure the theme is loaded on startup
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                custom_highlights = {
                    Normal = { bg = "NONE" },
                },
            })
        end,
    },
}
