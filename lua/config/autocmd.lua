local M = {}

local function compile_typst(typ_path)
	-- Save the file
	vim.cmd("silent write")

	-- Start typst watch in background and open zathura after PDF exists
	typst_watch_job_id = vim.fn.jobstart({ "typst", "compile", typ_path }, {
		detach = true,
		on_exit = function(_, code)
			if code ~= 0 then
				vim.schedule(function()
					vim.notify("[Typst] typst compile exited with code " .. code, vim.log.levels.ERROR)
				end)
			end
		end,
	})
end

function M.setup()
	vim.api.nvim_create_autocmd("VimLeavePre", {
		pattern = "*.typ",
		callback = function()
			vim.schedule(function()
				local typst_path = vim.fn.expand("%:p")
				compile_typst(typst_path)
			end)
		end,
	})
end

return M
