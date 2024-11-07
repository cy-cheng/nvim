-- ui.lua

-- Set the current line number color to orange
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#888888" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#888888" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFA500" })  -- #FFA500 is orange

-- Set the visual selection highlight color to orange
vim.api.nvim_set_hl(0, "Visual", { fg = "#000000", bg = "#FFA500" })        -- Adjust if you want different shade or transparency

