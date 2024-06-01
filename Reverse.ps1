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

# Remove bound.exe registry entry
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\InventoryApplicationFile\bound.exe|18399b81ecce1834\Version" -Force

# Additional cleanup actions if needed
# (No reverse actions needed for queries or commands that didn't change the system state)

# Print completion message
Write-Output "Reversal of changes is complete."
