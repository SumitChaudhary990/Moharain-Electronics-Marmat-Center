@echo off
title Moharain Electronics Marmat Center - Software Launcher
set "APP_HTML=%~dp0src\1-Presentation\ElectronicsInventory.RichClient\Views\index.html"
if not exist "%APP_HTML%" set "APP_HTML=%~dp0index.html"

:: Convert backslashes to forward slashes for file:// URI
set "APP_URL=file:///%APP_HTML:\=/%"

:: Try Microsoft Edge in standalone Desktop App mode first
where msedge >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    start "" msedge --app="%APP_URL%" --window-size=1400,900
    exit /b 0
)

if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app="%APP_URL%" --window-size=1400,900
    exit /b 0
)

if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app="%APP_URL%" --window-size=1400,900
    exit /b 0
)

:: Try Google Chrome in standalone Desktop App mode
where chrome >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    start "" chrome --app="%APP_URL%" --window-size=1400,900
    exit /b 0
)

if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app="%APP_URL%" --window-size=1400,900
    exit /b 0
)

:: Fallback to default system handler
start "" "%APP_HTML%"
exit /b 0
