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
		config = function()
			require("codecompanion").setup({
				memory = {
					opts = {
						chat = {
							enabled = true,
						},
					},
				},
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
						variables = {
							buffer = {
								opts = {
									max_lines = 200,
								},
							},
						},
						slash_commands = {
							file = {
								opts = {
									max_lines = 200,
								},
							},
						}
					},
				},
			})
		end,
	},
}
