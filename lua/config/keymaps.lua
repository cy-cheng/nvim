-- keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("i", "jk", "<esc>", opts)
map("i", "JK", "<esc>", opts)

map("n", "H", "h", opts)
map("n", "J", "j", opts)
map("n", "K", "k", opts)
map("n", "L", "l", opts)

map("n", "<leader>l", ":VimtexCompile<CR>", opts)
map("n", "<leader>e", ":VimtexErrors<CR>", opts)
map("n", "<leader>o", ":!zathura %:r.pdf &<CR><CR>", opts)

map('i', '<C-J>', "copilot#Accept('<CR>')", { expr = true, silent = true })
map("n", "<leader>c", ":CopilotChatToggle<CR>", opts)

