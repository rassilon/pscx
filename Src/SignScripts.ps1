param([string]$RootDir)

# This script is invoked by the Pscx project's post build event.
$cert = Get-ChildItem Cert:\CurrentUser\My\2BE1DA66486C6EE58D5EA3BC692F86EEE413D35C

Get-ChildItem $RootDir -Recurse -Include *.ps1,*.psm1,*.ps1xml | 
    Where {!$_.PSIsContainer -and $_.Name -ne 'Pscx.UserPreferences.ps1'} | 
    Foreach {
        Set-AuthenticodeSignature -Certificate $cert -TimestampServer http://timestamp.digicert.com $_.FullName
    }
     