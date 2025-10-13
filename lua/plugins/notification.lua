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
            presets = {
                lsp_doc_border = true,
            },
            routes = {
                {
                    filter = { event = "msg_showmode" },
                    opts = { skip = true },
                },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }
}
