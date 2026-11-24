import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'

// En desarrollo, /api se redirige al backend FastAPI: el navegador nunca ve credenciales.
export default defineConfig({
  plugins: [react()],
  build: { chunkSizeWarningLimit: 1600 },
  server: { proxy: { '/api': process.env.VITE_API_PROXY || 'http://localhost:8000' } },
})
