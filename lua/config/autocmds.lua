-- autocmds.lua
local aug = vim.api.nvim_create_augroup("user", { clear = true })
local au = vim.api.nvim_create_autocmd

-- Reload files changed on disk (by an agent, git, ...) whenever we come back.
au({ "FocusGained", "BufEnter", "CursorHold", "TermLeave", "TermClose" }, {
    group = aug,
    callback = function()
        if vim.fn.getcmdwintype() == "" and vim.bo.buftype == "" then
            vim.cmd("checktime")
        end
    end,
})
au("FileChangedShellPost", {
    group = aug,
    callback = function(ev)
        vim.notify("Reloaded " .. vim.fn.fnamemodify(ev.file, ":~:."), vim.log.levels.INFO)
    end,
})

-- Briefly highlight yanked text
au("TextYankPost", {
    group = aug,
    callback = function() vim.hl.on_yank({ timeout = 150 }) end,
})

-- Return to the last cursor position when reopening a file
au("BufReadPost", {
    group = aug,
    callback = function(ev)
        local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
        local lines = vim.api.nvim_buf_line_count(ev.buf)
        if mark[1] > 0 and mark[1] <= lines then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Terminals (agent CLIs included): no line numbers, start in insert mode
au("TermOpen", {
    group = aug,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})

-- Typst: compile the PDF when leaving Neovim (kept from the old config)
au("VimLeavePre", {
    group = aug,
    pattern = "*.typ",
    callback = function(ev)
        vim.cmd("silent! write")
        vim.fn.jobstart({ "typst", "compile", vim.api.nvim_buf_get_name(ev.buf) }, { detach = true })
    end,
})
