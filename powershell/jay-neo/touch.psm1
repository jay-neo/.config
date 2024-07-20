function touch {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    Write-Host ""
    $Directory = ''
    $Filename = $Path
    $flag = $true
    if($Path -match '/' -or $Path -match '\\') {
        if($Path -match '\\') {
            $Directory = $Path -replace '\\[^\\]+$'
            $Filename = $Path -replace '.+\\'
        } elseif ($Path -match '/') {
            $Directory = $Path -replace '/[^/]+$'
            $Filename = $Path -replace '.+/'
        }

        if (-not(Test-Path $Directory -PathType container)) {
            $flag = $false
            try {
                New-Item -Path $Directory -ItemType Directory -ErrorAction Stop | Out-Null
                Write-Host " 📂 Creating Directory: " -n -ForegroundColor Green
                Write-Host "$Directory" -ForegroundColor Cyan
            } catch {
                $Directory = $Path -replace '[\\/]', ''
                Write-Host " 📜 $Directory " -n -ForegroundColor Yellow
                Write-Host "same named file already exits!!" -ForegroundColor Red
            }
        }
    }
    if ((Test-Path $Path) -and ($flag -eq $true)) {
        if (($Filename -eq '') -or ($Filename -notcontains '.') -or ($Filename -ne $Path -and $Directory -eq '')) {
            Write-Host " 🗂️ $Path " -n -ForegroundColor Yellow
        } else {
            Write-Host " 📜 $Filename " -n -ForegroundColor Yellow
        }
        Write-Host "already exits!!" -ForegroundColor Red
    } elseif ($Filename -ne '') {
        New-Item -Path $Path -ItemType File -Force | Out-Null
        Write-Host " 📝 Creating File: " -n -ForegroundColor Green
        Write-Host "$Filename" -ForegroundColor Cyan
    }
    Write-Host ""
}