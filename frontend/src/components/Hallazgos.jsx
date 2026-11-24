// Hallazgos obtenidos al explorar el tablero (escenario base, umbrales originales 3,0 ★ / 5 / 5 títulos).
// Detalle, consultas y limitaciones en docs/hallazgos.md.
export default function Hallazgos() {
  return (
    <section className="tarjeta" aria-label="Hallazgos y acción recomendada">
      <header className="tarjeta-cab">
        <div>
          <h2>Hallazgos y acción recomendada</h2>
          <p className="sub">Escenario base · umbrales originales · sin filtros. Análisis descriptivo: no implica causalidad.</p>
        </div>
      </header>
      <div className="hallazgos">
        <article>
          <span className="h-num">1</span>
          <h3>Las categorías mejor calificadas no son las que más conviene ampliar</h3>
          <p>De las 14 categorías evaluadas con calificación ≥ 3,0 ★, <b>6 quedan fuera por cobertura alta</b>.
            Christian Fiction tiene la mejor nota (4,17 ★) pero cobertura de 37,0, y Young Adult (3,30 ★) llega a 544,4:
            la tienda ya está bien surtida frente a lo que existe en Open Library.</p>
          <p className="fuente">Mapa de decisión y tabla de detalle.</p>
        </article>
        <article>
          <span className="h-num">2</span>
          <h3>La parte baja de la lista es frágil</h3>
          <p><b>6 categorías están a menos de 0,1 ★ del umbral</b> (entre 2,90 y 2,99). History, Science y Business ya cumplen la cobertura.
            Basta un libro de History que pase de 2 ★ a 3 ★ para que entre en el puesto 8 y desplace a Sports and Games, que tiene
            exactamente 3,00 ★ y solo 5 títulos.</p>
          <p className="fuente">Comparación de escenarios y simulador (U<sub>R</sub> = 2,9 → 11 priorizadas).</p>
        </article>
        <article className="accion">
          <span className="h-num">→</span>
          <h3>Acción recomendada</h3>
          <p>El responsable de compras debería <b>ampliar primero Art, Poetry, Humor y Spirituality</b>: tienen ≥ 3,33 ★ y cobertura ≤ 3,6,
            y siguen priorizadas aunque el umbral suba a 3,3 ★. Conviene dejar <b>Sports and Games, History, Science y Business en observación</b>{' '}
            hasta reunir más calificaciones, porque su decisión cambia con un solo dato.</p>
        </article>
      </div>
    </section>
  )
}
