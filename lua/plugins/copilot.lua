return {
    {
    -- Main Copilot plugin
    "github/copilot.vim",

    -- Copilot Chat plugin
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim" 
            },
            config = function()
                require("CopilotChat").setup({})
            end,
        },

    },
    
}

