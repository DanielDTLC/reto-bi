@echo off
REM Inicia la aplicacion en http://localhost:8000 (cierre esta ventana para detenerla)
cd /d "%~dp0..\backend"
title Catalogo en foco - servidor
".venv\Scripts\python.exe" -m uvicorn app.main:app --port 8000
pause
