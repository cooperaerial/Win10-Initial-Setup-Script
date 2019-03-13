
Write-Host "Map FTPRoot as F: ..."
New-PSDrive -Name "F" -Root "\\phx-storage\FTPRoot" -Persist -PSProvider "FileSystem"

Write-Host "Map Lidar as L: ..."
New-PSDrive -Name "L" -Root "\\phx-storage\Lidar" -Persist -PSProvider "FileSystem"

Write-Host "Map Management as M: ..."
New-PSDrive -Name "M" -Root "\\phx-storage\Management" -Persist -PSProvider "FileSystem"

Write-Host "Map ToArchive as T: ..."
New-PSDrive -Name "T" -Root "\\phx-storage\ToArchive" -Persist -PSProvider "FileSystem"
Net Use