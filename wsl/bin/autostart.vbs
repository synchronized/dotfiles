rem 作为windows启动项，启动BashOnWindows里面的开机设置
Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run "C:\Windows\System32\bash.exe -c 'sudo /etc/rc.local'",0
Set WshShell = Nothing
