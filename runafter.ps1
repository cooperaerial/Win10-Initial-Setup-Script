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
  Clear-Host
  Write-Host "================ $Title ================"

  Write-Host "1: Press '1' for Desktop (never sleep)"
  Write-Host "2: Press '2' for Laptop (3 Hr Sleep)"
  Write-Host "3: Press '3' for Laptop Battery save (1 Hr Sleep)"
  Write-Host "S: Press 'S' to skip"
}

Show-Menu
$menu = Read-Host "Please make a selection"
switch ($menu) {
  '1' {
    Clear-Host
    Write-Host "Desktop (never sleep)..."
    powercfg /X monitor-timeout-ac 30
    powercfg /X monitor-timeout-dc 5
    powercfg /X standby-timeout-ac 0
    powercfg /X standby-timeout-dc 10
  } '2' {
    Clear-Host
    Write-Host "Setting Laptop (3 Hr Sleep)..."
    powercfg /X monitor-timeout-ac 30
    powercfg /X monitor-timeout-dc 5
    powercfg /X standby-timeout-ac 180
    powercfg /X standby-timeout-dc 10
  } '3' {
    Clear-Host
    Write-Host "Setting Laptop (3 Hr Sleep)..."
    powercfg /X monitor-timeout-ac 15
    powercfg /X monitor-timeout-dc 5
    powercfg /X standby-timeout-ac 60
    powercfg /X standby-timeout-dc 10
  } 's' {
    return
  }
}

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

Write-Host "Turn on remote desktop..."
If (!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server")) {
  New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 0
If (!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp")) {
  New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Type DWord -Value 1

Write-Host "Show Most Used Apps in Start Menu..."
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
  New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 0


Write-Host "Remove Meet Now from taskbar..."
If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
  New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1

Write-Host "Disable Edge Shopping..."
If (!(Test-Path "HKLM:SOFTWARE\Policies\Microsoft\Edge\Recommended")) {
  New-Item -Path "HKLM:SOFTWARE\Policies\Microsoft\Edge\Recommended" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:SOFTWARE\Policies\Microsoft\Edge\Recommended" -Name "EdgeShoppingAssistantEnabled" -Value 0

Write-Host "Disable Edge new tab content..."
If (!(Test-Path "HKLM:SOFTWARE\Policies\Microsoft\Edge\Recommended")) {
  New-Item -Path "HKLM:SOFTWARE\Policies\Microsoft\Edge\Recommended" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:SOFTWARE\Policies\Microsoft\Edge\Recommended" -Name "NewTabPageContentEnabled" -Value 0

Write-Host "Restore Edge tabs when opening..."
If (!(Test-Path "HKLM:SOFTWARE\Policies\Microsoft\Edge\Recommended")) {
  New-Item -Path "HKLM:SOFTWARE\Policies\Microsoft\Edge\Recommended" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:SOFTWARE\Policies\Microsoft\Edge\Recommended" -Name "RestoreOnStartup" -Value 1

Write-Host "Turn off News and Interests..."
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds")) {
  New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Value 0


Write-Host "Setting Time Zone To AZ No DST"
Set-TimeZone -Name "US Mountain Standard Time"

Write-Host "VR License"
[Environment]::SetEnvironmentVariable("VRLHOME", $env:VRLHOME + "\\tuc-jobs\vrl$\lic", "Machine")


Write-Output "`nPress any key to continue..."
[Console]::ReadKey($true) | Out-Null

Write-Host "Restarting..."
Restart-Computer