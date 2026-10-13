@echo off
title Moharain Electronics Marmat Center - Software Updater
color 0A
echo ============================================================================
echo   MOHARAIN ELECTRONICS MARMAT CENTER (Dhangadhi, Hasanpur-5)
echo   1-Click Software Update Utility for Any Windows PC
echo ============================================================================
echo.

set "NEW_HTML=%~dp0index.html"
if not exist "%NEW_HTML%" (
    echo [ERROR] New "index.html" update file not found in this folder!
    pause
    exit /b 1
)

set "UPDATED=0"

:: Check 1: Inno Setup 64-bit Program Files
if exist "%ProgramFiles%\MoharainElectronicsCenter\index.html" (
    echo [1/3] Found installation in: %ProgramFiles%\MoharainElectronicsCenter
    copy /y "%NEW_HTML%" "%ProgramFiles%\MoharainElectronicsCenter\index.html" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] Successfully updated %ProgramFiles%\MoharainElectronicsCenter\index.html
        set "UPDATED=1"
    )
)

:: Check 2: Inno Setup 32-bit Program Files (x86)
if exist "%ProgramFiles(x86)%\MoharainElectronicsCenter\index.html" (
    echo [2/3] Found installation in: %ProgramFiles(x86)%\MoharainElectronicsCenter
    copy /y "%NEW_HTML%" "%ProgramFiles(x86)%\MoharainElectronicsCenter\index.html" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] Successfully updated %ProgramFiles(x86)%\MoharainElectronicsCenter\index.html
        set "UPDATED=1"
    )
)

:: Check 3: LocalAppData Installation Directory
if exist "%LOCALAPPDATA%\MoharainElectronicsCenter\index.html" (
    echo [3/3] Found installation in: %LOCALAPPDATA%\MoharainElectronicsCenter
    copy /y "%NEW_HTML%" "%LOCALAPPDATA%\MoharainElectronicsCenter\index.html" >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] Successfully updated %LOCALAPPDATA%\MoharainElectronicsCenter\index.html
        set "UPDATED=1"
    )
)

if "%UPDATED%"=="1" (
    echo.
    echo ============================================================================
    echo   UPDATE COMPLETE!
    echo   All new features & fixes are installed.
    echo   NOTE: All your saved inventory, stock, and repair data remain 100%% safe!
    echo ============================================================================
) else (
    echo.
    echo [NOTICE] Existing installation folder was not detected automatically.
    echo You can run "Moharain-Electronics-Setup.exe" to install the update.
)

echo.
pause
