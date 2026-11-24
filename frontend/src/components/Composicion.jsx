import Grafico, { BASE_GRAFICO } from './Grafico'
import { ESTRELLAS_COLORES, num } from '../formato'

// Barras apiladas al 100 %: qué mezcla de calificaciones (1 a 5 ★) explica cada promedio.
export default function Composicion({ composicion, onSeleccion }) {
  const cats = [...new Set(composicion.map((r) => r.categoria))].reverse()
  const tot = Object.fromEntries(cats.map((c) => [c, composicion.filter((r) => r.categoria === c)
    .reduce((s, r) => s + r.libros, 0)]))
  const series = [1, 2, 3, 4, 5].map((e) => ({
    name: `${e} ★`, type: 'bar', stack: 'total', barMaxWidth: 14,
    itemStyle: { color: ESTRELLAS_COLORES[e - 1] },
    data: cats.map((c) => {
      const n = composicion.find((r) => r.categoria === c && r.estrellas === e)?.libros ?? 0
      return { value: tot[c] ? (100 * n) / tot[c] : 0, n }
    }),
  }))
  const opcion = {
    ...BASE_GRAFICO,
    legend: { top: 0, itemWidth: 10, itemHeight: 10, textStyle: { fontSize: 11 } },
    grid: { ...BASE_GRAFICO.grid, top: 30 },
    tooltip: { ...BASE_GRAFICO.tooltip, trigger: 'axis', axisPointer: { type: 'shadow' },
      formatter: (ps) => `<b>${ps[0].name}</b> (${tot[ps[0].name]} libros)<br/>` +
        ps.map((p) => `${p.marker}${p.seriesName}: ${p.data.n} (${num(p.value, 0)} %)`).join('<br/>') },
    xAxis: { type: 'value', max: 100, axisLabel: { formatter: '{value} %' },
      splitLine: { lineStyle: { color: '#eef2f6' } } },
    yAxis: { type: 'category', data: cats, axisLabel: { fontSize: 11 }, axisTick: { show: false } },
    series,
  }
  return (
    <Grafico opcion={opcion} alto={Math.max(260, cats.length * 19 + 60)}
      etiqueta="Composición de calificaciones por categoría"
      onClick={(p) => onSeleccion(p.name)} />
  )
}
