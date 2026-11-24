@echo off
REM Prepara todo (base de datos, dependencias, pruebas y frontend). Resultado en scripts\preparar_log.txt
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0preparar.ps1"
echo.
echo Listo. Revise scripts\preparar_log.txt
timeout /t 5
