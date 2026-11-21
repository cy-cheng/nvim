-- git.lua — see and review what changed (by you or by an agent)
return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(buf)
                local gs = require("gitsigns")
                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buf, desc = desc })
                end
                map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
                map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
                map("n", "<leader>gp", gs.preview_hunk_inline, "Preview hunk")
                map("n", "<leader>gs", gs.stage_hunk, "Stage/unstage hunk")
                map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
                map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
            end,
        },
    },

    -- Review: ,gd shows every changed file side by side (e.g. after an agent run).
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Review working-tree changes" },
            { "<leader>gD", "<cmd>DiffviewOpen HEAD~1<CR>", desc = "Review last commit" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
            { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Close review" },
        },
        opts = { enhanced_diff_hl = true },
    },

    {
        "folke/snacks.nvim",
        keys = {
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
            { "<leader>gf", function() Snacks.picker.git_status() end, desc = "Changed files" },
        },
    },
}
