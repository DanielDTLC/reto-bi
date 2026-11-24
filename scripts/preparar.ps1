# Prepara el proyecto en Windows: .env, base de datos reto_bi, backend, pruebas y frontend.
# Escribe el resultado en scripts\preparar_log.txt (sin mostrar contrasenas).
$ErrorActionPreference = 'Continue'
$raiz = Split-Path -Parent $PSScriptRoot
$log = Join-Path $PSScriptRoot 'preparar_log.txt'
"=== Preparacion $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ===" | Out-File $log -Encoding utf8
function L($m) { $m | Out-File $log -Append -Encoding utf8 }
function Paso($n) { L ""; L "### $n" }

# 1. Herramientas
Paso 'Herramientas'
$py = (Get-Command python -ErrorAction SilentlyContinue).Source
$npm = (Get-Command npm.cmd -ErrorAction SilentlyContinue).Source
$psql = (Get-Command psql -ErrorAction SilentlyContinue).Source
if (-not $psql) {
  $psql = Get-ChildItem 'C:\Program Files\PostgreSQL\*\bin\psql.exe' -ErrorAction SilentlyContinue |
          Sort-Object FullName -Descending | Select-Object -First 1 -ExpandProperty FullName
}
L "python: $py"; if ($py) { L (& python --version 2>&1) }
L "npm: $npm"; if ($npm) { L "node $(& node --version 2>&1) / npm $(& npm.cmd --version 2>&1)" }
L "psql: $psql"
if (-not $py -or -not $npm -or -not $psql) { L 'FALTA_HERRAMIENTA'; exit 1 }

# 2. .env (toma la conexion del Reto ETL y usa la base reto_bi)
Paso '.env'
$envEtl = Join-Path (Split-Path -Parent $raiz) 'Reto_ETL_DeLaCruz_Daniel\reto_etl\.env'
$envBi = Join-Path $raiz '.env'
if (-not (Test-Path $envBi)) {
  if (Test-Path $envEtl) {
    $lineas = Get-Content $envEtl | Where-Object { $_ -match '^\s*PG' -and $_ -notmatch '^\s*PGDATABASE' }
    ($lineas + 'PGDATABASE=reto_bi') | Out-File $envBi -Encoding ascii
    L ".env creado a partir del .env del Reto ETL (PGDATABASE=reto_bi)"
  } else { L "NO_HAY_ENV_ETL: cree reto-bi\.env a partir de .env.example"; exit 1 }
} else { L ".env ya existia (no se modifica)" }
$vars = @{}
Get-Content $envBi | ForEach-Object { if ($_ -match '^\s*([A-Z_]+)\s*=\s*(.*)$') { $vars[$matches[1]] = $matches[2].Trim() } }
foreach ($k in 'PGHOST','PGPORT','PGUSER','PGPASSWORD') { if ($vars[$k]) { Set-Item "env:$k" $vars[$k] } }
L "conexion: host=$($vars.PGHOST) port=$($vars.PGPORT) user=$($vars.PGUSER) db=$($vars.PGDATABASE)"

# 3. Base de datos
Paso 'Base de datos'
$db = $vars.PGDATABASE
$existe = (& $psql -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$db'" 2>&1)
L "existe base ${db}: $existe"
if ($LASTEXITCODE -ne 0) { L 'ERROR_CONEXION_POSTGRES'; exit 1 }
if ("$existe".Trim() -ne '1') { L (& $psql -d postgres -c "CREATE DATABASE $db" 2>&1) }
$tieneLibros = (& $psql -d $db -tAc "SELECT to_regclass('public.libros') IS NOT NULL" 2>&1)
if ("$tieneLibros".Trim() -ne 't') {
  L 'restaurando database\datos.sql ...'
  & $psql -d $db -q -v ON_ERROR_STOP=1 -f (Join-Path $raiz 'database\datos.sql') 2>&1 | Select-Object -Last 5 | ForEach-Object { L $_ }
} else { L 'la base ya tenia los datos (no se restaura)' }
L (& $psql -d $db -tAc "SELECT 'decision_categorias=' || (SELECT count(*) FROM decision_categorias) || ' libros=' || (SELECT count(*) FROM libros)" 2>&1)

# 4. Backend
Paso 'Backend'
$back = Join-Path $raiz 'backend'
if (-not (Test-Path (Join-Path $back '.venv'))) { & python -m venv (Join-Path $back '.venv') 2>&1 | ForEach-Object { L $_ } }
$vpy = Join-Path $back '.venv\Scripts\python.exe'
& $vpy -m pip install -q --disable-pip-version-check -r (Join-Path $back 'requirements.txt') 2>&1 | Select-Object -Last 5 | ForEach-Object { L $_ }
L "pip: codigo $LASTEXITCODE"

# 5. Pruebas
Paso 'Pruebas (pytest)'
Push-Location $back
& $vpy -m pytest -q 2>&1 | Select-Object -Last 8 | ForEach-Object { L $_ }
Pop-Location

# 6. Frontend
Paso 'Frontend'
Push-Location (Join-Path $raiz 'frontend')
& npm.cmd install --no-audit --no-fund 2>&1 | Select-Object -Last 4 | ForEach-Object { L $_ }
& npm.cmd run build 2>&1 | Select-Object -Last 4 | ForEach-Object { L $_ }
L "build: codigo $LASTEXITCODE"
Pop-Location

L ''; L 'PREPARACION_TERMINADA'
