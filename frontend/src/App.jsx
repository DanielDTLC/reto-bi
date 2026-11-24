import { useCallback, useEffect, useMemo, useState } from 'react'
import { api } from './api'
import { CLASIF, ESCENARIO_CORTO, TAMANO, fechaHora, num } from './formato'
import Filtros from './components/Filtros'
import Kpis from './components/Kpis'
import MapaDecision from './components/MapaDecision'
import Ranking from './components/Ranking'
import Composicion from './components/Composicion'
import Simulador from './components/Simulador'
import Escenarios from './components/Escenarios'
import TablaDetalle from './components/TablaDetalle'
import DetalleCategoria from './components/DetalleCategoria'
import Hallazgos from './components/Hallazgos'
import { Cargando, ErrorCaja, SinResultados } from './components/Estados'

const useDebounce = (valor, ms = 250) => {
  const [v, setV] = useState(valor)
  useEffect(() => { const t = setTimeout(() => setV(valor), ms); return () => clearTimeout(t) }, [valor, ms])
  return v
}

function Tarjeta({ titulo, pregunta, children, extra }) {
  return (
    <section className="tarjeta">
      <header className="tarjeta-cab">
        <div><h2>{titulo}</h2><p className="sub">{pregunta}</p></div>{extra}
      </header>
      {children}
    </section>
  )
}

