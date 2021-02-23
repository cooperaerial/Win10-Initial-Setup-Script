Write-Host "Show taskbar buttons on taskbar where windows is open..."
If (!(Test-Path "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced")) {
  New-Item -Path "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MMTaskbarMode" -Type DWord -Value 2