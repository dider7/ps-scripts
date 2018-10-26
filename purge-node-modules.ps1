<#
    .DESCRIPTION
        Purges every 'node_modules' folder under a target directory.
#>
Param(
    [Parameter(Mandatory = $True, Position = 1, HelpMessage = "Enter target directory")]
    [string]
    $targetDir
)

Get-ChildItem "$targetDir" -Directory -Include "node_modules" -Recurse | 
    Foreach-Object {
        Write-Host "Purging $($_.FullName) .." -ForegroundColor Blue
        Remove-Item "$($_.FullName)\*" -Recurse -Force
    }