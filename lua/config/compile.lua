-- File: lua/config/compile.lua

local M = {}

-- Define commands for each file type in a table
local commands = {
    cpp = function(filename)
        local output = filename:gsub("%.%w+$", "")
        print(output)
        return "g++ " .. filename .. " -DLOCAL -o" .. output .. " && ./" .. output
    end,
    c = function(filename)
        local output = filename:gsub("%.%w+$", "")
        return "gcc " .. filename .. " -DLOCAL -o" .. output .. " && ./" .. output
    end,
    python = function(filename)
        return "python3 " .. filename
    end,
    javascript = function(filename)
        return "node " .. filename
    end,
    -- Add more file types and commands here as needed
}

-- Function to compile and run the current file
function M.compile_and_run()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%")

    -- Retrieve the command for the current filetype
    local cmd_func = commands[filetype]
    if cmd_func then
        -- Open a terminal on the right and execute the command
        vim.cmd("rightbelow vsplit | terminal " .. cmd_func(filename))
    else
        print("File type '" .. filetype .. "' is not supported for compilation.")
    end
end

-- Setup function to configure keybinding and command
function M.setup()
    -- Define the custom command :CompileAndRun
    vim.api.nvim_create_user_command("CompileAndRun", M.compile_and_run, {})

    -- Define the keybinding to trigger :CompileAndRun
    vim.api.nvim_set_keymap("n", "<leader>r", ":w<CR>:CompileAndRun<CR>i", { noremap = true, silent = true })
end

return M

