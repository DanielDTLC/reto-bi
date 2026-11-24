-- =====================================================================
-- Reto BI · Esquema analítico
-- Tabla 1 (heredada del Reto ETL): decision_categorias
--   Granularidad: una fila = una categoría de la tienda en un escenario.
-- Tabla 2 (ajuste para el Reto BI): libros
--   Granularidad: una fila = un registro de libro extraído en un escenario
--   (incluye el registro duplicado detectado, marcado con es_duplicado).
-- =====================================================================

CREATE TABLE IF NOT EXISTS decision_categorias (
    escenario         TEXT         NOT NULL,
    categoria         TEXT         NOT NULL,
    slug              TEXT         NOT NULL,
    n_filas_crudas    INTEGER      NOT NULL,
    n_duplicados      INTEGER      NOT NULL,
    n_titulos         INTEGER      NOT NULL,
    suma_estrellas    INTEGER      NOT NULL,
    rating_promedio   NUMERIC(6,4) NOT NULL,
    precio_promedio   NUMERIC(8,2) NOT NULL,
    work_count        INTEGER      NOT NULL,
    coincide_b        BOOLEAN      NOT NULL,
    cobertura         NUMERIC(12,4),
    elegible          BOOLEAN      NOT NULL,
    priorizar         BOOLEAN      NOT NULL,
    prioridad         INTEGER,
    u_rating          NUMERIC(4,2) NOT NULL,
    u_cobertura       NUMERIC(8,2) NOT NULL,
    min_titulos       INTEGER      NOT NULL,
    cargado_en        TIMESTAMP    DEFAULT now(),
    PRIMARY KEY (escenario, categoria)
);

CREATE TABLE IF NOT EXISTS libros (
    id             SERIAL       PRIMARY KEY,
    escenario      TEXT         NOT NULL,
    id_libro       INTEGER      NOT NULL,
    categoria      TEXT         NOT NULL,
    titulo         TEXT         NOT NULL,
    precio_gbp     NUMERIC(8,2) NOT NULL,
    estrellas      SMALLINT     NOT NULL CHECK (estrellas BETWEEN 1 AND 5),
    disponibilidad TEXT,
    es_duplicado   BOOLEAN      NOT NULL DEFAULT false,
    FOREIGN KEY (escenario, categoria) REFERENCES decision_categorias (escenario, categoria)
);
CREATE INDEX IF NOT EXISTS ix_libros_esc_cat ON libros (escenario, categoria);

-- Vista de libros limpios (la misma población que usa la decisión)
CREATE OR REPLACE VIEW v_libros_limpios AS
SELECT escenario, id_libro, categoria, titulo, precio_gbp, estrellas, disponibilidad
FROM libros
WHERE NOT es_duplicado;
