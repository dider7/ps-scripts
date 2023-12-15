<#
    .DESCRIPTION
        Creates four scheduled tasks to switch between light and dark modes at specific times.
#>

<#
    .NOTES
        References:
        https://www.howtogeek.com/356087/how-to-automatically-enable-windows-10s-dark-theme-at-night/
        https://www.windowscentral.com/how-switch-between-light-and-dark-colors-schedule-automatically-windows-10
        https://superuser.com/a/1590444
#>

$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `

# Enable Dark mode for apps at 7pm daily:
$trigger = New-ScheduledTaskTrigger `
    -Daily `
    -At 7pm

$action = New-ScheduledTaskAction `
    -Execute 'reg.exe' `
    -Argument 'add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f'

Register-ScheduledTask `
    -Action $action `
    -Trigger $trigger `
    -TaskPath "\My custom tasks" `
    -TaskName "Enable Dark mode for apps" `
    -Description "Enable Dark mode for apps at 7pm daily" `
    -Settings $settings

Write-Host "Created scheduled task to enable Dark mode for apps at 7pm daily." -ForegroundColor Green

# Enable Dark mode for system (Windows) at 7pm daily:
$action = New-ScheduledTaskAction `
    -Execute 'reg.exe' `
    -Argument 'add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f'

Register-ScheduledTask `
    -Action $action `
    -Trigger $trigger `
    -TaskPath "\My custom tasks" `
    -TaskName "Enable Dark mode for system" `
    -Description "Enable Dark mode for system (Windows) at 7pm daily" `
    -Settings $settings

Write-Host "Created scheduled task to enable Dark mode for system (Windows) at 7pm daily." -ForegroundColor Green

# Disable Dark mode for apps at 7am daily:
$trigger = New-ScheduledTaskTrigger `
    -Daily `
    -At 7am

$action = New-ScheduledTaskAction `
    -Execute 'reg.exe' `
    -Argument 'add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 1 /f'

Register-ScheduledTask `
    -Action $action `
    -Trigger $trigger `
    -TaskPath "\My custom tasks" `
    -TaskName "Disable Dark mode for apps" `
    -Description "Disable Dark mode for apps at 7am daily" `
    -Settings $settings

Write-Host "Created scheduled task to disable Dark mode for apps at 7am daily." -ForegroundColor Green

# Disable Dark mode for system (Windows) at 7am daily:
$action = New-ScheduledTaskAction `
    -Execute 'reg.exe' `
    -Argument 'add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 1 /f'

Register-ScheduledTask `
    -Action $action `
    -Trigger $trigger `
    -TaskPath "\My custom tasks" `
    -TaskName "Disable Dark mode for system" `
    -Description "Disable Dark mode for system (Windows) at 7am daily" `
    -Settings $settings

Write-Host "Created scheduled task to disable Dark mode for system (Windows) at 7am daily." -ForegroundColor Green