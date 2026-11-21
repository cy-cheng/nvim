-- compile.lua — ,r saves, compiles and runs the current file in a right split.
local M = {}

local q = vim.fn.shellescape

-- Each entry gets the file path (relative) and returns a shell command.
local commands = {
    cpp = function(f)
        local out = f:gsub("%.%w+$", "")
        return ("g++ %s -DLOCAL -o %s && %s"):format(q(f), q(out), q("./" .. out))
    end,
    c = function(f)
        local out = f:gsub("%.%w+$", "")
        return ("gcc %s -DLOCAL -o %s && %s"):format(q(f), q(out), q("./" .. out))
    end,
    python = function(f) return "python3 " .. q(f) end,
    javascript = function(f) return "node " .. q(f) end,
    sh = function(f) return "bash " .. q(f) end,
    typst = function(f) return "typst compile " .. q(f) end,
}

function M.compile_and_run()
    local cmd = commands[vim.bo.filetype]
    if not cmd then
        vim.notify("No run command for filetype '" .. vim.bo.filetype .. "'", vim.log.levels.WARN)
        return
    end
    vim.cmd("write")
    vim.cmd("rightbelow vsplit")
    vim.cmd.terminal(cmd(vim.fn.expand("%")))
    vim.cmd("startinsert")
end

function M.setup()
    vim.api.nvim_create_user_command("CompileAndRun", M.compile_and_run, {})
    vim.keymap.set("n", "<leader>r", M.compile_and_run, { desc = "Compile & run file" })
end

return M
