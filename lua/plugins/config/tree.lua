require("neo-tree").setup({
    filesystem = {
        window = {
            position = "left",
        },
        follow_current_file = {
            enable = true,
        },
        use_libuv_file_watcher = true,
    },
    buffers = {
        show_unloaded = false,
    },
    popup_border_style = "rounded",
})

