-- keymaps.lua

local noctlmap = vim.keymap.set -- cannot use <C-...> in lua
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General options
map("i", "jk", "<esc>", opts)
map("i", "JK", "<esc>", opts)

noctlmap({"n", "v"}, "<A-h>", "h", opts)
noctlmap({"n", "v"}, "<A-j>", "gj", opts)
noctlmap({"n", "v"}, "<A-k>", "gk", opts)
noctlmap({"n", "v"}, "<A-l>", "l", opts)

-- Windows options
map("n", "  ", ":Neotree toggle<CR>", opts)
map("n", "<A-.>", ":bNext<CR>", opts)
map("n", "<A-,>", ":bprevious<CR>", opts)
map("n", "<A-r>", ":BufferCloseAllButCurrentOrPinned<CR>", opts)
map("n", "<C-h>", "<C-w>W", opts)
map("n", "<C-l>", "<C-w>w", opts)

-- Tex options
map("n", "<leader>vl", ":VimtexCompile<CR>", opts)
map("n", "<leader>ve", ":VimtexErrors<CR>", opts)
map("n", "<leader>vo", ":!zathura %:r.pdf &<CR><CR>", opts)

-- Terminal options
map("n", "<C-A-t>", ":belowright 10split | terminal<CR>i", opts)
map("n", "<C-A-v>", ":belowright 40vsplit | terminal<CR>i", opts)
map("t", "jk", "<C-\\><C-n>", opts)

-- Copilot options
map("i", "<C-J>", "copilot#Accept('<CR>')", { expr = true, silent = true })
map("n", "<leader>c", ":CopilotChatToggle<CR>", opts)

