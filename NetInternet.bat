```batch
@echo off
chcp 65001 >nul
title NetSentinel 1.0.1v

:: 1. Yönetici Yetkisi Kontrolü (UAC)
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
echo  ^|  ^| ^|/ _ \ __\___ \ / _ \ '_ ^| __^| ^| ^| '_ \ / _ \ ^|
echo  ^| ^|\  ^|  __/ ^|_ ___) ^|  __/ ^| ^| ^| ^|_^| ^| ^| ^| ^|  __/ ^|
echo  ^|_^| \_\___^|\__^|____/ \___^|_^| ^|_^|\__^|_^|_^|_^| ^|_^|\___^|_^|
echo %R%
echo  %D%v1.0.1  ^|  Efe E. K. tarafindan hazirlanmistir%R%
echo  %D%GitHub: %W%https://github.com/efevsl/NetSentinel%R%
echo  %D%--------------------------------------------------------%R%
echo.
echo   %C%[1]%R% Internet Bağlantısını Kır (Sistem Yetkisi ile)
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
echo  %Y%[*]%R% İşlem başlatıldı, yüksek yetkili servisler durduruluyor...

:: Sistem yetkisiyle çalıştırmak için geçici görev oluşturma
schtasks /create /tn "KillPluginsTask" /tr "cmd /c taskkill /F /T /IM runplugin.exe & taskkill /F /T /IM runplugin64.exe" /sc once /st 00:00 /ru "NT AUTHORITY\SYSTEM" /rl HIGHEST /f >nul 2>&1

:: Görevi anında tetikle
schtasks /run /tn "KillPluginsTask" >nul 2>&1

:: Temizlik için kısa bir bekleme
timeout /t 1 /nobreak >nul

:: Geçici görevi sil
schtasks /delete /tn "KillPluginsTask" /f >nul 2>&1

echo.
echo  %G%[+]%R% NetSupport Pluginleri sistem yetkisiyle başarıyla kapatıldı.
echo.
echo  %D%Menüye dönmek için bir tuşa basın...%R%
pause >nul
goto MENU
```