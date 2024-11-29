-- keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("i", "jk", "<esc>", opts)

map("n", "<leader>ll", ":VimtexCompile<CR>", opts)
map("n", "<leader>oo", ":!zathura %:r.pdf &<CR><CR>", opts)
map('i', '<C-J>', "copilot#Accept('<CR>')", { expr = true, silent = true })

map("n", "<leader>cc", ":CopilotChatToggle<CR>", opts)
