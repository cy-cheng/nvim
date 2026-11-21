-- editor.lua — editing helpers and sessions
return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { ignored_next_char = "[%w%.]" },
    },

    { "nmac427/guess-indent.nvim", event = "BufReadPre", opts = {} },

    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "BufReadPost",
        config = function()
            vim.api.nvim_set_hl(0, "DelimiterGreen", { fg = "#75E01F" })
            vim.api.nvim_set_hl(0, "DelimiterBlue", { fg = "#1F75E0" })
            vim.api.nvim_set_hl(0, "DelimiterPink", { fg = "#CA11EE" })
            require("rainbow-delimiters.setup").setup({
                highlight = { "DelimiterGreen", "DelimiterPink", "DelimiterBlue" },
            })
        end,
    },

    -- One session per project directory: reopen a project where you left it.
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore session (this dir)" },
            { "<leader>qS", function() require("persistence").select() end, desc = "Pick a session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
        },
    },
}
