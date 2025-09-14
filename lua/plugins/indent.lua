return {
    {
        "nmac427/guess-indent.nvim",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
        config = function()
            require("guess-indent").setup()
            require("ibl").setup({
                indent = { char = "┃" },
            })
        end,
    }
}
