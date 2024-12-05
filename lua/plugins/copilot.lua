return {
    {
    -- Main Copilot plugin
    "github/copilot.vim",

    -- Copilot Chat plugin
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            branch = "main",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = function()
                require("plugins.config.copilot")
            end,
        },

    },
    
}

