-- =====================================================================
-- Reto BI · Consultas SQL independientes de validación
-- Se escriben SIN la CTE del backend (app/consultas.py) para contrastar
-- lo que muestra el dashboard con condiciones equivalentes.
-- Parámetros por defecto: escenario base, U_R = 3.0, U_C = 5.0, N = 5, sin filtros.
-- =====================================================================

-- V1 · KPI «Categorías evaluadas» (dashboard: 32)
SELECT COUNT(*) AS evaluadas
FROM decision_categorias
WHERE escenario = 'base' AND coincide_b AND n_titulos >= 5;

-- V2 · KPI «Priorizadas» (dashboard: 8) y lista en orden
SELECT categoria, rating_promedio, cobertura
FROM decision_categorias
WHERE escenario = 'base' AND coincide_b AND n_titulos >= 5
  AND rating_promedio >= 3.0 AND cobertura <= 5.0
ORDER BY rating_promedio DESC, cobertura ASC;

-- V3 · KPI «Cumplimiento» (dashboard: 25,0 %)
SELECT ROUND(100.0 * SUM(CASE WHEN rating_promedio >= 3.0 AND cobertura <= 5.0 THEN 1 ELSE 0 END)
             / COUNT(*), 1) AS cumplimiento_pct
FROM decision_categorias
WHERE escenario = 'base' AND coincide_b AND n_titulos >= 5;

-- V4 · KPI «Calificación de las priorizadas» desde los LIBROS (dashboard: 3,27)
SELECT ROUND(AVG(l.estrellas)::numeric, 2) AS rating_priorizadas, COUNT(*) AS libros_priorizados
FROM libros l
WHERE l.escenario = 'base' AND NOT l.es_duplicado
  AND l.categoria IN ('Art','Poetry','Humor','Spirituality','Fiction','Music','Religion','Sports and Games');

-- V5 · KPI «Cobertura mediana de las priorizadas» (dashboard: 1,33)
SELECT ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY n_titulos::numeric / work_count * 10000))::numeric, 2)
       AS cobertura_mediana
FROM decision_categorias
WHERE escenario = 'base' AND coincide_b AND n_titulos >= 5
  AND rating_promedio >= 3.0 AND n_titulos::numeric / work_count * 10000 <= 5.0;

-- V6 · KPI «Variación vs. base» en cambio_decision (dashboard: +1)
SELECT escenario, COUNT(*) FILTER (WHERE coincide_b AND n_titulos >= 5
                                     AND rating_promedio >= 3.0 AND cobertura <= 5.0) AS priorizadas
FROM decision_categorias GROUP BY escenario ORDER BY escenario;

-- V7 · Escenarios: los resultados guardados por el ETL coinciden con los esperados
--      (base 8; cambio_decision: History entra 8.ª y Sports and Games pasa a 9.ª; duplicado: 1 duplicado, Poetry sigue 2.ª)
SELECT escenario, categoria, prioridad, rating_promedio, n_filas_crudas, n_duplicados, n_titulos
FROM decision_categorias
WHERE categoria IN ('History','Sports and Games','Poetry')
ORDER BY categoria, escenario;

-- V8 · Simulador: U_R = 2.9 (resto original) sobre la base (dashboard: 11; entran History, Science, Business)
SELECT categoria, rating_promedio, cobertura
FROM decision_categorias
WHERE escenario = 'base' AND coincide_b AND n_titulos >= 5
  AND rating_promedio >= 2.9 AND cobertura <= 5.0
ORDER BY rating_promedio DESC, cobertura;

-- V9 · Simulador: U_C = 40 y N = 3 sobre cambio_decision (comparar con el dashboard)
SELECT COUNT(*) AS priorizadas
FROM decision_categorias
WHERE escenario = 'cambio_decision' AND coincide_b AND n_titulos >= 3
  AND rating_promedio >= 3.0 AND cobertura <= 40;

-- V10 · Filtros: clasificación «priorizada» + tamaño «mediana» (5–19 títulos) en base
SELECT categoria, n_titulos
FROM decision_categorias
WHERE escenario = 'base' AND coincide_b AND n_titulos BETWEEN 5 AND 19
  AND rating_promedio >= 3.0 AND cobertura <= 5.0
ORDER BY rating_promedio DESC;

-- V11 · Filtro de precio £40–£59 en base (categorías y priorizadas)
SELECT COUNT(*) AS categorias,
       COUNT(*) FILTER (WHERE coincide_b AND n_titulos >= 5 AND rating_promedio >= 3.0 AND cobertura <= 5.0) AS priorizadas
FROM decision_categorias
WHERE escenario = 'base' AND precio_promedio BETWEEN 40 AND 59;

-- V12 · Selección sin resultados: precio entre £58 y £58 (dashboard: estado vacío)
SELECT COUNT(*) AS categorias FROM decision_categorias
WHERE escenario = 'base' AND precio_promedio BETWEEN 58 AND 58;

-- V13 · La simulación no escribe: el total de filas y los umbrales guardados no cambian
SELECT escenario, COUNT(*) AS filas, MAX(u_rating) AS u_rating, MAX(u_cobertura) AS u_cobertura,
       SUM(priorizar::int) AS priorizadas_guardadas
FROM decision_categorias GROUP BY escenario ORDER BY escenario;
