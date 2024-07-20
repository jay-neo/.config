function init {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Param='localhost'
    )
    if ($Param -eq '0') {
        Stop-Computer -ComputerName localhost
    } elseif ($Param -eq '1') {
        rundll32.exe user32.dll,LockWorkStation
    } elseif ($Param -eq '6') {
        Restart-Computer
    } else {
        Stop-Computer -ComputerName $Param
    }

}
