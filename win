$ErrorActionPreference = "Stop"
# إيقاف شريط التقدم الافتراضي البطيء جداً الخاص بالويندوز (يسرع التحميل 10 أضعاف)
$ProgressPreference = 'SilentlyContinue'

Clear-Host
Write-Host ""
Write-Host "  🚀 Welcome to Agintes R (Multi-Agent Swarm Orchestrator)" -ForegroundColor Cyan
Write-Host "  ========================================================"
Write-Host ""

# 1. Install Bun
Write-Host "  [1/4] 📦 Checking Environment (Bun Runtime)..." -ForegroundColor Yellow
if (!(Get-Command "bun" -ErrorAction SilentlyContinue)) {
    Write-Host "        Downloading Bun..." -ForegroundColor DarkGray
    irm bun.sh/install.ps1 | iex
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
} else {
    Write-Host "        ✅ Bun is ready." -ForegroundColor Green
}

$InstallDir = "$HOME\.agintes-r"
$ZipPath = "$HOME\agintes-r-main.zip"

if (Test-Path $InstallDir) {
    Remove-Item -Recurse -Force $InstallDir
}

# 2. Download ZIP (Using Native cURL for maximum speed and a beautiful progress bar)
Write-Host ""
Write-Host "  [2/4] 📥 Downloading Agintes R Source Code..." -ForegroundColor Yellow
if (Get-Command "curl.exe" -ErrorAction SilentlyContinue) {
    # استخدام curl الأصلي الخاص بالويندوز لأنه أسرع بكثير من Invoke-WebRequest
    curl.exe -L -# -o "$ZipPath" "https://github.com/tjarb8521-ux/Agintes-R/archive/refs/heads/main.zip"
} else {
    Invoke-WebRequest -Uri "https://github.com/tjarb8521-ux/Agintes-R/archive/refs/heads/main.zip" -OutFile $ZipPath
}

# 3. Extracting
Write-Host ""
Write-Host "  [3/4] ⚡ Extracting Files (Lightning Speed)..." -ForegroundColor Yellow
if (Get-Command "tar.exe" -ErrorAction SilentlyContinue) {
    tar.exe -xf $ZipPath -C $HOME
} else {
    Expand-Archive -Path $ZipPath -DestinationPath $HOME -Force
}
Rename-Item -Path "$HOME\Agintes-R-main" -NewName ".agintes-r" -Force
Remove-Item -Path $ZipPath -Force

# 4. Install dependencies
Write-Host ""
Write-Host "  [4/4] ⚙️  Installing Packages (via Bun)..." -ForegroundColor Yellow
Set-Location $InstallDir
$env:BUN_INSTALL = "$HOME\.bun"
$env:PATH = "$env:BUN_INSTALL\bin;$env:PATH"

# تشغيل تنصيب الحزم
bun install

# 5. Create the 'agintes' command
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

Write-Host ""
Write-Host "  ========================================================"
Write-Host "  🎉 Installation Complete Successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "  👉 Restart your terminal, then type:  agintes" -ForegroundColor Cyan
Write-Host "  ========================================================"
Write-Host ""
