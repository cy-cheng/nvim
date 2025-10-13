-- keymaps.lua

-- Map Q to save all and quit all
vim.api.nvim_create_user_command("Q", function()
    vim.cmd("wall")
    vim.cmd("qa")
end, {})

local noctlmap = vim.keymap.set -- cannot use <C-...> in lua
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General options
map("i", "jk", "<ESC>", opts)
map("i", "{<S-CR>", "{<CR>}<ESC>ko", opts)
map("n", "<Tab>", "A", opts)

noctlmap({"n", "v"}, "H", "b", opts)
noctlmap({"n", "v"}, "J", "gj", opts)
noctlmap({"n", "v"}, "K", "gk", opts)
noctlmap({"n", "v"}, "L", "w", opts)

-- Windows options
map("n", "  ", ":Neotree toggle<CR>", opts)
map("n", "<A-h>", ":BufferPrevious<CR>", opts)
map("n", "<A-l>", ":BufferNext<CR>", opts)
map("n", "<A-r>", ":BufferCloseAllButCurrentOrPinned<CR>", opts)
map("n", "<A-c>", ":BufferClose<CR>", opts)
map("n", "<C-h>", "<C-w>W", opts)
map("n", "<C-l>", "<C-w>w", opts)

map("n", "<A-1>", ":BufferGoto 1<CR>", opts)
map("n", "<A-2>", ":BufferGoto 2<CR>", opts)
map("n", "<A-3>", ":BufferGoto 3<CR>", opts)
map("n", "<A-4>", ":BufferGoto 4<CR>", opts)
map("n", "<A-5>", ":BufferGoto 5<CR>", opts)
map("n", "<A-6>", ":BufferGoto 6<CR>", opts)
map("n", "<A-7>", ":BufferGoto 7<CR>", opts)
map("n", "<A-8>", ":BufferGoto 8<CR>", opts)
map("n", "<A-9>", ":BufferGoto 9<CR>", opts)
map("n", "<A-0>", ":BufferLast<CR>", opts)

-- Terminal options
map("n", "<C-A-t>", ":belowright 10split | terminal<CR>i", opts)
map("n", "<C-A-v>", ":belowright 40vsplit | terminal<CR>i", opts)
map("t", "jk", "<C-\\><C-n>", opts)

-- Copilot options
map("i", "<C-J>", "copilot#Accept('<CR>')", { expr = true, silent = true })
map("n", "<leader>c", ":CodeCompanionChat<CR>", opts)

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

