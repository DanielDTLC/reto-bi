# Diccionario de KPI

Todos los KPI se calculan en el servidor sobre `decision_categorias` (y `libros` para el KPI 4), con los **filtros activos** (escenario, clasificación, tamaño, rango de precio) y los **umbrales del simulador** (U_R, U_C, N). Consulta: `KPIS` en `backend/app/consultas.py`.

Valores de referencia = escenario base, umbrales originales (3,0 ★ / 5,0 / 5), sin filtros.

| # | KPI | Significado | Fórmula | Unidad | Granularidad y filtros | Referencia | Dirección esperada | Interpretación · responsable · acción |
|---|---|---|---|---|---|---|---|---|
| 1 | **Categorías evaluadas** | Categorías con datos suficientes para aplicar la regla | `COUNT(*) WHERE coincide_b AND n_titulos ≥ N` | categorías | Categoría; todos los filtros; depende de N | 32 de 50 | Estable (más = más cobertura del análisis) | Si baja mucho, la decisión se apoya en pocas categorías. **Analista de datos**: revisar sinónimos de Open Library o bajar N. |
| 2 | **Priorizadas** | Categorías que cumplen la regla completa | `COUNT(*) WHERE elegible AND rating ≥ U_R AND cobertura ≤ U_C` | categorías | Categoría; todos los filtros y umbrales | 8 | Según presupuesto: ni 0 ni todas | Es la lista de compra. **Responsable de compras**: repartir presupuesto entre estas categorías en orden de prioridad. |
| 3 | **Cumplimiento de la regla** | Qué tan exigente es la regla con las categorías evaluadas | `priorizadas / evaluadas × 100` | % | Categoría; todos los filtros | 25,0 % | Moderada (≈ 20–40 %) | Cerca de 0 % la regla es demasiado estricta; cerca de 100 % no discrimina. **Gerente de catálogo**: ajustar umbrales con el simulador. |
| 4 | **Calificación de las priorizadas** | Satisfacción de los clientes con lo que ya hay en las categorías elegidas | `SUM(suma_estrellas) / SUM(n_titulos)` de las priorizadas (= promedio de estrellas de sus libros únicos) | ★ (1–5) | Libro agregado a categoría; filtros y umbrales | 3,27 ★ (catálogo completo: 2,92 ★) | ↑ Más alto es mejor | Confirma que se invierte donde los clientes están satisfechos. **Responsable de compras**: si cae por debajo de U_R + 0,2, revisar las categorías del final de la lista. |
| 5 | **Cobertura mediana de las priorizadas** | Cuánto espacio para crecer tienen las categorías elegidas | `PERCENTILE_CONT(0,5)` de `cobertura` de las priorizadas | títulos / 10 000 obras | Categoría; filtros y umbrales | 1,33 (mediana de las 32 evaluadas: 5,54) | ↓ Más bajo es mejor | Bajo = hay mucha oferta mundial sin representar. **Responsable de compras**: priorizar volumen de compra donde es más baja. |
| 6 | **Variación vs. base** | Cuánto cambia la lista en el escenario activo frente a la base, con los mismos umbrales y filtros | `priorizadas(escenario) − priorizadas(base)` | categorías | Escenario; filtros y umbrales | 0 en base · +1 en `cambio_decision` · 0 en `duplicado` | 0 en datos limpios; ≠ 0 señala sensibilidad | Un cambio por un solo dato indica una decisión frágil. **Analista de datos**: validar el dato que la provoca antes de comprar. |

KPI adicional mostrado en la tarjeta 2: **libros en categorías priorizadas** (`SUM(n_titulos)` de las priorizadas; base = 133 libros, 13,3 % del catálogo).

## Clasificación de cada categoría (colores del tablero)

| Clasificación | Condición | Color |
|---|---|---|
| Priorizada | cumple la regla completa | verde `#0f8a74` |
| Evaluada, no priorizada | elegible, pero falla calificación o cobertura | azul gris `#6b8bb0` |
| Pocos títulos | tiene dato en Open Library pero `n_titulos < N` | gris `#b9c2cc` |
| Sin dato en Open Library | `coincide_b = false` (tema inexistente o < 100 obras) | ocre `#d59a5b` |
