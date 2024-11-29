-- plugins/config/indentline.lua

require("ibl").setup({
	char = "|",
	filetype_exclude = { "help", "dashboard", "packer", "NvimTree", "terminal" },
	buftype_exclude = { "terminal" },
})
