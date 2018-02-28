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

Write-Host "Restarting..."
Restart-Computer