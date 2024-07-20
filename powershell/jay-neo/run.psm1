Function run {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $FileName
    )
    $Extension = [System.IO.Path]::GetExtension($FileName).ToLower()
    $FilePath = Join-Path -Path $PWD -ChildPath $FileName
    if (-not (Test-Path $FilePath)) {
        Write-Error "File '$FilePath' not found."  -ForegroundColor Red
        return
    }
    $OutputName = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
    switch ($Extension) {
        ".c" {
            $CompileCommand = "gcc $FilePath -o $OutputName"
            $RunCommand = ".\\$OutputName.exe"
        }
        ".cpp"{
            $CompileCommand = "g++ $FilePath -o $OutputName"
            $RunCommand = ".\\$OutputName.exe"
        }
        ".sh" {
            $RunCommand = "bash $FilePath"
        }
        ".ps1" {
            $RunCommand = "& $FilePath"
        }
        ".js" {
            $RunCommand = "node $FilePath"
        }
        ".py" {
            $RunCommand = "python $FilePath"
        }
        ".java" {
            $CompileCommand = "javac $FilePath"
            $RunCommand = "java $OutputName"
        }
        ".rs" {
            $CompileCommand = "rustc $FilePath -o $OutputName"
            $RunCommand = ".\\$OutputName.exe"
        }
        ".rb" {
            $RunCommand = "ruby $FilePath"
        }
        ".r" {
            $RunCommand = "Rscript $FilePath"
        }
        ".go" {
            $CompileCommand = "go build -o $OutputName $FilePath"
            $RunCommand = ".\\$OutputName.exe"
        }
        ".dart" {
            $RunCommand = "dart $FilePath"
        }
        ".swift" {
            $CompileCommand = "swiftc $FilePath -o $OutputName"
            $RunCommand = ".\\$OutputName"
        }
        ".flutter" {
            $RunCommand = "flutter run $FilePath"
        }
        default {
            Write-Error "Unsupported file type: $Extension" -ForegroundColor Red
            return
        }
    }
    if ($CompileCommand) {
        Write-Host "🛠️ Compiling $OutputName$Extension..." -ForegroundColor Green
        Invoke-Expression $CompileCommand
        if ($LASTEXITCODE -ne 0) {
            #Write-Error "Compilation failed:`n$CompileOut" -ForegroundColor Red
            return
        }
    }
    if ($RunCommand) {
        Write-Host "🚀 Running $OutputName..." -ForegroundColor Green
        Write-Host "---------------------------------------------" -ForegroundColor Yellow
        Invoke-Expression $RunCommand
        Write-Host "`n---------------------------------------------" -ForegroundColor Yellow
    }
}