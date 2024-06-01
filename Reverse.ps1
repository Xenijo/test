# PowerShell script to reverse the changes

# Remove exclusion paths from Windows Defender
powershell -Command Remove-MpPreference -ExclusionPath 'C:\Users\user\AppData\Local\Temp\bound.exe'
powershell -Command Remove-MpPreference -ExclusionPath 'C:\Users\user\Desktop\software.exe'

# Re-enable Windows Defender features
powershell -Command Set-MpPreference -DisableIntrusionPreventionSystem $false
powershell -Command Set-MpPreference -DisableIOAVProtection $false
powershell -Command Set-MpPreference -DisableRealtimeMonitoring $false
powershell -Command Set-MpPreference -DisableScriptScanning $false
powershell -Command Set-MpPreference -EnableControlledFolderAccess Enabled
powershell -Command Set-MpPreference -EnableNetworkProtection Block
powershell -Command Set-MpPreference -MAPSReporting Advanced
powershell -Command Set-MpPreference -SubmitSamplesConsent AlwaysPrompt

# Restore file attributes
attrib -r C:\Windows\System32\drivers\etc\hosts

# Remove bound.exe registry entry
Remove-Item -Path "REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\InventoryApplicationFile\bound.exe|18399b81ecce1834\Version" -Force

# Additional cleanup actions if needed
# (No reverse actions needed for queries or commands that didn't change the system state)

# Print completion message
Write-Output "Reversal of changes is complete."
