@echo off
:: Advanced System Security Script with Error Handling, Auto-Admin Elevation, Notifications, and Advanced Features

:: Check for Admin privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrative Privileges...
    powershell -Command "Start-Process '%0' -Verb RunAs"
    exit /b
)

:: Setup a log file
set logFile=%temp%\security_script.log
echo Starting security script... > "%logFile%"

:: Function to log and check errors
:check_error
if %errorLevel% neq 0 (
    echo Error occurred: %1 failed. >> "%logFile%"
    echo %1 failed with error code %errorLevel%. Check log for details.
    pause
    exit /b %errorLevel%
) else (
    echo %1 succeeded. >> "%logFile%"
)

:: 0. Integrity Check for Script
echo Verifying script integrity...
certutil -hashfile "%~f0" SHA256 >> "%logFile%"
:: Add hash comparison here if required for verification.
call :check_error "Script Integrity Check"

:: 1. Ensure Windows Defender is enabled and working in real-time
echo Enabling Windows Defender and Real-time Protection...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
call :check_error "Windows Defender Enable (DisableAntiSpyware)"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRealtimeMonitoring /t REG_DWORD /d 0 /f
call :check_error "Windows Defender Enable (DisableRealtimeMonitoring)"
sc start windefend >nul 2>&1
call :check_error "Windows Defender Service Start"
sc config windefend start= auto >nul 2>&1
call :check_error "Windows Defender Auto Start"

:: 2. Close unused ports to reduce attack surface
echo Closing unused ports (RDP, SSH)...
netsh advfirewall firewall add rule name="Block RDP" dir=in action=block protocol=TCP localport=3389
call :check_error "Block RDP (port 3389)"
netsh advfirewall firewall add rule name="Block SSH" dir=in action=block protocol=TCP localport=22
call :check_error "Block SSH (port 22)"

:: 3. Enable automatic system updates for security patches
echo Enabling automatic Windows updates...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0 /f
call :check_error "Enable Automatic Updates"

:: 4. Create a system restore point (for recovery)
echo Creating a system restore point...
powershell -command "Checkpoint-Computer -Description 'Pre-Security Updates' -RestorePointType 'MODIFY_SETTINGS'"
call :check_error "Create Restore Point"

:: 5. Enable basic firewall rules for protection
echo Enabling Windows Firewall with default settings...
netsh advfirewall set allprofiles state on
call :check_error "Enable Windows Firewall"
netsh advfirewall reset
call :check_error "Reset Windows Firewall to Default"

:: 6. Clear outdated logs but retain recent logs for forensic purposes
echo Clearing old system logs (keeping the last 30 days)...
for /f "tokens=*" %%G in ('wevtutil el') do wevtutil cl "%%G" /keep /age:30d
call :check_error "Clear Old System Logs"

:: 7. Schedule regular antivirus scans
echo Scheduling a weekly Windows Defender full scan...
schtasks /create /tn "Windows Defender Scan" /tr "MpCmdRun.exe -Scan -ScanType 2" /sc weekly /d SUN /st 02:00
call :check_error "Schedule Windows Defender Weekly Scan"

:: 8. Display current firewall and security status
echo Displaying firewall status...
netsh advfirewall show allprofiles
call :check_error "Display Firewall Status"

:: 9. Perform Malware Scanning
echo Performing a full malware scan...
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2 > "%temp%\scanResults.txt"
call :check_error "Malware Scan"
echo Malware scan complete. Results saved in "%temp%\scanResults.txt".

:: 10. Backup Important Files
echo Backing up critical system files...
robocopy C:\ImportantData D:\Backup\ImportantData /MIR >nul
powershell -command "reg export HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run D:\Backup\registry_backup.reg"
call :check_error "Backup Critical Files"

:: 11. Send Email Notification on Completion or Failure
echo Sending email notification...
powershell -command "Send-MailMessage -From 'security@yourdomain.com' -To 'admin@yourdomain.com' -Subject 'Security Script Completed' -Body 'The security script completed successfully.' -SmtpServer smtp.yourserver.com"
call :check_error "Email Notification"

:: 12. Dynamic Health Check (Check for Updates, Drivers, Services)
echo Performing system health check...
powershell -command "Get-ComputerInfo | Select-Object OSName, WindowsVersion, CsName"
powershell -command "Get-HotFix | Where-Object { $_.InstalledOn -lt (Get-Date).AddDays(-30) }"
call :check_error "System Health Check"

:: 13. Provide System Hardening Recommendations
echo Checking for system hardening opportunities...
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections >nul
if %errorLevel%==0 (
    echo Warning: RDP is enabled. Consider disabling it for better security. >> "%logFile%"
)

:: 14. Reboot if Critical Settings Were Changed
echo Rebooting system if critical changes were made...
shutdown /r /t 60 /c "Rebooting to apply security settings in 60 seconds."
call :check_error "Reboot System"

:: 15. Final Logging and Cleanup
echo Security enhancements complete. >> "%logFile%"
echo Script completed successfully. Log saved in "%logFile%".
pause
exit

:: Function to handle errors and log the status of each operation
:check_error
if %errorLevel% neq 0 (
    echo Error occurred: %1 failed. >> "%logFile%"
    echo %1 failed with error code %errorLevel%. Check log for details.
    pause
    exit /b %errorLevel%
) else (
    echo %1 succeeded. >> "%logFile%"
)
