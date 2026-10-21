@echo off
title TAMVESTA - Master Launcher
cd /d "%~dp0"
echo ========================================================
echo       TAMVESTA - MEMULAI SERVER & TUNNEL PUBLIK
echo ========================================================
echo 1. Menjalankan Server Lokal (Port 3000)...
start "TAMVESTA Server" cmd /k "%~dp0JALANKAN_TAMVESTA_SERVER.bat"
timeout /t 2 /nobreak >nul
echo 2. Menjalankan Cloudflare Online Tunnel...
start "TAMVESTA Tunnel Online" cmd /k "%~dp0JALANKAN_TUNNEL_ONLINE.bat"
echo ========================================================
echo Selesai! Server dan Link Online telah aktif.
echo Jangan tutup kedua jendela terminal tersebut agar server tidak mati.
echo ========================================================
pause
