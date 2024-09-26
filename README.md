

# 🔒 Advanced System Security Script

Welcome to the **Advanced System Security Script**! This powerful batch script automates essential security measures for your Windows environment, ensuring a robust defense against threats. With error handling, administrative elevation, and comprehensive logging, you can enhance your system's security with ease. 🌟

![Security Animation](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExbDhoN2dpdnJ3Y3M3YXA3eWs1YTA0MWdpZGhwcDBhdWFjdnVqYXRzbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/IXnygGeB6LPPi/giphy.gif)

---

## 🚀 Features

- **Admin Privilege Request**: Automatically requests administrative rights to execute security tasks. 
- **Detailed Logging**: Logs every action and error for transparency and review.
- **Integrity Check**: Verifies the script's integrity to prevent unauthorized modifications.
- **Windows Defender Management**: Ensures Windows Defender is enabled and running.
- **Firewall Configuration**: Blocks unnecessary ports to reduce attack surface.
- **Automated Updates**: Configures the system to download and install updates automatically.
- **System Restore Points**: Creates restore points before making changes for safety.
- **Malware Scanning**: Schedules regular scans to detect potential threats.
- **Backup Functionality**: Backs up important files and system settings.
- **Health Checks**: Performs system health checks and provides hardening recommendations.
- **Email Notifications**: Sends completion or failure notifications via email.
- **Reboot Management**: Prompts a reboot if critical changes are made.



---

## 📋 Usage Instructions

1. **Download the Script**: Save the script as `SecurityScript.bat`.
2. **Run the Script**: Right-click on the file and select **Run as administrator**. If prompted, grant administrative privileges.
3. **Follow the Prompts**: The script will execute various security measures and log the results. Monitor the command prompt for real-time updates! 📡
4. **Check the Log File**: After execution, review the log file located at `%temp%\security_script.log` for detailed results. 📖

![Running Animation](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExYzUyNzBjcm1nbngzMHk0ZHhjMzUybGJrdzNyMTJ4MHdodXRraDJlbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/a7jCRzDW5TH7vsIbYD/giphy.gif) 

---

## 🛠️ Requirements

- Windows Operating System
- Administrative privileges
- PowerShell must be enabled for email notifications and health checks.

---

## 🧩 Code Breakdown

```batch
@echo off
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
```
> This snippet requests administrative privileges and sets up a log file to track operations.


---

## ⚠️ Important Notes

- **Backup Important Data**: Before running the script, ensure that you have backups of important data.
- **Review Firewall Rules**: Customize the firewall rules as necessary for your environment.
- **Email Configuration**: Modify the SMTP settings in the email notification section to fit your email provider's requirements.


---

## 📧 Contact

For questions or issues, feel free to contact the script maintainer at:

**Email**:  tejasbarguje9@gmail.com

![Contact Animation](https://th.bing.com/th/id/OIP.oiM-CTC_nBsbi_fMmiLE0wHaEX?rs=1&pid=ImgDetMain) <!-- Example link for animation -->

---

## 🌟 Contribution

Contributions are welcome! If you'd like to enhance this script or report an issue, please open an issue or submit a pull request.

---

## 🎉 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.



Thank you for using the Advanced System Security Script! Your system's safety is our priority. Stay secure! 🔐✨

![Closing Animation](https://image.slidesharecdn.com/group26-141217093822-conversion-gate02/95/hacker-hunters-case-study-24-638.jpg?cb=1418809152) 

```

