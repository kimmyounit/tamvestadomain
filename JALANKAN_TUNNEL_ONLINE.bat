@echo off
title TAMVESTA - Cloudflare Online Tunnel
cd /d "%~dp0"
echo ========================================================
echo       TAMVESTA - ONLINE CLOUDFLARE TUNNEL (24/7)
echo ========================================================
echo [INFO] Menghubungkan localhost:3000 ke internet publik...
echo [INFO] Anti-Mati: Tunnel akan otomatis reconnect jika internet terputus.
echo ========================================================

:tunnel_loop
echo [%date% %time%] Mengaktifkan Cloudflare Tunnel...
call npx.cmd -y cloudflared tunnel --url http://localhost:3000
echo [%date% %time%] Koneksi tunnel terputus. Menghubungkan kembali dalam 3 detik...
timeout /t 3 /nobreak >nul
goto tunnel_loop
