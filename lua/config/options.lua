-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local g = vim.g
local o = vim.o
local opt = vim.opt

g.python_recommended_style = 0
g.rust_recommended_style = 0
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.expandtab = true
opt.scrolloff = 10
opt.wrap = true
opt.breakindent = true
