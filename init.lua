-- init.lua — agent-first Neovim (0.12+)
-- Layout:
--   lua/config/   options, keymaps, autocmds, compile-and-run
--   lua/plugins/  one file per area (ui, editor, lsp, git, ai, docs)

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require("config.options")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git", lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Failed to clone lazy.nvim:\n" .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = { { import = "plugins" } },
    install = { colorscheme = { "kanagawa", "habamax" } },
    change_detection = { notify = false },
    rocks = { enabled = false },
    ui = { border = "rounded" },
})

require("config.keymaps")
require("config.autocmds")
require("config.compile").setup()
