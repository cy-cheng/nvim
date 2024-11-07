-- init.lua

-- Load lazy.nvim plugin manager

vim.g.mapleader = ','

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
require("lazy").setup("plugins")  -- Load plugins from `plugins/` folder

require("config.keymaps")
require("config.options")
require("config.ui")
require("config.compile").setup()
