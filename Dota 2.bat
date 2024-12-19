@echo off
title Steam Launcher

:: Config
set path_steam="C:\Program Files (x86)\Steam\steam.exe"
set id_game=570


@echo [SCRIPT]: Start game from Steam under ID %id_game%
start "" %path_steam% -applaunch %id_game%


@echo [SCRIPT]: Wait, while process Steam is not started
:waitForSteam

timeout /t 15 >nul
powershell -command "if ((Get-Process | Where-Object {$_.MainWindowTitle -like '*Steam*'}) -eq $null) {exit 1} else {exit 0}"

if errorlevel 1 (
    timeout /t 10 >nul
    goto waitForSteam
)


@echo [SCRIPT]: Successfully, hide Steam to tray...

powershell -command "(Get-Process | Where-Object {$_.MainWindowTitle -like '*Steam*'}).CloseMainWindow() | Out-Null"