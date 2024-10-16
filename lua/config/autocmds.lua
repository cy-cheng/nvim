-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Function to set terminal background color
-- Create an autocommand that triggers on opening any file
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        -- This will display a notification
        -- vim.notify("Autocmd triggered: Welcome!", vim.log.levels.INFO)
        vim.api.nvim_set_hl(0, "Visual", { bg = "#ff9e64", fg = "#ffffff", bold = true })
        -- vim.cmd("highlight Normal guibg=NONE")
        -- vim.cmd("highlight Normal ctermbg=NONE") -- Optional for transparency
    end,
})
-- Autocommands
