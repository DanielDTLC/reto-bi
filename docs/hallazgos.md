# Hallazgos analíticos y recomendación

Análisis **descriptivo**: muestra asociaciones en los datos, no causas.

## Hallazgo 1 · Las categorías mejor calificadas no son las que más conviene ampliar

| | |
|---|---|
| **Situación observada** | De las 14 categorías evaluadas con calificación ≥ 3,0 ★, **6 quedan fuera por cobertura alta**. La de mejor calificación, Christian Fiction (4,17 ★, 6 títulos), tiene cobertura de 37,04: la tienda ya tiene 37 títulos por cada 10 000 obras que existen. Young Adult (3,30 ★, 54 títulos) llega a 544,35 porque Open Library registra solo 992 obras en ese tema. |
| **Indicador / visualización** | Mapa de decisión (puntos arriba a la derecha, fuera de la zona verde), tabla de detalle ordenada por calificación, KPI 5. |
| **Valores** | Priorizadas: cobertura mediana 1,33 frente a 5,54 de las 32 evaluadas. Christian Fiction 4,17 ★ / 37,04; Young Adult 3,30 ★ / 544,35; Historical Fiction 3,23 ★ / 33,16; Fantasy 3,08 ★ / 32,09. |
| **Escenario y filtros** | Base · umbrales originales (3,0 / 5,0 / 5) · sin filtros. |
| **Limitaciones** | `work_count` depende de cómo Open Library etiqueta los temas (Young Adult tiene pocas obras etiquetadas, aunque el género es grande). Cuatro categorías usan sinónimos definidos a mano en el ETL. La cobertura cambia con el tiempo (copia del 23/11/2026). |

## Hallazgo 2 · La parte baja de la lista priorizada es frágil

| | |
|---|---|
| **Situación observada** | **6 categorías están a menos de 0,1 ★ del umbral** (entre 2,90 y 2,99): Sequential Art, History, Mystery, Science, Business y Food and Drink. Tres de ellas (History, Science y Business) ya cumplen la condición de cobertura. En el escenario `cambio_decision` basta con que **un solo libro** de History pase de 2 a 3 ★ (suma de estrellas 53 → 54) para que su promedio llegue a 3,00 y entre en el puesto 8, desplazando a Sports and Games, que tiene **exactamente 3,00 ★ con solo 5 títulos** (el mínimo permitido). |
| **Indicador / visualización** | Comparación de escenarios (gráfico de pendiente), ranking de calificación (barras pegadas al umbral), simulador y KPI 6 (+1 en `cambio_decision`). |
| **Valores** | Simulador con U_R = 2,9 → 11 priorizadas (entran History 2,94 ★, Science 2,93 ★ y Business 2,92 ★). Con U_R = 3,3 → 4 priorizadas (Art 3,63, Poetry 3,53, Humor 3,40, Spirituality 3,33). History: cobertura 0,07, la segunda más baja de las evaluadas (después de Biography, 0,05). |
| **Escenario y filtros** | Base y `cambio_decision` · umbrales originales y simulados · sin filtros. |
| **Limitaciones** | Las calificaciones vienen de un portal de práctica de scraping, sin número de reseñas por libro: un promedio de 5 libros pesa igual que uno de 65. No hay ventas ni datos de tiempo para saber si la satisfacción es estable. |

El escenario `duplicado` confirma la otra cara: un registro repetido (Poetry, id 530) **no** cambia nada después de la limpieza (20 filas crudas → 19 títulos, 3,5263 ★, prioridad 2 en ambos escenarios). La fragilidad viene de los datos reales cerca del umbral, no de errores de carga.

## Acción recomendada

| | |
|---|---|
| **Acción** | Ampliar primero **Art, Poetry, Humor y Spirituality** y dejar **Sports and Games, History, Science y Business en observación** hasta reunir más calificaciones (por ejemplo, pedir reseñas a quienes compraron esos libros) antes de comprometer presupuesto. |
| **Quién** | Responsable de compras de la librería, con el analista de datos (que vuelve a correr el ETL cuando haya calificaciones nuevas). |
| **Evidencia** | Las cuatro categorías recomendadas tienen ≥ 3,33 ★ y cobertura ≤ 3,6, y **siguen priorizadas con U_R = 3,3** (simulador). Las cuatro en observación cambian de estado con un solo dato o con 0,1 ★ de diferencia en el umbral (Hallazgo 2). Juntas, las 4 recomendadas suman 43 libros, con calificación promedio de 3,49 ★. |
| **Límite de la recomendación** | Indica dónde la evidencia actual es más sólida. No afirma que comprar más libros de esas categorías aumentará las ventas, porque no hay datos de ventas ni de demanda. |
