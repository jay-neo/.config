function rmrf {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ItemPath,
        [Parameter(Mandatory=$false)]
        [switch]$f
    )
    if (-not (Test-Path $ItemPath)) {
        Write-Host "`n ❌ $ItemPath " -n -ForegroundColor Yellow
        Write-Host "not found!!`n" -ForegroundColor Red
        return
    }
    if ($f) {
        Import-Module PSWindowsUpdate
        $credentials = Get-Credential
        TakeOwn -Path $ItemPath -Credential $credentials
    }
    Remove-Item -Path $ItemPath -Recurse -Force
    Write-Host "`n 🗑️ $ItemPath " -n -ForegroundColor Yellow
    Write-Host "removed successfully.`n" -ForegroundColor Green
}