$ErrorActionPreference = "Stop"

Write-Host "======================================================"
Write-Host "🚀 Installing Agintes R (Multi-Agent Swarm Orchestrator)"
Write-Host "======================================================"

# 1. Install Bun if it's not installed
if (!(Get-Command "bun" -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Installing Bun (Fast JavaScript Runtime)..."
    irm bun.sh/install.ps1 | iex
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
} else {
    Write-Host "✅ Bun is already installed."
}

# 2. Download ZIP instead of Git clone
$InstallDir = "$HOME\.agintes-r"
$ZipPath = "$HOME\agintes-r-main.zip"

Write-Host "📥 Downloading Agintes R source code (ZIP)..."
if (Test-Path $InstallDir) {
    Write-Host "🗑️  Removing old installation to perform a clean update..."
    Remove-Item -Recurse -Force $InstallDir
}

Invoke-WebRequest -Uri "https://github.com/tjarb8521-ux/Agintes-R/archive/refs/heads/main.zip" -OutFile $ZipPath
Write-Host "📦 Extracting files..."
Expand-Archive -Path $ZipPath -DestinationPath $HOME -Force
Rename-Item -Path "$HOME\Agintes-R-main" -NewName ".agintes-r" -Force
Remove-Item -Path $ZipPath -Force

Set-Location $InstallDir

# 3. Install dependencies
Write-Host "⚙️  Installing system dependencies (this may take a moment)..."
bun install

# 4. Create the 'agintes' command
Write-Host "🔗 Setting up 'agintes' command-line interface..."
$BinDir = "$HOME\.local\bin"
if (!(Test-Path $BinDir)) {
    New-Item -ItemType Directory -Force -Path $BinDir | Out-Null
}

$CmdPath = Join-Path $BinDir "agintes.cmd"
$CmdContent = @"
@echo off
set "BUN_INSTALL=%USERPROFILE%\.bun"
set "PATH=%BUN_INSTALL%\bin;%PATH%"
bun run "%USERPROFILE%\.agintes-r\packages\cli\src\index.ts" %*
"@

Set-Content -Path $CmdPath -Value $CmdContent

$UserPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($UserPath -notmatch [regex]::Escape($BinDir)) {
    [Environment]::SetEnvironmentVariable("PATH", "$BinDir;$UserPath", "User")
    $env:Path = "$BinDir;$env:Path"
}

Write-Host "======================================================"
Write-Host "🎉 Installation Complete!"
Write-Host ""
Write-Host "To start using Agintes R immediately in this window, run:"
Write-Host "👉 agintes --help"
Write-Host ""
Write-Host "Note: If 'agintes' is not recognized, restart your PowerShell."
Write-Host "======================================================"
