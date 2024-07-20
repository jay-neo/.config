# Import-Module ($PSScriptRoot + "\jay-neo")
Get-ChildItem -Path  ($PSScriptRoot + "\jay-neo") -Filter *.psm1 | ForEach-Object { Import-Module $_.FullName }

[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView


# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"


# Alias
Set-Alias open explorer.exe
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
# Set-Alias zsh "C:\Program Files\Git\bin\bash.exe && exec zsh"
Set-Alias bash "C:\Program Files\Git\bin\bash.exe"


function dev { & "C:\Windows\system32\wsl.exe" -d Ubuntu-22.04 }



