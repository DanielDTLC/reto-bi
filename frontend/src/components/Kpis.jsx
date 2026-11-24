import { num, pct, signo } from '../formato'

function Kpi({ titulo, valor, unidad, nota, tono }) {
  return (
    <article className={`kpi ${tono ? `kpi-${tono}` : ''}`}>
      <h3>{titulo}</h3>
      <p className="kpi-valor">{valor}{unidad && <small> {unidad}</small>}</p>
      <p className="kpi-nota">{nota}</p>
    </article>
  )
}

export default function Kpis({ k, escenario }) {
  const variacion = k.variacion_vs_base
  return (
    <section className="kpis" aria-label="Indicadores clave">
      <Kpi titulo="Categorías evaluadas" valor={num(k.evaluadas)}
        nota={`de ${num(k.categorias_filtradas)} en el filtro · con dato en Open Library y títulos suficientes`} />
      <Kpi titulo="Priorizadas" valor={num(k.priorizadas)} tono="clave"
        nota={`${num(k.libros_priorizados)} libros en esas categorías`} />
      <Kpi titulo="Cumplimiento de la regla" valor={pct(k.cumplimiento_pct)}
        nota="priorizadas ÷ evaluadas" />
      <Kpi titulo="Calificación de las priorizadas" valor={num(k.rating_priorizadas, 2)} unidad="★ / 5"
        nota="promedio ponderado por libro" />
      <Kpi titulo="Cobertura mediana priorizadas" valor={num(k.cobertura_mediana_priorizadas, 2)}
        unidad="títulos / 10 000 obras" nota="menor = más espacio para crecer" />
      <Kpi titulo="Variación vs. base" valor={escenario === 'base' ? '0' : signo(variacion)}
        unidad="categorías" tono={variacion > 0 ? 'sube' : variacion < 0 ? 'baja' : ''}
        nota={escenario === 'base' ? 'el escenario activo es la base' : `base: ${num(k.priorizadas_base)} priorizadas con los mismos umbrales`} />
    </section>
  )
}
