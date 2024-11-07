-- Ensure this line is at the top if using Lazy.nvim
local nvim_tree = require("nvim-tree")

nvim_tree.setup({
    -- General Settings
    disable_netrw = true,     -- Disables Neovim's default netrw file explorer
    hijack_netrw = true,      -- Prevents netrw from opening
    update_focused_file = {
        enable = true,        -- Updates the tree to focus on the current file
        update_cwd = true,    -- Changes the working directory to the file in focus
    },
    
    -- View Settings
    view = {
        width = 30,           -- Width of the tree window
        side = "left",        -- Position the tree on the left
    },
    -- Renderer Settings
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",       -- Default icon for files
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    untracked = "★",
                    renamed = "➜",
                },
            },
        },
    },

    -- Filtering and Git
    filters = {
        dotfiles = false,          -- Show or hide dotfiles
        custom = { "node_modules", ".cache" },  -- Hide specified directories
    },
    git = {
        enable = true,             -- Show git status icons
        ignore = false,            -- Show files ignored by .gitignore
    },

    -- File Highlighting
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
})

