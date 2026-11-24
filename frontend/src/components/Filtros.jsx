import { CLASIF, TAMANO } from '../formato'

function Chips({ opciones, seleccion, onCambio, etiqueta }) {
  const alternar = (v) =>
    onCambio(seleccion.includes(v) ? seleccion.filter((x) => x !== v) : [...seleccion, v])
  return (
    <div className="filtro" role="group" aria-label={etiqueta}>
      <span className="filtro-etiqueta">{etiqueta}</span>
      <div className="chips">
        {Object.entries(opciones).map(([v, o]) => (
          <button key={v} type="button"
            className={`chip ${seleccion.includes(v) ? 'chip-on' : ''}`}
            aria-pressed={seleccion.includes(v)} onClick={() => alternar(v)}>
            {o.color && <span className="punto" style={{ background: o.color }} />}
            {o.etiqueta ?? o}
          </button>
        ))}
      </div>
    </div>
  )
}

export default function Filtros({ meta, f, setF, onRestablecer }) {
  const r = meta.rangos
  return (
    <section className="barra-filtros" aria-label="Filtros">
      <div className="filtro">
        <span className="filtro-etiqueta">Escenario</span>
        <div className="segmentado" role="radiogroup" aria-label="Escenario">
          {meta.escenarios.map((e) => (
            <button key={e.escenario} type="button" role="radio" aria-checked={f.escenario === e.escenario}
              className={f.escenario === e.escenario ? 'seg-on' : ''}
              onClick={() => setF({ ...f, escenario: e.escenario })}>
              {e.nombre}
            </button>
          ))}
        </div>
      </div>
      <Chips etiqueta="Clasificación" opciones={CLASIF} seleccion={f.clasificaciones}
        onCambio={(v) => setF({ ...f, clasificaciones: v })} />
      <Chips etiqueta="Tamaño en tienda (títulos)" opciones={TAMANO} seleccion={f.tamanos}
        onCambio={(v) => setF({ ...f, tamanos: v })} />
      <div className="filtro">
        <span className="filtro-etiqueta">Precio promedio (£)</span>
        <div className="rango">
          <input type="number" aria-label="Precio mínimo" min={r.precio_min} max={f.precio_max} step="1"
            value={f.precio_min} onChange={(e) => setF({ ...f, precio_min: Number(e.target.value) })} />
          <span>a</span>
          <input type="number" aria-label="Precio máximo" min={f.precio_min} max={r.precio_max} step="1"
            value={f.precio_max} onChange={(e) => setF({ ...f, precio_max: Number(e.target.value) })} />
        </div>
      </div>
      <button type="button" className="boton-secundario" onClick={onRestablecer}>Restablecer todo</button>
    </section>
  )
}
