@echo off
chcp 65001 >nul
title NetSentinel 0.1v

:: Yonetici Yetkisi Kontrolu
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Renk Tanımlamaları
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "R=%ESC%[0m"
set "C=%ESC%[96m"
set "G=%ESC%[92m"
set "Y=%ESC%[93m"
set "D=%ESC%[90m"
set "W=%ESC%[97m"

:MENU
cls
echo %C%
echo   _   _      _   ____             _   _            _ 
echo  ^| \ ^| ^| ___^| ^|_/ ___^|  ___ _ __ ^| ^|_^(_^) _ __   ___^| ^|
echo  ^|  \^| ^|/ _ \ __\___ \ / _ \ '_ \^| __^| ^| ^| '_ \ / _ \ ^|
echo  ^| ^|\  ^|  __/ ^|_ ___) ^|  __/ ^| ^| ^| ^|_^| ^| ^| ^| ^| ^|  __/ ^|
echo  ^|_^| \_\___^|\__^|____/ \___^|_^| ^|_^|\__^|_^|_^|_^| ^|_^|\___^|_^|
echo %R%
echo  %D%v1.0.0  ^|  Efe E. K. tarafindan hazirlanmistir%R%
echo  %D%GitHub: %W%https://github.com/efevsl/NetSentinel%R%
echo  %D%--------------------------------------------------------%R%
echo.
echo   %C%[1]%R% Internet Bağlantısını Kır
echo   %C%[0]%R% Cikis
echo.
echo  %D%--------------------------------------------------------%R%
set /p "s=%Y%> %R%"

if "%s%"=="1" goto KILL
if "%s%"=="0" exit /b
goto MENU

:KILL
cls
echo.
echo  %Y%[*]%R% Islem baslatildi, servisler durduruluyor...

taskkill /F /T /IM runplugin.exe >nul 2>&1
taskkill /F /T /IM runplugin64.exe >nul 2>&1

echo.
echo  %G%[+]%R% NetSupport Pluginleri basariyla kapatildi.
echo.
echo  %D%Menuye donmek icin bir tusa basin...%R%
pause >nul
goto MENU