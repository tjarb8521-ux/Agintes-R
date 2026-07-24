@echo off
setlocal EnableDelayedExpansion

echo ======================================================
echo 🗑️ Uninstalling Agintes R (Multi-Agent Swarm Orchestrator)
echo ======================================================
echo.
echo This will remove the Agintes R source code and the 'agintes' command from your system.
echo It will NOT remove Bun (as you may need it for other projects).
echo.
pause

:: 1. Remove the installation directory (.agintes-r)
set "INSTALL_DIR=%USERPROFILE%\.agintes-r"
if exist "%INSTALL_DIR%" (
    echo 🧹 Removing Agintes R files from "%INSTALL_DIR%"...
    rmdir /s /q "%INSTALL_DIR%"
    if exist "%INSTALL_DIR%" (
        echo ❌ Failed to fully remove the directory. Close any terminals using it and try again.
    ) else (
        echo ✅ Source code removed successfully.
    )
) else (
    echo ℹ️ Agintes R source directory not found. Already removed.
)

:: 2. Remove the command executable (agintes.cmd)
set "CMD_PATH=%USERPROFILE%\.local\bin\agintes.cmd"
if exist "%CMD_PATH%" (
    echo 🧹 Removing 'agintes' command...
    del /f /q "%CMD_PATH%"
    echo ✅ Command removed successfully.
) else (
    echo ℹ️ 'agintes' command not found.
)

:: 3. Clean up any leftover ZIP files
set "ZIP_PATH=%USERPROFILE%\agintes-r-main.zip"
if exist "%ZIP_PATH%" (
    del /f /q "%ZIP_PATH%"
)
set "EXTRACT_DIR=%USERPROFILE%\Agintes-R-main"
if exist "%EXTRACT_DIR%" (
    rmdir /s /q "%EXTRACT_DIR%"
)

echo.
echo ======================================================
echo ✨ Uninstallation Complete!
echo Agintes R has been completely removed from your system.
echo ======================================================
pause
