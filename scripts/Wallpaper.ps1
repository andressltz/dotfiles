#.\Wallpaper.ps1 -ImagePath "C:\Imagens\wallpaper.jpg"
#param(
#    [Parameter(Mandatory = $true)]
#    [string]$ImagePath
#)

$ImagePath = $args[0]

if (-not $ImagePath -or -not (Test-Path -LiteralPath $ImagePath -PathType Leaf)) {
    Write-Host "Arquivo nao encontrado."
    Read-Host "Pressione ENTER para sair"
    exit 1
}

$destination = Join-Path $env:APPDATA "Microsoft\Windows\Themes\TranscodedWallpaper"

try {
#    Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
#    Start-Sleep -Seconds 1

    Copy-Item -LiteralPath $ImagePath -Destination $destination -Force
}
finally {
#    Start-Process explorer.exe
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
}