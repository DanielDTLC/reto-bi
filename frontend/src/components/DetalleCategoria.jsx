import { useEffect, useState } from 'react'
import Grafico, { BASE_GRAFICO } from './Grafico'
import { api } from '../api'
import { CLASIF, ESTRELLAS_COLORES, gbp, num } from '../formato'
import { Cargando, ErrorCaja } from './Estados'

// Drill-down: de la categoría a sus libros. Cerrar = roll-up a la vista general.
export default function DetalleCategoria({ categoria, escenario, resumen, onCerrar }) {
  const [datos, setDatos] = useState(null)
  const [error, setError] = useState(null)
  useEffect(() => {
    setDatos(null); setError(null)
    api.libros(categoria, escenario).then(setDatos).catch((e) => setError(e.message))
  }, [categoria, escenario])
  useEffect(() => {
    const esc = (e) => e.key === 'Escape' && onCerrar()
    window.addEventListener('keydown', esc)
    return () => window.removeEventListener('keydown', esc)
  }, [onCerrar])

  const limpios = datos?.libros.filter((l) => !l.es_duplicado) ?? []
  const bins = [0, 10, 20, 30, 40, 50, 60]
  const histo = {
    ...BASE_GRAFICO,
    title: { text: 'Distribución de precios (£)', textStyle: { fontSize: 12, fontWeight: 600 } },
    grid: { ...BASE_GRAFICO.grid, top: 34 },
    tooltip: { ...BASE_GRAFICO.tooltip, trigger: 'axis' },
    xAxis: { type: 'category', data: bins.slice(0, -1).map((b, i) => `${b}–${bins[i + 1]}`) },
    yAxis: { type: 'value', minInterval: 1, splitLine: { lineStyle: { color: '#eef2f6' } } },
    series: [{ type: 'bar', barCategoryGap: '8%', itemStyle: { color: '#6b8bb0' },
      data: bins.slice(0, -1).map((b, i) => limpios.filter((l) => l.precio_gbp >= b && l.precio_gbp < bins[i + 1]).length) }],
  }
  const estrellas = {
    ...BASE_GRAFICO,
    title: { text: 'Libros por calificación', textStyle: { fontSize: 12, fontWeight: 600 } },
    grid: { ...BASE_GRAFICO.grid, top: 34 },
    tooltip: { ...BASE_GRAFICO.tooltip, trigger: 'axis' },
    xAxis: { type: 'category', data: ['1 ★', '2 ★', '3 ★', '4 ★', '5 ★'] },
    yAxis: { type: 'value', minInterval: 1, splitLine: { lineStyle: { color: '#eef2f6' } } },
    series: [{ type: 'bar', data: [1, 2, 3, 4, 5].map((e) => ({ value: limpios.filter((l) => l.estrellas === e).length,
      itemStyle: { color: ESTRELLAS_COLORES[e - 1] } })) }],
  }

  return (
    <div className="velo" onClick={onCerrar}>
      <aside className="panel" role="dialog" aria-modal="true" aria-label={`Detalle de ${categoria}`} onClick={(e) => e.stopPropagation()}>
        <header className="panel-cab">
          <div>
            <p className="miga">Vista general › <b>{categoria}</b></p>
            <h2>{categoria}</h2>
            {resumen && <span className="insignia" style={{ background: CLASIF[resumen.clasificacion].color }}>
              {CLASIF[resumen.clasificacion].etiqueta}{resumen.prioridad ? ` · prioridad ${resumen.prioridad}` : ''}</span>}
          </div>
          <button type="button" className="boton-secundario" onClick={onCerrar}>← Volver a la vista general</button>
        </header>
        {resumen && (
          <div className="mini-kpis cuatro">
            <div><span>Títulos únicos</span><b>{resumen.n_titulos}</b></div>
            <div><span>Calificación</span><b>{num(resumen.rating_promedio, 2)} ★</b></div>
            <div><span>Obras en Open Library</span><b>{num(resumen.work_count)}</b></div>
            <div><span>Cobertura</span><b>{resumen.cobertura === null ? '—' : num(resumen.cobertura, 2)}</b></div>
          </div>
        )}
        {error && <ErrorCaja mensaje={error} />}
        {!datos && !error && <Cargando texto="Cargando libros…" />}
        {datos && (
          <>
            <div className="dos-col">
              <Grafico opcion={estrellas} alto={200} etiqueta="Libros por calificación" />
              <Grafico opcion={histo} alto={200} etiqueta="Distribución de precios" />
            </div>
            <div className="tabla-scroll alto">
              <table className="tabla compacta">
                <thead><tr><th>Id</th><th>Título</th><th>Precio</th><th>★</th><th>Estado</th></tr></thead>
                <tbody>
                  {datos.libros.map((l, i) => (
                    <tr key={`${l.id_libro}-${i}`} className={l.es_duplicado ? 'fila-duplicado' : ''}>
                      <td className="num">{l.id_libro}</td><td>{l.titulo}</td>
                      <td className="num">{gbp(l.precio_gbp)}</td><td className="num">{l.estrellas}</td>
                      <td>{l.es_duplicado ? <span className="etq-sale">Duplicado descartado</span> : <span className="muted">{l.disponibilidad}</span>}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </>
        )}
      </aside>
    </div>
  )
}
