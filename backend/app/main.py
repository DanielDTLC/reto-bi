"""API del dashboard «Catálogo en foco» (Reto BI).

Ejecutar:  uvicorn app.main:app --reload --port 8000   (desde la carpeta backend/)
"""
from datetime import datetime
from pathlib import Path
from typing import Literal, Optional

from fastapi import FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from fastapi.staticfiles import StaticFiles

from . import consultas as q
from .db import consultar

ESCENARIOS = {
    "base": "Base · fuentes originales",
    "cambio_decision": "Cambio que altera la decisión",
    "duplicado": "Duplicado que conserva la decisión",
}
CLASIFICACIONES = {"priorizada", "no_priorizada", "pocos_titulos", "sin_coincidencia"}
TAMANOS = {"pequena", "mediana", "grande"}
Escenario = Literal["base", "cambio_decision", "duplicado"]

app = FastAPI(title="Catálogo en foco · API", version="1.0.0")
app.add_middleware(CORSMiddleware, allow_origins=["http://localhost:5173", "http://127.0.0.1:5173"],
                   allow_methods=["GET"], allow_headers=["*"])


def _lista(valor: Optional[str], permitidos: set[str], nombre: str) -> Optional[str]:
    if not valor:
        return None
    items = [v.strip() for v in valor.split(",") if v.strip()]
    malos = [v for v in items if v not in permitidos]
    if malos:
        raise HTTPException(422, f"Valor no válido en {nombre}: {', '.join(malos)}")
    return ",".join(items)


def _params(escenario, u_rating, u_cobertura, min_titulos, clasificaciones, tamanos, precio_min, precio_max):
    if precio_min > precio_max:
        raise HTTPException(422, "precio_min no puede ser mayor que precio_max")
    return dict(escenario=escenario, u_rating=u_rating, u_cobertura=u_cobertura, min_titulos=min_titulos,
                clasificaciones=_lista(clasificaciones, CLASIFICACIONES, "clasificaciones"),
                tamanos=_lista(tamanos, TAMANOS, "tamanos"),
                precio_min=precio_min, precio_max=precio_max)


def _umbrales_originales(escenario: str) -> dict:
    fila = next(m for m in consultar(q.META_ESCENARIOS) if m["escenario"] == escenario)
    return {k: fila[k] for k in ("u_rating", "u_cobertura", "min_titulos")}


@app.get("/api/salud")
def salud():
    consultar("SELECT 1")
    return {"ok": True, "hora_servidor": datetime.now().isoformat(timespec="seconds")}


@app.get("/api/meta")
def meta():
    esc = consultar(q.META_ESCENARIOS)
    rangos = consultar(q.META_RANGOS)[0]
    return {
        "problema": "¿Qué categorías de libros debería priorizar la librería para ampliar su catálogo?",
        "escenarios": [{**e, "nombre": ESCENARIOS[e["escenario"]],
                        "cargado_en": e["cargado_en"].isoformat(timespec="seconds")} for e in esc],
        "ultima_actualizacion": max(e["cargado_en"] for e in esc).isoformat(timespec="seconds"),
        "rangos": rangos,
    }


@app.get("/api/tablero")
def tablero(
    escenario: Escenario = "base",
    u_rating: float = Query(3.0, ge=1, le=5),
    u_cobertura: float = Query(5.0, ge=0, le=1000),
    min_titulos: int = Query(5, ge=1, le=50),
    clasificaciones: Optional[str] = None,
    tamanos: Optional[str] = None,
    precio_min: float = Query(0, ge=0),
    precio_max: float = Query(1000, ge=0),
):
    p = _params(escenario, u_rating, u_cobertura, min_titulos, clasificaciones, tamanos, precio_min, precio_max)
    categorias = consultar(q.CATEGORIAS, **p)
    kpis = consultar(q.KPIS, **p)[0]
    kpis["priorizadas_base"] = consultar(q.PRIORIZADAS_BASE, **p)[0]["priorizadas"]
    kpis["variacion_vs_base"] = kpis["priorizadas"] - kpis["priorizadas_base"]

    # Simulación: mismo escenario y filtros con los umbrales originales
    orig = _umbrales_originales(escenario)
    p_orig = {**p, **orig}
    originales = {c["categoria"]: c for c in consultar(q.CATEGORIAS, **p_orig)}
    for c in categorias:
        o = originales.get(c["categoria"])
        c["priorizar_umbral_original"] = bool(o and o["priorizar"])
        c["prioridad_umbral_original"] = o["prioridad"] if o else None
        c["cambio_simulacion"] = ("entra" if c["priorizar"] and not c["priorizar_umbral_original"]
                                  else "sale" if c["priorizar_umbral_original"] and not c["priorizar"]
                                  else "igual")
    simulacion = {
        "umbrales_originales": orig,
        "umbrales_actuales": {"u_rating": u_rating, "u_cobertura": u_cobertura, "min_titulos": min_titulos},
        "activa": (u_rating, u_cobertura, min_titulos) != (orig["u_rating"], orig["u_cobertura"], orig["min_titulos"]),
        "priorizadas_original": sum(1 for c in originales.values() if c["priorizar"]),
        "priorizadas_simulada": kpis["priorizadas"],
        "entran": [c["categoria"] for c in categorias if c["cambio_simulacion"] == "entra"],
        "salen": [c["categoria"] for c in categorias if c["cambio_simulacion"] == "sale"],
    }
    composicion = consultar(q.COMPOSICION, **p)
    return {"kpis": kpis, "categorias": categorias, "simulacion": simulacion, "composicion": composicion}


@app.get("/api/comparacion")
def comparacion(
    u_rating: float = Query(3.0, ge=1, le=5),
    u_cobertura: float = Query(5.0, ge=0, le=1000),
    min_titulos: int = Query(5, ge=1, le=50),
):
    salida = {}
    for esc in ("cambio_decision", "duplicado"):
        filas = consultar(q.COMPARACION, escenario=esc, u_rating=u_rating,
                          u_cobertura=u_cobertura, min_titulos=min_titulos)
        salida[esc] = {
            "nombre": ESCENARIOS[esc],
            "afectadas": [f for f in filas if f["cambio"] != "igual"],
            "priorizadas_base": sum(1 for f in filas if f["pos_base"] is not None),
            "priorizadas_escenario": sum(1 for f in filas if f["pos_escenario"] is not None),
            "ranking": [f for f in filas if f["pos_base"] is not None or f["pos_escenario"] is not None],
        }
    return salida


@app.get("/api/categorias/{categoria}/libros")
def libros_categoria(categoria: str, escenario: Escenario = "base"):
    filas = consultar(q.LIBROS_CATEGORIA, escenario=escenario, categoria=categoria)
    if not filas:
        raise HTTPException(404, f"La categoría «{categoria}» no existe en el escenario {escenario}")
    return {"categoria": categoria, "escenario": escenario, "libros": filas}


# --- Frontend compilado (opcional): sirve frontend/dist si existe -----------
DIST = Path(__file__).resolve().parents[2] / "frontend" / "dist"
if DIST.exists():
    app.mount("/assets", StaticFiles(directory=DIST / "assets"), name="assets")

    @app.get("/{ruta:path}", include_in_schema=False)
    def spa(ruta: str):
        return FileResponse(DIST / "index.html")
