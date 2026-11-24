import Grafico, { BASE_GRAFICO } from './Grafico'
import { CLASIF, num } from '../formato'

// Barras ordenadas: compara la calificación de las categorías evaluadas contra el umbral.
export default function Ranking({ categorias, uRating, onSeleccion }) {
  const datos = categorias.filter((c) => c.elegible)
    .sort((a, b) => a.rating_promedio - b.rating_promedio)
  const opcion = {
    ...BASE_GRAFICO,
    grid: { ...BASE_GRAFICO.grid, right: 46 },
    tooltip: { ...BASE_GRAFICO.tooltip, trigger: 'axis', axisPointer: { type: 'shadow' },
      formatter: ([p]) => `<b>${p.name}</b><br/>${num(p.value, 2)} ★ · ${p.data.c.n_titulos} títulos<br/>${CLASIF[p.data.c.clasificacion].etiqueta}` },
    xAxis: { type: 'value', min: 0, max: 5, splitLine: { lineStyle: { color: '#eef2f6' } } },
    yAxis: { type: 'category', data: datos.map((c) => c.categoria), axisLabel: { fontSize: 11 },
      axisTick: { show: false } },
    series: [{
      type: 'bar', barMaxWidth: 14,
      data: datos.map((c) => ({ value: c.rating_promedio, c,
        itemStyle: { color: CLASIF[c.clasificacion].color, borderRadius: [0, 3, 3, 0] } })),
      label: { show: true, position: 'right', fontSize: 10, formatter: (p) => num(p.value, 2) },
      markLine: { silent: true, symbol: 'none', lineStyle: { color: '#0f2233', type: 'dashed' },
        label: { formatter: `umbral ${num(uRating, 1)}`, fontSize: 10 }, data: [{ xAxis: uRating }] },
    }],
  }
  return (
    <Grafico opcion={opcion} alto={Math.max(260, datos.length * 19 + 50)}
      etiqueta="Ranking de calificación de las categorías evaluadas"
      onClick={(p) => p.data?.c && onSeleccion(p.data.c.categoria)} />
  )
}
