return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					cpp = { "clang_format" },
					python = { "black" },
					lua = { "stylua" },
				},
				formatters = {
					stylua = {
						exe = "stylua",
						args = { "--indent-width", "4", "-" },
						stdin = true,
					},
				}
			})
		end,
	},
}
