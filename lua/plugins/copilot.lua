return {
    {
        "github/copilot.vim",
        lazy = false,

        config = function()
            vim.g.copilot_no_tab_map = true

        end,
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            display = {
                chat = {
                    show_settings = true,
                },
            },
            strategies = {
                chat = {
                    adapter = {
                        name = "copilot",
                        model = "grok-code-fast-1",
                    },
                },
            },
        }
    }
}
