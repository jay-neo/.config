function sshneo {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        [String]$Key
    )
if (-not (Test-Path -Path $Key -PathType Leaf)) {
    Write-Host "`n`tFile does not exist !!`n" -f Yellow
}
# Remove Inheritance:
  Icacls $Key /c /t /Inheritance:d | Out-Null

# Set Ownership to Owner:
  # Key's within $env:UserProfile:
    Icacls $Key /c /t /Grant ${env:UserName}:F | Out-Null

   # Key's outside of $env:UserProfile:
     TakeOwn /F $Key | Out-Null
     Icacls $Key /c /t /Grant:r ${env:UserName}:F | Out-Null

# Remove All Users, except for Owner:
  Icacls $Key /c /t /Remove:g Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users | Out-Null

# Verify:
  Icacls $Key
}