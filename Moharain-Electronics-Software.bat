@echo off
title Moharain Electronics Software
set "APP_HTML=%~dp0Moharain-Electronics-Software.html"
if not exist "%APP_HTML%" set "APP_HTML=%~dp0index.html"
set "APP_URL=file:///%APP_HTML:\=/%"
where msedge >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    start "" msedge --app="%APP_URL%" --window-size=1400,900
    exit /b 0
)
where chrome >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    start "" chrome --app="%APP_URL%" --window-size=1400,900
    exit /b 0
)
start "" "%APP_HTML%"
exit /b 0
