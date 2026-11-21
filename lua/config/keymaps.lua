-- keymaps.lua — your old maps, kept. Plugin maps live next to their plugin.
-- Press "," or <Space> and wait: which-key shows everything available.

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- :Q saves everything and quits
vim.api.nvim_create_user_command("Q", function()
    vim.cmd("wall")
    vim.cmd("qa")
end, {})

-- General
map("i", "jk", "<Esc>", opts)
map("i", "{<S-CR>", "{<CR>}<Esc>ko", opts)
map("n", "<Tab>", "A", opts)

map({ "n", "v" }, "H", "b", opts)
map({ "n", "v" }, "J", "gj", opts)
map({ "n", "v" }, "K", "gk", opts)
map({ "n", "v" }, "L", "w", opts)

-- Windows
map("n", "<C-h>", "<C-w>W", opts)
map("n", "<C-l>", "<C-w>w", opts)

-- Terminals
map("n", "<C-A-t>", "<cmd>belowright 10split | terminal<CR>i", opts)
map("n", "<C-A-v>", "<cmd>belowright 40vsplit | terminal<CR>i", opts)
map("t", "jk", [[<C-\><C-n>]], opts)
map("t", "<C-h>", [[<C-\><C-n><C-w>W]], opts)
map("t", "<C-l>", [[<C-\><C-n><C-w>w]], opts)

-- Formatting
map({ "n", "v" }, "<leader>ff", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })

-- Diagnostics
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
