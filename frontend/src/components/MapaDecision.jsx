import Grafico, { BASE_GRAFICO } from './Grafico'
import { CLASIF, num } from '../formato'

// Dispersión rating × cobertura: muestra la regla de decisión completa en un solo gráfico.
export default function MapaDecision({ categorias, umbrales, onSeleccion }) {
  const puntos = categorias.filter((c) => c.cobertura !== null && c.cobertura > 0)
  const ur = umbrales.u_rating
  const uc = umbrales.u_cobertura
  const series = Object.entries(CLASIF).map(([clave, o]) => ({
    name: o.etiqueta,
    type: 'scatter',
    data: puntos.filter((c) => c.clasificacion === clave).map((c) => ({
      value: [c.rating_promedio, c.cobertura, c.n_titulos],
      name: c.categoria,
      c,
    })),
    symbolSize: (v) => Math.max(9, Math.min(34, Math.sqrt(v[2]) * 4)),
    itemStyle: { color: o.color, opacity: 0.88, borderColor: '#fff', borderWidth: 1 },
    label: {
      show: clave === 'priorizada', position: 'right', fontSize: 11, color: '#0f2233',
      formatter: (p) => p.name,
    },
    labelLayout: { hideOverlap: true },
    emphasis: { focus: 'self', label: { show: true } },
  }))
  // Zona que cumple la regla (rating ≥ umbral y cobertura ≤ umbral)
  series.push({
    name: 'Zona de priorización', type: 'scatter', data: [],
    markArea: {
      silent: true, itemStyle: { color: 'rgba(15,138,116,0.08)' },
      data: [[{ xAxis: ur, yAxis: 0.01 }, { xAxis: 5, yAxis: uc }]],
    },
    markLine: {
      silent: true, symbol: 'none', lineStyle: { color: '#0f2233', type: 'dashed', width: 1.2 },
      label: { color: '#0f2233', fontSize: 11 },
      data: [
        { xAxis: ur, label: { formatter: `rating ≥ ${num(ur, 1)}`, position: 'end' } },
        { yAxis: uc, label: { formatter: `cobertura ≤ ${num(uc, 1)}`, position: 'insideEndTop' } },
      ],
    },
  })

  const opcion = {
    ...BASE_GRAFICO,
    grid: { ...BASE_GRAFICO.grid, top: 40, right: 90, bottom: 26, left: 18 },
    legend: { top: 0, left: 0, itemWidth: 10, itemHeight: 10, textStyle: { fontSize: 11 },
      data: Object.values(CLASIF).map((o) => o.etiqueta) },
    tooltip: {
      ...BASE_GRAFICO.tooltip, trigger: 'item',
      formatter: (p) => p.data?.c ? `<b>${p.data.c.categoria}</b><br/>Calificación: ${num(p.data.c.rating_promedio, 2)} ★<br/>Cobertura: ${num(p.data.c.cobertura, 2)} títulos/10 000 obras<br/>Títulos en tienda: ${p.data.c.n_titulos}<br/>Obras en Open Library: ${num(p.data.c.work_count)}<br/><i>Clic para ver sus libros</i>` : '',
    },
    xAxis: { type: 'value', name: 'Calificación promedio (★)', nameLocation: 'middle', nameGap: 26,
      min: 1, max: 5, splitLine: { lineStyle: { color: '#eef2f6' } } },
    yAxis: { type: 'log', name: 'Cobertura (títulos por 10 000 obras, escala log)', nameLocation: 'middle',
      nameGap: 44, min: 0.01, max: 1000, splitLine: { lineStyle: { color: '#eef2f6' } },
      axisLabel: { formatter: (v) => num(v, v < 1 ? 2 : 0) } },
    series,
  }
  return (
    <Grafico opcion={opcion} alto={400} etiqueta="Mapa de decisión: calificación frente a cobertura"
      onClick={(p) => p.data?.c && onSeleccion(p.data.c.categoria)} />
  )
}
