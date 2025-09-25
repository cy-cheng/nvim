-- keymaps.lua

local noctlmap = vim.keymap.set -- cannot use <C-...> in lua
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General options
map("i", "jk", "<esc>", opts)
map("i", "JK", "<esc>", opts)
map("i", "{<S-CR>", "{<CR>}<ESC>ko", opts)
map("n", "<Tab>", "A", opts)

noctlmap({"n", "v"}, "H", "h", opts)
noctlmap({"n", "v"}, "J", "gj", opts)
noctlmap({"n", "v"}, "K", "gk", opts)
noctlmap({"n", "v"}, "L", "l", opts)

-- Windows options
map("n", "  ", ":Neotree toggle<CR>", opts)
map("n", "<A-h>", ":BufferPrevious<CR>", opts)
map("n", "<A-l>", ":BufferNext<CR>", opts)
map("n", "<A-r>", ":BufferCloseAllButCurrentOrPinned<CR>", opts)
map("n", "<A-x>", ":BufferClose<CR>", opts)
map("n", "<C-h>", "<C-w>W", opts)
map("n", "<C-l>", "<C-w>w", opts)

-- Terminal options
map("n", "<C-A-t>", ":belowright 10split | terminal<CR>i", opts)
map("n", "<C-A-v>", ":belowright 40vsplit | terminal<CR>i", opts)
map("t", "jk", "<C-\\><C-n>", opts)

-- Copilot options
map("i", "<C-J>", "copilot#Accept('<CR>')", { expr = true, silent = true })
map("n", "<leader>c", ":CopilotChatToggle<CR>", opts)

-- Notification options
map("n", "<leader>nh", ":Noice dismiss<CR>", opts)

-- Format options
noctlmap({"n", "v"}, "<leader>ff", function()
    require("conform").format({
        async = true,
        lsp_fallback = true,
    })
end, opts)

-- Typst commands
map("n", "<leader>tc", ":TypstPreview<CR>", opts)

