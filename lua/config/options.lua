-- options.lua
local o = vim.opt

o.encoding = "utf-8"
o.fileencodings = "ucs-bom,utf-8,gbk,big5,gb18030,default,latin1"

-- Line numbers
o.number = true
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "both"
o.signcolumn = "yes"
o.updatetime = 500

-- Indentation (guess-indent overrides per file)
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.smartindent = true
o.scrolloff = 10

-- Splits: agents open on the right, terminals below
o.splitbelow = true
o.splitright = true

-- Quality of life
o.mouse = "a"
o.termguicolors = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.laststatus = 3 -- one global statusline; agent splits stay clean
o.showmode = false
o.confirm = true

-- Agents edit files behind your back: pick up their changes automatically.
o.autoread = true
