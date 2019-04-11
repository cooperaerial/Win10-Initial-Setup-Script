@powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Win10.ps1" -include "%~dp0Win10.psm1" -preset "NewUser.txt"
@powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Win10.ps1" -include "%~dp0Win10.psm1" -preset "RemoveBloat.txt"
@powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0MapDrives.ps1"
pause