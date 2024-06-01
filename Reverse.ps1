# PowerShell script to reverse the changes

# Get the current user's profile path
$userProfile = $env:USERPROFILE
Write-Output "User profile path: $userProfile"

# Remove exclusion paths from Windows Defender
Write-Output "Removing exclusion paths from Windows Defender..."
Remove-MpPreference -ExclusionPath "$userProfile\AppData\Local\Temp\bound.exe"
Write-Output "Removed exclusion path: $userProfile\AppData\Local\Temp\bound.exe"
Remove-MpPreference -ExclusionPath "$userProfile\Desktop\software.exe"
Write-Output "Removed exclusion path: $userProfile\Desktop\software.exe"

# Re-enable Windows Defender features
Write-Output "Re-enabling Windows Defender features..."
Set-MpPreference -DisableIntrusionPreventionSystem $false
Write-Output "Intrusion Prevention System enabled"
Set-MpPreference -DisableIOAVProtection $false
Write-Output "IOAV Protection enabled"
Set-MpPreference -DisableRealtimeMonitoring $false
Write-Output "Realtime Monitoring enabled"
Set-MpPreference -DisableScriptScanning $false
Write-Output "Script Scanning enabled"
Set-MpPreference -EnableControlledFolderAccess Enabled
Write-Output "Controlled Folder Access enabled"
Set-MpPreference -EnableNetworkProtection Block
Write-Output "Network Protection set to Block"
Set-MpPreference -MAPSReporting Advanced
Write-Output "MAPS Reporting set to Advanced"
Set-MpPreference -SubmitSamplesConsent AlwaysPrompt
Write-Output "Submit Samples Consent set to Always Prompt"

# Restore file attributes
Write-Output "Restoring file attributes..."
attrib -r C:\Windows\System32\drivers\etc\hosts
Write-Output "File attribute restored: C:\Windows\System32\drivers\etc\hosts"

# Remove bound.exe registry entries
Write-Output "Removing registry entries for bound.exe..."
Remove-Item -Path "HKCU:\Software\Classes\Local Settings\MuiCache\4d\52C64B7E\@%SystemRoot%\system32\mlang.dll,-4386" -Force
Write-Output "Removed registry entry: HKCU:\Software\Classes\Local Settings\MuiCache\4d\52C64B7E\@%SystemRoot%\system32\mlang.dll,-4386"
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AmiHiveOwnerCorrect" -Force
Write-Output "Removed registry entry: HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AmiHiveOwnerCorrect"
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AmiHivePermissionsCorrect" -Force
Write-Output "Removed registry entry: HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AmiHivePermissionsCorrect"
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\Windows Error Reporting\Debug\ExceptionRecord" -Force
Write-Output "Removed registry entry: HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\Windows Error Reporting\Debug\ExceptionRecord"

# Remove InventoryApplicationFile\bound.exe registry entries
$inventoryPath = "REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\InventoryApplicationFile"
Write-Output "Removing InventoryApplicationFile\bound.exe registry entries..."
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\BinFileVersion" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\BinFileVersion"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\BinProductVersion" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\BinProductVersion"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\BinaryType" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\BinaryType"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\FileId" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\FileId"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\IsOsComponent" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\IsOsComponent"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\IsPeFile" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\IsPeFile"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Language" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\Language"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\LinkDate" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\LinkDate"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\LongPathHash" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\LongPathHash"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\LowerCaseLongPath" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\LowerCaseLongPath"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Name" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\Name"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\ProductName" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\ProductName"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\ProductVersion" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\ProductVersion"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\ProgramId" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\ProgramId"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Publisher" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\Publisher"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Size" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\Size"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Usn" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\Usn"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Version" -Force
Write-Output "Removed registry entry: $inventoryPath\bound.exe|18399b81ecce1834\Version"

# Additional cleanup actions if needed
# (No reverse actions needed for queries or commands that didn't change the system state)

# Print completion message
Write-Output "Reversal of changes is complete."
