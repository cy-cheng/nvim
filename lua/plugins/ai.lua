-- ai.lua — coding agents inside the editor. Everything lives under ,a
--
--   Claude Code  (claudecode.nvim — the same IDE protocol as the VS Code extension)
--     ,ac  toggle Claude          ,af  focus Claude
--     ,ar  resume a conversation  ,aC  continue last conversation
--     ,ab  add current file       ,as  send selection (visual)
--     ,ay  accept proposed diff   ,an  reject proposed diff
--     A `claude` started in any other terminal can attach with `/ide`.
--
--   Any agent CLI — codex, claude, gemini, ... (sidekick.nvim)
--     ,ax  toggle Codex           ,al  pick / switch agent session
--     ,at  send "this" (cursor position or selection)
--     ,av  send the visual selection
--     ,ap  pick a prompt (explain, fix diagnostics, review, tests, ...)
--     <C-.> jump between the code and the agent
--     Sessions run inside tmux, so they keep going after Neovim closes.

return {
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        event = "VeryLazy", -- start the IDE server early so external `claude` can /ide in
        opts = {
            terminal = {
                split_side = "right",
                split_width_percentage = 0.40,
            },
        },
        keys = {
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude: toggle" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude: focus" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Claude: resume" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude: continue" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude: add file" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude: send selection" },
            { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
            { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: reject diff" },
        },
    },

    {
        "folke/sidekick.nvim",
        event = "VeryLazy",
        opts = {
            nes = { enabled = false }, -- next-edit suggestions need Copilot
            copilot = { status = { enabled = false } },
            cli = {
                mux = { backend = "tmux", enabled = true },
            },
        },
        keys = {
            {
                "<C-.>",
                function() require("sidekick.cli").toggle() end,
                mode = { "n", "t", "i", "x" },
                desc = "Agent: toggle",
            },
            {
                "<leader>ax",
                function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end,
                desc = "Codex: toggle",
            },
            {
                "<leader>al",
                function() require("sidekick.cli").select() end,
                desc = "Agent: pick session",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "n", "x" },
                desc = "Agent: send this",
            },
            {
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Agent: send selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Agent: prompts",
            },
        },
    },
}
