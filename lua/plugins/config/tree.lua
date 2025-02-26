require("neo-tree").setup({
    filesystem = {
        window = {
            position = "left",     -- You can adjust this as per your preference
        },
        follow_current_file = true, -- Option to highlight current file
        use_libuv_file_watcher = true, -- Improve performance on large directories
    },
    buffers = {
        show_unloaded = false, -- This avoids showing empty buffers
    },
})

