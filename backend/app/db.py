"""Conexión a PostgreSQL. Las credenciales solo viven en el servidor (.env)."""
import os
from pathlib import Path

from dotenv import load_dotenv
from sqlalchemy import create_engine, text

# Busca .env en backend/ y en la raíz del repositorio
for p in (Path(__file__).resolve().parents[1] / ".env", Path(__file__).resolve().parents[2] / ".env"):
    if p.exists():
        load_dotenv(p)


def url_conexion() -> str:
    if os.getenv("DATABASE_URL"):
        return os.environ["DATABASE_URL"]
    return "postgresql+psycopg2://{u}:{p}@{h}:{port}/{db}".format(
        u=os.getenv("PGUSER", "postgres"), p=os.getenv("PGPASSWORD", ""),
        h=os.getenv("PGHOST", "localhost"), port=os.getenv("PGPORT", "5432"),
        db=os.getenv("PGDATABASE", "reto_etl"))


engine = create_engine(url_conexion(), pool_pre_ping=True)


def consultar(sql: str, **params) -> list[dict]:
    with engine.connect() as con:
        res = con.execute(text(sql), params)
        return [dict(r._mapping) for r in res]
