"""Capa de procesamiento analítico: consultas SQL parametrizadas.

La regla de decisión del Reto ETL se reproduce aquí en SQL con umbrales recibidos
como parámetros (:u_rating, :u_cobertura, :min_titulos). Nunca se escribe en la
base: la simulación es solo una consulta con otros parámetros.
"""

# --- Clasificación de cada categoría con los umbrales recibidos -------------
CTE_CLASIFICACION = """
clasif AS (
    SELECT d.escenario, d.categoria, d.slug, d.n_filas_crudas, d.n_duplicados, d.n_titulos,
           d.suma_estrellas, d.rating_promedio, d.precio_promedio, d.work_count, d.coincide_b,
           d.cobertura,
           d.priorizar  AS priorizar_original,
           d.prioridad  AS prioridad_original,
           d.u_rating   AS u_rating_original,
           d.u_cobertura AS u_cobertura_original,
           d.min_titulos AS min_titulos_original,
           (d.coincide_b AND d.n_titulos >= :min_titulos)                    AS elegible,
           (d.coincide_b AND d.n_titulos >= :min_titulos
              AND d.rating_promedio >= :u_rating
              AND d.cobertura <= :u_cobertura)                                 AS priorizar
    FROM decision_categorias d
),
clasif2 AS (
    SELECT c.*,
           CASE WHEN c.priorizar THEN
                ROW_NUMBER() OVER (PARTITION BY c.escenario, c.priorizar
                                   ORDER BY c.rating_promedio DESC, c.cobertura ASC)
           END AS prioridad,
           CASE WHEN NOT c.coincide_b THEN 'sin_coincidencia'
                WHEN NOT c.elegible   THEN 'pocos_titulos'
                WHEN c.priorizar      THEN 'priorizada'
                ELSE 'no_priorizada' END AS clasificacion,
           CASE WHEN c.n_titulos < 5 THEN 'pequena'
                WHEN c.n_titulos < 20 THEN 'mediana'
                ELSE 'grande' END AS tamano
    FROM clasif c
)
"""

FILTROS = """
WHERE escenario = :escenario
  AND (CAST(:clasificaciones AS TEXT) IS NULL OR clasificacion = ANY(string_to_array(:clasificaciones, ',')))
  AND (CAST(:tamanos AS TEXT) IS NULL OR tamano = ANY(string_to_array(:tamanos, ',')))
  AND precio_promedio BETWEEN :precio_min AND :precio_max
"""

CATEGORIAS = f"""
WITH {CTE_CLASIFICACION}
SELECT categoria, slug, n_filas_crudas, n_duplicados, n_titulos, suma_estrellas,
       rating_promedio::float AS rating_promedio, precio_promedio::float AS precio_promedio,
       work_count, coincide_b, cobertura::float AS cobertura,
       elegible, priorizar, prioridad, clasificacion, tamano,
       priorizar_original, prioridad_original
FROM clasif2
{FILTROS}
ORDER BY prioridad NULLS LAST, rating_promedio DESC, categoria
"""

# KPIs sobre el mismo conjunto filtrado
KPIS = f"""
WITH {CTE_CLASIFICACION},
f AS (SELECT * FROM clasif2 {FILTROS})
SELECT
  COUNT(*)                                             AS categorias_filtradas,
  COUNT(*) FILTER (WHERE elegible)                     AS evaluadas,
  COUNT(*) FILTER (WHERE priorizar)                    AS priorizadas,
  ROUND(100.0 * COUNT(*) FILTER (WHERE priorizar)
        / NULLIF(COUNT(*) FILTER (WHERE elegible), 0), 1)::float AS cumplimiento_pct,
  ROUND(SUM(suma_estrellas) FILTER (WHERE priorizar)::numeric
        / NULLIF(SUM(n_titulos) FILTER (WHERE priorizar), 0), 2)::float AS rating_priorizadas,
  ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY cobertura)
        FILTER (WHERE priorizar))::numeric, 2)::float AS cobertura_mediana_priorizadas,
  COALESCE(SUM(n_titulos) FILTER (WHERE priorizar), 0) AS libros_priorizados,
  COALESCE(SUM(n_titulos), 0)                          AS libros_filtrados
FROM f
"""