export default function App() {
  const [meta, setMeta] = useState(null)
  const [errorMeta, setErrorMeta] = useState(null)
  const [f, setF] = useState(null)              // filtros
  const [umbrales, setUmbrales] = useState(null) // simulador
  const [datos, setDatos] = useState(null)
  const [comp, setComp] = useState(null)
  const [cargando, setCargando] = useState(false)
  const [error, setError] = useState(null)
  const [seleccion, setSeleccion] = useState(null)
  const [recarga, setRecarga] = useState(0)

  const filtrosIniciales = useCallback((m) => ({
    escenario: 'base', clasificaciones: [], tamanos: [],
    precio_min: m.rangos.precio_min, precio_max: m.rangos.precio_max,
  }), [])
  const umbralesDe = (m, esc) => {
    const e = m.escenarios.find((x) => x.escenario === esc)
    return { u_rating: e.u_rating, u_cobertura: e.u_cobertura, min_titulos: e.min_titulos }
  }

  const cargarMeta = useCallback(() => {
    setErrorMeta(null)
    api.meta().then((m) => {
      setMeta(m)
      setF((prev) => prev ?? filtrosIniciales(m))
      setUmbrales((prev) => prev ?? umbralesDe(m, 'base'))
    }).catch((e) => setErrorMeta(e.message))
  }, [filtrosIniciales])
  useEffect(cargarMeta, [cargarMeta, recarga])

  const fD = useDebounce(f, 200)
  const uD = useDebounce(umbrales, 200)

  useEffect(() => {
    if (!fD || !uD) return
    let vivo = true
    setCargando(true); setError(null)
    const p = { ...uD, escenario: fD.escenario, precio_min: fD.precio_min, precio_max: fD.precio_max,
      clasificaciones: fD.clasificaciones.join(','), tamanos: fD.tamanos.join(',') }
    Promise.all([api.tablero(p), api.comparacion(uD)])
      .then(([t, c]) => { if (vivo) { setDatos(t); setComp(c) } })
      .catch((e) => vivo && setError(e.message))
      .finally(() => vivo && setCargando(false))
    return () => { vivo = false }
  }, [fD, uD, recarga])

  const restablecer = () => { setF(filtrosIniciales(meta)); setUmbrales(umbralesDe(meta, 'base')) }
  const resumenSel = useMemo(() => datos?.categorias.find((c) => c.categoria === seleccion), [datos, seleccion])

  if (errorMeta) return <main className="contenedor"><ErrorCaja mensaje={errorMeta} onReintentar={cargarMeta} /></main>
  if (!meta || !f || !umbrales) return <main className="contenedor"><Cargando /></main>

  const esc = meta.escenarios.find((e) => e.escenario === f.escenario)
  const activos = [
    `Escenario: ${esc.nombre}`,
    f.clasificaciones.length ? `Clasificación: ${f.clasificaciones.map((c) => CLASIF[c].etiqueta).join(', ')}` : null,
    f.tamanos.length ? `Tamaño: ${f.tamanos.map((t) => TAMANO[t]).join(', ')}` : null,
    (f.precio_min !== meta.rangos.precio_min || f.precio_max !== meta.rangos.precio_max)
      ? `Precio: £${f.precio_min}–£${f.precio_max}` : null,
    datos?.simulacion.activa ? `Umbrales simulados: ${num(umbrales.u_rating, 1)} ★ / ${num(umbrales.u_cobertura, 1)} / ${umbrales.min_titulos}` : null,
  ].filter(Boolean)
  const vacio = datos && datos.categorias.length === 0

  return (
    <>
      <header className="cabecera">
        <div className="contenedor cabecera-in">
          <div>
            <p className="sobretitulo">Dashboard decisional · Librería en línea</p>
            <h1>Catálogo en foco</h1>
            <p className="problema">{meta.problema} Se prioriza una categoría si sus clientes la califican bien
              y la tienda tiene poca cobertura frente a la oferta mundial (Open Library).</p>
          </div>
          <div className="cabecera-meta">
            <span className="insignia insignia-esc">{ESCENARIO_CORTO[f.escenario]}</span>
            <span>Datos cargados: <b>{fechaHora(meta.ultima_actualizacion)}</b></span>
            <span>{esc.libros_unicos} libros · {esc.categorias} categorías</span>
            <button type="button" className="boton-claro" onClick={() => setRecarga((r) => r + 1)}>Volver a consultar</button>
          </div>
        </div>
      </header>

      <main className="contenedor">
        <Filtros meta={meta} f={f} setF={setF} onRestablecer={restablecer} />
        <p className="activos" aria-live="polite">
          {activos.map((a) => <span key={a} className="activo">{a}</span>)}
          {cargando && <span className="actualizando">actualizando…</span>}
        </p>

        {error && <ErrorCaja mensaje={error} onReintentar={() => setRecarga((r) => r + 1)} />}
        {!datos && !error && <Cargando />}

        {datos && (
          <>
            <Kpis k={datos.kpis} escenario={f.escenario} />
            {vacio ? <SinResultados onRestablecer={restablecer} /> : (
              <>
                <div className="fila-principal">
                  <Tarjeta titulo="Mapa de decisión"
                    pregunta="¿Qué categorías cumplen las dos condiciones de la regla? La zona verde es donde se prioriza. Clic en un punto para ver sus libros.">
                    <MapaDecision categorias={datos.categorias} umbrales={umbrales} onSeleccion={setSeleccion} />
                  </Tarjeta>
                  <Simulador umbrales={umbrales} setUmbrales={setUmbrales} sim={datos.simulacion} escenarioNombre={esc.nombre} />
                </div>
                <div className="dos-col">
                  <Tarjeta titulo="Ranking de calificación" pregunta="¿Cómo se ordenan las categorías evaluadas por calificación y cuáles superan el umbral?">
                    <Ranking categorias={datos.categorias} uRating={umbrales.u_rating} onSeleccion={setSeleccion} />
                  </Tarjeta>
                  <Tarjeta titulo="Composición de calificaciones" pregunta="¿Qué mezcla de 1 a 5 ★ explica el promedio de cada categoría evaluada?">
                    {datos.composicion.length ? <Composicion composicion={datos.composicion} onSeleccion={setSeleccion} />
                      : <p className="vacio-txt">No hay categorías evaluadas con estos filtros.</p>}
                  </Tarjeta>
                </div>
              </>
            )}
            {comp && <Escenarios comparacion={comp} />}
            {!vacio && (
              <Tarjeta titulo="Detalle de categorías" pregunta={`${datos.categorias.length} categorías con los filtros activos. Clic en una fila para ver sus libros; clic en un encabezado para ordenar.`}>
                <TablaDetalle categorias={datos.categorias} onSeleccion={setSeleccion} />
              </Tarjeta>
            )}
            <Hallazgos />
          </>
        )}
        <footer className="pie">
          Fuentes: books.toscrape.com (web scraping) y Open Library Subjects API, integradas en el Reto ETL · PostgreSQL ·
          Daniel De La Cruz Tomalá · Inteligencia de Negocios, UPSE 2026-2
        </footer>
      </main>

      {seleccion && (
        <DetalleCategoria categoria={seleccion} escenario={f.escenario} resumen={resumenSel}
          onCerrar={() => setSeleccion(null)} />
      )}
    </>
  )
}
