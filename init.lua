-- init.lua

-- Load lazy.nvim plugin manager

vim.g.mapleader = ','

-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")  -- Load plugins from `plugins/` folder

require("config.keymaps")
require("config.options")
require("config.ui")
require("config.compile").setup()