# Priorizadas en el escenario base con los mismos umbrales y filtros (para la variación)
PRIORIZADAS_BASE = f"""
WITH {CTE_CLASIFICACION}
SELECT COUNT(*) FILTER (WHERE priorizar) AS priorizadas
FROM clasif2
{FILTROS.replace(':escenario', "'base'")}
"""

# Composición de estrellas por categoría (libros limpios) para las categorías filtradas
COMPOSICION = f"""
WITH {CTE_CLASIFICACION},
f AS (SELECT categoria, rating_promedio, prioridad FROM clasif2 {FILTROS} AND elegible)
SELECT l.categoria, l.estrellas, COUNT(*) AS libros
FROM v_libros_limpios l JOIN f USING (categoria)
WHERE l.escenario = :escenario
GROUP BY l.categoria, l.estrellas, f.rating_promedio, f.prioridad
ORDER BY f.prioridad NULLS LAST, f.rating_promedio DESC, l.categoria, l.estrellas
"""

# Comparación escenario vs. base (mismos umbrales, sin filtros: población completa de cada variante)
COMPARACION = f"""
WITH {CTE_CLASIFICACION},
b AS (SELECT * FROM clasif2 WHERE escenario = 'base'),
e AS (SELECT * FROM clasif2 WHERE escenario = :escenario)
SELECT e.categoria,
       b.prioridad AS pos_base, e.prioridad AS pos_escenario,
       b.rating_promedio::float AS rating_base, e.rating_promedio::float AS rating_escenario,
       b.cobertura::float AS cobertura_base, e.cobertura::float AS cobertura_escenario,
       b.n_titulos AS titulos_base, e.n_titulos AS titulos_escenario,
       e.n_filas_crudas AS filas_crudas_escenario, e.n_duplicados AS duplicados_escenario,
       b.suma_estrellas AS estrellas_base, e.suma_estrellas AS estrellas_escenario,
       CASE WHEN b.priorizar AND NOT e.priorizar THEN 'sale'
            WHEN NOT b.priorizar AND e.priorizar THEN 'entra'
            WHEN b.priorizar AND e.priorizar AND e.prioridad < b.prioridad THEN 'sube'
            WHEN b.priorizar AND e.priorizar AND e.prioridad > b.prioridad THEN 'baja'
            WHEN b.rating_promedio <> e.rating_promedio OR b.n_titulos <> e.n_titulos
                 OR e.n_duplicados > 0 THEN 'datos_cambian'
            ELSE 'igual' END AS cambio
FROM e JOIN b USING (categoria)
ORDER BY COALESCE(e.prioridad, b.prioridad, 999), e.categoria
"""

LIBROS_CATEGORIA = """
SELECT id_libro, titulo, precio_gbp::float AS precio_gbp, estrellas, disponibilidad, es_duplicado
FROM libros
WHERE escenario = :escenario AND categoria = :categoria
ORDER BY es_duplicado DESC, estrellas DESC, precio_gbp
"""

META_ESCENARIOS = """
SELECT escenario,
       MAX(u_rating)::float AS u_rating, MAX(u_cobertura)::float AS u_cobertura,
       MAX(min_titulos) AS min_titulos,
       COUNT(*) AS categorias, SUM(n_filas_crudas) AS filas_crudas,
       SUM(n_duplicados) AS duplicados, SUM(n_titulos) AS libros_unicos,
       MAX(cargado_en) AS cargado_en
FROM decision_categorias
GROUP BY escenario
ORDER BY CASE escenario WHEN 'base' THEN 1 WHEN 'cambio_decision' THEN 2 ELSE 3 END
"""

META_RANGOS = """
SELECT FLOOR(MIN(precio_promedio))::float AS precio_min, CEIL(MAX(precio_promedio))::float AS precio_max,
       MIN(rating_promedio)::float AS rating_min, MAX(rating_promedio)::float AS rating_max,
       MAX(cobertura)::float AS cobertura_max
FROM decision_categorias
"""
