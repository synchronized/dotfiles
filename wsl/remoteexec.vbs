dim objShell
set objShell=wscript.createObject("WScript.Shell")
Set args = WScript.Arguments
if args.Count > 1 then
    url = args(0)
    cmd = args(1)
 
    iReturnCode=objShell.Run("plink -ssh -2 -X -C " & url & " " & cmd,0,TRUE)
 
 end if