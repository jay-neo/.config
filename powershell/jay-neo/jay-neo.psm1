
function logo {
    $console = $Host.UI.RawUI
    $n = $console.BufferSize.Width - 66
    $n = [math]::Floor($n / 2)
    $s = " " * $n

    Write-Host "$s████████╗  █████╗  ██╗   ██╗         ███╗    ██╗ ███████╗ ███████╗" -f Blue
    Write-Host "$s╚═════██║ ██╔══██╗ ╚██╗ ██╔╝         ██║██╗  ██║ ██╔════╝ ██╔══██║" -f Blue
    Write-Host "$s      ██║ ███████║  ╚████╔╝ ███████╗ ██║╚██╗ ██║ █████╗   ██║  ██║" -f Blue
    Write-Host "$s██    ██║ ██╔══██║    ██╔╝  ╚══════╝ ██║ ╚██╗██║ ██╔══╝   ██║  ██║" -f Blue
    Write-Host "$s╚██████╔╝ ██║  ██║    ██║            ██║   ╚███║ ███████╗ ███████║" -f Blue
    Write-Host "$s ╚═════╝  ╚═╝  ╚═╝    ╚═╝            ╚═╝    ╚══╝ ╚══════╝ ╚══════╝" -f Blue
    Write-Host "`n`n"
}


