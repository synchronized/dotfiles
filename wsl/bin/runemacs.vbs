' 直接在windows里面启动BashOnWindows 里面的emacs

Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run "C:/Windows/System32/bash.exe -c '/home/sunday/.dotfiles/wsl/bin/runemacs'",0
Set WshShell = Nothing
