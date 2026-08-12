@echo off
title 67guy - Free Tunnel
cd /d D:\67guy

echo ===========================================
echo   67guy 免费公网部署
echo ===========================================
echo.

:: Check if server is already running
echo [1/2] 检查本地服务...
curl -s -o NUL http://localhost:3000/ 2>NUL
if errorlevel 1 (
    echo   启动本地服务...
    start "67guy-Server" /MIN cmd /c "node server.js"
    timeout /t 3 /nobreak >NUL
    echo   服务已启动
) else (
    echo   服务已在运行
)

:: Start tunnel
echo.
echo [2/2] 启动免费隧道 (localhost.run)...
echo.
echo   公网地址会在下方显示，按 Ctrl+C 可随时停止
echo   每次启动地址会变，这是正常的 ^(免费版限制^)
echo ===========================================
echo.

ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=30 -R 80:localhost:3000 nokey@localhost.run

pause
