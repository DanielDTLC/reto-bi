// Cliente de la API. Solo habla con /api (el backend); no conoce la base de datos.
async function get(ruta, params = {}) {
  const qs = new URLSearchParams(
    Object.entries(params).filter(([, v]) => v !== undefined && v !== null && v !== ''),
  ).toString()
  const res = await fetch(`/api${ruta}${qs ? `?${qs}` : ''}`)
  if (!res.ok) {
    let detalle = res.statusText
    try { detalle = (await res.json()).detail ?? detalle } catch { /* sin cuerpo JSON */ }
    throw new Error(typeof detalle === 'string' ? detalle : JSON.stringify(detalle))
  }
  return res.json()
}

export const api = {
  meta: () => get('/meta'),
  tablero: (p) => get('/tablero', p),
  comparacion: (p) => get('/comparacion', p),
  libros: (categoria, escenario) => get(`/categorias/${encodeURIComponent(categoria)}/libros`, { escenario }),
}
