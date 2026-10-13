@echo off
title Moharain Electronics Marmat Center - Desktop Software Installer
color 0B
echo ============================================================================
echo   MOHARAIN ELECTRONICS MARMAT CENTER (Dhangadhi, Hasanpur-5)
echo   Desktop Software Installer for Windows
echo ============================================================================
echo.

set "INSTALL_DIR=%LOCALAPPDATA%\MoharainElectronicsCenter"
set "SOURCE_DIR=%~dp0src\1-Presentation\ElectronicsInventory.RichClient\Views"
if not exist "%SOURCE_DIR%\index.html" set "SOURCE_DIR=%~dp0"

echo [1/4] Creating installation directory at:
echo       %INSTALL_DIR%
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

echo [2/4] Copying software files...
copy /Y "%SOURCE_DIR%\index.html" "%INSTALL_DIR%\index.html" >nul
if exist "%SOURCE_DIR%\manifest.json" copy /Y "%SOURCE_DIR%\manifest.json" "%INSTALL_DIR%\manifest.json" >nul
if exist "%SOURCE_DIR%\sw.js" copy /Y "%SOURCE_DIR%\sw.js" "%INSTALL_DIR%\sw.js" >nul
if exist "%SOURCE_DIR%\icon.svg" copy /Y "%SOURCE_DIR%\icon.svg" "%INSTALL_DIR%\icon.svg" >nul

:: Create standalone launcher inside INSTALL_DIR
set "LAUNCHER=%INSTALL_DIR%\Launch-Moharain-Electronics.bat"
(
echo @echo off
echo set "APP_HTML=%%~dp0index.html"
echo set "APP_URL=file:///%%APP_HTML:\=/%%"
echo if exist "%%ProgramFiles(x86)%%\Microsoft\Edge\Application\msedge.exe" ^(
echo     start "" "%%ProgramFiles(x86)%%\Microsoft\Edge\Application\msedge.exe" --app="%%APP_URL%%" --window-size=1400,900
echo     exit /b 0
echo ^)
echo if exist "%%ProgramFiles%%\Microsoft\Edge\Application\msedge.exe" ^(
echo     start "" "%%ProgramFiles%%\Microsoft\Edge\Application\msedge.exe" --app="%%APP_URL%%" --window-size=1400,900
echo     exit /b 0
echo ^)
echo if exist "%%ProgramFiles%%\Google\Chrome\Application\chrome.exe" ^(
echo     start "" "%%ProgramFiles%%\Google\Chrome\Application\chrome.exe" --app="%%APP_URL%%" --window-size=1400,900
echo     exit /b 0
echo ^)
echo start "" "%%APP_HTML%%"
) > "%LAUNCHER%"

echo [3/4] Creating Desktop and Start Menu Shortcuts...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$WshShell = New-Object -ComObject WScript.Shell; ^
   $DesktopPath = [Environment]::GetFolderPath('Desktop'); ^
   $StartMenuPath = [Environment]::GetFolderPath('Programs'); ^
   $Shortcut1 = $WshShell.CreateShortcut((Join-Path $DesktopPath 'Moharain Electronics Marmat Center.lnk')); ^
   $Shortcut1.TargetPath = '%LAUNCHER%'; ^
   $Shortcut1.WorkingDirectory = '%INSTALL_DIR%'; ^
   $Shortcut1.Description = 'Moharain Electronics Marmat Center - Inventory & Repair Software'; ^
   $Shortcut1.IconLocation = 'shell32.dll,21'; ^
   $Shortcut1.Save(); ^
   $Shortcut2 = $WshShell.CreateShortcut((Join-Path $StartMenuPath 'Moharain Electronics Marmat Center.lnk')); ^
   $Shortcut2.TargetPath = '%LAUNCHER%'; ^
   $Shortcut2.WorkingDirectory = '%INSTALL_DIR%'; ^
   $Shortcut2.Description = 'Moharain Electronics Marmat Center - Inventory & Repair Software'; ^
   $Shortcut2.IconLocation = 'shell32.dll,21'; ^
   $Shortcut2.Save();"

echo [4/4] Launching Moharain Electronics Marmat Center Software...
call "%LAUNCHER%"

echo.
echo ============================================================================
echo   INSTALLATION COMPLETE!
echo   A shortcut "Moharain Electronics Marmat Center" has been placed on your
echo   Desktop and in your Windows Start Menu.
echo ============================================================================
timeout /t 4
exit /b 0
