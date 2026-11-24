import { num } from '../formato'

function Control({ etiqueta, ayuda, valor, original, min, max, paso, d, onCambio }) {
  return (
    <label className="control">
      <span className="control-cab">
        <span>{etiqueta}</span>
        <span className="control-valor">{num(valor, d)}
          {valor !== original && <small> (original {num(original, d)})</small>}</span>
      </span>
      <input type="range" min={min} max={max} step={paso} value={valor}
        onChange={(e) => onCambio(Number(e.target.value))} />
      <span className="control-ayuda">{ayuda}</span>
    </label>
  )
}

export default function Simulador({ umbrales, setUmbrales, sim, escenarioNombre }) {
  const o = sim.umbrales_originales
  return (
    <section className="tarjeta simulador" aria-label="Simulador de decisiones">
      <header className="tarjeta-cab">
        <div>
          <h2>Simulador de la regla</h2>
          <p className="sub">Sobre: <b>{escenarioNombre}</b>. No modifica la base de datos.</p>
        </div>
        {sim.activa && <span className="insignia insignia-sim">Simulación activa</span>}
      </header>
      <p className="regla">Priorizar si <b>calificación ≥ U<sub>R</sub></b> y <b>cobertura ≤ U<sub>C</sub></b>, con al menos N títulos.</p>
      <Control etiqueta="U_R · calificación mínima (★)" ayuda="Exigencia sobre lo que opinan los clientes"
        valor={umbrales.u_rating} original={o.u_rating} min={1} max={5} paso={0.1} d={1}
        onCambio={(v) => setUmbrales({ ...umbrales, u_rating: v })} />
      <Control etiqueta="U_C · cobertura máxima" ayuda="Títulos en tienda por cada 10 000 obras en Open Library"
        valor={umbrales.u_cobertura} original={o.u_cobertura} min={0} max={50} paso={0.5} d={1}
        onCambio={(v) => setUmbrales({ ...umbrales, u_cobertura: v })} />
      <Control etiqueta="N · mínimo de títulos" ayuda="Filtro de calidad: con pocos libros el promedio es ruido"
        valor={umbrales.min_titulos} original={o.min_titulos} min={1} max={20} paso={1} d={0}
        onCambio={(v) => setUmbrales({ ...umbrales, min_titulos: v })} />

      <div className="sim-comparacion">
        <div><span>Con umbrales originales</span><b>{sim.priorizadas_original}</b></div>
        <div className="flecha" aria-hidden>→</div>
        <div><span>Con la simulación</span><b>{sim.priorizadas_simulada}</b></div>
      </div>
      <div className="sim-listas">
        <p><span className="etq-entra">Entran ({sim.entran.length})</span> {sim.entran.join(', ') || 'ninguna'}</p>
        <p><span className="etq-sale">Salen ({sim.salen.length})</span> {sim.salen.join(', ') || 'ninguna'}</p>
      </div>
      <button type="button" className="boton-secundario ancho" disabled={!sim.activa}
        onClick={() => setUmbrales({ ...o })}>Restablecer umbrales originales</button>
    </section>
  )
}
