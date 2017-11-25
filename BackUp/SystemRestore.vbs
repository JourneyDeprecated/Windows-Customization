If GetOS = "Windows 10" Then
	If WScript.Arguments.length =0 Then
  		Set objShell = CreateObject("Shell.Application")
		objShell.ShellExecute "wscript.exe", """" & _
  		 WScript.ScriptFullName & """" & " uac","", "runas", 1
	Else
		const HKEY_LOCAL_MACHINE = &H80000002
             	strComputer = "."
            	Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\default:StdRegProv")
             	strKeyPath = "SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore"
             	strValueName = "SystemRestorePointCreationFrequency"
             	oReg.SetDWORDValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName, 0  
  		CreateSRP
		oReg.DeleteValue HKEY_LOCAL_MACHINE, strKeyPath, strValueName
  	End If
End If

Sub CreateSRP
	Set SRP = getobject("winmgmts:\\.\root\default:Systemrestore")
	sDesc = "Manual Restore Point"
	sDesc = InputBox ("Enter a description.", "System Restore Script","Manual Restore Point")
	If Trim(sDesc) <> "" Then
		sOut = SRP.createrestorepoint (sDesc, 0, 100)
		If sOut <> 0 Then
	 		WScript.echo "Error " & sOut & _
	 		  ": Unable to create Restore Point."
		End If
	End If
End Sub

Function GetOS    
    Set objWMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _
    	".\root\cimv2")
    Set colOS = objWMI.ExecQuery("Select * from Win32_OperatingSystem")
    For Each objOS in colOS
	strOSName = objOS.Caption
        If instr(strOSName, "Windows 10") Then
        	GetOS = "Windows 10"    
        ElseIf instr(strOSName, "Windows 10") Then
      		GetOS = "Windows 10"
        End If
	Next
End Function
