@echo off
title TAMVESTA - Akses Publik Cloudflare Tunnel
echo ===================================================
echo   Membuka Akses Publik Online TAMVESTA (Cloudflare)
echo ===================================================
echo.
call npx.cmd -y cloudflared tunnel --url http://localhost:3000
pause
