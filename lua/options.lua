require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- change term to pwsh
o.shell = "pwsh.exe"
o.shellcmdflag = "-command "
o.shellquote = '"'
o.shellxquote = ""
o.shellpipe = "| Out-File -Encoding UTF8 %s"
o.shellredir = "| Out-File -Encoding UTF8 %s"

-- title 在powershell使用时要在profile中添加$env:TERM = "xterm-256color"
vim.opt.title = true
vim.opt.titlelen = 20 -- do not shorten title
vim.opt.titlestring = '%{expand("%:t")}'
