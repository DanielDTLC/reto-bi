# Validación de resultados

Cada verificación compara lo que muestra el dashboard (o su API) con una **consulta SQL independiente** de `database/validaciones.sql`. Esas consultas no reutilizan la CTE del backend: escriben la condición directamente sobre las tablas.

- Fecha de ejecución: 24/11/2026, PostgreSQL 16, datos de `database/datos.sql`.
- Pruebas automáticas equivalentes: `backend/tests/test_api.py` (8 pruebas, todas aprobadas: `pytest -q` → `8 passed`).

| ID | Condición evaluada | Resultado esperado (SQL) | Resultado observado (dashboard) | Evidencia | Estado |
|---|---|---|---|---|---|
| V1 | KPI 1 · evaluadas, base, umbrales originales | 32 | 32 | `validaciones.sql` V1 · `screenshots/01_vista_general.png` | ✅ |
| V2 | KPI 2 · priorizadas y orden | 8: Art, Poetry, Humor, Spirituality, Fiction, Music, Religion, Sports and Games | 8, mismo orden en la tabla de detalle | V2 · `00_dashboard_completo.png` | ✅ |
| V3 | KPI 3 · cumplimiento | 25,0 % | 25,0 % | V3 · `01_vista_general.png` | ✅ |
| V4 | KPI 4 · calificación de las priorizadas, calculada desde la tabla `libros` | 3,27 ★ (133 libros) | 3,27 ★ · «133 libros» | V4 · `01_vista_general.png` | ✅ |
| V5 | KPI 5 · cobertura mediana de las priorizadas | 1,33 | 1,33 | V5 · `01_vista_general.png` | ✅ |
| V6 | KPI 6 · variación vs. base en `cambio_decision` | base 8 · cambio 9 → +1 | +1 | V6 · API `/api/tablero?escenario=cambio_decision` | ✅ |
| V7 | Escenarios = resultados del Reto ETL | `cambio_decision`: History entra 8.ª (2,9444 → 3,0000 ★) y Sports and Games pasa a 9.ª. `duplicado`: Poetry 20 filas crudas, 1 duplicado, 19 títulos, 3,5263 ★, prioridad 2 | Los mismos valores en la comparación de escenarios | V7 · `03_escenario_cambio.png`, `04_escenario_duplicado.png` | ✅ |
| V8 | Simulador · U_R = 2,9 (U_C = 5, N = 5), base | 11 priorizadas; entran History, Science y Business | 8 → 11; entran History, Science, Business; salen 0 | V8 · `02_simulador_ur_2_9.png` | ✅ |
| V9 | Simulador · U_C = 40 y N = 3, `cambio_decision` | 14 | 14 | V9 · API | ✅ |
| V10 | Filtros · clasificación «Priorizada» + tamaño «Mediana (5–19)» | 7 categorías (todas menos Fiction, que tiene 65 títulos) | 7, las mismas | V10 · `06_filtros_priorizada_mediana.png` | ✅ |
| V11 | Filtro · precio promedio £40–£59 | 8 categorías, 1 priorizada | 8 categorías, 1 priorizada | V11 · API | ✅ |
| V12 | Selección sin resultados · precio £58–£58 | 0 categorías | Estado vacío «Ninguna categoría cumple estos filtros» con botón Restablecer; KPIs en 0 y «—» | V12 · `07_sin_resultados.png` | ✅ |
| V13 | El simulador no escribe en la base | Después de simular: 50 filas por escenario, umbrales guardados 3,00 / 5,00 y priorizadas guardadas 8 / 9 / 8 | Sin cambios | V13 | ✅ |

## Salida de las consultas (extracto)

```text
V1  evaluadas = 32
V3  cumplimiento_pct = 25.0
V4  rating_priorizadas = 3.27 | libros_priorizados = 133
V5  cobertura_mediana = 1.33
V6  base 8 | cambio_decision 9 | duplicado 8
V7  cambio_decision | History          | prioridad 8 | 3.0000 | 18 filas | 0 dup | 18
    cambio_decision | Sports and Games | prioridad 9 | 3.0000 |  5 filas | 0 dup |  5
    duplicado       | Poetry           | prioridad 2 | 3.5263 | 20 filas | 1 dup | 19
V8  11 filas: … Sports and Games, History, Science, Business
V9  priorizadas = 14
V11 categorias = 8 | priorizadas = 1
V12 categorias = 0
V13 base 50 3.00 5.00 8 | cambio_decision 50 3.00 5.00 9 | duplicado 50 3.00 5.00 8
```

## Comportamiento de filtros y visualizaciones

- Al cambiar escenario, filtros o umbrales, **KPIs, mapa, ranking, composición, tabla y simulador** se recalculan con una sola consulta al servidor (comprobado con la API y en las capturas 01, 02 y 06).
- La comparación de escenarios usa los umbrales del simulador y siempre toma la **población completa** de cada variante, porque comparar escenarios filtrados de forma distinta mezclaría poblaciones.
- Parámetros no válidos (clasificación inexistente, U_R = 9, escenario desconocido) responden **422** y el frontend muestra el mensaje de error con «Reintentar». Una categoría inexistente responde **404**.
