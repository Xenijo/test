# PowerShell script to reverse the changes

# Get the current user's profile path
$userProfile = $env:USERPROFILE

# Remove exclusion paths from Windows Defender
Remove-MpPreference -ExclusionPath "$userProfile\AppData\Local\Temp\bound.exe"
Remove-MpPreference -ExclusionPath "$userProfile\Desktop\software.exe"

# Re-enable Windows Defender features
Set-MpPreference -DisableIntrusionPreventionSystem $false
Set-MpPreference -DisableIOAVProtection $false
Set-MpPreference -DisableRealtimeMonitoring $false
Set-MpPreference -DisableScriptScanning $false
Set-MpPreference -EnableControlledFolderAccess Enabled
Set-MpPreference -EnableNetworkProtection Block
Set-MpPreference -MAPSReporting Advanced
Set-MpPreference -SubmitSamplesConsent AlwaysPrompt

# Restore file attributes
attrib -r C:\Windows\System32\drivers\etc\hosts

# Remove bound.exe registry entries
Remove-Item -Path "HKCU:\Software\Classes\Local Settings\MuiCache\4d\52C64B7E\@%SystemRoot%\system32\mlang.dll,-4386" -Force
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AmiHiveOwnerCorrect" -Force
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AmiHivePermissionsCorrect" -Force
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\Windows Error Reporting\Debug\ExceptionRecord" -Force

# Remove InventoryApplicationFile\bound.exe registry entries
$inventoryPath = "REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\InventoryApplicationFile"
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\BinFileVersion" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\BinProductVersion" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\BinaryType" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\FileId" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\IsOsComponent" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\IsPeFile" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Language" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\LinkDate" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\LongPathHash" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\LowerCaseLongPath" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Name" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\ProductName" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\ProductVersion" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\ProgramId" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Publisher" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Size" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Usn" -Force
Remove-Item -Path "$inventoryPath\bound.exe|18399b81ecce1834\Version" -Force

# Additional cleanup actions if needed
# (No reverse actions needed for queries or commands that didn't change the system state)

# Print completion message
Write-Output "Reversal of changes is complete."
