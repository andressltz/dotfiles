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
    if ($exitCode -eq -1978335212) {
        return $false
    }

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

$explorerAdvancedKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
New-ItemProperty -Path $explorerAdvancedKey -Name LaunchTo -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $explorerAdvancedKey -Name HideFileExt -Value 0 -PropertyType DWord -Force | Out-Null

$desktopIcons = @{
    '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' = 0
    '{59031A47-3F72-44A7-89C5-5595FE6B30EE}' = 0
    '{645FF040-5081-101B-9F08-00AA002F954E}' = 0
}
$desktopIconKeys = @(
    'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'
    'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'
)
foreach ($key in $desktopIconKeys) {
    New-Item -Path $key -Force | Out-Null
    foreach ($icon in $desktopIcons.GetEnumerator()) {
        New-ItemProperty -Path $key -Name $icon.Key -Value $icon.Value -PropertyType DWord -Force | Out-Null
    }
}
Write-Host 'O Explorador de Arquivos foi configurado para abrir em Este Computador, exibir extensoes e mostrar os icones Pasta do Usuario, Este Computador e Lixeira.'

Write-Host "`nAtualizando aplicativos da Microsoft Store..."
Invoke-CheckedCommand -FilePath $wingetCommand.Source -Arguments @(
    'upgrade'
    '--all'
    '--source'
    'msstore'
    '--accept-source-agreements'
    '--accept-package-agreements'
    '--disable-interactivity'
)

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

Write-Host "`nVerificando distribuicoes instaladas no WSL..."
$previousErrorActionPreference = $ErrorActionPreference
try {
    $ErrorActionPreference = 'Continue'
    $distributionOutput = @(& $wslCommand.Source --list --quiet 2>&1)
    $listExitCode = $LASTEXITCODE
} finally {
    $ErrorActionPreference = $previousErrorActionPreference
}

if ($listExitCode -eq 0) {
    $installedDistributions = @(
        $distributionOutput |
            ForEach-Object { ($_ -replace "`0", '').Trim() } |
            Where-Object { $_ }
    )
} else {
    Write-Host "Nao foi possivel listar distribuicoes WSL (codigo de saida $listExitCode). A instalacao do Ubuntu tentara inicializar o WSL."
    if ($distributionOutput.Count -gt 0) {
        Write-Host "Saida: $($distributionOutput -join ' ')"
    }
    $installedDistributions = @()
}

Write-Host "`nDistribuicoes instaladas no WSL: $($installedDistributions -join ', ')"
if ($installedDistributions -contains 'Ubuntu') {
    Write-Host "`nUbuntu no WSL ja esta instalado."
} else {
    Write-Host "`nInstalando WSL com Ubuntu..."
    Invoke-CheckedCommand -FilePath $wslCommand.Source -Arguments @('--install', '-d', 'Ubuntu')
    Write-Host 'A instalacao do WSL pode exigir que o Windows seja reiniciado.'
}
