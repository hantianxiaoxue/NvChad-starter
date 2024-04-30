require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

if vim.fn.has "win32" ~= 0 then
  local function is_command_exists(cmd)
    local status = os.execute(cmd .. " --version >NUL 2>&1")
    return status == 0
  end
  -- change term to pwsh
  o.shell = is_command_exists "pwsh.exe" and "pwsh.exe" or "cmd.exe"
  o.shellcmdflag = "-command "
  o.shellquote = '"'
  o.shellxquote = ""
  o.shellpipe = "| Out-File -Encoding UTF8 %s"
  o.shellredir = "| Out-File -Encoding UTF8 %s"
end
-- title 在powershell使用时要在profile中添加$env:TERM = "xterm-256color"
vim.opt.title = true
vim.opt.titlelen = 20 -- do not shorten title
vim.opt.titlestring = '%{expand("%:t")}'
