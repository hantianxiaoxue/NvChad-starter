require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

if vim.fn.has "win32" == 1 then
  -- change term
  local pwsh_or_cmd = vim.fn.executable "pwsh.exe" == 1 and "pwsh.exe" or "cmd.exe"
  o.shell = vim.fn.executable "zsh.exe" == 1 and "zsh.exe" or pwsh_or_cmd
  if o.shell == "pwsh.exe" then
    o.shellcmdflag = "-command "
    o.shellquote = '"'
    o.shellxquote = ""
    o.shellpipe = "| Out-File -Encoding UTF8 %s"
    o.shellredir = "| Out-File -Encoding UTF8 %s"
  elseif o.shell == "zsh.exe" then
    o.shellcmdflag = "-c"
  end
end
-- title 在powershell使用时要在profile中添加$env:TERM = "xterm-256color"
vim.opt.title = true
vim.opt.titlelen = 20 -- do not shorten title
vim.opt.titlestring = '%{expand("%:t")} NVIM'
vim.opt.titleold=vim.fn.getcwd()
