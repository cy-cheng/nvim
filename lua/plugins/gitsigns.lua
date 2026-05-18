return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        -- Enables gutter signs for added/changed/removed lines and feeds
        -- barbar.nvim's per-buffer git status column.
        opts = {},
    },
}
