return {
    {
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    python = { "black" },
                    lua = { "lua-format" },
                    tex = { "latexindent" },
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>ff", function()
                conform.format({
                    lsp_fallback = true,
                    async = true,
                    timeout = 500,
                })
            end)
        end,
    }
}
