Start-Process powershell -Verb runas "Get-AppxPackage -AllUsers | Select Name, InstallLocation > c:\AppxList.txt"
Start-Process powershell -Verb runas "winget list > c:\WingetList.txt"