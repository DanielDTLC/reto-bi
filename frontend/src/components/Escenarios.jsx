import { useState } from 'react'
import Grafico, { BASE_GRAFICO } from './Grafico'
import { CAMBIO, num } from '../formato'

// Gráfico de pendiente: posición en la lista priorizada en la base y en la variante.
function Pendiente({ ranking, priorizadasBase, priorizadasEsc }) {
  const fuera = Math.max(priorizadasBase, priorizadasEsc) + 1
  const series = ranking.map((r) => {
    const color = CAMBIO[r.cambio]?.color ?? CAMBIO.igual.color
    const destacada = r.cambio !== 'igual'
    return {
      type: 'line', name: r.categoria, symbolSize: destacada ? 9 : 6,
      lineStyle: { color, width: destacada ? 3 : 1.2, opacity: destacada ? 1 : 0.55 },
      itemStyle: { color },
      data: [r.pos_base ?? fuera, r.pos_escenario ?? fuera],
      label: { show: true, fontSize: 11, color: destacada ? '#0f2233' : '#64748b',
        formatter: (p) => (p.dataIndex === 1 ? `${p.value === fuera ? 'fuera' : p.value}. ${r.categoria}` : `${r.categoria} ${p.value === fuera ? 'fuera' : p.value}.`),
        position: undefined },
      endLabel: { show: false },
    }
  }).map((s) => ({ ...s, label: { ...s.label, position: 'right' },
    data: [{ value: s.data[0], label: { position: 'left' } }, { value: s.data[1], label: { position: 'right' } }] }))
  const opcion = {
    ...BASE_GRAFICO,
    grid: { left: 150, right: 160, top: 26, bottom: 10, containLabel: false },
    tooltip: { show: false },
    xAxis: { type: 'category', data: ['Base', 'Variante'], boundaryGap: false, position: 'top',
      axisLine: { show: false }, axisTick: { show: false }, axisLabel: { fontWeight: 600 } },
    yAxis: { type: 'value', inverse: true, min: 0.5, max: fuera + 0.5, show: false },
    series,
  }
  return <Grafico opcion={opcion} alto={Math.max(240, fuera * 30)} etiqueta="Cambio de posiciones entre la base y la variante" />
}

export default function Escenarios({ comparacion }) {
  const [tab, setTab] = useState('cambio_decision')
  const c = comparacion[tab]
  return (
    <section className="tarjeta" aria-label="Comparación de escenarios">
      <header className="tarjeta-cab">
        <div>
          <h2>¿Qué cambia entre la base y cada variante?</h2>
          <p className="sub">Las variantes son copias independientes de los datos: no se suman entre sí.</p>
        </div>
        <div className="segmentado pequeno" role="tablist">
          {Object.entries(comparacion).map(([k, v]) => (
            <button key={k} role="tab" aria-selected={tab === k} className={tab === k ? 'seg-on' : ''}
              onClick={() => setTab(k)}>{v.nombre}</button>
          ))}
        </div>
      </header>
      <div className="escenarios-cuerpo">
        <div>
          <div className="mini-kpis">
            <div><span>Priorizadas base</span><b>{c.priorizadas_base}</b></div>
            <div><span>Priorizadas variante</span><b>{c.priorizadas_escenario}</b></div>
            <div><span>Categorías afectadas</span><b>{c.afectadas.length}</b></div>
          </div>
          <Pendiente ranking={c.ranking} priorizadasBase={c.priorizadas_base} priorizadasEsc={c.priorizadas_escenario} />
        </div>
        <div className="tabla-scroll">
          <h3 className="h3">Entidades afectadas y valores que lo explican</h3>
          {c.afectadas.length === 0 ? <p className="vacio-txt">Ninguna categoría cambia con estos umbrales.</p> : (
            <table className="tabla compacta">
              <thead><tr><th>Categoría</th><th>Cambio</th><th>Posición</th><th>Calificación</th><th>Cobertura</th><th>Filas → títulos</th></tr></thead>
              <tbody>
                {c.afectadas.map((a) => (
                  <tr key={a.categoria}>
                    <td><b>{a.categoria}</b></td>
                    <td><span className="insignia" style={{ background: CAMBIO[a.cambio].color }}>{CAMBIO[a.cambio].etiqueta}</span></td>
                    <td>{a.pos_base ?? '—'} → {a.pos_escenario ?? '—'}</td>
                    <td>{num(a.rating_base, 4)} → {num(a.rating_escenario, 4)}</td>
                    <td>{num(a.cobertura_base, 4)} → {num(a.cobertura_escenario, 4)}</td>
                    <td>{a.filas_crudas_escenario} → {a.titulos_escenario}{a.duplicados_escenario > 0 && <small> ({a.duplicados_escenario} duplicado)</small>}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
          <p className="nota">
            {tab === 'cambio_decision'
              ? 'Se cambió la calificación de un libro de History (id 254: 2 ★ → 3 ★). Su promedio sube y la categoría cruza el umbral.'
              : 'Se duplicó el libro id 530 en Poetry. El proceso detecta la fila repetida, la descarta y la calificación y la prioridad se conservan.'}
          </p>
        </div>
      </div>
    </section>
  )
}
