function prompt {
    if (-not $?) {
        Write-Host "$('➜') " -n -ForegroundColor Red
    } else {
        Write-Host "$('➜') " -n -ForegroundColor Green
    }
    if ($PWD.Path -eq $([System.IO.Path]::Combine($env:USERPROFILE, ''))) {  # not work in Unix
        Write-Host " ~" -n -ForegroundColor Cyan
    } elseif ($PWD.Path -eq "Microsoft.PowerShell.Core\Registry::") {
        Write-Host " /" -n -ForegroundColor Red
    }elseif ($PWD.Path -eq (Get-Item $PWD.Path).PSDrive.Root) {
        $driveLetter = (Get-Item $PWD.Path).PSDrive.Name
        Write-Host " $((Get-Item $PWD.Path).PSDrive.Name):" -n -ForegroundColor Cyan
    } else {
        Write-Host " $([System.IO.Path]::GetFileName($PWD.Path))" -n -ForegroundColor Cyan
    }
    if (Test-Path "$env:ProgramFiles\Git\bin\git.exe") {
        $gitBranch = & "$env:ProgramFiles\Git\bin\git.exe" symbolic-ref --short HEAD 2>$null
        if ($gitBranch) {
            Write-Host " git:(" -n -ForegroundColor Blue
            Write-Host "$($gitBranch)" -n -ForegroundColor Red
            Write-Host ")" -n -ForegroundColor Blue
            Write-Host " ✘" -n -ForegroundColor Yellow
            # Write-Host " ⚡" -n -ForegroundColor Yellow
        }
    }
    return ' '
}


function posh {
    Import-Module posh-git
    function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
    $PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'jay.omp.json'
    oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression
}
