Write-Host "Show taskbar buttons on taskbar where windows is open..."
If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced")) {
  New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MMTaskbarMode" -Type DWord -Value 2

Write-Output "Remove News and Interests from Taskbar..."
If (!(Test-Path "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds")) {
  New-Item -Path "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds" -Force | Out-Null
}
Set-ItemProperty -Path "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Type DWord -Value 2

