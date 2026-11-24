@echo off
REM Crea el repo publico dtdanieldlc/reto-bi y sube el proyecto. Resultado en scripts\subir_log.txt
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0subir_github.ps1"
echo.
type "%~dp0subir_log.txt"
pause
