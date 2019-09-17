#Admin rights
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
    Exit
}

$name = Read-Host -Prompt 'Input new computer name'
Rename-Computer -NewName $name

function Show-Menu {
  param (
    [string]$Title = 'Sleep Settings'
  )
  cls
  Write-Host "================ $Title ================"

  Write-Host "1: Press '1' for Desktop (never sleep)"
  Write-Host "2: Press '2' for Laptop (3 Hr Sleep)"
  Write-Host "3: Press '3' for Laptop Battery save (1 Hr Sleep)"
  Write-Host "S: Press 'S' to skip"
}

do {
  Show-Menu
  $input = Read-Host "Please make a selection"
  switch ($input) {
    '1' {
      cls
      Write-Host "Desktop (never sleep)..."
      powercfg /X monitor-timeout-ac 30
      powercfg /X monitor-timeout-dc 5
      powercfg /X standby-timeout-ac 0
      powercfg /X standby-timeout-dc 10
    } '2' {
      cls
      Write-Host "Setting Laptop (3 Hr Sleep)..."
      powercfg /X monitor-timeout-ac 30
      powercfg /X monitor-timeout-dc 5
      powercfg /X standby-timeout-ac 180
      powercfg /X standby-timeout-dc 10
    } '3' {
      cls
      Write-Host "Setting Laptop (3 Hr Sleep)..."
      powercfg /X monitor-timeout-ac 15
      powercfg /X monitor-timeout-dc 5
      powercfg /X standby-timeout-ac 60
      powercfg /X standby-timeout-dc 10
    } 's' {
      return
    }
  }
  pause
}
until ($input -eq 's')

Write-Host "Set RegisteredOrganization and RegisteredOwner..."
If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\RegisteredOrganization")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\RegisteredOrganization" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "RegisteredOrganization" -Type String -Value "Cooper Aerial Surveys Co."

If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\RegisteredOwner")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\RegisteredOwner" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "RegisteredOwner" -Type String -Value "Cooper Aerial"

If (!(Test-Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\RegisteredOrganization")) {
    New-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\RegisteredOrganization" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" -Name "RegisteredOrganization" -Type String -Value "Cooper Aerial Surveys Co."

If (!(Test-Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\RegisteredOwner")) {
    New-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\RegisteredOwner" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" -Name "RegisteredOwner" -Type String -Value "Cooper Aerial"

Write-Host "Enable uninstalling Mixed Reality Portal - Open Settings and go to Mixed Reality select Uninstall..."
If (!(Test-Path "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Holographic")) {
    Set-ItemProperty -Path "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Holographic" -Name "FirstRunSucceeded" -Type DWord -Value 1
}

Write-Host "Turn on remote desktop..."
If (!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server")) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 0
If (!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp")) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Type DWord -Value 1

Write-Host "Turn on Tamper Protection..."
If (!(Test-Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features")) {
    New-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" -Force | Out-Null
}
Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" -Name "TamperProtection" -Type DWord -Value 5

Write-Host "Show Most Used Apps in Start Menu..."
If (!(Test-Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Force | Out-Null
}
Set-ItemProperty -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 0

Write-Host "Restarting..."
Restart-Computer