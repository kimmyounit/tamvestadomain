@echo off
title TAMVESTA - Server Aplikasi Siswa
cd /d "%~dp0"
echo ========================================================
echo       TAMVESTA - SERVER APLIKASI TAMANSISWA BATAM
echo ========================================================
echo [INFO] Menyalakan server TAMVESTA di port 3000...
echo [INFO] Anti-Mati: Jika server terhenti, akan otomatis restart.
echo ========================================================

:loop
echo [%date% %time%] Memulai server TAMVESTA...
call npm.cmd run dev
echo [%date% %time%] PERINGATAN: Server terhenti. Me-restart dalam 3 detik...
timeout /t 3 /nobreak >nul
goto loop
