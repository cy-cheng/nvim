return {
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
              top_down = false,
            })
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            top_down = false,

        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }
}
