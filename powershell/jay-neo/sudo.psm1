function sudo {
    param (
        [string]$argumentsParameter
    )
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        try {
            $LogDate = (Get-Date).tostring("yyyyMMdd_HHmmss")
            $logDir = $HOME + "\PowerShell_Logs\sudo"

            
            if (-not(Test-Path $logDir -PathType container)) {
                New-Item -Path $logDir -ItemType Directory -ErrorAction Stop | Out-Null
            }
            $LogFile = $logDir + "\" + $LogDate + ".txt"
            if (-not (Test-Path $LogFile)) {
                New-Item -Path $LogFile -ItemType File -ErrorAction Stop | Out-Null
            }
            # "Start-Transcript -Path $LogFile -UseMinimalHeader"
            $arguments = "& Start-Transcript -Path $LogFile; $argumentsParameter; Stop-Transcript"
            $process = Start-Process powershell -Verb runAs -ArgumentList $arguments -PassThru -Wait
            if ($process.ExitCode -ne 0) {
                Write-Host "`n`tError: Elevated PowerShell process exited with code $($process.ExitCode)" -ForegroundColor Red
            }

            $lineUpto = (Get-Content -Path $LogFile | Measure-Object -Line).Lines - 23
            $content = Get-Content -Path $LogFile | Select-Object -Skip 19 -First $lineUpto

            Write-Host
            foreach ($line in $content) {
                Write-Host $line -ForegroundColor Cyan
            }
            Write-Host
        } catch {
            Write-Host "Error: $_.Exception.Message" -ForegroundColor Red
        }
        # Break
    }
}