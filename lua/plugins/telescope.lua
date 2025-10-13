return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", " f", builtin.find_files, {})
            vim.keymap.set("n", " g", builtin.live_grep, {})
            vim.keymap.set("n", " b", builtin.buffers, {})
            vim.keymap.set("n", " h", builtin.help_tags, {})
        end,
    }
}
