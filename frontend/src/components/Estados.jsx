export function Cargando({ texto = 'Cargando datos…' }) {
  return <div className="estado" role="status"><span className="spinner" aria-hidden />{texto}</div>
}

export function ErrorCaja({ mensaje, onReintentar }) {
  return (
    <div className="estado estado-error" role="alert">
      <b>No se pudieron obtener los datos.</b> <span>{mensaje}</span>
      {onReintentar && <button type="button" className="boton-secundario" onClick={onReintentar}>Reintentar</button>}
    </div>
  )
}

export function SinResultados({ onRestablecer }) {
  return (
    <div className="estado estado-vacio" role="status">
      <b>Ninguna categoría cumple estos filtros.</b>
      <span>Amplíe el rango de precio o quite alguna clasificación.</span>
      <button type="button" className="boton-secundario" onClick={onRestablecer}>Restablecer filtros</button>
    </div>
  )
}
