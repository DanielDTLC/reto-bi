import { useEffect, useRef } from 'react'
import * as echarts from 'echarts'

// Envoltorio reutilizable de ECharts: crea, actualiza, redimensiona y expone clics.
export default function Grafico({ opcion, alto = 320, onClick, etiqueta }) {
  const ref = useRef(null)
  const chart = useRef(null)
  const clickRef = useRef(onClick)
  clickRef.current = onClick

  useEffect(() => {
    chart.current = echarts.init(ref.current, null, { renderer: 'canvas' })
    chart.current.on('click', (p) => clickRef.current?.(p))
    const ro = new ResizeObserver(() => chart.current?.resize())
    ro.observe(ref.current)
    return () => { ro.disconnect(); chart.current?.dispose() }
  }, [])

  useEffect(() => {
    chart.current?.setOption(opcion, true)
  }, [opcion])

  return <div ref={ref} style={{ height: alto, width: '100%' }} role="img" aria-label={etiqueta} />
}

export const BASE_GRAFICO = {
  textStyle: { fontFamily: 'Inter, Segoe UI, system-ui, sans-serif', color: '#334155' },
  grid: { left: 12, right: 18, top: 28, bottom: 12, containLabel: true },
  tooltip: { backgroundColor: '#0f2233', borderWidth: 0, textStyle: { color: '#fff', fontSize: 12 } },
  animationDuration: 350,
}
