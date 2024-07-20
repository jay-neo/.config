function gcp {
    param (
        [Parameter(Mandatory=$false, Position=0)]
        [string]$msg="code by jay-neo",
        [Parameter(Mandatory=$false, Position=1)]
        [string]$remote="origin",
        [Parameter(Mandatory=$false, Position=2)]
        [string]$branch="master",
        [Parameter(Mandatory=$false, Position=3)]
        [string]$date=(Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    )
    git commit --date=$date -m $msg
    git push -u $remote $branch
}

