# Copy the start.bin file into all existing profiles, to overwrite all the crap MS is including in the default Start Menu
# Won't prevent users from unpinning these items or pinning new items, only handles initial cleanup
echo ""
echo "Clean up new and existing Win 11 Start Menus"
# replace default start layout for all new users
New-Item -ItemType Directory -Path C:\Users\Default\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState -ErrorAction SilentlyContinue
Copy-Item -path "C:\Win10-Initial-Setup-Script-master\start2.bin" -Destination C:\Users\Default\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState
# replace default start layout for all existing users
$Source = 'C:\Win10-Initial-Setup-Script-master\start2.bin'
$Destination = 'C:\Users\*\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState'
Get-ChildItem $Destination | ForEach-Object {Copy-Item -Path $Source -Destination $_ -Force}