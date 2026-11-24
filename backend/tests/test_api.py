"""Pruebas de la API contra la base cargada (database/datos.sql).

Ejecutar desde backend/:  pytest -q
Los valores esperados salen del Reto ETL y de database/validaciones.sql.
"""
from fastapi.testclient import TestClient

from app.main import app

c = TestClient(app)
BASE_8 = ["Art", "Poetry", "Humor", "Spirituality", "Fiction", "Music", "Religion", "Sports and Games"]


def priorizadas(r):
    return [x["categoria"] for x in sorted((x for x in r["categorias"] if x["priorizar"]), key=lambda x: x["prioridad"])]


def test_kpis_base_coinciden_con_sql():
    k = c.get("/api/tablero").json()["kpis"]
    assert (k["evaluadas"], k["priorizadas"], k["cumplimiento_pct"]) == (32, 8, 25.0)
    assert (k["rating_priorizadas"], k["cobertura_mediana_priorizadas"]) == (3.27, 1.33)


def test_lista_base_en_orden():
    assert priorizadas(c.get("/api/tablero").json()) == BASE_8


def test_escenario_cambio_history_entra_octava():
    r = c.get("/api/tablero", params={"escenario": "cambio_decision"}).json()
    assert priorizadas(r)[7:] == ["History", "Sports and Games"]
    assert r["kpis"]["variacion_vs_base"] == 1


def test_escenario_duplicado_conserva_decision():
    r = c.get("/api/tablero", params={"escenario": "duplicado"}).json()
    assert priorizadas(r) == BASE_8
    poetry = next(x for x in r["categorias"] if x["categoria"] == "Poetry")
    assert (poetry["n_filas_crudas"], poetry["n_titulos"], poetry["rating_promedio"]) == (20, 19, 3.5263)


def test_simulador_recalcula_sin_escribir():
    r = c.get("/api/tablero", params={"u_rating": 2.9}).json()
    assert r["simulacion"]["activa"] and r["kpis"]["priorizadas"] == 11
    assert r["simulacion"]["entran"] == ["History", "Science", "Business"]
    # la base no cambió
    assert c.get("/api/tablero").json()["kpis"]["priorizadas"] == 8


def test_filtros_y_resultado_vacio():
    r = c.get("/api/tablero", params={"clasificaciones": "priorizada", "tamanos": "mediana"}).json()
    assert [x["categoria"] for x in r["categorias"]] == [x for x in BASE_8 if x != "Fiction"]
    vacio = c.get("/api/tablero", params={"precio_min": 58, "precio_max": 58}).json()
    assert vacio["categorias"] == [] and vacio["kpis"]["priorizadas"] == 0


def test_validacion_de_parametros():
    assert c.get("/api/tablero", params={"clasificaciones": "inventada"}).status_code == 422
    assert c.get("/api/tablero", params={"u_rating": 9}).status_code == 422
    assert c.get("/api/tablero", params={"escenario": "otro"}).status_code == 422
    assert c.get("/api/categorias/NoExiste/libros").status_code == 404


def test_drill_down_marca_duplicado():
    libros = c.get("/api/categorias/Poetry/libros", params={"escenario": "duplicado"}).json()["libros"]
    assert len(libros) == 20 and sum(l["es_duplicado"] for l in libros) == 1
