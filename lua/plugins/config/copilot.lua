local CChat = require("CopilotChat")

CChat.setup({
    window = {
        layout = "horizontal",
        row = 1,
    },
    model = "gpt-4o",
})

vim.g.copilot_no_tab_map = true

