@echo off

rem Remove exclusion paths from Windows Defender
echo Removing exclusion paths from Windows Defender...
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -RemoveExclusion "%USERPROFILE%\AppData\Local\Temp\bound.exe"
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -RemoveExclusion "%USERPROFILE%\Desktop\software.exe"

rem Re-enable Windows Defender features
echo Re-enabling Windows Defender features...
powershell -Command "Set-MpPreference -DisableIntrusionPreventionSystem $false"
powershell -Command "Set-MpPreference -DisableIOAVProtection $false"
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false"
powershell -Command "Set-MpPreference -DisableScriptScanning $false"
powershell -Command "Set-MpPreference -EnableControlledFolderAccess Enabled"
powershell -Command "Set-MpPreference -EnableNetworkProtection Block"
powershell -Command "Set-MpPreference -MAPSReporting Advanced"
powershell -Command "Set-MpPreference -SubmitSamplesConsent AlwaysPrompt"

rem Restore file attributes
echo Restoring file attributes...
attrib -r "C:\Windows\System32\drivers\etc\hosts"

rem Print completion message
echo Reversal of changes is complete.
pause
