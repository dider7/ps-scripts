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

[int] $MinFileSize = 102400
[string] $ext = "jpg"
[int] $CopyCount = 0

$WinSpotlightBGDir = "$(Get-Item "C:\Users\$user\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_*")\LocalState\Assets"

Get-ChildItem "$WinSpotlightBGDir" | 
    Where-Object { !(Test-Path "$destination\$($_.BaseName).$ext") -and $_.Length -gt $MinFileSize } | 
    Foreach-Object {
        Write-Host "Copying $($_.FullName) to $destination .." -ForegroundColor Blue
        Copy-Item $_.FullName -Destination $destination -Force
        $CopyCount++
    }
Write-Host "$CopyCount files copied" -ForegroundColor Blue
if($CopyCount -gt 0) {
    ChangeFileExtensions $destination $ext *.ps1, *.psm1
}

Write-Host "DONE." -ForegroundColor Green
