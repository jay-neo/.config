function awsuser {
    param (
        [Parameter(Position = 0)]
        [string]$FilePath = '',
        [Parameter(Position = 1)]
        [string]$UserName = ''
    )

    if ($FilePath -eq '') {
        Write-Host "`nUsage: " -n
        Write-Host "awsuser " -n -f Yellow
        Write-Host "filepath " -n -f Green
        Write-Host "[username]`n" -f Cyan
        return
    }

    if (-not (Test-Path $FilePath -PathType Leaf)) {
        Write-Host "File not found: $FilePath"
        return
    }

    $CredentialFile = "~/.aws/config"
    if (-not (Test-Path $CredentialFile -PathType Leaf)) {
        $CredentialContent = "[default]`nregion = ap-south-1`noutput = table"
        New-Item -Path $CredentialFile -ItemType File -Force | Out-Null
        Set-Content -Path $CredentialFile -Value $CredentialContent
    }

    if ($UserName -eq '') {
        aws configure import --csv file://$FilePath
        return
    }

    $newFilePath = "~/" + (Get-Date).tostring("yyyyMMdd_HHmmss") + ".csv"
    if (-not (Test-Path $newFilePath)) {
        New-Item -Path $newFilePath -ItemType File -ErrorAction Stop | Out-Null
    }

    $data = Import-Csv $FilePath
    $data | ForEach-Object { $_ | Add-Member -MemberType NoteProperty -Name 'User Name' -Value $UserName -PassThru } | Export-Csv -Path $newFilePath -NoTypeInformation -QuoteFields None

    aws configure import --csv file://$newFilePath
    Remove-Item -Path $newFilePath -Force
}