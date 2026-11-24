"""Ajuste del Reto ETL para el Reto BI.

Ejecuta el ETL original (reto_etl.py, sin cambios) para los tres escenarios y,
además de la tabla `decision_categorias` que ese ETL ya carga, guarda la tabla
`libros` a nivel de libro. Esa tabla permite el drill-down categoría -> libros
y los filtros por precio y estrellas del dashboard.

Uso:
    set RETO_ETL_DIR=C:/ruta/a/reto_etl        (Windows)
    export RETO_ETL_DIR=/ruta/a/reto_etl       (Linux/Mac)
    python database/cargar_libros.py

Lee la conexión de las mismas variables PG* del archivo .env.
"""
import os
import runpy
from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine, text

ETL_DIR = Path(os.environ.get("RETO_ETL_DIR", "../reto_etl")).resolve()
ESQUEMA = Path(__file__).with_name("01_esquema.sql")


def main():
    os.chdir(ETL_DIR)  # el ETL usa rutas relativas (data/original, .env)
    ns = runpy.run_path(str(ETL_DIR / "reto_etl.py"))
    engine = create_engine(ns["url_conexion"]())

    with engine.begin() as con:
        con.execute(text(ESQUEMA.read_text(encoding="utf-8")))
        con.execute(text("TRUNCATE libros RESTART IDENTITY"))

    for escenario, r in ns["res"].items():
        lib = r["libros"].copy()
        # Marca el duplicado igual que el ETL: segunda aparición de (categoria, id_libro)
        lib["es_duplicado"] = lib.duplicated(subset=["categoria", "id_libro"], keep="first")
        lib["escenario"] = escenario
        cols = ["escenario", "id_libro", "categoria", "titulo", "precio_gbp", "estrellas",
                "disponibilidad", "es_duplicado"]
        with engine.begin() as con:
            lib[cols].to_sql("libros", con, if_exists="append", index=False)
        print(f"[{escenario}] libros cargados: {len(lib)} (duplicados marcados: {int(lib.es_duplicado.sum())})")


if __name__ == "__main__":
    main()
