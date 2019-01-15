#Admin rights
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
    Exit
}

$name = Read-Host -Prompt 'Input new computer name'
Rename-Computer -NewName $name

Write-Host "Enabling display and sleep mode timeouts..."
powercfg /X monitor-timeout-ac 30
powercfg /X monitor-timeout-dc 5
powercfg /X standby-timeout-ac 180
powercfg /X standby-timeout-dc 10

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
Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\CurrentVersion" -Name "RegisteredOrganization" -Type String -Value "Cooper Aerial Surveys Co."

If (!(Test-Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\RegisteredOwner")) {
    New-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\RegisteredOwner" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion" -Name "RegisteredOwner" -Type String -Value "Cooper Aerial"

Write-Host "Enable uninstalling Mixed Reality Portal - Open Settings and go to Mixed Reality select Uninstall..."
If (!(Test-Path "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Holographic")) {
    Set-ItemProperty -Path "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Holographic" -Name "FirstRunSucceeded" -Type DWord -Value 1
}

Get-AppxPackage -AllUsers "ThumbmunkeysLtd.PhototasticCollage" | Remove-AppxPackage

Get-AppxPackage -AllUsers "Microsoft.Office.OneNote" | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

Write-Host "Restarting..."
Restart-Computer