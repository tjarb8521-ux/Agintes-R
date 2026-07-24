@echo off
setlocal EnableDelayedExpansion

echo ======================================================
echo 🚀 Installing Agintes R (Multi-Agent Swarm Orchestrator)
echo ======================================================

:: 1. Check if Bun is installed
where bun >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo 📦 Installing Bun (Fast JavaScript Runtime)...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "irm bun.sh/install.ps1 | iex"
    set "BUN_INSTALL=%USERPROFILE%\.bun"
    set "PATH=%USERPROFILE%\.bun\bin;%PATH%"
) else (
    echo ✅ Bun is already installed.
)

:: 2. Set up paths
set "INSTALL_DIR=%USERPROFILE%\.agintes-r"
set "ZIP_PATH=%USERPROFILE%\agintes-r-main.zip"
set "EXTRACT_DIR=%USERPROFILE%\Agintes-R-main"

:: 3. Clean old installation
if exist "%INSTALL_DIR%" (
    echo 🗑️ Removing old installation...
    rmdir /s /q "%INSTALL_DIR%"
)

if exist "%ZIP_PATH%" del /f /q "%ZIP_PATH%"
if exist "%EXTRACT_DIR%" rmdir /s /q "%EXTRACT_DIR%"

:: 4. Download and Extract ZIP using PowerShell
echo 📥 Downloading Agintes R source code...
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/tjarb8521-ux/Agintes-R/archive/refs/heads/main.zip' -OutFile '%ZIP_PATH%'"

if not exist "%ZIP_PATH%" (
    echo ❌ Failed to download the source code.
    pause
    exit /b 1
)

echo 📦 Extracting files...
powershell -NoProfile -Command "Expand-Archive -Path '%ZIP_PATH%' -DestinationPath '%USERPROFILE%' -Force"

:: Rename extracted folder to .agintes-r
ren "%EXTRACT_DIR%" ".agintes-r"
del /f /q "%ZIP_PATH%"

:: 5. Install dependencies
echo ⚙️ Installing system dependencies...
cd /d "%INSTALL_DIR%"
call bun install

:: 6. Create the agintes command
echo 🔗 Setting up 'agintes' command-line interface...
set "BIN_DIR=%USERPROFILE%\.local\bin"
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"

set "CMD_PATH=%BIN_DIR%\agintes.cmd"
echo @echo off > "%CMD_PATH%"
echo set "BUN_INSTALL=%%USERPROFILE%%\.bun" >> "%CMD_PATH%"
echo set "PATH=%%BUN_INSTALL%%\bin;%%PATH%%" >> "%CMD_PATH%"
echo bun run "%%USERPROFILE%%\.agintes-r\packages\cli\src\index.ts" %%* >> "%CMD_PATH%"

:: 7. Add to User PATH if not exists
powershell -NoProfile -Command "$UserPath = [Environment]::GetEnvironmentVariable('PATH', 'User'); if ($UserPath -notmatch [regex]::Escape('%BIN_DIR%')) { [Environment]::SetEnvironmentVariable('PATH', '%BIN_DIR%;' + $UserPath, 'User') }"

echo ======================================================
echo 🎉 Installation Complete!
echo.
echo To start using Agintes R, RESTART your terminal (close this window and open a new one), then type:
echo 👉 agintes --help
echo ======================================================
pause
