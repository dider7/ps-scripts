<#
    .DESCRIPTION
        Changes the extensions of all files in the directory where this script is executed.
#>
Param(
    [Parameter(Mandatory = $True, Position = 1, HelpMessage = "Enter extension")]
    [string]
    $ext = ""
)
if($ext.StartsWith(".")) {
    $ext = $ext.Replace(".", "")
}

Get-ChildItem . -Exclude *.ps1 | 
    Foreach-Object {
        Write-Host "Changing the extensions of all files to .$ext .." -ForegroundColor Blue
        
        Rename-Item $_.FullName "$($_.FullName).$ext"
        # Write-Host $_.FullName
        
        Write-Host "DONE." -ForegroundColor Blue
    }
