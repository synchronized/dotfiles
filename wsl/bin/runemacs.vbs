' 直接在windows里面启动BashOnWindows 里面的emacs

Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run "C:/Windows/System32/bash.exe -c '~/.dotfiles/wsl/bin/runemacsclient'",0
Set WshShell = Nothing
