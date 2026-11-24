# Sube el proyecto al repositorio DanielDTLC/reto-bi y sube el proyecto. Resultado en scripts\subir_log.txt
$raiz = Split-Path -Parent $PSScriptRoot
$log = Join-Path $PSScriptRoot 'subir_log.txt'
"=== Subida $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ===" | Out-File $log -Encoding utf8
function L($m) { $m | Out-File $log -Append -Encoding utf8 }
Set-Location $raiz

$git = (Get-Command git -ErrorAction SilentlyContinue).Source
$gh = $null
L "git: $git"; L "gh: $gh"
if (-not $git) { L 'FALTA_GIT'; exit 1 }
L "usuario git: $(& git config --global user.name) <$(& git config --global user.email)>"

if (-not (Test-Path (Join-Path $raiz '.git'))) { & git init -b main 2>&1 | ForEach-Object { L $_ } }
& git add -A 2>&1 | Out-Null
L "archivos a subir: $((& git ls-files).Count)"
$secretos = & git ls-files | Select-String -Pattern '(^|/)\.env$|node_modules|/dist/|\.venv'
if ($secretos) { L "ALTO: hay archivos que no deben subirse: $secretos"; exit 1 }
$msg = "Reto BI: dashboard decisional Catalogo en foco`n`nCo-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`nClaude-Session: https://claude.ai/code/session_01GZxiiGySeerGn2xfD4HJSE"
& git commit -q -m $msg 2>&1 | ForEach-Object { L $_ }
& git branch -M main 2>&1 | Out-Null

$url = 'https://github.com/DanielDTLC/reto-bi'
$creado = $false
if ($gh) {
  & $gh auth status 2>&1 | ForEach-Object { L "gh: $_" }
  if ($LASTEXITCODE -eq 0) {
    & $gh repo create dtdanieldlc/reto-bi --public --description "Catalogo en foco: dashboard decisional (Reto BI) con React, ECharts, FastAPI y PostgreSQL" --source . --remote origin --push 2>&1 | ForEach-Object { L $_ }
    if ($LASTEXITCODE -eq 0) { $creado = $true }
  }
}
if (-not $creado) {
  if (& git remote) { & git remote set-url origin "$url.git" } else { & git remote add origin "$url.git" }
  L "remoto: $(& git remote get-url origin)"
  L 'intentando git push (el repositorio debe existir en GitHub)...'
  & git push -u origin main 2>&1 | ForEach-Object { L $_ }
  if ($LASTEXITCODE -eq 0) { $creado = $true }
}
if ($creado) { L "SUBIDA_OK $url" } else { L 'SUBIDA_FALLO' }
