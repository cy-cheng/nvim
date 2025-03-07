-- options.lua

vim.cmd("filetype plugin indent on") -- Enable filetype detection, plugins, and indentation

-- Line number settings
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.number = true       -- Absolute line numbers
vim.opt.relativenumber = true -- Relative line numbers

vim.opt.updatetime = 500    -- Faster completion

-- Indentation settings
vim.opt.tabstop = 4         -- Sets the width of a tab to 4 spaces
vim.opt.shiftwidth = 4      -- Indentation level of 4 spaces
vim.opt.softtabstop = 4     -- Inserts 4 spaces for each tab
vim.opt.scrolloff = 10      -- Keeps 10 lines visible when scrolling
vim.opt.smartindent = true  -- Automatically smart-indents new lines
vim.opt.expandtab = true

vim.opt.splitbelow = true   -- Set the split window to be below the current window

