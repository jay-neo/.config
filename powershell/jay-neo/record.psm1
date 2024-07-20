function record {
    if ($args[0] -eq "start" -or $args.Length -eq 0) {
        $LogDate = (Get-Date).tostring("yyyyMMdd_HHmmss")
        $logDir = $HOME + "\PowerShell_Logs\record"

        if (-not(Test-Path $logDir -PathType container)) {
            New-Item -Path $logDir -ItemType Directory -ErrorAction Stop | Out-Null
        }
        $LogFile = $logDir + "\" + $LogDate + ".txt"

        Start-Transcript -Path $LogFile -UseMinimalHeader -NoClobber
    } elseif ($args[0] -eq "stop") {
        Stop-Transcript -Confirm
    }
}
