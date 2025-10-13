-- ui.lua

-- Set the current line number color to orange
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#999999" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#999999" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFA500" }) -- #FFA500 is orange
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#554433" })

-- Set the visual selection highlight color to orange
vim.api.nvim_set_hl(0, "Visual", { fg = "#000000", bg = "#FFA500" }) -- Adjust if you want different shade or transparency

vim.api.nvim_set_hl(0, "Heading", { fg = "#FFA500", bg = "#333333" }) 
