return {
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            vim.api.nvim_set_hl(0, "DelimiterGreen", { fg = "#75E01F"})
            vim.api.nvim_set_hl(0, "DelimiterBlue", { fg = "#1F75E0"})
            vim.api.nvim_set_hl(0, "DelimiterPink", { fg = "#CA11EE"})
            require("rainbow-delimiters.setup").setup({
                highlight = {
                    "DelimiterGreen",
                    "DelimiterPink",
                    "DelimiterBlue",
                },
            })
        end,
    }
}
