<#
    .DESCRIPTION
        Some useful functions.
#>

<#
.SYNOPSIS
Changes the extensions of all files in a directory.

.DESCRIPTION
Changes the extensions of all files in a directory.

.PARAMETER location
Directory location of the files

.PARAMETER ext
The target extension name.

.PARAMETER exclude
Files to exclude

.EXAMPLE
ChangeFileExtensions . jpg *.ps1, *.psm1

.NOTES
General notes
#>
function ChangeFileExtensions {
    Param(
        [Parameter(Mandatory = $True, Position = 1, HelpMessage = "Enter files' location")]
        [string]
        $location,
    
        [Parameter(Mandatory = $True, Position = 2, HelpMessage = "Enter extension")]
        [string]
        $ext,

        [Parameter(Mandatory = $False, Position = 3, HelpMessage = "Exclude these files")]
        [string[]]
        $exclude
    )
    if($ext.StartsWith(".")) {
        $ext = $ext.Replace(".", "")
    }

    Get-ChildItem $location -Exclude $exclude | 
        Foreach-Object {
            Write-Host "Changing the extension of $($_.FullName) to .$ext .." -ForegroundColor Blue
            Rename-Item $_.FullName "$($_.BaseName).$ext"
        }

    Write-Host "Finished changing the extensions of all files." -ForegroundColor Blue
}
