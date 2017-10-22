<#
    .DESCRIPTION
        Retrieves Windows Spotlight backgrounds!
#>

Param(
    [Parameter(Mandatory = $True, Position = 1, HelpMessage = "Enter destination")]
    [string]
    $destination,

    [Parameter(Mandatory = $False, Position = 2, HelpMessage = "Enter username")]
    [string]
    $user = $env:username
)

Import-Module .\functions.psm1

$WinSpotlightBGDir = "$(Get-Item "C:\Users\$user\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_*")\LocalState\Assets"

Write-Host "Copying all files to $destination .." -ForegroundColor Blue

Copy-Item "$WinSpotlightBGDir\*" -Destination $destination -Force

ChangeFileExtensions $destination jpg

Write-Host "DONE." -ForegroundColor Green
