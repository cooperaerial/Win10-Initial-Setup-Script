$name = Read-Host -Prompt 'Input new computer name'
Rename-Computer -NewName $name

Write-Host "Enabling display and sleep mode timeouts..."
powercfg /X monitor-timeout-ac 30
powercfg /X monitor-timeout-dc 55

Write-Host "Restarting..."
Restart-Computer