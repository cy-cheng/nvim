-- docs.lua — Markdown and Typst
return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
            markdown = {
                headings = {
                    enable = true,
                    heading_1 = { hl = "Heading" },
                    heading_2 = { hl = "Heading" },
                    heading_3 = { hl = "Heading" },
                    heading_4 = { hl = "Heading" },
                    heading_5 = { hl = "Heading" },
                },
            },
            preview = {
                filetypes = { "markdown" },
                -- Rendered in normal mode; insert mode shows the raw text.
                modes = { "n" },
            },
        },
    },

    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "1.*",
        opts = {},
        keys = { { "<leader>tc", "<cmd>TypstPreview<CR>", desc = "Typst live preview", ft = "typst" } },
    },
}
