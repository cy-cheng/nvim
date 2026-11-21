-- ui.lua — theme, statusline, buffer tabs, which-key, snacks (pickers, explorer, notifications)

local muted = "#b8ab9b"

return {
    -- Your original theme: transparent tokyonight + the highlights from the old ui.lua
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
                styles = { sidebars = "transparent", floats = "transparent" },
                on_highlights = function(hl)
                    hl.Comment = { fg = "#999999", italic = true }
                    hl.LineNrAbove = { fg = "#999999" }
                    hl.LineNrBelow = { fg = "#999999" }
                    hl.CursorLineNr = { fg = "#FFA500" }
                    hl.CursorLine = { bg = "#554433" }
                    hl.Visual = { fg = "#000000", bg = "#FFA500" }
                    hl.Heading = { fg = "#FFA500", bg = "#333333" }
                end,
            })
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- Command line, search and messages in a popup in the middle (as before)
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        opts = {
            presets = { lsp_doc_border = true },
            routes = {
                { filter = { event = "msg_showmode" }, opts = { skip = true } },
            },
        },
        keys = {
            { "<leader>nh", "<cmd>Noice dismiss<CR>", desc = "Dismiss notifications" },
            { "<leader>nn", "<cmd>Noice history<CR>", desc = "Notification history" },
        },
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
        opts = { top_down = false },
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                component_separators = "",
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = { { "filename", path = 1 }, "diagnostics" },
                lualine_x = {
                    -- Copilot status from sidekick (shows when Copilot is busy/offline)
                    {
                        function() return " " end,
                        cond = function()
                            local ok, status = pcall(require, "sidekick.status")
                            return ok and status.get() ~= nil
                        end,
                        color = function()
                            local s = require("sidekick.status").get()
                            if s and s.kind == "Error" then return { fg = "#ff5c57" } end
                            if s and s.busy then return { fg = "#FFA500" } end
                            return { fg = muted }
                        end,
                    },
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },

    {
        "romgrk/barbar.nvim",
        event = "VeryLazy",
        dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            animation = false,
            icons = { buffer_index = true, separator_at_end = false },
        },
        keys = {
            { "<A-h>", "<cmd>BufferPrevious<CR>", desc = "Prev buffer" },
            { "<A-l>", "<cmd>BufferNext<CR>", desc = "Next buffer" },
            { "<A-c>", "<cmd>BufferClose<CR>", desc = "Close buffer" },
            { "<A-r>", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", desc = "Close other buffers" },
            { "<A-p>", "<cmd>BufferPin<CR>", desc = "Pin buffer" },
            { "<A-1>", "<cmd>BufferGoto 1<CR>" },
            { "<A-2>", "<cmd>BufferGoto 2<CR>" },
            { "<A-3>", "<cmd>BufferGoto 3<CR>" },
            { "<A-4>", "<cmd>BufferGoto 4<CR>" },
            { "<A-5>", "<cmd>BufferGoto 5<CR>" },
            { "<A-6>", "<cmd>BufferGoto 6<CR>" },
            { "<A-7>", "<cmd>BufferGoto 7<CR>" },
            { "<A-8>", "<cmd>BufferGoto 8<CR>" },
            { "<A-9>", "<cmd>BufferGoto 9<CR>" },
            { "<A-0>", "<cmd>BufferLast<CR>" },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            delay = 400,
            spec = {
                { "<leader>a", group = "AI agents" },
                { "<leader>g", group = "git / review" },
                { "<leader>q", group = "session" },
                { "<leader>n", group = "notifications" },
                { "<Space>", group = "find" },
            },
        },
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            quickfile = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = false }, -- noice + nvim-notify handle messages
            indent = { enabled = true, indent = { char = "┃" }, scope = { char = "┃" } },
            scope = { enabled = true },
            words = { enabled = true },
            explorer = { enabled = true, replace_netrw = true },
            picker = {
                enabled = true,
                sources = { explorer = { layout = { layout = { position = "left" } } } },
            },
        },
        keys = {
            -- <Space> = find things (same keys as your old telescope/neo-tree setup)
            { "<Space><Space>", function() Snacks.explorer() end, desc = "File tree" },
            { "<Space>f", function() Snacks.picker.files() end, desc = "Files" },
            { "<Space>g", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<Space>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<Space>h", function() Snacks.picker.help() end, desc = "Help" },
            { "<Space>r", function() Snacks.picker.recent() end, desc = "Recent files" },
            { "<Space>p", function() Snacks.picker.projects() end, desc = "Projects" },
            { "<Space>d", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<Space>s", function() Snacks.picker.lsp_symbols() end, desc = "Symbols" },
            { "<Space>w", function() Snacks.picker.grep_word() end, desc = "Word under cursor", mode = { "n", "x" } },
            { "<Space>k", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<Space>.", function() Snacks.picker.resume() end, desc = "Resume last picker" },
            -- LSP navigation through the picker
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to definition" },
            { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "]]", function() Snacks.words.jump(1, true) end, desc = "Next reference" },
            { "[[", function() Snacks.words.jump(-1, true) end, desc = "Prev reference" },
        },
    },
}
