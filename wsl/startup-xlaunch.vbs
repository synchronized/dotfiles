' 作为windows启动项，启动XServer(VcXsrv)

dim VcxsrvHome
Set WshShell = CreateObject("WScript.Shell") 
Set WshProccessEnv = WshShell.Environment("Process")
VcxsrvHome = WshProccessEnv("VCXSRV_HOME")
cmd = """" & VcxsrvHome & "\xlaunch.exe"" -run """ & VcxsrvHome & "\config.xlaunch"""
WshShell.Run cmd,0
Set WshShell = Nothing
