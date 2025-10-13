return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		config = function()
			local presets = require("markview.presets")
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
					modes = { "n", "i" },
				},
			})
		end,
	},
}
