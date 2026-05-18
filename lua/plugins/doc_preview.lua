return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		config = function()
			require("markview").setup({
				markdown = {
					headings = {
						enable = true,
						heading_1 = {
							hl = "Heading",
						},
						heading_2 = {
							hl = "Heading",
						},
						heading_3 = {
							hl = "Heading",
						},
						heading_4 = {
							hl = "Heading",
						},
						heading_5 = {
							hl = "Heading",
						},
					}
				},
				preview = {
					filetypes = { "markdown", "codecompanion" },
					ignore_buftypes = {},
					-- Render the preview only in normal mode; entering insert
					-- mode shows the raw markdown for editing.
					modes = { "n" },
				},
			})
		end,
	},
}
