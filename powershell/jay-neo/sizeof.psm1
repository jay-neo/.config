# To get the size of file or folder in Bytes
function sizeof {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        [Alias("FullName")]
        [String]$Path
    )

    process {
        $item = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
        if ($item) {
            $lastModified = $item.LastWriteTime.ToString("HH:mm    dd MMMM yyyy")

            if ($item.PSIsContainer) {
                $size = Get-ChildItem -LiteralPath $Path -Recurse -Force | Measure-Object -Property Length -Sum
                $sizeInBytes = $size.Sum
            }
            else {
                $sizeInBytes = $item.Length
            }

            $sizeString = ""
            if ($sizeInBytes -ge 1GB) {
                $sizeString = "{0:N2} GB      " -f ($sizeInBytes / 1GB)
            }
            elseif ($sizeInBytes -ge 1MB) {
                $sizeString = "{0:N2} MB      " -f ($sizeInBytes / 1MB)
            }
            elseif ($sizeInBytes -ge 1KB) {
                $sizeString = "{0:N2} KB      " -f ($sizeInBytes / 1KB)
            }
            else {
                $sizeString = "$sizeInBytes B"
            }

            $item | Select-Object -Property @{
                Name = "  Name  "
                Expression = { $_.Name + "      "}
            }, @{
                Name = "  Size  "
                Expression = { $sizeString }
            }, @{
                Name = "    Last Modified    "
                Expression = { $lastModified }
            }
        }
        else {
            Write-Warning "Invalid path: $Path"
        }
    }
}