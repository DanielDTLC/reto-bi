import { useMemo, useState } from 'react'
import { CLASIF, num, gbp } from '../formato'

const COLUMNAS = [
  ['prioridad', 'Prioridad'], ['categoria', 'Categoría'], ['clasificacion', 'Clasificación'],
  ['n_titulos', 'Títulos'], ['rating_promedio', 'Calificación ★'], ['work_count', 'Obras en Open Library'],
  ['cobertura', 'Cobertura'], ['precio_promedio', 'Precio prom.'], ['cambio_simulacion', 'Simulación'],
]

export default function TablaDetalle({ categorias, onSeleccion }) {
  const [orden, setOrden] = useState({ col: 'prioridad', asc: true })
  const filas = useMemo(() => {
    const v = (x) => x ?? (orden.asc ? Infinity : -Infinity)
    return [...categorias].sort((a, b) => {
      const x = v(a[orden.col]); const y = v(b[orden.col])
      const r = typeof x === 'string' ? x.localeCompare(y) : x - y
      return orden.asc ? r : -r
    })
  }, [categorias, orden])
  const ordenar = (col) => setOrden((o) => ({ col, asc: o.col === col ? !o.asc : true }))
  return (
    <div className="tabla-scroll alto">
      <table className="tabla">
        <thead>
          <tr>{COLUMNAS.map(([k, t]) => (
            <th key={k} aria-sort={orden.col === k ? (orden.asc ? 'ascending' : 'descending') : 'none'}>
              <button type="button" onClick={() => ordenar(k)}>{t}{orden.col === k ? (orden.asc ? ' ▲' : ' ▼') : ''}</button>
            </th>))}</tr>
        </thead>
        <tbody>
          {filas.map((c) => (
            <tr key={c.categoria} className={c.priorizar ? 'fila-priorizada' : ''} tabIndex={0}
              onClick={() => onSeleccion(c.categoria)} onKeyDown={(e) => e.key === 'Enter' && onSeleccion(c.categoria)}>
              <td className="num">{c.prioridad ?? '—'}</td>
              <td><b>{c.categoria}</b></td>
              <td><span className="punto" style={{ background: CLASIF[c.clasificacion].color }} /> {CLASIF[c.clasificacion].etiqueta}</td>
              <td className="num">{c.n_titulos}</td>
              <td className="num">{num(c.rating_promedio, 2)}</td>
              <td className="num">{c.coincide_b ? num(c.work_count) : <span className="muted">{num(c.work_count)} (no confiable)</span>}</td>
              <td className="num">{c.cobertura === null ? '—' : num(c.cobertura, 2)}</td>
              <td className="num">{gbp(c.precio_promedio)}</td>
              <td>{c.cambio_simulacion === 'entra' ? <span className="etq-entra">Entra</span>
                : c.cambio_simulacion === 'sale' ? <span className="etq-sale">Sale</span> : <span className="muted">—</span>}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}
