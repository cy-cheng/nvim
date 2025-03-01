require("neo-tree").setup({
    filesystem = {
        window = {
            position = "left",
        },
        follow_current_file = true,
        use_libuv_file_watcher = true,
    },
    buffers = {
        show_unloaded = false,
    },
})

