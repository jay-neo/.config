
function psrm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$String
    )

    $historyPath = (Get-PSReadlineOption).HistorySavePath
    $historyLines = Get-Content -LiteralPath $historyPath

    $updatedLines = $historyLines | Where-Object { $_ -notlike "*$String*" }
    $updatedLines | Set-Content -LiteralPath $historyPath

    # $updatedLines = $historyLines | Where-Object { -not $_.StartsWith("psrm") }
    # $updatedLines | Set-Content -LiteralPath $historyPath
}