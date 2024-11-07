-- plugins/config/autopairs.lua

local npairs = require("nvim-autopairs")
npairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" },
    check_ts = true,  -- Enables Treesitter integration for better context handling
    fast_wrap = {},   -- Allows for fast wrapping with <M-e> (you can configure this if needed)
})

-- Integration with nvim-cmp to avoid conflicts
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done()
)

