Write-Host "Map Management as M: ..."
New-PSDrive -Name "M" -Root "\\phx-storage\Management" -Persist -PSProvider "FileSystem"

Write-Host "Map ToArchive as T: ..."
New-PSDrive -Name "T" -Root "\\phx-storage\ToArchive" -Persist -PSProvider "FileSystem"

Write-Host "Map Projects as X: ..."
New-PSDrive -Name "X" -Root "\\tuc-jobs\projects" -Persist -PSProvider "FileSystem"
Net Use