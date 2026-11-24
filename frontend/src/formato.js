// Formatos y significado de colores compartidos por todos los componentes.
const nf = (d) => new Intl.NumberFormat('es-EC', { minimumFractionDigits: d, maximumFractionDigits: d })

export const num = (v, d = 0) => (v === null || v === undefined || Number.isNaN(v) ? '—' : nf(d).format(v))
export const pct = (v, d = 1) => (v === null || v === undefined ? '—' : `${nf(d).format(v)} %`)
export const gbp = (v) => (v === null || v === undefined ? '—' : `£${nf(2).format(v)}`)
export const signo = (v) => (v > 0 ? `+${v}` : `${v}`)
export const fechaHora = (iso) =>
  iso ? new Date(iso).toLocaleString('es-EC', { dateStyle: 'medium', timeStyle: 'short' }) : '—'

// Un color = un significado en todo el tablero
export const CLASIF = {
  priorizada: { etiqueta: 'Priorizada', color: '#0f8a74' },
  no_priorizada: { etiqueta: 'Evaluada, no priorizada', color: '#6b8bb0' },
  pocos_titulos: { etiqueta: 'Pocos títulos', color: '#b9c2cc' },
  sin_coincidencia: { etiqueta: 'Sin dato en Open Library', color: '#d59a5b' },
}
export const CAMBIO = {
  entra: { etiqueta: 'Entra', color: '#0f8a74' },
  sale: { etiqueta: 'Sale', color: '#c2453d' },
  sube: { etiqueta: 'Sube', color: '#0f8a74' },
  baja: { etiqueta: 'Baja', color: '#c27a1d' },
  datos_cambian: { etiqueta: 'Dato cambia, decisión igual', color: '#6b8bb0' },
  igual: { etiqueta: 'Sin cambio', color: '#8a97a5' },
}
export const ESTRELLAS_COLORES = ['#c2453d', '#e08b4f', '#d9c27a', '#7fb7a3', '#0f8a74']
export const TAMANO = { pequena: 'Pequeña (1–4)', mediana: 'Mediana (5–19)', grande: 'Grande (20+)' }
export const ESCENARIO_CORTO = { base: 'Base', cambio_decision: 'Cambio', duplicado: 'Duplicado' }
