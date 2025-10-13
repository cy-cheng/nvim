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
    }
}
