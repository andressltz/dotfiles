$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object -TypeName Security.Principal.WindowsPrincipal -ArgumentList $identity
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'Abra o PowerShell como administrador e execute o script novamente.'
}

function Invoke-CheckedCommand {
    param(
        [Parameter(Mandatory)]
        [string] $FilePath,

        [Parameter(Mandatory)]
        [string[]] $Arguments,

        [int[]] $AllowedExitCodes = @()
    )

    & $FilePath @Arguments
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0 -and $AllowedExitCodes -notcontains $exitCode) {
        throw "$FilePath terminou com o codigo de saida $exitCode."
    }
}

function Test-WingetPackageInstalled {
    param(
        [Parameter(Mandatory)]
        [string] $PackageId
    )

    $output = @(& $wingetCommand.Source list --exact --id $PackageId --source winget --accept-source-agreements --disable-interactivity)
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        throw "winget list para $PackageId terminou com o codigo de saida $exitCode."
    }

    foreach ($line in $output) {
        if (([string]$line -split '\s+') -contains $PackageId) {
            return $true
        }
    }

    return $false
}

$wingetCommand = Get-Command winget.exe -ErrorAction Stop
$packages = @(
    'Git.Git'
    'KeePassXCTeam.KeePassXC'
    'Microsoft.Coreutils'
    'Microsoft.PowerToys'
    'Ditto.Ditto'
    'Fastfetch-cli.Fastfetch'
)

# To install kubectl, add 'Kubernetes.kubectl' to $packages.

foreach ($package in $packages) {
    if (Test-WingetPackageInstalled -PackageId $package) {
        Write-Host "`n$package ja esta instalado; ignorando."
        continue
    }

    Write-Host "`nInstalando $package..."
    Invoke-CheckedCommand -FilePath $wingetCommand.Source -Arguments @(
        'install'
        '--exact'
        '--id'
        $package
        '--source'
        'winget'
        '--accept-source-agreements'
        '--accept-package-agreements'
    ) -AllowedExitCodes @(-1978335189)
}

$gitCommand = Get-Command git.exe -ErrorAction SilentlyContinue
if ($gitCommand) {
    $gitPath = $gitCommand.Source
} else {
    $gitPath = Join-Path $env:ProgramFiles 'Git\cmd\git.exe'
    if (-not (Test-Path $gitPath)) {
        throw 'Git foi instalado, mas git.exe nao foi encontrado. Abra um novo PowerShell e execute o script novamente.'
    }
}

Write-Host "`nConfigurando Git..."
Invoke-CheckedCommand -FilePath $gitPath -Arguments @('config', '--global', 'core.longpaths', 'true')

$fontsDirectory = Join-Path $PSScriptRoot 'fonts'
$fontsInstaller = Join-Path $fontsDirectory 'install.ps1'
if (-not (Test-Path $fontsInstaller)) {
    Write-Host "`nBaixando fontes Powerline..."
    Invoke-CheckedCommand -FilePath $gitPath -Arguments @(
        'clone'
        '--depth=1'
        'https://github.com/powerline/fonts.git'
        $fontsDirectory
    )
}

if (-not (Test-Path $fontsInstaller)) {
    throw "O instalador de fontes não foi encontrado em $fontsInstaller."
}

Write-Host "`nInstalando fontes Powerline..."
& $fontsInstaller

Write-Host "`nRemovendo arquivos temporarios das fontes..."
Remove-Item -LiteralPath $fontsDirectory -Recurse -Force -ErrorAction Stop

$wslCommand = Get-Command wsl.exe -ErrorAction Stop
$installedDistributions = @(
    & $wslCommand.Source --list --quiet |
        ForEach-Object { ($_ -replace "`0", '').Trim() } |
        Where-Object { $_ }
)
if ($LASTEXITCODE -ne 0) {
    throw "wsl --list --quiet terminou com o codigo de saida $LASTEXITCODE."
}

if ($installedDistributions -contains 'Ubuntu') {
    Write-Host "`nUbuntu no WSL ja esta instalado."
} else {
    Write-Host "`nInstalando WSL com Ubuntu..."
    Invoke-CheckedCommand -FilePath $wslCommand.Source -Arguments @('--install', '-d', 'Ubuntu')
    Write-Host 'A instalacao do WSL pode exigir que o Windows seja reiniciado.'
}
