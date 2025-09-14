local M = {}

local typst_autorun = false
local typst_watch_job_id = nil
local zathura_job_id = nil

local function get_pdf_path(typ_path)
  return typ_path:gsub("%.typ$", ".pdf")
end

local function file_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file"
end

local function open_zathura(pdf_path)
  local function try_open()
    if file_exists(pdf_path) then
      zathura_job_id = vim.fn.jobstart({ "zathura", pdf_path }, { detach = true })
    else
      -- Try again after 200ms, up to 10 times (2 seconds)
      local tries = 0
      local timer = vim.loop.new_timer()
      timer:start(200, 200, function()
        tries = tries + 1
        if file_exists(pdf_path) or tries >= 10 then
          timer:stop()
          timer:close()
          if file_exists(pdf_path) then
            vim.schedule(function()
              zathura_job_id = vim.fn.jobstart({ "zathura", pdf_path }, { detach = true })
            end)
          else
            vim.schedule(function()
              vim.notify("[Typst] PDF was not generated in time for zathura.", vim.log.levels.WARN)
            end)
          end
        end
      end)
    end
  end
  try_open()
end

local function start_typst_compile(typ_path)
  -- Save the file
  vim.cmd("silent write")

  -- Start typst watch in background and open zathura after PDF exists
  typst_watch_job_id = vim.fn.jobstart({ "typst", "watch", typ_path }, {
    detach = true,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.schedule(function()
          vim.notify("[Typst] typst watch exited with code " .. code, vim.log.levels.ERROR)
        end)
      end
    end,
  })

  open_zathura(get_pdf_path(typ_path))
end

function M.setup()
  vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.typ",
    callback = function()
      if not typst_autorun then
        typst_autorun = true
        -- Defer out of fast event context
        vim.schedule(function()
          local typ_path = vim.fn.expand("%:p")
          -- If file doesn't exist, force write (for new unsaved files)
          if not file_exists(typ_path) then
            vim.cmd("silent write")
          end
          start_typst_compile(typ_path)
        end)
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      if typst_watch_job_id then
        vim.fn.jobstop(typst_watch_job_id)
      end
      if zathura_job_id then
        vim.fn.jobstop(zathura_job_id)
      end
    end,
  })
end

return M
