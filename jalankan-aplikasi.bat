@echo off
title TAMVESTA - Tamansiswa Batam
echo ===================================================
echo   Menjalankan Aplikasi TAMVESTA - Tamansiswa Batam
echo ===================================================
echo.
cd /d "%~dp0"
call npm.cmd run dev
pause
