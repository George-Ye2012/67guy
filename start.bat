@echo off
cd /d D:\67guy
echo Installing dependencies...
call npm install
echo.
echo Starting 67guy...
echo Open http://localhost:3000 in your browser
echo.
node server.js
pause
