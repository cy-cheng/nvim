-- keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("i", "jk", "<esc>", opts)

map("n", "<leader>ll", ":VimtexCompile<CR>:!zathura %:r.pdf &<CR>", opts)

