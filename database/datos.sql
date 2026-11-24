-- Respaldo completo de la base reto_etl (tablas decision_categorias y libros, vista v_libros_limpios)
-- generado con pg_dump a partir del Reto ETL + database/cargar_libros.py
-- Restaurar:  psql -U postgres -d reto_etl -f database/datos.sql

--
-- PostgreSQL database dump
--

\restrict 3ib4Es5gPijQ0gJ0gWoPCbPdFvuhfkHX4o0qnzWXPr79YULCXchX7pbsk2l8PYa

-- Dumped from database version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: decision_categorias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.decision_categorias (
    escenario text NOT NULL,
    categoria text NOT NULL,
    slug text NOT NULL,
    n_filas_crudas integer NOT NULL,
    n_duplicados integer NOT NULL,
    n_titulos integer NOT NULL,
    suma_estrellas integer NOT NULL,
    rating_promedio numeric(6,4) NOT NULL,
    precio_promedio numeric(8,2) NOT NULL,
    work_count integer NOT NULL,
    coincide_b boolean NOT NULL,
    cobertura numeric(12,4),
    elegible boolean NOT NULL,
    priorizar boolean NOT NULL,
    prioridad integer,
    u_rating numeric(4,2) NOT NULL,
    u_cobertura numeric(8,2) NOT NULL,
    min_titulos integer NOT NULL,
    cargado_en timestamp without time zone DEFAULT now()
);


--
-- Name: libros; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.libros (
    id integer NOT NULL,
    escenario text NOT NULL,
    id_libro integer NOT NULL,
    categoria text NOT NULL,
    titulo text NOT NULL,
    precio_gbp numeric(8,2) NOT NULL,
    estrellas smallint NOT NULL,
    disponibilidad text,
    es_duplicado boolean DEFAULT false NOT NULL,
    CONSTRAINT libros_estrellas_check CHECK (((estrellas >= 1) AND (estrellas <= 5)))
);


--
-- Name: libros_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.libros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: libros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.libros_id_seq OWNED BY public.libros.id;


--
-- Name: v_libros_limpios; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_libros_limpios AS
 SELECT escenario,
    id_libro,
    categoria,
    titulo,
    precio_gbp,
    estrellas,
    disponibilidad
   FROM public.libros
  WHERE (NOT es_duplicado);


--
-- Name: libros id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libros ALTER COLUMN id SET DEFAULT nextval('public.libros_id_seq'::regclass);


--
-- Data for Name: decision_categorias; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.decision_categorias (escenario, categoria, slug, n_filas_crudas, n_duplicados, n_titulos, suma_estrellas, rating_promedio, precio_promedio, work_count, coincide_b, cobertura, elegible, priorizar, prioridad, u_rating, u_cobertura, min_titulos, cargado_en) FROM stdin;
base	Art	art	8	0	8	29	3.6250	38.52	135097	t	0.5922	t	t	1	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Poetry	poetry	19	0	19	67	3.5263	35.97	113628	t	1.6721	t	t	2	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Humor	humor	10	0	10	34	3.4000	33.50	28058	t	3.5640	t	t	3	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Spirituality	spirituality	6	0	6	20	3.3333	35.10	48746	t	1.2309	t	t	4	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Fiction	fiction	65	0	65	207	3.1846	36.07	666302	t	0.9755	t	t	5	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Music	music	13	0	13	41	3.1538	35.64	91481	t	1.4211	t	t	6	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Religion	religion	7	0	7	22	3.1429	32.57	171564	t	0.4080	t	t	7	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Sports and Games	sports	5	0	5	15	3.0000	41.17	30796	t	1.6236	t	t	8	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Adult Fiction	adult_fiction	1	0	1	5	5.0000	15.36	88	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Erotica	erotica	1	0	1	5	5.0000	19.19	1812	t	5.5188	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Novels	novels	1	0	1	5	5.0000	54.81	286	t	34.9650	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Christian Fiction	christian_fiction	6	0	6	25	4.1667	34.38	1620	t	37.0370	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Health	health	4	0	4	15	3.7500	51.45	37591	t	1.0641	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Young Adult	young_adult	54	0	54	178	3.2963	35.45	992	t	544.3548	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Historical Fiction	historical_fiction	26	0	26	84	3.2308	33.64	7840	t	33.1633	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	New Adult	new_adult	6	0	6	19	3.1667	46.38	185	t	324.3243	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Womens Fiction	womens_fiction	17	0	17	53	3.1176	36.79	7	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Fantasy	fantasy	48	0	48	148	3.0833	39.59	14957	t	32.0920	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Autobiography	autobiography	9	0	9	27	3.0000	37.05	4693	t	19.1775	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Historical	historical	2	0	2	6	3.0000	22.83	3504	t	5.7078	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Suspense	suspense	1	0	1	3	3.0000	58.33	4470	t	2.2371	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Sequential Art	comics	75	0	75	223	2.9733	34.57	564	t	1329.7872	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	History	history	18	0	18	53	2.9444	37.29	2559603	t	0.0703	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Mystery	mystery	32	0	32	94	2.9375	31.72	5980	t	53.5117	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Science	science	14	0	14	41	2.9286	33.09	105837	t	1.3228	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Business	business	12	0	12	35	2.9167	32.46	61065	t	1.9651	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Food and Drink	food_and_drink	30	0	30	87	2.9000	31.41	1369	t	219.1381	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Nonfiction	nonfiction	110	0	110	317	2.8818	34.26	39294	t	27.9941	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Default	default	152	0	152	431	2.8355	34.39	4	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Add a comment	add_a_comment	67	0	67	185	2.7612	35.80	0	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Thriller	thriller	11	0	11	30	2.7273	31.43	2865	t	38.3944	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Travel	travel	11	0	11	30	2.7273	39.79	88097	t	1.2486	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Horror	horror	17	0	17	46	2.7059	35.95	2911	t	58.3992	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Christian	christian	3	0	3	8	2.6667	42.50	930	t	32.2581	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Romance	romance	35	0	35	92	2.6286	33.93	22254	t	15.7275	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Childrens	juvenile_fiction	29	0	29	76	2.6207	32.64	176016	t	1.6476	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Self Help	self_help	5	0	5	13	2.6000	40.62	740	t	67.5676	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Classics	classics	19	0	19	47	2.4737	36.55	1634	t	116.2791	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Philosophy	philosophy	11	0	11	26	2.3636	33.56	204932	t	0.5368	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Contemporary	contemporary	3	0	3	7	2.3333	36.20	2499	t	12.0048	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Politics	politics	3	0	3	7	2.3333	53.61	4801	t	6.2487	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Science Fiction	science_fiction	16	0	16	36	2.2500	33.80	21278	t	7.5195	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Biography	biography	5	0	5	11	2.2000	33.66	916554	t	0.0546	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Academic	education	1	0	1	2	2.0000	13.12	274941	t	0.0364	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Parenting	parenting	1	0	1	2	2.0000	37.35	17838	t	0.5606	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Psychology	psychology	7	0	7	12	1.7143	34.22	97538	t	0.7177	t	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Crime	crime	1	0	1	1	1.0000	10.97	23579	t	0.4241	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Cultural	cultural	1	0	1	1	1.0000	36.58	3409	t	2.9334	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Paranormal	paranormal	1	0	1	1	1.0000	15.40	1125	t	8.8889	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
base	Short Stories	short_stories	1	0	1	1	1.0000	35.88	19439	t	0.5144	f	f	\N	3.00	5.00	5	2026-11-24 17:26:36.484668
cambio_decision	Art	art	8	0	8	29	3.6250	38.52	135097	t	0.5922	t	t	1	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Poetry	poetry	19	0	19	67	3.5263	35.97	113628	t	1.6721	t	t	2	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Humor	humor	10	0	10	34	3.4000	33.50	28058	t	3.5640	t	t	3	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Spirituality	spirituality	6	0	6	20	3.3333	35.10	48746	t	1.2309	t	t	4	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Fiction	fiction	65	0	65	207	3.1846	36.07	666302	t	0.9755	t	t	5	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Music	music	13	0	13	41	3.1538	35.64	91481	t	1.4211	t	t	6	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Religion	religion	7	0	7	22	3.1429	32.57	171564	t	0.4080	t	t	7	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	History	history	18	0	18	54	3.0000	37.29	2559603	t	0.0703	t	t	8	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Sports and Games	sports	5	0	5	15	3.0000	41.17	30796	t	1.6236	t	t	9	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Adult Fiction	adult_fiction	1	0	1	5	5.0000	15.36	88	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Erotica	erotica	1	0	1	5	5.0000	19.19	1812	t	5.5188	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Novels	novels	1	0	1	5	5.0000	54.81	286	t	34.9650	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Christian Fiction	christian_fiction	6	0	6	25	4.1667	34.38	1620	t	37.0370	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Health	health	4	0	4	15	3.7500	51.45	37591	t	1.0641	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Young Adult	young_adult	54	0	54	178	3.2963	35.45	992	t	544.3548	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Historical Fiction	historical_fiction	26	0	26	84	3.2308	33.64	7840	t	33.1633	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	New Adult	new_adult	6	0	6	19	3.1667	46.38	185	t	324.3243	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Womens Fiction	womens_fiction	17	0	17	53	3.1176	36.79	7	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Fantasy	fantasy	48	0	48	148	3.0833	39.59	14957	t	32.0920	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Autobiography	autobiography	9	0	9	27	3.0000	37.05	4693	t	19.1775	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Historical	historical	2	0	2	6	3.0000	22.83	3504	t	5.7078	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Suspense	suspense	1	0	1	3	3.0000	58.33	4470	t	2.2371	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Sequential Art	comics	75	0	75	223	2.9733	34.57	564	t	1329.7872	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Mystery	mystery	32	0	32	94	2.9375	31.72	5980	t	53.5117	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Science	science	14	0	14	41	2.9286	33.09	105837	t	1.3228	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Business	business	12	0	12	35	2.9167	32.46	61065	t	1.9651	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Food and Drink	food_and_drink	30	0	30	87	2.9000	31.41	1369	t	219.1381	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Nonfiction	nonfiction	110	0	110	317	2.8818	34.26	39294	t	27.9941	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Default	default	152	0	152	431	2.8355	34.39	4	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Add a comment	add_a_comment	67	0	67	185	2.7612	35.80	0	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Thriller	thriller	11	0	11	30	2.7273	31.43	2865	t	38.3944	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Travel	travel	11	0	11	30	2.7273	39.79	88097	t	1.2486	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Horror	horror	17	0	17	46	2.7059	35.95	2911	t	58.3992	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Christian	christian	3	0	3	8	2.6667	42.50	930	t	32.2581	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Romance	romance	35	0	35	92	2.6286	33.93	22254	t	15.7275	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Childrens	juvenile_fiction	29	0	29	76	2.6207	32.64	176016	t	1.6476	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Self Help	self_help	5	0	5	13	2.6000	40.62	740	t	67.5676	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Classics	classics	19	0	19	47	2.4737	36.55	1634	t	116.2791	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Philosophy	philosophy	11	0	11	26	2.3636	33.56	204932	t	0.5368	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Contemporary	contemporary	3	0	3	7	2.3333	36.20	2499	t	12.0048	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Politics	politics	3	0	3	7	2.3333	53.61	4801	t	6.2487	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Science Fiction	science_fiction	16	0	16	36	2.2500	33.80	21278	t	7.5195	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Biography	biography	5	0	5	11	2.2000	33.66	916554	t	0.0546	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Academic	education	1	0	1	2	2.0000	13.12	274941	t	0.0364	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Parenting	parenting	1	0	1	2	2.0000	37.35	17838	t	0.5606	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Psychology	psychology	7	0	7	12	1.7143	34.22	97538	t	0.7177	t	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Crime	crime	1	0	1	1	1.0000	10.97	23579	t	0.4241	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Cultural	cultural	1	0	1	1	1.0000	36.58	3409	t	2.9334	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Paranormal	paranormal	1	0	1	1	1.0000	15.40	1125	t	8.8889	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
cambio_decision	Short Stories	short_stories	1	0	1	1	1.0000	35.88	19439	t	0.5144	f	f	\N	3.00	5.00	5	2026-11-24 17:26:39.153953
duplicado	Art	art	8	0	8	29	3.6250	38.52	135097	t	0.5922	t	t	1	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Poetry	poetry	20	1	19	67	3.5263	35.97	113628	t	1.6721	t	t	2	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Humor	humor	10	0	10	34	3.4000	33.50	28058	t	3.5640	t	t	3	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Spirituality	spirituality	6	0	6	20	3.3333	35.10	48746	t	1.2309	t	t	4	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Fiction	fiction	65	0	65	207	3.1846	36.07	666302	t	0.9755	t	t	5	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Music	music	13	0	13	41	3.1538	35.64	91481	t	1.4211	t	t	6	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Religion	religion	7	0	7	22	3.1429	32.57	171564	t	0.4080	t	t	7	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Sports and Games	sports	5	0	5	15	3.0000	41.17	30796	t	1.6236	t	t	8	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Adult Fiction	adult_fiction	1	0	1	5	5.0000	15.36	88	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Erotica	erotica	1	0	1	5	5.0000	19.19	1812	t	5.5188	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Novels	novels	1	0	1	5	5.0000	54.81	286	t	34.9650	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Christian Fiction	christian_fiction	6	0	6	25	4.1667	34.38	1620	t	37.0370	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Health	health	4	0	4	15	3.7500	51.45	37591	t	1.0641	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Young Adult	young_adult	54	0	54	178	3.2963	35.45	992	t	544.3548	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Historical Fiction	historical_fiction	26	0	26	84	3.2308	33.64	7840	t	33.1633	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	New Adult	new_adult	6	0	6	19	3.1667	46.38	185	t	324.3243	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Womens Fiction	womens_fiction	17	0	17	53	3.1176	36.79	7	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Fantasy	fantasy	48	0	48	148	3.0833	39.59	14957	t	32.0920	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Autobiography	autobiography	9	0	9	27	3.0000	37.05	4693	t	19.1775	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Historical	historical	2	0	2	6	3.0000	22.83	3504	t	5.7078	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Suspense	suspense	1	0	1	3	3.0000	58.33	4470	t	2.2371	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Sequential Art	comics	75	0	75	223	2.9733	34.57	564	t	1329.7872	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	History	history	18	0	18	53	2.9444	37.29	2559603	t	0.0703	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Mystery	mystery	32	0	32	94	2.9375	31.72	5980	t	53.5117	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Science	science	14	0	14	41	2.9286	33.09	105837	t	1.3228	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Business	business	12	0	12	35	2.9167	32.46	61065	t	1.9651	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Food and Drink	food_and_drink	30	0	30	87	2.9000	31.41	1369	t	219.1381	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Nonfiction	nonfiction	110	0	110	317	2.8818	34.26	39294	t	27.9941	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Default	default	152	0	152	431	2.8355	34.39	4	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Add a comment	add_a_comment	67	0	67	185	2.7612	35.80	0	f	\N	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Thriller	thriller	11	0	11	30	2.7273	31.43	2865	t	38.3944	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Travel	travel	11	0	11	30	2.7273	39.79	88097	t	1.2486	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Horror	horror	17	0	17	46	2.7059	35.95	2911	t	58.3992	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Christian	christian	3	0	3	8	2.6667	42.50	930	t	32.2581	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Romance	romance	35	0	35	92	2.6286	33.93	22254	t	15.7275	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Childrens	juvenile_fiction	29	0	29	76	2.6207	32.64	176016	t	1.6476	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Self Help	self_help	5	0	5	13	2.6000	40.62	740	t	67.5676	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Classics	classics	19	0	19	47	2.4737	36.55	1634	t	116.2791	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Philosophy	philosophy	11	0	11	26	2.3636	33.56	204932	t	0.5368	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Contemporary	contemporary	3	0	3	7	2.3333	36.20	2499	t	12.0048	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Politics	politics	3	0	3	7	2.3333	53.61	4801	t	6.2487	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Science Fiction	science_fiction	16	0	16	36	2.2500	33.80	21278	t	7.5195	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Biography	biography	5	0	5	11	2.2000	33.66	916554	t	0.0546	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Academic	education	1	0	1	2	2.0000	13.12	274941	t	0.0364	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Parenting	parenting	1	0	1	2	2.0000	37.35	17838	t	0.5606	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Psychology	psychology	7	0	7	12	1.7143	34.22	97538	t	0.7177	t	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Crime	crime	1	0	1	1	1.0000	10.97	23579	t	0.4241	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Cultural	cultural	1	0	1	1	1.0000	36.58	3409	t	2.9334	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Paranormal	paranormal	1	0	1	1	1.0000	15.40	1125	t	8.8889	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
duplicado	Short Stories	short_stories	1	0	1	1	1.0000	35.88	19439	t	0.5144	f	f	\N	3.00	5.00	5	2026-11-24 17:26:41.919598
\.


--
-- Data for Name: libros; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.libros (id, escenario, id_libro, categoria, titulo, precio_gbp, estrellas, disponibilidad, es_duplicado) FROM stdin;
1	base	981	Travel	It's Only the Himalayas	45.17	2	In stock	f
2	base	811	Travel	Full Moon over Noah’s Ark: An Odyssey to Mount Ararat and Beyond	49.43	4	In stock	f
3	base	732	Travel	See America: A Celebration of Our National Parks & Treasured Sites	48.87	3	In stock	f
4	base	552	Travel	Vagabonding: An Uncommon Guide to the Art of Long-Term World Travel	36.94	2	In stock	f
5	base	504	Travel	Under the Tuscan Sun	37.33	3	In stock	f
6	base	458	Travel	A Summer In Europe	44.34	2	In stock	f
7	base	446	Travel	The Great Railway Bazaar	30.54	1	In stock	f
8	base	421	Travel	A Year in Provence (Provence #1)	56.88	4	In stock	f
9	base	277	Travel	The Road to Little Dribbling: Adventures of an American in Britain (Notes From a Small Island #2)	23.21	1	In stock	f
10	base	198	Travel	Neither Here nor There: Travels in Europe	38.95	3	In stock	f
11	base	1	Travel	1,000 Places to See Before You Die	26.08	5	In stock	f
12	base	997	Mystery	Sharp Objects	47.82	4	In stock	f
13	base	963	Mystery	In a Dark, Dark Wood	19.63	1	In stock	f
14	base	942	Mystery	The Past Never Ends	56.50	4	In stock	f
15	base	877	Mystery	A Murder in Time	16.64	1	In stock	f
16	base	852	Mystery	The Murder of Roger Ackroyd (Hercule Poirot #4)	44.10	4	In stock	f
17	base	754	Mystery	The Last Mile (Amos Decker #2)	54.21	2	In stock	f
18	base	743	Mystery	That Darkness (Gardiner and Renner #1)	13.92	1	In stock	f
19	base	742	Mystery	Tastes Like Fear (DI Marnie Rome #3)	10.69	1	In stock	f
20	base	657	Mystery	A Time of Torment (Charlie Parker #14)	48.35	5	In stock	f
21	base	656	Mystery	A Study in Scarlet (Sherlock Holmes #1)	16.73	2	In stock	f
22	base	627	Mystery	Poisonous (Max Revere Novels #3)	26.80	3	In stock	f
23	base	624	Mystery	Murder at the 42nd Street Library (Raymond Ambler #1)	54.36	4	In stock	f
24	base	623	Mystery	Most Wanted	35.28	3	In stock	f
25	base	620	Mystery	Hide Away (Eve Duncan #20)	11.84	1	In stock	f
26	base	613	Mystery	Boar Island (Anna Pigeon #19)	59.48	3	In stock	f
27	base	609	Mystery	The Widow	27.26	2	In stock	f
28	base	602	Mystery	Playing with Fire	13.71	3	In stock	f
29	base	506	Mystery	What Happened on Beale Street (Secrets of the South Mysteries #2)	25.37	5	In stock	f
30	base	491	Mystery	The Bachelor Girl's Guide to Murder (Herringford and Watts Mysteries #1)	52.30	5	In stock	f
31	base	464	Mystery	Delivering the Truth (Quaker Midwife Mystery #1)	20.89	4	In stock	f
32	base	452	Mystery	The Mysterious Affair at Styles (Hercule Poirot #1)	24.80	4	In stock	f
33	base	433	Mystery	In the Woods (Dublin Murder Squad #1)	38.38	2	In stock	f
34	base	280	Mystery	The Silkworm (Cormoran Strike #2)	23.05	5	In stock	f
35	base	247	Mystery	The Exiled	43.45	3	In stock	f
36	base	239	Mystery	The Cuckoo's Calling (Cormoran Strike #1)	19.21	1	In stock	f
37	base	154	Mystery	Extreme Prey (Lucas Davenport #26)	25.40	3	In stock	f
38	base	137	Mystery	Career of Evil (Cormoran Strike #3)	24.72	2	In stock	f
39	base	76	Mystery	The No. 1 Ladies' Detective Agency (No. 1 Ladies' Detective Agency #1)	57.70	4	In stock	f
40	base	66	Mystery	The Girl You Lost	12.29	5	In stock	f
41	base	65	Mystery	The Girl In The Ice (DCI Erika Foster #1)	15.85	3	In stock	f
42	base	8	Mystery	Blood Defense (Samantha Brinkman #1)	20.30	3	In stock	f
43	base	2	Mystery	1st to Die (Women's Murder Club #1)	53.98	1	In stock	f
44	base	999	Historical Fiction	Tipping the Velvet	53.74	1	In stock	f
45	base	894	Historical Fiction	Forever and Forever: The Courtship of Henry Longfellow and Fanny Appleton	29.69	3	In stock	f
46	base	876	Historical Fiction	A Flight of Arrows (The Pathfinders #2)	55.53	5	In stock	f
47	base	846	Historical Fiction	The House by the Lake	36.95	1	In stock	f
48	base	821	Historical Fiction	Mrs. Houdini	30.25	5	In stock	f
49	base	759	Historical Fiction	The Marriage of Opposites	28.08	4	In stock	f
50	base	696	Historical Fiction	Glory over Everything: Beyond The Kitchen House	45.84	3	In stock	f
51	base	622	Historical Fiction	Love, Lies and Spies	20.55	2	In stock	f
52	base	612	Historical Fiction	A Paris Apartment	39.01	4	In stock	f
53	base	597	Historical Fiction	Lilac Girls	17.28	2	In stock	f
54	base	493	Historical Fiction	The Constant Princess (The Tudor Court #1)	16.62	3	In stock	f
55	base	448	Historical Fiction	The Invention of Wings	37.34	1	In stock	f
56	base	420	Historical Fiction	World Without End (The Pillars of the Earth #2)	32.97	4	In stock	f
57	base	351	Historical Fiction	The Passion of Dolssa	28.32	5	In stock	f
58	base	322	Historical Fiction	Girl With a Pearl Earring	26.77	1	In stock	f
59	base	299	Historical Fiction	Voyager (Outlander #3)	21.07	5	In stock	f
60	base	273	Historical Fiction	The Red Tent	35.66	5	In stock	f
61	base	259	Historical Fiction	The Last Painting of Sara de Vos	55.55	2	In stock	f
62	base	253	Historical Fiction	The Guernsey Literary and Potato Peel Pie Society	49.53	1	In stock	f
63	base	160	Historical Fiction	Girl in the Blue Coat	46.83	2	In stock	f
64	base	128	Historical Fiction	Between Shades of Gray	20.79	5	In stock	f
65	base	97	Historical Fiction	While You Were Mine	41.32	5	In stock	f
66	base	80	Historical Fiction	The Secret Healer	34.56	3	In stock	f
67	base	56	Historical Fiction	Starlark	25.83	3	In stock	f
68	base	31	Historical Fiction	Lost Among the Living	27.70	4	In stock	f
69	base	3	Historical Fiction	A Spy's Devotion (The Regency Spies of London #1)	16.97	5	In stock	f
70	base	987	Sequential Art	Scott Pilgrim's Precious Little Life (Scott Pilgrim #1)	52.29	5	In stock	f
71	base	949	Sequential Art	Tsubasa: WoRLD CHRoNiCLE 2 (Tsubasa WoRLD CHRoNiCLE #2)	16.28	1	In stock	f
72	base	947	Sequential Art	This One Summer	19.49	4	In stock	f
73	base	940	Sequential Art	The Nameless City (The Nameless City #1)	38.16	4	In stock	f
74	base	923	Sequential Art	Saga, Volume 5 (Saga (Collected Editions) #5)	51.04	2	In stock	f
75	base	921	Sequential Art	Rat Queens, Vol. 3: Demons (Rat Queens (Collected Editions) #11-15)	50.40	3	In stock	f
76	base	920	Sequential Art	Princess Jellyfish 2-in-1 Omnibus, Vol. 01 (Princess Jellyfish 2-in-1 Omnibus #1)	13.61	5	In stock	f
77	base	918	Sequential Art	Pop Gun War, Volume 1: Gift	18.97	1	In stock	f
78	base	916	Sequential Art	Patience	10.16	3	In stock	f
79	base	915	Sequential Art	Outcast, Vol. 1: A Darkness Surrounds Him (Outcast #1)	15.44	4	In stock	f
80	base	914	Sequential Art	orange: The Complete Collection 1 (orange: The Complete Collection #1)	48.41	1	In stock	f
81	base	907	Sequential Art	Lumberjanes, Vol. 2: Friendship to the Max (Lumberjanes #5-8)	46.91	2	In stock	f
82	base	906	Sequential Art	Lumberjanes, Vol. 1: Beware the Kitten Holy (Lumberjanes #1-4)	45.61	3	In stock	f
83	base	905	Sequential Art	Lumberjanes Vol. 3: A Terrible Plan (Lumberjanes #9-12)	19.92	2	In stock	f
84	base	899	Sequential Art	I Hate Fairyland, Vol. 1: Madly Ever After (I Hate Fairyland (Compilations) #1-5)	29.17	2	In stock	f
85	base	898	Sequential Art	I am a Hero Omnibus Volume 1	54.63	3	In stock	f
86	base	895	Sequential Art	Giant Days, Vol. 2 (Giant Days #5-8)	22.11	2	In stock	f
87	base	889	Sequential Art	Danganronpa Volume 1	51.99	4	In stock	f
88	base	887	Sequential Art	Codename Baboushka, Volume 1: The Conclave of Death	36.72	4	In stock	f
89	base	886	Sequential Art	Camp Midnight	17.08	4	In stock	f
90	base	882	Sequential Art	Bitch Planet, Vol. 1: Extraordinary Machine (Bitch Planet (Collected Editions))	37.92	2	In stock	f
91	base	860	Sequential Art	The Shadow Hero (The Shadow Hero)	33.14	1	In stock	f
92	base	806	Sequential Art	Fables, Vol. 1: Legends in Exile (Fables #1)	41.62	4	In stock	f
93	base	793	Sequential Art	Batman: The Long Halloween (Batman)	36.50	2	In stock	f
94	base	792	Sequential Art	Batman: The Dark Knight Returns (Batman)	15.38	5	In stock	f
95	base	783	Sequential Art	Wonder Woman: Earth One, Volume One (Wonder Woman: Earth One #1)	37.34	4	In stock	f
96	base	778	Sequential Art	We Are Robin, Vol. 1: The Vigilante Business (We Are Robin #1)	53.90	1	In stock	f
97	base	772	Sequential Art	Through the Woods	25.38	2	In stock	f
98	base	739	Sequential Art	Superman Vol. 1: Before Truth (Superman by Gene Luen Yang #1)	11.89	5	In stock	f
99	base	734	Sequential Art	So Cute It Hurts!!, Vol. 6 (So Cute It Hurts!! #6)	35.43	4	In stock	f
100	base	730	Sequential Art	Robin War	47.82	3	In stock	f
101	base	729	Sequential Art	Red Hood/Arsenal, Vol. 1: Open for Business (Red Hood/Arsenal #1)	25.48	2	In stock	f
102	base	721	Sequential Art	Naruto (3-in-1 Edition), Vol. 14: Includes Vols. 40, 41 & 42 (Naruto: Omnibus #14)	38.39	2	In stock	f
103	base	712	Sequential Art	Lowriders to the Center of the Earth (Lowriders in Space #2)	51.51	2	In stock	f
104	base	691	Sequential Art	El Deafo	57.62	5	In stock	f
105	base	668	Sequential Art	Batman: Europa	32.01	2	In stock	f
106	base	664	Sequential Art	Art Ops Vol. 1	48.80	3	In stock	f
107	base	659	Sequential Art	Adulthood Is a Myth: A "Sarah's Scribbles" Collection	10.90	2	In stock	f
108	base	563	Sequential Art	Fruits Basket, Vol. 9 (Fruits Basket #9)	33.95	4	In stock	f
109	base	540	Sequential Art	Roller Girl	14.10	5	In stock	f
110	base	468	Sequential Art	Fruits Basket, Vol. 7 (Fruits Basket #7)	19.57	1	In stock	f
111	base	427	Sequential Art	Fruits Basket, Vol. 6 (Fruits Basket #6)	20.96	4	In stock	f
112	base	425	Sequential Art	Death Note, Vol. 6: Give-and-Take (Death Note #6)	36.39	3	In stock	f
113	base	376	Sequential Art	Fruits Basket, Vol. 5 (Fruits Basket #5)	16.33	1	In stock	f
114	base	368	Sequential Art	Death Note, Vol. 5: Whiteout (Death Note #5)	52.41	1	In stock	f
115	base	344	Sequential Art	The Demon Prince of Momochi House, Vol. 4 (The Demon Prince of Momochi House #4)	27.88	2	In stock	f
116	base	321	Sequential Art	Fruits Basket, Vol. 4 (Fruits Basket #4)	50.44	4	In stock	f
117	base	287	Sequential Art	The Wicked + The Divine, Vol. 3: Commercial Suicide (The Wicked + The Divine)	14.41	3	In stock	f
118	base	279	Sequential Art	The Sandman, Vol. 3: Dream Country (The Sandman (volumes) #3)	55.55	5	In stock	f
119	base	216	Sequential Art	Saga, Volume 3 (Saga (Collected Editions) #3)	21.57	5	In stock	f
120	base	207	Sequential Art	Prodigy: The Graphic Novel (Legend: The Graphic Novel #2)	43.63	3	In stock	f
121	base	206	Sequential Art	Persepolis: The Story of a Childhood (Persepolis #1-2)	39.13	1	In stock	f
122	base	203	Sequential Art	Original Fake	31.45	3	In stock	f
123	base	164	Sequential Art	Grayson, Vol 3: Nemesis (Grayson #3)	42.72	1	In stock	f
124	base	159	Sequential Art	Fruits Basket, Vol. 3 (Fruits Basket #3)	45.17	2	In stock	f
125	base	130	Sequential Art	Black Butler, Vol. 1 (Black Butler #1)	49.31	1	In stock	f
126	base	124	Sequential Art	Awkward	38.02	2	In stock	f
127	base	110	Sequential Art	The Sandman, Vol. 2: The Doll's House (The Sandman (volumes) #2)	54.81	1	In stock	f
128	base	107	Sequential Art	Saga, Volume 2 (Saga (Collected Editions) #2)	11.75	3	In stock	f
129	base	100	Sequential Art	Fruits Basket, Vol. 2 (Fruits Basket #2)	11.64	5	In stock	f
130	base	98	Sequential Art	Y: The Last Man, Vol. 1: Unmanned (Y: The Last Man #1)	18.51	4	In stock	f
131	base	86	Sequential Art	The Wicked + The Divine, Vol. 1: The Faust Act (The Wicked + The Divine)	36.52	2	In stock	f
132	base	79	Sequential Art	The Sandman, Vol. 1: Preludes and Nocturnes (The Sandman (volumes) #1)	54.12	3	In stock	f
133	base	62	Sequential Art	The Complete Maus (Maus #1-2)	10.64	3	In stock	f
134	base	55	Sequential Art	Skip Beat!, Vol. 01 (Skip Beat! #1)	42.12	3	In stock	f
135	base	48	Sequential Art	Saga, Volume 1 (Saga (Collected Editions) #1)	28.48	1	In stock	f
483	base	791	Default	Ayumi's Violin	15.48	2	In stock	f
136	base	46	Sequential Art	Rat Queens, Vol. 1: Sass & Sorcery (Rat Queens (Collected Editions) #1-5)	46.96	5	In stock	f
137	base	44	Sequential Art	Paper Girls, Vol. 1 (Paper Girls #1-5)	21.71	4	In stock	f
138	base	43	Sequential Art	Ouran High School Host Club, Vol. 1 (Ouran High School Host Club #1)	29.87	3	In stock	f
139	base	34	Sequential Art	Ms. Marvel, Vol. 1: No Normal (Ms. Marvel (2014-2015) #1)	39.39	4	In stock	f
140	base	24	Sequential Art	Hawkeye, Vol. 1: My Life as a Weapon (Hawkeye #1)	45.24	3	In stock	f
141	base	22	Sequential Art	Giant Days, Vol. 1 (Giant Days #1-4)	56.76	4	In stock	f
142	base	21	Sequential Art	Fruits Basket, Vol. 1 (Fruits Basket #1)	40.28	5	In stock	f
143	base	7	Sequential Art	Bleach, Vol. 1: Strawberry and the Soul Reapers (Bleach #1)	34.65	5	In stock	f
144	base	4	Sequential Art	Ajin: Demi-Human, Volume 1 (Ajin: Demi-Human #1)	57.06	4	In stock	f
145	base	413	Classics	The Secret Garden	15.08	4	In stock	f
146	base	409	Classics	The Metamorphosis	28.58	1	In stock	f
147	base	353	Classics	The Pilgrim's Progress	50.26	2	In stock	f
148	base	348	Classics	The Hound of the Baskervilles (Sherlock Holmes #5)	14.82	2	In stock	f
149	base	331	Classics	Little Women (Little Women #1)	28.07	4	In stock	f
150	base	324	Classics	Gone with the Wind	32.49	3	In stock	f
151	base	316	Classics	Candide	58.63	3	In stock	f
152	base	313	Classics	Animal Farm	57.22	3	In stock	f
153	base	307	Classics	Wuthering Heights	17.73	3	In stock	f
154	base	270	Classics	The Picture of Dorian Gray	29.70	2	In stock	f
155	base	238	Classics	The Complete Stories and Poems (The Works of Edgar Allan Poe [Cameo Edition])	26.78	4	In stock	f
156	base	126	Classics	Beowulf	38.35	2	In stock	f
157	base	119	Classics	And Then There Were None	35.01	2	In stock	f
158	base	84	Classics	The Story of Hong Gildong	43.19	4	In stock	f
159	base	72	Classics	The Little Prince	45.42	2	In stock	f
160	base	49	Classics	Sense and Sensibility	37.46	1	In stock	f
161	base	37	Classics	Of Mice and Men	47.11	2	In stock	f
162	base	17	Classics	Emma	32.93	2	In stock	f
163	base	5	Classics	Alice in Wonderland (Alice's Adventures in Wonderland #1)	55.53	1	In stock	f
164	base	966	Philosophy	Sophie's World	15.94	5	In stock	f
165	base	932	Philosophy	The Death of Humanity: and the Case for Life	58.11	4	In stock	f
166	base	861	Philosophy	The Stranger	17.44	4	In stock	f
167	base	538	Philosophy	Proofs of God: Classical Arguments from Tertullian to Barth	54.21	1	In stock	f
168	base	527	Philosophy	Kierkegaard: A Christian Missionary to Christians	47.13	1	In stock	f
169	base	459	Philosophy	At The Existentialist Café: Freedom, Being, and apricot cocktails with: Jean-Paul Sartre, Simone de Beauvoir, Albert Camus, Martin Heidegger, Edmund Husserl, Karl Jaspers, Maurice Merleau-Ponty and others	29.93	5	In stock	f
170	base	366	Philosophy	Critique of Pure Reason	20.75	1	In stock	f
171	base	106	Philosophy	Run, Spot, Run: The Ethics of Keeping Pets	20.02	1	In stock	f
172	base	75	Philosophy	The Nicomachean Ethics	36.34	1	In stock	f
173	base	33	Philosophy	Meditations	25.89	2	In stock	f
174	base	6	Philosophy	Beyond Good and Evil	43.38	1	In stock	f
175	base	977	Romance	Chase Me (Paris Nights #2)	25.27	5	In stock	f
176	base	976	Romance	Black Dust	34.53	5	In stock	f
177	base	896	Romance	Her Backup Boyfriend (The Sorensen Family #1)	33.97	1	In stock	f
178	base	893	Romance	First and First (Five Boroughs #3)	15.97	4	In stock	f
179	base	892	Romance	Fifty Shades Darker (Fifty Shades #2)	21.96	1	In stock	f
180	base	864	Romance	The Wedding Dress	24.12	1	In stock	f
181	base	835	Romance	Suddenly in Love (Lake Haven #1)	55.99	2	In stock	f
182	base	834	Romance	Something More Than This	16.24	4	In stock	f
183	base	802	Romance	Doing It Over (Most Likely To #1)	35.61	3	In stock	f
184	base	767	Romance	The Wedding Pact (The O'Malleys #2)	32.61	3	In stock	f
185	base	700	Romance	Hold Your Breath (Search and Rescue #1)	28.82	1	In stock	f
186	base	615	Romance	Dirty (Dive Bar #1)	40.83	4	In stock	f
187	base	605	Romance	Take Me Home Tonight (Rock Star Romance #3)	53.98	3	In stock	f
188	base	601	Romance	Off the Hook (Fishing for Trouble #1)	47.67	3	In stock	f
189	base	584	Romance	A Gentleman's Position (Society of Gentlemen #3)	14.75	5	In stock	f
190	base	486	Romance	Sit, Stay, Love	20.90	3	In stock	f
191	base	359	Romance	A Girl's Guide to Moving On (New Beginnings #2)	31.30	1	In stock	f
192	base	352	Romance	The Perfect Play (Play by Play #1)	59.99	3	In stock	f
193	base	319	Romance	Dark Lover (Black Dagger Brotherhood #1)	12.87	1	In stock	f
194	base	317	Romance	Changing the Game (Play by Play #2)	13.38	3	In stock	f
195	base	312	Romance	A Walk to Remember	56.43	1	In stock	f
196	base	271	Romance	The Purest Hook (Second Circle Tattoos #3)	12.25	1	In stock	f
197	base	268	Romance	The Obsession	45.43	1	In stock	f
198	base	211	Romance	Reservations for Two	11.10	3	In stock	f
199	base	127	Romance	Best of My Love (Fool's Gold #20)	27.41	2	In stock	f
200	base	96	Romance	Where Lightning Strikes (Bleeding Stars #3)	39.77	3	In stock	f
201	base	88	Romance	This One Moment (Pushing Limits #1)	48.71	1	In stock	f
202	base	47	Romance	Rhythm, Chord & Malykhin	28.34	2	In stock	f
203	base	35	Romance	My Perfect Mistake (Over the Top #1)	38.92	2	In stock	f
204	base	29	Romance	Listen to Me (Fusion #1)	58.99	3	In stock	f
205	base	26	Romance	Imperfect Harmony	34.74	4	In stock	f
206	base	18	Romance	Fighting Fate (Fighting #6)	39.24	3	In stock	f
207	base	15	Romance	Deep Under (Walker Security #1)	47.09	5	In stock	f
208	base	12	Romance	Charity's Cross (Charles Towne Belles #4)	41.24	1	In stock	f
209	base	9	Romance	Bounty (Colorado Mountain #7)	37.26	4	In stock	f
210	base	814	Womens Fiction	I Had a Nice Time And Other Lies...: How to find love & sh*t like that	57.36	4	In stock	f
211	base	644	Womens Fiction	Will You Won't You Want Me?	13.86	3	In stock	f
212	base	594	Womens Fiction	Keep Me Posted	20.46	4	In stock	f
213	base	592	Womens Fiction	Grey (Fifty Shades #4)	48.49	4	In stock	f
214	base	478	Womens Fiction	Meternity	43.58	3	In stock	f
215	base	341	Womens Fiction	Some Women	13.73	5	In stock	f
216	base	340	Womens Fiction	Shopaholic Ties the Knot (Shopaholic #3)	48.39	5	In stock	f
217	base	315	Womens Fiction	Can You Keep a Secret?	21.94	1	In stock	f
218	base	292	Womens Fiction	Twenties Girl	42.80	2	In stock	f
219	base	286	Womens Fiction	The Undomestic Goddess	45.75	4	In stock	f
220	base	265	Womens Fiction	The Nanny Diaries (Nanny #1)	52.53	5	In stock	f
221	base	243	Womens Fiction	The Devil Wears Prada (The Devil Wears Prada #1)	44.29	1	In stock	f
222	base	224	Womens Fiction	Something Borrowed (Darcy & Rachel #1)	48.96	5	In stock	f
223	base	223	Womens Fiction	Something Blue (Darcy & Rachel #2)	54.62	1	In stock	f
224	base	173	Womens Fiction	I've Got Your Number	19.69	1	In stock	f
225	base	63	Womens Fiction	The Edge of Reason (Bridget Jones #2)	19.18	4	In stock	f
226	base	10	Womens Fiction	Bridget Jones's Diary (Bridget Jones #1)	29.82	1	In stock	f
227	base	998	Fiction	Soumission	50.10	1	In stock	f
228	base	958	Fiction	Private Paris (Private #10)	47.61	5	In stock	f
229	base	954	Fiction	We Love You, Charlie Freeman	50.27	5	In stock	f
230	base	946	Fiction	Thirst	17.27	5	In stock	f
231	base	939	Fiction	The Murder That Never Was (Forensic Instincts #5)	54.11	3	In stock	f
232	base	870	Fiction	Tuesday Nights in 1980	21.04	2	In stock	f
233	base	863	Fiction	The Vacationers	42.15	4	In stock	f
234	base	858	Fiction	The Regional Office Is Under Attack!	51.36	5	In stock	f
235	base	807	Fiction	Finders Keepers (Bill Hodges Trilogy #2)	53.53	5	In stock	f
236	base	766	Fiction	The Time Keeper	27.88	5	In stock	f
237	base	765	Fiction	The Testament of Mary	52.67	4	In stock	f
238	base	749	Fiction	The First Hostage (J.B. Collins #2)	25.85	3	In stock	f
239	base	741	Fiction	Take Me with You	45.21	3	In stock	f
240	base	738	Fiction	Still Life with Bread Crumbs	26.41	3	In stock	f
241	base	733	Fiction	Shtum	55.84	4	In stock	f
242	base	720	Fiction	My Name Is Lucy Barton	41.56	1	In stock	f
243	base	719	Fiction	My Mrs. Brown	24.48	3	In stock	f
244	base	717	Fiction	Mr. Mercedes (Bill Hodges Trilogy #1)	28.90	1	In stock	f
245	base	703	Fiction	I Am Pilgrim (Pilgrim #1)	10.60	4	In stock	f
246	base	692	Fiction	Eligible (The Austen Project #4)	27.09	3	In stock	f
247	base	690	Fiction	Eight Hundred Grapes	14.39	4	In stock	f
248	base	684	Fiction	Dear Mr. Knightley	11.21	5	In stock	f
249	base	681	Fiction	Cometh the Hour (The Clifton Chronicles #6)	25.01	3	In stock	f
250	base	665	Fiction	Balloon Animals	17.03	3	In stock	f
251	base	653	Fiction	A Man Called Ove	39.72	1	In stock	f
252	base	641	Fiction	The Silent Sister (Riley MacPherson #1)	46.29	5	In stock	f
253	base	635	Fiction	The Dinner Party	56.54	2	In stock	f
254	base	607	Fiction	The Improbability of Love	59.45	1	In stock	f
255	base	600	Fiction	Mothering Sunday	13.34	2	In stock	f
256	base	596	Fiction	Lies and Other Acts of Love	45.14	1	In stock	f
257	base	590	Fiction	Daredevils	16.34	3	In stock	f
258	base	583	Fiction	11/22/63	48.48	3	In stock	f
259	base	576	Fiction	The Shack	28.03	1	In stock	f
260	base	547	Fiction	The High Mountains of Portugal	51.15	1	In stock	f
261	base	534	Fiction	Miller's Valley	58.54	2	In stock	f
262	base	523	Fiction	Hystopia: A Novel	21.96	4	In stock	f
263	base	492	Fiction	The Bourne Identity (Jason Bourne #1)	42.78	4	In stock	f
264	base	485	Fiction	Sister Dear	40.20	4	In stock	f
265	base	477	Fiction	Memoirs of a Geisha	49.67	3	In stock	f
266	base	434	Fiction	Me Before You (Me Before You #1)	19.02	1	In stock	f
267	base	426	Fiction	Deception Point	40.32	4	In stock	f
268	base	407	Fiction	The Little Paris Bookshop	24.73	3	In stock	f
269	base	404	Fiction	The Firm	45.56	3	In stock	f
270	base	401	Fiction	The Expatriates	44.58	2	In stock	f
271	base	393	Fiction	Siddhartha	34.22	5	In stock	f
272	base	383	Fiction	Last One Home (New Beginnings #1)	59.98	3	In stock	f
273	base	369	Fiction	Digital Fortress	58.00	5	In stock	f
274	base	314	Fiction	Atlas Shrugged	26.58	5	In stock	f
275	base	290	Fiction	Three-Martini Lunch	23.21	3	In stock	f
276	base	267	Fiction	The Nightingale	26.26	4	In stock	f
277	base	257	Fiction	The Infinities	27.41	1	In stock	f
278	base	256	Fiction	The Husband's Secret	52.51	5	In stock	f
279	base	240	Fiction	The Da Vinci Code (Robert Langdon #2)	22.96	2	In stock	f
280	base	228	Fiction	The Art of Fielding	22.10	1	In stock	f
281	base	190	Fiction	Lila (Gilead #3)	12.47	3	In stock	f
282	base	180	Fiction	Jurassic Park (Jurassic Park #1)	44.97	1	In stock	f
283	base	176	Fiction	Inferno (Robert Langdon #4)	41.00	5	In stock	f
284	base	143	Fiction	Crazy Rich Asians (Crazy Rich Asians #1)	49.13	5	In stock	f
285	base	129	Fiction	Big Little Lies	22.11	1	In stock	f
286	base	109	Fiction	The Course of Love	16.78	3	In stock	f
287	base	95	Fiction	When I'm Gone	51.96	3	In stock	f
288	base	83	Fiction	The Silent Wife	12.34	5	In stock	f
289	base	59	Fiction	The Bette Davis Club	30.66	3	In stock	f
290	base	28	Fiction	Kitchens of the Great Midwest	57.20	5	In stock	f
291	base	11	Fiction	Bright Lines	39.07	5	In stock	f
292	base	975	Childrens	Birdsong: A Story in Pictures	54.64	3	In stock	f
293	base	967	Childrens	The Bear and the Piano	36.89	1	In stock	f
294	base	944	Childrens	The Secret of Dreadwillow Carse	56.13	1	In stock	f
295	base	865	Childrens	The White Cat and the Monk: A Retelling of the Poem “Pangur Bán”	58.08	4	In stock	f
296	base	817	Childrens	Little Red	13.47	3	In stock	f
297	base	777	Childrens	Walt Disney's Alice in Wonderland	12.96	5	In stock	f
298	base	773	Childrens	Twenty Yawns	22.08	2	In stock	f
299	base	728	Childrens	Rain Fish	23.57	3	In stock	f
300	base	724	Childrens	Once Was a Time	18.28	2	In stock	f
301	base	714	Childrens	Luis Paints the World	53.95	3	In stock	f
302	base	567	Childrens	Nap-a-Roo	25.08	1	In stock	f
303	base	501	Childrens	The Whale	35.96	4	In stock	f
304	base	484	Childrens	Shrunken Treasures: Literary Classics, Short, Sweet, and Silly	52.87	3	In stock	f
305	base	482	Childrens	Raymie Nightingale	34.41	2	In stock	f
306	base	481	Childrens	Playing from the Heart	32.38	1	In stock	f
307	base	386	Childrens	Maybe Something Beautiful: How Art Transformed a Neighborhood	22.54	1	In stock	f
308	base	288	Childrens	The Wild Robot	56.07	3	In stock	f
309	base	283	Childrens	The Thing About Jellyfish	48.77	1	In stock	f
310	base	261	Childrens	The Lonely Ones	43.59	5	In stock	f
311	base	241	Childrens	The Day the Crayons Came Home (Crayons)	26.33	5	In stock	f
312	base	235	Childrens	The Cat in the Hat (Beginner Books B-1)	16.26	2	In stock	f
313	base	210	Childrens	Red: The True Story of Red Riding Hood	28.54	3	In stock	f
314	base	168	Childrens	Horrible Bear!	37.52	2	In stock	f
315	base	165	Childrens	Green Eggs and Ham (Beginner Books B-16)	10.79	4	In stock	f
316	base	142	Childrens	Counting Thyme	10.62	1	In stock	f
317	base	122	Childrens	Are We There Yet?	10.66	3	In stock	f
318	base	99	Childrens	Diary of a Minecraft Zombie Book 1: A Scare of a Dare (An Unofficial Minecraft Book)	52.88	4	In stock	f
319	base	32	Childrens	Matilda	28.34	1	In stock	f
320	base	13	Childrens	Charlie and the Chocolate Factory (Charlie Bucket #1)	22.85	3	In stock	f
321	base	890	Religion	Don't Be a Jerk: And Other Practical Advice from Dogen, Japan's Greatest Zen Master	37.97	2	In stock	f
322	base	872	Religion	You Are What You Love: The Spiritual Power of Habit	21.87	4	In stock	f
323	base	697	Religion	God: The Most Unpleasant Character in All Fiction	30.03	5	In stock	f
324	base	571	Religion	The Book of Mormon	24.57	3	In stock	f
325	base	310	Religion	A History of God: The 4,000-Year Quest of Judaism, Christianity, and Islam	27.62	1	In stock	f
326	base	60	Religion	The Bhagavad Gita	57.49	3	In stock	f
327	base	14	Religion	Choosing Our Religion: The Spiritual Lives of America's Nones	28.42	4	In stock	f
328	base	972	Nonfiction	Worlds Elsewhere: Journeys Around Shakespeare’s Globe	40.30	5	In stock	f
329	base	969	Nonfiction	The Five Love Languages: How to Express Heartfelt Commitment to Your Mate	31.05	3	In stock	f
330	base	959	Nonfiction	Reasons to Stay Alive	26.41	2	In stock	f
331	base	957	Nonfiction	#HigherSelfie: Wake Up Your Life. Free Your Soul. Find Your Tribe.	23.11	5	In stock	f
332	base	952	Nonfiction	Unseen City: The Majesty of Pigeons, the Discreet Charm of Snails & Other Wonders of the Urban Wilderness	44.18	4	In stock	f
333	base	948	Nonfiction	Throwing Rocks at the Google Bus: How Growth Became the Enemy of Prosperity	31.12	3	In stock	f
334	base	936	Nonfiction	The Life-Changing Magic of Tidying Up: The Japanese Art of Decluttering and Organizing	16.77	3	In stock	f
335	base	934	Nonfiction	The Gutsy Girl: Escapades for Your Life of Epic Adventure	37.13	1	In stock	f
336	base	933	Nonfiction	The Electric Pencil: Drawings from Inside State Hospital No. 3	56.06	1	In stock	f
337	base	927	Nonfiction	Spark Joy: An Illustrated Master Class on the Art of Organizing and Tidying Up	41.83	4	In stock	f
338	base	922	Nonfiction	Reskilling America: Learning to Labor in the Twenty-First Century	19.83	2	In stock	f
339	base	901	Nonfiction	In the Country We Love: My Family Divided	22.00	4	In stock	f
340	base	891	Nonfiction	Everydata: The Misinformation Hidden in the Little Data You Consume Every Day	54.35	2	In stock	f
341	base	885	Nonfiction	Call the Nurse: True Stories of a Country Nurse on a Scottish Isle	29.14	5	In stock	f
342	base	880	Nonfiction	Algorithms to Live By: The Computer Science of Human Decisions	30.81	1	In stock	f
343	base	855	Nonfiction	The Power of Now: A Guide to Spiritual Enlightenment	43.54	2	In stock	f
344	base	854	Nonfiction	The Omnivore's Dilemma: A Natural History of Four Meals	38.21	2	In stock	f
345	base	843	Nonfiction	The Genius of Birds	17.24	1	In stock	f
346	base	839	Nonfiction	The Artist's Way: A Spiritual Path to Higher Creativity	38.49	5	In stock	f
347	base	832	Nonfiction	So You've Been Publicly Shamed	12.23	2	In stock	f
348	base	799	Nonfiction	Daring Greatly: How the Courage to Be Vulnerable Transforms the Way We Live, Love, Parent, and Lead	19.43	3	In stock	f
349	base	796	Nonfiction	Big Magic: Creative Living Beyond Fear	30.80	3	In stock	f
350	base	795	Nonfiction	Becoming Wise: An Inquiry into the Mystery and Art of Living	27.43	2	In stock	f
351	base	786	Nonfiction	Agnostic: A Spirited Manifesto	12.51	5	In stock	f
352	base	780	Nonfiction	Whole Lotta Creativity Going On: 60 Fun and Unusual Exercises to Awaken and Strengthen Your Creativity	38.20	4	In stock	f
353	base	779	Nonfiction	What's It Like in Space?: Stories from Astronauts Who've Been There	19.60	2	In stock	f
354	base	770	Nonfiction	The Year of Magical Thinking	43.04	2	In stock	f
355	base	755	Nonfiction	The Literature Book (Big Ideas Simply Explained)	17.43	3	In stock	f
484	base	790	Default	Anonymous	46.82	4	In stock	f
356	base	745	Nonfiction	The Bad-Ass Librarians of Timbuktu: And Their Race to Save the World’s Most Precious Manuscripts	15.77	1	In stock	f
357	base	740	Nonfiction	Swell: A Year of Waves	45.58	1	In stock	f
358	base	722	Nonfiction	No Dream Is Too High: Life Lessons From a Man Who Walked on the Moon	21.95	2	In stock	f
359	base	710	Nonfiction	Looking for Lovely: Collecting the Moments that Matter	29.14	5	In stock	f
360	base	708	Nonfiction	Let It Out: A Journey Through Journaling	26.79	5	In stock	f
361	base	699	Nonfiction	Hamilton: The Revolution	58.79	3	In stock	f
362	base	694	Nonfiction	Far & Away: Places on the Brink of Change: Seven Continents, Twenty-Five Years	15.06	4	In stock	f
363	base	689	Nonfiction	Eaternity: More than 150 Deliciously Easy Vegan Recipes for a Long, Healthy, Satisfied, Joyful Life	51.75	5	In stock	f
364	base	670	Nonfiction	Buying In: The Secret Dialogue Between What We Buy and Who We Are	37.80	4	In stock	f
365	base	669	Nonfiction	Brain on Fire: My Month of Madness	49.32	5	In stock	f
366	base	658	Nonfiction	Abstract City	56.37	5	In stock	f
367	base	645	Nonfiction	13 Hours: The Inside Account of What Really Happened In Benghazi	27.06	1	In stock	f
368	base	639	Nonfiction	The Lonely City: Adventures in the Art of Being Alone	33.26	2	In stock	f
369	base	634	Nonfiction	The Diary of a Young Girl	59.90	3	In stock	f
370	base	631	Nonfiction	Snatched: How A Drug Queen Went Undercover for the DEA and Was Kidnapped By Colombian Guerillas	21.21	3	In stock	f
371	base	619	Nonfiction	Furiously Happy: A Funny Book About Horrible Things	41.46	4	In stock	f
372	base	608	Nonfiction	The Sleep Revolution: Transforming Your Life, One Night at a Time	11.68	4	In stock	f
373	base	599	Nonfiction	Mother, Can You Not?	16.89	5	In stock	f
374	base	585	Nonfiction	A Mother's Reckoning: Living in the Aftermath of Tragedy	19.53	3	In stock	f
375	base	582	Nonfiction	10% Happier: How I Tamed the Voice in My Head, Reduced Stress Without Losing My Edge, and Found Self-Help That Actually Works	24.57	2	In stock	f
376	base	560	Nonfiction	Chernobyl 01:23:40: The Incredible True Story of the World's Worst Nuclear Disaster	35.92	2	In stock	f
377	base	555	Nonfiction	Zero to One: Notes on Startups, or How to Build the Future	34.06	3	In stock	f
378	base	554	Nonfiction	Why Not Me?	17.76	1	In stock	f
379	base	553	Nonfiction	When Breath Becomes Air	39.36	2	In stock	f
380	base	549	Nonfiction	The Midnight Assassin: Panic, Scandal, and the Hunt for America's First Serial Killer	28.45	4	In stock	f
381	base	543	Nonfiction	Smarter Faster Better: The Secrets of Being Productive in Life and Business	38.89	5	In stock	f
382	base	539	Nonfiction	Rising Strong	21.82	3	In stock	f
383	base	533	Nonfiction	Man's Search for Meaning	29.48	3	In stock	f
384	base	532	Nonfiction	Love That Boy: What Two Presidents, Eight Road Trips, and My Son Taught Me About a Parent's Expectations	25.06	2	In stock	f
385	base	531	Nonfiction	Living Forward: A Proven Plan to Stop Drifting and Get the Life You Want	12.55	3	In stock	f
386	base	524	Nonfiction	I Will Find You	44.21	1	In stock	f
387	base	514	Nonfiction	Brazen: The Courage to Find the You That's Been Hiding	19.22	2	In stock	f
388	base	513	Nonfiction	Between the World and Me	56.91	4	In stock	f
389	base	512	Nonfiction	Being Mortal: Medicine and What Matters in the End	55.06	4	In stock	f
390	base	511	Nonfiction	A Murder Over a Girl: Justice, Gender, Junior High	13.20	3	In stock	f
391	base	467	Nonfiction	For the Love: Fighting for Grace in a World of Impossible Standards	45.13	3	In stock	f
392	base	466	Nonfiction	Finding God in the Ruins: How God Redeems Pain	46.64	2	In stock	f
393	base	451	Nonfiction	The Man Who Mistook His Wife for a Hat and Other Clinical Tales	59.45	4	In stock	f
394	base	432	Nonfiction	In Cold Blood	49.98	4	In stock	f
395	base	429	Nonfiction	Girl, Interrupted	42.14	3	In stock	f
396	base	418	Nonfiction	Why Save the Bankers?: And Other Essays on Our Economic and Political Crisis	48.67	2	In stock	f
397	base	394	Nonfiction	Talking to Girls About Duran Duran: One Young Man's Quest for True Love and a Cooler Haircut	25.15	4	In stock	f
398	base	388	Nonfiction	My Mother Was Nuts	31.63	4	In stock	f
399	base	367	Nonfiction	Data, A Love Story: How I Gamed Online Dating to Meet My Match	32.35	3	In stock	f
400	base	350	Nonfiction	The Jazz of Physics: The Secret Link Between Music and the Structure of the Universe	38.71	3	In stock	f
401	base	347	Nonfiction	The Gunning of America: Business and the Making of American Gun Culture	16.81	4	In stock	f
402	base	346	Nonfiction	The Geography of Bliss: One Grump's Search for the Happiest Places in the World	28.23	2	In stock	f
403	base	323	Nonfiction	God Is Not Great: How Religion Poisons Everything	27.80	1	In stock	f
404	base	302	Nonfiction	We the People: The Modern-Day Figures Who Have Reshaped and Affirmed the Founding Fathers' Vision of America	31.95	3	In stock	f
405	base	298	Nonfiction	Very Good Lives: The Fringe Benefits of Failure and the Importance of Imagination	50.66	3	In stock	f
406	base	296	Nonfiction	Unstuffed: Decluttering Your Home, Mind, and Soul	58.09	1	In stock	f
407	base	295	Nonfiction	Under the Banner of Heaven: A Story of Violent Faith	30.00	1	In stock	f
408	base	291	Nonfiction	Trespassing Across America: One Man's Epic, Never-Done-Before (and Sort of Illegal) Hike Across the Heartland	53.51	1	In stock	f
409	base	264	Nonfiction	The Name of God is Mercy	37.25	2	In stock	f
410	base	226	Nonfiction	Stiff: The Curious Lives of Human Cadavers	36.74	3	In stock	f
411	base	225	Nonfiction	Spilled Milk: Based on a True Story	49.51	1	In stock	f
412	base	213	Nonfiction	Rise of the Rocket Girls: The Women Who Propelled Us, from Missiles to the Moon to Mars	41.67	4	In stock	f
413	base	204	Nonfiction	Outliers: The Story of Success	14.16	1	In stock	f
414	base	200	Nonfiction	Notes from a Small Island (Notes From a Small Island #1)	40.17	1	In stock	f
415	base	199	Nonfiction	Night (The Night Trilogy #1)	13.51	1	In stock	f
485	base	789	Default	Amy Meets the Saints and Sages	18.46	3	In stock	f
416	base	195	Nonfiction	Miracles from Heaven: A Little Girl, Her Journey to Heaven, and Her Amazing Story of Healing	57.83	1	In stock	f
417	base	186	Nonfiction	Letter to a Christian Nation	22.20	1	In stock	f
418	base	185	Nonfiction	Let's Pretend This Never Happened: A Mostly True Memoir	45.11	1	In stock	f
419	base	179	Nonfiction	It's Never Too Late to Begin Again: Discovering Creativity and Meaning at Midlife and Beyond	42.38	1	In stock	f
420	base	177	Nonfiction	Into the Wild	56.70	5	In stock	f
421	base	175	Nonfiction	In the Garden of Beasts: Love, Terror, and an American Family in Hitler's Berlin	28.85	3	In stock	f
422	base	172	Nonfiction	I Am Malala: The Girl Who Stood Up for Education and Was Shot by the Taliban	28.88	2	In stock	f
423	base	163	Nonfiction	Gratitude	26.66	5	In stock	f
424	base	148	Nonfiction	Disrupted: My Misadventure in the Start-Up Bubble	15.28	5	In stock	f
425	base	135	Nonfiction	Brave Enough	51.32	5	In stock	f
426	base	133	Nonfiction	Born to Run: A Hidden Tribe, Superathletes, and the Greatest Race the World Has Never Seen	27.35	2	In stock	f
427	base	132	Nonfiction	Blink: The Power of Thinking Without Thinking	21.74	5	In stock	f
428	base	131	Nonfiction	Black Flags: The Rise of ISIS	40.87	1	In stock	f
429	base	121	Nonfiction	Are We Smart Enough to Know How Smart Animals Are?	56.58	1	In stock	f
430	base	118	Nonfiction	A Walk in the Woods: Rediscovering America on the Appalachian Trail	30.48	4	In stock	f
431	base	112	Nonfiction	The Suffragettes (Little Black Classics, #96)	11.89	2	In stock	f
432	base	103	Nonfiction	Kindle Paperwhite User's Guide	34.00	3	In stock	f
433	base	102	Nonfiction	H is for Hawk	57.42	5	In stock	f
434	base	90	Nonfiction	Travels with Charley: In Search of America	57.82	5	In stock	f
435	base	85	Nonfiction	The Tumor	41.56	5	In stock	f
436	base	64	Nonfiction	The End of the Jesus Era (An Investigation #1)	14.40	1	In stock	f
437	base	16	Nonfiction	Eat, Pray, Love	51.32	3	In stock	f
438	base	986	Music	Rip it Up and Start Again	35.02	5	In stock	f
439	base	985	Music	Our Band Could Be Your Life: Scenes from the American Indie Underground, 1981-1991	57.25	3	In stock	f
440	base	979	Music	How Music Works	37.32	2	In stock	f
441	base	711	Music	Love Is a Mix Tape (Music #1)	18.03	1	In stock	f
442	base	537	Music	Please Kill Me: The Uncensored Oral History of Punk	31.19	4	In stock	f
443	base	528	Music	Kill 'Em and Leave: Searching for James Brown and the American Soul	45.05	5	In stock	f
444	base	462	Music	Chronicles, Vol. 1	52.60	2	In stock	f
445	base	414	Music	This Is Your Brain on Music: The Science of a Human Obsession	38.40	1	In stock	f
446	base	337	Music	Orchestra of Exiles: The Story of Bronislaw Huberman, the Israel Philharmonic, and the One Thousand Jews He Saved from Nazi Horrors	12.36	3	In stock	f
447	base	336	Music	No One Here Gets Out Alive	20.02	5	In stock	f
448	base	104	Music	Life	31.58	5	In stock	f
449	base	39	Music	Old Records Never Die: One Man's Quest for His Vinyl and His Past	55.66	2	In stock	f
450	base	19	Music	Forever Rockers (The Rocker #12)	28.80	3	In stock	f
451	base	993	Default	The Coming Woman: A Novel Based on the Life of the Infamous Feminist, Victoria Woodhull	17.93	3	In stock	f
452	base	992	Default	The Boys in the Boat: Nine Americans and Their Epic Quest for Gold at the 1936 Berlin Olympics	22.60	4	In stock	f
453	base	990	Default	Starving Hearts (Triangular Trade Trilogy, #1)	13.99	2	In stock	f
454	base	974	Default	America's Cradle of Quarterbacks: Western Pennsylvania's Football Factory from Johnny Unitas to Joe Montana	22.50	3	In stock	f
455	base	973	Default	Aladdin and His Wonderful Lamp	53.13	3	In stock	f
456	base	965	Default	Penny Maybe	33.29	3	In stock	f
457	base	964	Default	Maude (1883-1993):She Grew Up with the country	18.02	2	In stock	f
458	base	935	Default	The Inefficiency Assassin: Time Management Tactics for Working Smarter, Not Longer	20.59	5	In stock	f
459	base	926	Default	Soul Reader	39.58	2	In stock	f
460	base	883	Default	Bossypants	49.46	2	In stock	f
461	base	879	Default	A World of Flavor: Your Gluten Free Passport	42.95	1	In stock	f
462	base	878	Default	A Piece of Sky, a Grain of Rice: A Memoir in Four Meditations	56.76	5	In stock	f
463	base	869	Default	Tracing Numbers on a Train	41.60	3	In stock	f
464	base	866	Default	Thirteen Reasons Why	52.72	1	In stock	f
465	base	859	Default	The Secret (The Secret #1)	27.37	4	In stock	f
466	base	857	Default	The Psychopath Test: A Journey Through the Madness Industry	36.00	2	In stock	f
467	base	847	Default	The Kite Runner	41.82	4	In stock	f
468	base	844	Default	The Girl on the Train	55.02	2	In stock	f
469	base	842	Default	The Emerald Mystery	23.15	2	In stock	f
470	base	840	Default	The Bridge to Consciousness: I'm Writing the Bridge Between Science and Our Old and New Beliefs.	32.00	3	In stock	f
471	base	838	Default	The Art of War	33.34	5	In stock	f
472	base	829	Default	Secrets and Lace (Fatal Hearts #1)	20.27	1	In stock	f
473	base	827	Default	Romero and Juliet: A Tragic Tale of Love and Zombies	36.94	1	In stock	f
474	base	825	Default	Poses for Artists Volume 1 - Dynamic and Sitting Poses: An Essential Reference for Figure Drawing and the Human Form	41.06	1	In stock	f
475	base	819	Default	Miss Peregrine’s Home for Peculiar Children (Miss Peregrine’s Peculiar Children #1)	10.76	1	In stock	f
476	base	815	Default	Large Print Heart of the Pride	19.15	2	In stock	f
477	base	812	Default	Grumbles	22.16	2	In stock	f
478	base	808	Default	First Steps for New Christians (Print Edition)	29.00	1	In stock	f
479	base	805	Default	Eureka Trivia 6.0	54.59	4	In stock	f
480	base	804	Default	Drive: The Surprising Truth About What Motivates Us	34.95	4	In stock	f
481	base	803	Default	Done Rubbed Out (Reightman & Bailey #1)	37.72	5	In stock	f
482	base	794	Default	Beauty Restored (Riley Family Legacy Novellas #3)	11.11	2	In stock	f
486	base	787	Default	Amatus	50.54	5	In stock	f
487	base	776	Default	V for Vendetta (V for Vendetta Complete)	37.10	4	In stock	f
488	base	774	Default	Unbroken: A World War II Story of Survival, Resilience, and Redemption	45.95	2	In stock	f
489	base	769	Default	The Wright Brothers	56.80	4	In stock	f
490	base	763	Default	The Songs of the Gods	44.48	5	In stock	f
491	base	761	Default	The Rosie Project (Don Tillman #1)	54.04	1	In stock	f
492	base	760	Default	The Power of Habit: Why We Do What We Do in Life and Business	16.88	3	In stock	f
493	base	737	Default	Steve Jobs	39.50	5	In stock	f
494	base	713	Default	Luckiest Girl Alive	49.83	3	In stock	f
495	base	709	Default	Living Leadership by Insight: A Good Leader Achieves, a Great Leader Builds Monuments	46.91	4	In stock	f
496	base	707	Default	Lady Midnight (The Dark Artifices #1)	16.28	5	In stock	f
497	base	701	Default	Hush, Hush (Hush, Hush #1)	47.02	3	In stock	f
498	base	698	Default	Greek Mythic History	10.23	5	In stock	f
499	base	693	Default	Every Last Word	46.47	3	In stock	f
500	base	683	Default	Daily Fantasy Sports	36.58	1	In stock	f
501	base	679	Default	Clockwork Angel (The Infernal Devices #1)	44.14	1	In stock	f
502	base	677	Default	City of Fallen Angels (The Mortal Instruments #4)	11.23	4	In stock	f
503	base	676	Default	City of Bones (The Mortal Instruments #1)	43.28	1	In stock	f
504	base	675	Default	City of Ashes (The Mortal Instruments #2)	47.27	1	In stock	f
505	base	672	Default	Carry On, Warrior: Thoughts on Life Unarmed	31.85	3	In stock	f
506	base	671	Default	Carrie	46.23	2	In stock	f
507	base	661	Default	Angels & Demons (Robert Langdon #1)	51.48	3	In stock	f
508	base	649	Default	The Three Searches, Meaning, and the Story	13.33	3	In stock	f
509	base	630	Default	Raspberry Pi Electronics Projects for the Evil Genius	49.67	4	In stock	f
510	base	621	Default	How to Speak Golf: An Illustrated Guide to Links Lingo	58.32	5	In stock	f
511	base	616	Default	Eleanor & Park	56.51	5	In stock	f
512	base	610	Default	Troublemaker: Surviving Hollywood and Scientology	48.39	2	In stock	f
513	base	586	Default	Adultery	20.88	5	In stock	f
514	base	578	Default	Unlimited Intuition Now	58.87	4	In stock	f
515	base	577	Default	Underlying Notes	11.82	2	In stock	f
516	base	575	Default	The New Brand You: Your New Image Makes the Sale for You	44.05	5	In stock	f
517	base	573	Default	The Flowers Lied	16.68	2	In stock	f
518	base	566	Default	NaNo What Now? Finding your editing process, revising your NaNoWriMo book and building a writing career through publishing and beyond	10.41	4	In stock	f
519	base	565	Default	Modern Day Fables	47.44	2	In stock	f
520	base	551	Default	The Unlikely Pilgrimage of Harold Fry (Harold Fry #1)	43.62	5	In stock	f
521	base	548	Default	The Martian (The Martian #1)	41.39	2	In stock	f
522	base	529	Default	Left Behind (Left Behind #1)	40.72	2	In stock	f
523	base	526	Default	John Vassos: Industrial Design for Modern Life	20.22	4	In stock	f
524	base	525	Default	I'll Give You the Sun	56.48	1	In stock	f
525	base	520	Default	Heaven is for Real: A Little Boy's Astounding Story of His Trip to Heaven and Back	52.86	2	In stock	f
526	base	518	Default	Ender's Game (The Ender Quintet #1)	43.64	1	In stock	f
527	base	516	Default	Death by Leisure: A Cautionary Tale	37.51	4	In stock	f
528	base	507	Default	Wildlife of New York: A Five-Borough Coloring Book	22.14	2	In stock	f
529	base	502	Default	The Year of Living Biblically: One Man's Humble Quest to Follow the Bible as Literally as Possible	34.72	1	In stock	f
530	base	498	Default	The Great Gatsby	36.05	4	In stock	f
531	base	497	Default	The Good Girl	49.03	3	In stock	f
532	base	489	Default	The 7 Habits of Highly Effective People: Powerful Lessons in Personal Change	33.17	4	In stock	f
533	base	487	Default	Steal Like an Artist: 10 Things Nobody Told You About Being Creative	20.90	2	In stock	f
534	base	475	Default	Life of Pi	13.22	4	In stock	f
535	base	455	Default	The Sound Of Love	57.84	5	In stock	f
536	base	453	Default	The Perks of Being a Wallflower	55.02	3	In stock	f
537	base	450	Default	The Makings of a Fatherless Child	31.58	2	In stock	f
538	base	447	Default	The Hobbit (Middle-Earth Universe)	17.80	5	In stock	f
539	base	442	Default	The Fellowship of the Ring (The Lord of the Rings #1)	10.27	2	In stock	f
540	base	438	Default	Ship Leaves Harbor: Essays on Travel by a Recovering Journeyman	30.60	3	In stock	f
541	base	436	Default	Musicophilia: Tales of Music and the Brain	46.58	1	In stock	f
542	base	416	Default	What If?: Serious Scientific Answers to Absurd Hypothetical Questions	53.68	4	In stock	f
543	base	403	Default	The Fault in Our Stars	47.22	1	In stock	f
544	base	400	Default	The Dream Thieves (The Raven Cycle #2)	34.50	1	In stock	f
545	base	397	Default	The 5th Wave (The 5th Wave #1)	11.83	2	In stock	f
546	base	392	Default	Shiver (The Wolves of Mercy Falls #1)	16.23	5	In stock	f
547	base	391	Default	Remember Me?	11.48	3	In stock	f
548	base	379	Default	If I Stay (If I Stay #1)	38.13	5	In stock	f
549	base	378	Default	I Know Why the Caged Bird Sings (Maya Angelou's Autobiography #1)	36.55	2	In stock	f
550	base	377	Default	Harry Potter and the Deathly Hallows (Harry Potter #7)	23.32	1	In stock	f
551	base	374	Default	Fool Me Once	16.96	1	In stock	f
552	base	371	Default	Drama	38.70	2	In stock	f
553	base	364	Default	Blue Lily, Lily Blue (The Raven Cycle #3)	34.13	5	In stock	f
554	base	360	Default	Alight (The Generations Trilogy #2)	58.59	4	In stock	f
555	base	355	Default	Vogue Colors A to Z: A Fashion Coloring Book	52.35	4	In stock	f
556	base	354	Default	The Shining (The Shining #1)	27.88	3	In stock	f
557	base	349	Default	The Hunger Games (The Hunger Games #1)	29.85	5	In stock	f
558	base	338	Default	Outlander (Outlander #1)	19.67	5	In stock	f
559	base	333	Default	Mockingjay (The Hunger Games #3)	20.44	4	In stock	f
560	base	329	Default	Harry Potter and the Sorcerer's Stone (Harry Potter #1)	13.90	3	In stock	f
561	base	318	Default	Confessions of a Shopaholic (Shopaholic #1)	48.94	2	In stock	f
562	base	308	Default	Zero History (Blue Ant #3)	34.77	1	In stock	f
563	base	306	Default	World War Z: An Oral History of the Zombie War	21.80	1	In stock	f
564	base	305	Default	Wild: From Lost to Found on the Pacific Crest Trail	46.02	3	In stock	f
565	base	304	Default	Where'd You Go, Bernadette	18.13	1	In stock	f
566	base	293	Default	Twilight (Twilight #1)	41.93	2	In stock	f
567	base	269	Default	The Paris Wife	36.80	3	In stock	f
568	base	263	Default	The Maze Runner (The Maze Runner #1)	20.93	1	In stock	f
569	base	262	Default	The Lover's Dictionary	58.09	2	In stock	f
570	base	252	Default	The Goldfinch	43.58	3	In stock	f
571	base	251	Default	The Giver (The Giver Quartet #1)	12.30	1	In stock	f
572	base	249	Default	The Girl Who Played with Fire (Millennium Trilogy #2)	22.14	2	In stock	f
573	base	242	Default	The Demon-Haunted World: Science as a Candle in the Dark	52.25	4	In stock	f
574	base	233	Default	The Book Thief	53.49	2	In stock	f
575	base	230	Default	The Autobiography of Malcolm X	23.43	2	In stock	f
576	base	221	Default	Shopaholic & Baby (Shopaholic #5)	46.45	2	In stock	f
577	base	208	Default	Quiet: The Power of Introverts in a World That Can't Stop Talking	43.55	1	In stock	f
578	base	205	Default	Packing for Mars: The Curious Science of Life in the Void	56.68	2	In stock	f
579	base	202	Default	Orange Is the New Black	24.61	2	In stock	f
580	base	201	Default	One for the Money (Stephanie Plum #1)	32.87	2	In stock	f
581	base	196	Default	Morning Star (Red Rising #3)	29.40	1	In stock	f
582	base	187	Default	Life After Life	26.13	2	In stock	f
583	base	183	Default	Lean In: Women, Work, and the Will to Lead	25.02	1	In stock	f
584	base	178	Default	Is Everyone Hanging Out Without Me? (And Other Concerns)	20.11	3	In stock	f
585	base	162	Default	Gone Girl	37.60	5	In stock	f
586	base	155	Default	Fellside	38.62	1	In stock	f
587	base	152	Default	Eclipse (Twilight #3)	18.74	1	In stock	f
588	base	150	Default	Dracula	52.62	3	In stock	f
589	base	147	Default	Dead Wake: The Last Crossing of the Lusitania	39.24	5	In stock	f
590	base	146	Default	David and Goliath: Underdogs, Misfits, and the Art of Battling Giants	17.81	1	In stock	f
591	base	144	Default	Dark Places	23.90	5	In stock	f
592	base	136	Default	Breaking Dawn (Twilight #4)	35.28	5	In stock	f
593	base	125	Default	Beautiful Creatures (Caster Chronicles #1)	21.55	5	In stock	f
594	base	117	Default	A Visit from the Goon Squad	14.08	5	In stock	f
595	base	87	Default	The Zombie Room	19.69	5	In stock	f
596	base	74	Default	The Name of the Wind (The Kingkiller Chronicle #1)	50.59	3	In stock	f
597	base	57	Default	Taking Shots (Assassins #1)	18.88	2	In stock	f
598	base	53	Default	Shatter Me (Shatter Me #1)	42.40	1	In stock	f
599	base	45	Default	Paradise Lost (Paradise #1)	24.96	1	In stock	f
600	base	40	Default	On the Road (Duluoz Legend)	32.36	3	In stock	f
601	base	27	Default	Jane Eyre	38.43	5	In stock	f
602	base	20	Default	Frankenstein	38.00	2	In stock	f
603	base	983	Science Fiction	Mesaerion: The Best Science Fiction Stories 1800-1849	37.59	1	In stock	f
604	base	902	Science Fiction	Join	35.67	5	In stock	f
605	base	871	Science Fiction	William Shakespeare's Star Wars: Verily, A New Hope (William Shakespeare's Star Wars #4)	43.30	4	In stock	f
606	base	856	Science Fiction	The Project	10.65	1	In stock	f
607	base	833	Science Fiction	Soft Apocalypse	26.12	2	In stock	f
608	base	604	Science Fiction	Sleeping Giants (Themis Files #1)	48.74	1	In stock	f
609	base	587	Science Fiction	Arena	21.36	4	In stock	f
610	base	375	Science Fiction	Foundation (Foundation (Publication Order) #1)	32.42	1	In stock	f
611	base	275	Science Fiction	The Restaurant at the End of the Universe (Hitchhiker's Guide to the Galaxy #2)	10.92	1	In stock	f
612	base	209	Science Fiction	Ready Player One	19.07	4	In stock	f
613	base	189	Science Fiction	Life, the Universe and Everything (Hitchhiker's Guide to the Galaxy #3)	33.26	2	In stock	f
614	base	151	Science Fiction	Dune (Dune #1)	54.86	1	In stock	f
615	base	149	Science Fiction	Do Androids Dream of Electric Sheep? (Blade Runner #1)	51.48	1	In stock	f
616	base	89	Science Fiction	Three Wishes (River of Time: California #1)	44.18	2	In stock	f
617	base	70	Science Fiction	The Last Girl (The Dominion Trilogy #1)	36.26	2	In stock	f
618	base	23	Science Fiction	Having the Barbarian's Baby (Ice Planet Barbarians #7.5)	34.96	4	In stock	f
619	base	232	Sports and Games	The Book of Basketball: The NBA According to The Sports Guy	44.84	5	In stock	f
620	base	158	Sports and Games	Friday Night Lights: A Town, a Team, and a Dream	51.22	3	In stock	f
621	base	108	Sports and Games	Sugar Rush (Offensive Line #2)	24.42	1	In stock	f
622	base	50	Sports and Games	Settling the Score (The Summer Games #1)	44.91	2	In stock	f
623	base	25	Sports and Games	Icing (Aces Hockey #2)	40.44	4	In stock	f
624	base	945	Add a comment	The Torch Is Passed: A Harding Family Story	19.09	1	In stock	f
625	base	937	Add a comment	The Mindfulness and Acceptance Workbook for Anxiety: A Guide to Breaking Free from Anxiety, Phobias, and Worry Using Acceptance and Commitment Therapy	23.89	4	In stock	f
626	base	930	Add a comment	The Art Forger	40.76	3	In stock	f
627	base	912	Add a comment	On a Midnight Clear	14.07	3	In stock	f
628	base	903	Add a comment	Judo: Seven Steps to Black Belt (an Introductory Guide for Beginners)	53.90	2	In stock	f
629	base	830	Add a comment	Shobu Samurai, Project Aryoku (#3)	29.06	3	In stock	f
630	base	820	Add a comment	Modern Romance	28.26	5	In stock	f
631	base	768	Add a comment	The White Queen (The Cousins' War #1)	25.91	5	In stock	f
632	base	762	Add a comment	The Song of Achilles	37.40	5	In stock	f
633	base	753	Add a comment	The Immortal Life of Henrietta Lacks	40.67	2	In stock	f
634	base	748	Add a comment	The Dovekeepers	48.78	1	In stock	f
635	base	716	Add a comment	More Than Music (Chasing the Dream #1)	37.61	2	In stock	f
636	base	680	Add a comment	Code Name Verity (Code Name Verity #1)	22.13	4	In stock	f
637	base	674	Add a comment	Cell	20.29	4	In stock	f
638	base	662	Add a comment	Angels Walking (Angels Walking #1)	34.20	2	In stock	f
639	base	655	Add a comment	A Series of Catastrophes and Miracles: A True Story of Love, Science, and Cancer	56.48	2	In stock	f
640	base	654	Add a comment	A People's History of the United States	40.79	2	In stock	f
641	base	651	Add a comment	A Brush of Wings (Angels Walking #3)	55.51	1	In stock	f
642	base	647	Add a comment	Rook	37.86	4	In stock	f
643	base	640	Add a comment	The Midnight Watch: A Novel of the Titanic and the Californian	26.20	1	In stock	f
644	base	638	Add a comment	The Gray Rhino: How to Recognize and Act on the Obvious Dangers We Ignore	59.15	4	In stock	f
645	base	633	Add a comment	The Children	11.88	3	In stock	f
646	base	626	Add a comment	One with You (Crossfire #5)	15.71	4	In stock	f
647	base	580	Add a comment	Without Shame	48.27	5	In stock	f
648	base	579	Add a comment	Watchmen	58.05	4	In stock	f
649	base	557	Add a comment	A Hero's Curse (The Unseen Chronicles #1)	50.49	3	In stock	f
650	base	556	Add a comment	23 Degrees South: A Tropical Tale of Changing Whether...	35.79	2	In stock	f
651	base	496	Add a comment	The Glass Castle	16.24	1	In stock	f
652	base	494	Add a comment	The Drowning Girls	35.67	3	In stock	f
653	base	488	Add a comment	Team of Rivals: The Political Genius of Abraham Lincoln	20.12	5	In stock	f
654	base	472	Add a comment	John Adams	57.43	4	In stock	f
655	base	469	Add a comment	Good in Bed (Cannie Shapiro #1)	37.05	5	In stock	f
656	base	449	Add a comment	The Joy of Cooking	43.27	4	In stock	f
657	base	445	Add a comment	The Golden Compass (His Dark Materials #1)	18.77	1	In stock	f
658	base	444	Add a comment	The God Delusion	46.85	3	In stock	f
659	base	437	Add a comment	Pride and Prejudice	19.27	4	In stock	f
660	base	435	Add a comment	Mere Christianity	48.51	3	In stock	f
661	base	428	Add a comment	Fun Home: A Family Tragicomic	56.59	4	In stock	f
662	base	412	Add a comment	The Raven King (The Raven Cycle #4)	30.57	2	In stock	f
663	base	373	Add a comment	Find Her (Detective D.D. Warren #8)	22.37	1	In stock	f
664	base	372	Add a comment	Evicted: Poverty and Profit in the American City	42.27	1	In stock	f
665	base	358	Add a comment	A Game of Thrones (A Song of Ice and Fire #1)	46.42	2	In stock	f
666	base	356	Add a comment	A Clash of Kings (A Song of Ice and Fire #2)	10.79	3	In stock	f
667	base	284	Add a comment	The Tipping Point: How Little Things Can Make a Big Difference	10.02	2	In stock	f
668	base	274	Add a comment	The Rest Is Noise: Listening to the Twentieth Century	34.77	1	In stock	f
669	base	272	Add a comment	The Purpose Driven Life: What on Earth Am I Here for?	37.19	3	In stock	f
670	base	255	Add a comment	The Hitchhiker's Guide to the Galaxy (Hitchhiker's Guide to the Galaxy #1)	47.80	3	In stock	f
671	base	248	Add a comment	The Girl Who Kicked the Hornet's Nest (Millennium Trilogy #3)	57.48	1	In stock	f
672	base	246	Add a comment	The End of Faith: Religion, Terror, and the Future of Reason	22.13	4	In stock	f
673	base	237	Add a comment	The Complete Poems	41.32	5	In stock	f
674	base	236	Add a comment	The Catcher in the Rye	24.55	1	In stock	f
675	base	234	Add a comment	The Case for Christ (Cases for Christianity)	47.84	1	In stock	f
676	base	231	Add a comment	The Blind Side: Evolution of a Game	53.71	5	In stock	f
677	base	220	Add a comment	Seven Days in the Art World	52.33	2	In stock	f
678	base	217	Add a comment	Sarah's Key	46.29	1	In stock	f
679	base	214	Add a comment	Rogue Lawyer (Rogue Lawyer #1)	50.11	3	In stock	f
680	base	192	Add a comment	Manuscript Found in Accra	34.98	2	In stock	f
681	base	157	Add a comment	Fire Bound (Sea Haven/Sisters of the Heart #5)	21.28	4	In stock	f
682	base	141	Add a comment	Cosmos	36.17	2	In stock	f
683	base	113	Add a comment	#GIRLBOSS	50.96	1	In stock	f
684	base	111	Add a comment	The Sense of an Ending	31.38	3	In stock	f
685	base	78	Add a comment	The Republic	33.78	3	In stock	f
686	base	77	Add a comment	The Odyssey	29.64	3	In stock	f
687	base	71	Add a comment	The Light of the Fireflies	54.43	1	In stock	f
688	base	69	Add a comment	The Iliad	16.16	1	In stock	f
689	base	61	Add a comment	The Communist Manifesto	14.76	3	In stock	f
690	base	30	Add a comment	Lord of the Flies	24.89	3	In stock	f
691	base	951	Fantasy	Unicorn Tracks	18.78	3	In stock	f
692	base	924	Fantasy	Saga, Volume 6 (Saga (Collected Editions) #6)	25.02	3	In stock	f
693	base	919	Fantasy	Princess Between Worlds (Wide-Awake Princess #5)	13.34	5	In stock	f
694	base	909	Fantasy	Masks and Shadows	56.40	2	In stock	f
695	base	888	Fantasy	Crown of Midnight (Throne of Glass #2)	43.29	3	In stock	f
696	base	881	Fantasy	Avatar: The Last Airbender: Smoke and Shadow, Part 3 (Smoke and Shadow #3)	28.09	2	In stock	f
697	base	874	Fantasy	A Court of Thorns and Roses (A Court of Thorns and Roses #1)	52.37	1	In stock	f
698	base	868	Fantasy	Throne of Glass (Throne of Glass #1)	35.07	3	In stock	f
699	base	845	Fantasy	The Glittering Court (The Glittering Court #1)	44.28	1	In stock	f
1040	cambio_decision	66	Mystery	The Girl You Lost	12.29	5	In stock	f
700	base	813	Fantasy	Hollow City (Miss Peregrine’s Peculiar Children #2)	42.98	1	In stock	f
701	base	764	Fantasy	The Star-Touched Queen	46.02	5	In stock	f
702	base	752	Fantasy	The Hidden Oracle (The Trials of Apollo #1)	52.26	2	In stock	f
703	base	746	Fantasy	The Bane Chronicles (The Bane Chronicles #1-11)	44.73	4	In stock	f
704	base	705	Fantasy	Island of Dragons (Unwanteds #7)	29.65	1	In stock	f
705	base	685	Fantasy	Demigods & Magicians: Percy and Annabeth Meet the Kanes (Percy Jackson & Kane Chronicles Crossover #1-3)	37.51	5	In stock	f
706	base	678	Fantasy	City of Glass (The Mortal Instruments #3)	56.02	4	In stock	f
707	base	648	Fantasy	Searching for Meaning in Gailana	38.73	1	In stock	f
708	base	642	Fantasy	The Star-Touched Queen	32.30	5	In stock	f
709	base	558	Fantasy	A Shard of Ice (The Black Symphony Saga #1)	56.63	3	In stock	f
710	base	473	Fantasy	King's Folly (The Kinsman Chronicles #1)	39.61	5	In stock	f
711	base	465	Fantasy	Every Heart a Doorway (Every Heart A Doorway #1)	12.16	5	In stock	f
712	base	456	Fantasy	A Gathering of Shadows (Shades of Magic #2)	44.81	4	In stock	f
713	base	411	Fantasy	The Raven Boys (The Raven Cycle #1)	57.74	4	In stock	f
714	base	402	Fantasy	The False Prince (The Ascendance Trilogy #1)	56.00	5	In stock	f
715	base	396	Fantasy	Tell the Wind and Fire	45.51	3	In stock	f
716	base	357	Fantasy	A Feast for Crows (A Song of Ice and Fire #4)	17.21	4	In stock	f
717	base	345	Fantasy	The Demonists (Demonist #1)	52.11	2	In stock	f
718	base	342	Fantasy	The Beast (Black Dagger Brotherhood #14)	46.08	5	In stock	f
719	base	339	Fantasy	Paper and Fire (The Great Library #2)	49.45	5	In stock	f
720	base	327	Fantasy	Harry Potter and the Order of the Phoenix (Harry Potter #5)	31.63	4	In stock	f
721	base	326	Fantasy	Harry Potter and the Half-Blood Prince (Harry Potter #6)	48.75	5	In stock	f
722	base	325	Fantasy	Harry Potter and the Chamber of Secrets (Harry Potter #2)	14.74	1	In stock	f
723	base	278	Fantasy	The Rose & the Dagger (The Wrath and the Dawn #2)	58.64	4	In stock	f
724	base	222	Fantasy	Soldier (Talon #3)	24.72	2	In stock	f
725	base	194	Fantasy	Midnight Riot (Peter Grant/ Rivers of London - books #1)	55.46	2	In stock	f
726	base	166	Fantasy	Heir to the Sky	44.07	4	In stock	f
727	base	153	Fantasy	Eragon (The Inheritance Cycle #1)	43.87	3	In stock	f
728	base	145	Fantasy	Darkfever (Fever #1)	56.02	1	In stock	f
729	base	123	Fantasy	Ash	22.06	4	In stock	f
730	base	116	Fantasy	A Storm of Swords (A Song of Ice and Fire #3)	31.22	2	In stock	f
731	base	92	Fantasy	Vampire Girl (Vampire Girl #1)	53.82	2	In stock	f
732	base	82	Fantasy	The Silent Twin (Detective Jennifer Knight #3)	36.25	3	In stock	f
733	base	73	Fantasy	The Mirror & the Maze (The Wrath and the Dawn #1.5)	29.38	1	In stock	f
734	base	54	Fantasy	Sister Sable (The Mad Queen #1)	13.33	3	In stock	f
735	base	51	Fantasy	Shadow Rites (Jane Yellowrock #10)	21.72	4	In stock	f
736	base	42	Fantasy	Origins (Alphas 0.5)	28.99	1	In stock	f
737	base	41	Fantasy	One Second (Seven #7)	52.94	2	In stock	f
738	base	36	Fantasy	Myriad (Prentor #1)	58.75	4	In stock	f
739	base	956	New Adult	Without Borders (Wanderlove #1)	45.07	2	In stock	f
740	base	851	New Adult	The Mistake (Off-Campus #2)	43.29	3	In stock	f
741	base	850	New Adult	The Matchmaker's Playbook (Wingmen Inc. #1)	55.85	1	In stock	f
742	base	68	New Adult	The Hook Up (Game On #1)	36.29	5	In stock	f
743	base	52	New Adult	Shameless	58.35	3	In stock	f
744	base	38	New Adult	Off Sides (Off #1)	39.45	5	In stock	f
745	base	995	Young Adult	The Requiem Red	22.65	1	In stock	f
746	base	988	Young Adult	Set Me Free	17.46	5	In stock	f
747	base	941	Young Adult	The Natural History of Us (The Fine Art of Pretending #2)	45.22	3	In stock	f
748	base	911	Young Adult	Obsidian (Lux #1)	14.86	2	In stock	f
749	base	884	Young Adult	Burning	28.81	3	In stock	f
750	base	875	Young Adult	A Fierce and Subtle Poison	28.13	4	In stock	f
751	base	828	Young Adult	Scarlett Epstein Hates It Here	43.55	5	In stock	f
752	base	823	Young Adult	Nightingale, Sing	38.28	1	In stock	f
753	base	816	Young Adult	Library of Souls (Miss Peregrine’s Peculiar Children #3)	48.56	5	In stock	f
754	base	810	Young Adult	Frostbite (Vampire Academy #2)	29.99	5	In stock	f
755	base	782	Young Adult	Wild Swans	14.36	2	In stock	f
756	base	775	Young Adult	Until Friday Night (The Field Party #1)	46.31	2	In stock	f
757	base	771	Young Adult	This Is Where It Ends	27.12	2	In stock	f
758	base	747	Young Adult	The Darkest Lie	35.35	5	In stock	f
759	base	718	Young Adult	My Kind of Crazy	40.36	1	In stock	f
760	base	687	Young Adult	Don't Get Caught	55.35	1	In stock	f
761	base	673	Young Adult	Catching Jordan (Hundred Oaks)	50.83	3	In stock	f
762	base	663	Young Adult	Aristotle and Dante Discover the Secrets of the Universe (Aristotle and Dante Discover the Secrets of the Universe #1)	58.14	4	In stock	f
763	base	636	Young Adult	The Epidemic (The Program 0.6)	14.44	5	In stock	f
764	base	632	Young Adult	Stars Above (The Lunar Chronicles #4.5)	48.05	2	In stock	f
765	base	625	Young Adult	No Love Allowed (Dodge Cove #1)	54.65	4	In stock	f
766	base	591	Young Adult	Exit, Pursued by a Bear	51.34	4	In stock	f
767	base	569	Young Adult	The Alien Club	54.40	1	In stock	f
768	base	561	Young Adult	Don't Forget Steven	33.23	1	In stock	f
769	base	544	Young Adult	South of Sunshine	28.93	1	In stock	f
770	base	535	Young Adult	My Life Next Door (My Life Next Door )	36.39	5	In stock	f
771	base	519	Young Adult	Future Shock (Future Shock #1)	55.65	5	In stock	f
772	base	480	Young Adult	Nightstruck: A Novel	50.35	4	In stock	f
773	base	439	Young Adult	Tell the Wolves I'm Home	50.96	2	In stock	f
774	base	419	Young Adult	Will Grayson, Will Grayson (Will Grayson, Will Grayson)	47.31	4	In stock	f
775	base	417	Young Adult	Where She Went (If I Stay #2)	41.73	4	In stock	f
776	base	415	Young Adult	Two Summers	14.64	1	In stock	f
777	base	399	Young Adult	The Darkest Corners	11.33	5	In stock	f
778	base	395	Young Adult	Tell Me Three Things	41.81	1	In stock	f
779	base	385	Young Adult	Lola and the Boy Next Door (Anna and the French Kiss #2)	23.63	4	In stock	f
780	base	381	Young Adult	Kill the Boy Band	15.52	5	In stock	f
781	base	380	Young Adult	Isla and the Happily Ever After (Anna and the French Kiss #3)	48.13	5	In stock	f
782	base	362	Young Adult	An Abundance of Katherines	10.00	5	In stock	f
783	base	328	Young Adult	Harry Potter and the Prisoner of Azkaban (Harry Potter #3)	24.17	4	In stock	f
784	base	300	Young Adult	Walk the Edge (Thunder Road #2)	32.36	3	In stock	f
785	base	294	Young Adult	Two Boys Kissing	32.74	2	In stock	f
786	base	266	Young Adult	The New Guy (and Other Senior Year Distractions)	44.92	3	In stock	f
787	base	258	Young Adult	The Land of 10,000 Madonnas	29.64	4	In stock	f
788	base	218	Young Adult	Scarlet (The Lunar Chronicles #2)	14.57	4	In stock	f
789	base	184	Young Adult	Legend (Legend #1)	43.69	4	In stock	f
790	base	181	Young Adult	Lady Renegades (Rebel Belle #3)	53.04	5	In stock	f
791	base	161	Young Adult	Golden (Heart of Dread #3)	42.21	4	In stock	f
792	base	139	Young Adult	Cinder (The Lunar Chronicles #1)	26.09	1	In stock	f
793	base	134	Young Adult	Boy Meets Boy	21.12	3	In stock	f
794	base	120	Young Adult	Annie on My Mind	36.83	5	In stock	f
795	base	105	Young Adult	New Moon (Twilight #2)	12.86	4	In stock	f
796	base	101	Young Adult	Girl Online On Tour (Girl Online #2)	53.47	1	In stock	f
797	base	67	Young Adult	The Haters	27.89	5	In stock	f
798	base	58	Young Adult	The Art of Not Breathing	40.83	4	In stock	f
799	base	938	Science	The Most Perfect Thing: Inside (and Outside) a Bird's Egg	42.96	4	In stock	f
800	base	900	Science	Immunity: How Elie Metchnikoff Changed the Course of Modern Medicine	57.36	5	In stock	f
801	base	736	Science	Sorting the Beef from the Bull: The Science of Food Fraud Forensics	44.74	4	In stock	f
802	base	643	Science	Tipping Point for Planet Earth: How Close Are We to the Edge?	37.55	1	In stock	f
803	base	572	Science	The Fabric of the Cosmos: Space, Time, and the Texture of Reality	55.91	1	In stock	f
804	base	517	Science	Diary of a Citizen Scientist: Chasing Tiger Beetles and Other New Ways of Engaging the World	28.41	1	In stock	f
805	base	499	Science	The Origin of Species	10.01	4	In stock	f
806	base	405	Science	The Grand Design	13.76	3	In stock	f
807	base	389	Science	Peak: Secrets from the New Science of Expertise	16.28	2	In stock	f
808	base	245	Science	The Elegant Universe: Superstrings, Hidden Dimensions, and the Quest for the Ultimate Theory	13.03	4	In stock	f
809	base	244	Science	The Disappearing Spoon: And Other True Tales of Madness, Love, and the History of the World from the Periodic Table of the Elements	57.35	5	In stock	f
810	base	227	Science	Surely You're Joking, Mr. Feynman!: Adventures of a Curious Character	25.83	2	In stock	f
811	base	219	Science	Seven Brief Lessons on Physics	30.60	4	In stock	f
812	base	81	Science	The Selfish Gene	29.45	1	In stock	f
813	base	1000	Poetry	A Light in the Attic	51.77	3	In stock	f
814	base	991	Poetry	The Black Maria	52.15	1	In stock	f
815	base	989	Poetry	Shakespeare's Sonnets	20.66	4	In stock	f
816	base	984	Poetry	Olio	23.88	1	In stock	f
817	base	961	Poetry	You can't bury them all: Poems	33.63	2	In stock	f
818	base	960	Poetry	Slow States of Collapse: Poems	57.31	3	In stock	f
819	base	953	Poetry	Untitled Collection: Sabbath Poems 2014	14.27	4	In stock	f
820	base	824	Poetry	Poems That Make Grown Women Cry	14.19	4	In stock	f
821	base	822	Poetry	Night Sky with Exit Wounds	41.05	1	In stock	f
822	base	731	Poetry	salt.	46.78	4	In stock	f
823	base	727	Poetry	Quarter Life Poetry: Poems for the Young, Broke and Hangry	50.89	5	In stock	f
824	base	536	Poetry	Out of Print: City Lights Spotlight No. 14	53.64	5	In stock	f
825	base	530	Poetry	Les Fleurs du Mal	29.04	5	In stock	f
826	base	522	Poetry	Howl and Other Poems	40.45	2	In stock	f
827	base	474	Poetry	Leave This Song Behind: Teen Poetry at Its Best	51.17	5	In stock	f
828	base	441	Poetry	The Collected Poems of W.B. Yeats (The Collected Works of W.B. Yeats #1)	15.42	5	In stock	f
829	base	398	Poetry	The Crossover	38.77	4	In stock	f
830	base	365	Poetry	Booked	17.49	5	In stock	f
831	base	91	Poetry	Twenty Love Poems and a Song of Despair	30.95	4	In stock	f
832	base	93	Paranormal	Vampire Knight, Vol. 1 (Vampire Knight #1)	15.40	1	In stock	f
833	base	971	Art	Wall and Piece	44.18	4	In stock	f
834	base	695	Art	Feathers: Displays of Brilliant Plumage	49.05	3	In stock	f
835	base	559	Art	Art and Fear: Observations on the Perils (and Rewards) of Artmaking	48.63	4	In stock	f
836	base	550	Art	The New Drawing on the Right Side of the Brain	43.02	3	In stock	f
837	base	521	Art	History of Beauty	10.29	4	In stock	f
838	base	500	Art	The Story of Art	41.14	4	In stock	f
839	base	490	Art	The Art Book	32.34	2	In stock	f
840	base	94	Art	Ways of Seeing	39.51	5	In stock	f
841	base	758	Psychology	The Lucifer Effect: Understanding How Good People Turn Evil	10.40	1	In stock	f
842	base	637	Psychology	The Golden Condom: And Other Essays on Love Lost and Found	39.43	1	In stock	f
843	base	593	Psychology	It Didn't Start with You: How Inherited Family Trauma Shapes Who We Are and How to End the Cycle	56.27	3	In stock	f
844	base	422	Psychology	An Unquiet Mind: A Memoir of Moods and Madness	21.30	3	In stock	f
845	base	289	Psychology	Thinking, Fast and Slow	21.14	1	In stock	f
846	base	140	Psychology	Civilization and Its Discontents	59.95	2	In stock	f
847	base	114	Psychology	8 Keys to Mental Health Through Exercise	31.04	1	In stock	f
848	base	837	Autobiography	The Argonauts	10.93	2	In stock	f
849	base	598	Autobiography	M Train	27.18	1	In stock	f
850	base	595	Autobiography	Lab Girl	40.85	1	In stock	f
851	base	363	Autobiography	Approval Junkie: Adventures in Caring Too Much	58.81	5	In stock	f
852	base	215	Autobiography	Running with Scissors	12.91	4	In stock	f
853	base	193	Autobiography	Me Talk Pretty One Day	57.60	2	In stock	f
854	base	191	Autobiography	Lust & Wonder	11.87	2	In stock	f
855	base	188	Autobiography	Life Without a Recipe	59.04	5	In stock	f
856	base	115	Autobiography	A Heartbreaking Work of Staggering Genius	54.29	5	In stock	f
857	base	138	Parenting	Catastrophic Happiness: Finding Joy in Childhood's Messy Years	37.35	2	In stock	f
858	base	156	Adult Fiction	Fifty Shades Freed (Fifty Shades #3)	15.36	5	In stock	f
859	base	757	Humor	The Long Haul (Diary of a Wimpy Kid #9)	44.07	1	In stock	f
860	base	723	Humor	Old School (Diary of a Wimpy Kid #10)	11.83	5	In stock	f
861	base	704	Humor	I Know What I'm Doing -- and Other Lies I Tell Myself: Dispatches from a Life Under Construction	25.98	4	In stock	f
862	base	702	Humor	Hyperbole and a Half: Unfortunate Situations, Flawed Coping Mechanisms, Mayhem, and Other Things That Happened	14.75	5	In stock	f
863	base	562	Humor	Dress Your Family in Corduroy and Denim	43.68	3	In stock	f
864	base	503	Humor	Toddlers Are A**holes: It's Not Your Fault	25.55	1	In stock	f
865	base	303	Humor	When You Are Engulfed in Flames	30.89	5	In stock	f
866	base	197	Humor	Naked	31.69	3	In stock	f
867	base	182	Humor	Lamb: The Gospel According to Biff, Christ's Childhood Pal	55.50	5	In stock	f
868	base	167	Humor	Holidays on Ice	51.07	2	In stock	f
869	base	925	Horror	Security	39.25	2	In stock	f
870	base	809	Horror	Follow You Home	21.36	1	In stock	f
871	base	756	Horror	The Loney	23.40	1	In stock	f
872	base	726	Horror	Pet Sematary	10.56	3	In stock	f
873	base	686	Horror	Doctor Sleep (The Shining #2)	40.12	2	In stock	f
874	base	628	Horror	Psycho: Sanitarium (Psycho #1.5)	36.97	5	In stock	f
875	base	614	Horror	Can You Keep a Secret? (Fear Street Relaunch #4)	48.64	1	In stock	f
876	base	390	Horror	Red Dragon (Hannibal Lecter #1)	23.37	3	In stock	f
877	base	370	Horror	Dracula the Un-Dead	35.63	5	In stock	f
878	base	335	Horror	Night Shift (Night Shift #1-20)	12.75	4	In stock	f
879	base	334	Horror	Needful Things	47.51	4	In stock	f
880	base	332	Horror	Misery	34.79	2	In stock	f
881	base	330	Horror	It	25.01	3	In stock	f
882	base	309	Horror	'Salem's Lot	49.56	4	In stock	f
883	base	282	Horror	The Stand	57.86	2	In stock	f
884	base	250	Horror	The Girl with All the Gifts	49.47	3	In stock	f
885	base	169	Horror	House of Leaves	54.89	1	In stock	f
886	base	996	History	Sapiens: A Brief History of Humankind	54.23	5	In stock	f
887	base	950	History	Unbound: How Eight Technologies Made Us Human, Transformed Society, and Brought Our World to the Brink	25.52	1	In stock	f
888	base	929	History	The Age of Genius: The Seventeenth Century and the Birth of the Modern Mind	19.73	1	In stock	f
889	base	917	History	Political Suicide: Missteps, Peccadilloes, Bad Calls, Backroom Hijinx, Sordid Pasts, Rotten Breaks, and Just Plain Dumb Mistakes in the Annals of American Politics	36.28	2	In stock	f
890	base	867	History	Thomas Jefferson and the Tripoli Pirates: The Forgotten War That Changed American History	59.64	1	In stock	f
891	base	785	History	Zealot: The Life and Times of Jesus of Nazareth	24.70	3	In stock	f
892	base	652	History	A Distant Mirror: The Calamitous 14th Century	14.58	3	In stock	f
893	base	650	History	1491: New Revelations of the Americas Before Columbus	21.80	3	In stock	f
894	base	515	History	Brilliant Beacons: A History of the American Lighthouse	11.45	3	In stock	f
895	base	509	History	"Most Blessed of the Patriarchs": Thomas Jefferson and the Empire of the Imagination	44.48	5	In stock	f
896	base	457	History	A Short History of Nearly Everything	52.40	5	In stock	f
897	base	454	History	The Rise and Fall of the Third Reich: A History of Nazi Germany	39.67	2	In stock	f
898	base	424	History	Catherine the Great: Portrait of a Woman	58.55	4	In stock	f
899	base	408	History	The Mathews Men: Seven Brothers and the War Against Hitler's U-boats	42.91	5	In stock	f
900	base	406	History	The Hiding Place	55.91	4	In stock	f
901	base	361	History	America's War for the Greater Middle East: A Military History	51.22	2	In stock	f
902	base	254	History	The Guns of August	14.54	2	In stock	f
903	base	170	History	House of Lost Worlds: Dinosaurs, Dynasties, and the Story of Life on Earth	43.70	2	In stock	f
904	base	978	Food and Drink	Foolproof Preserving: A Guide to Small Batch Jams, Jellies, Pickles, Condiments, and More: A Foolproof Guide to Making Small Batch Jams, Jellies, Pickles, Condiments, and More	30.52	3	In stock	f
905	base	943	Food and Drink	The Pioneer Woman Cooks: Dinnertime: Comfort Classics, Freezer Food, 16-Minute Meals, and Other Delicious Ways to Solve Supper!	56.41	1	In stock	f
906	base	910	Food and Drink	My Paris Kitchen: Recipes and Stories	33.37	2	In stock	f
907	base	908	Food and Drink	Mama Tried: Traditional Italian Cooking for the Screwed, Crude, Vegan, and Tattooed	14.02	4	In stock	f
908	base	904	Food and Drink	Layered: Baking, Building, and Styling Spectacular Cakes	40.11	1	In stock	f
909	base	853	Food and Drink	The Nerdy Nummies Cookbook: Sweet Treats for the Geek in All of Us	37.34	5	In stock	f
910	base	849	Food and Drink	The Love and Lemons Cookbook: An Apple-to-Zucchini Celebration of Impromptu Cooking	37.60	2	In stock	f
911	base	841	Food and Drink	The Cookies & Cups Cookbook: 125+ sweet & savory recipes reminding you to Always Eat Dessert First	41.25	1	In stock	f
912	base	801	Food and Drink	Deliciously Ella Every Day: Quick and Easy Recipes for Gluten-Free Snacks, Packed Lunches, and Simple Meals	42.16	3	In stock	f
913	base	751	Food and Drink	The Help Yourself Cookbook for Kids: 60 Easy Plant-Based Recipes Kids Can Make to Stay Healthy and Save the Earth	28.77	3	In stock	f
914	base	706	Food and Drink	It's All Easy: Healthy, Delicious Weeknight Meals in under 30 Minutes	19.55	1	In stock	f
915	base	667	Food and Drink	Barefoot Contessa Back to Basics	28.01	1	In stock	f
916	base	666	Food and Drink	Barefoot Contessa at Home: Everyday Recipes You'll Make Over and Over Again	50.62	5	In stock	f
917	base	646	Food and Drink	My Kitchen Year: 136 Recipes That Saved My Life	11.53	2	In stock	f
918	base	618	Food and Drink	Everyday Italian: 125 Simple and Delicious Recipes	20.10	5	In stock	f
919	base	611	Food and Drink	A la Mode: 120 Recipes in 60 Pairings: Pies, Tarts, Cakes, Crisps, and More Topped with Ice Cream, Gelato, Frozen Custard, and More	38.77	1	In stock	f
920	base	589	Food and Drink	Cravings: Recipes for What You Want to Eat	20.50	3	In stock	f
921	base	574	Food and Drink	The Moosewood Cookbook: Recipes from Moosewood Restaurant, Ithaca, New York	12.34	4	In stock	f
922	base	510	Food and Drink	32 Yolks	53.63	2	In stock	f
923	base	479	Food and Drink	Naturally Lean: 125 Nourishing Gluten-Free, Plant-Based Recipes--All Under 300 Calories	11.38	5	In stock	f
924	base	471	Food and Drink	How to Cook Everything Vegetarian: Simple Meatless Recipes for Great Food (How to Cook Everything)	46.01	4	In stock	f
925	base	470	Food and Drink	How to Be a Domestic Goddess: Baking and the Art of Comfort Cooking	28.25	2	In stock	f
926	base	440	Food and Drink	The Barefoot Contessa Cookbook	59.92	5	In stock	f
927	base	423	Food and Drink	Better Homes and Gardens New Cook Book	39.61	3	In stock	f
928	base	410	Food and Drink	The Power Greens Cookbook: 140 Delicious Superfood Recipes	11.05	5	In stock	f
929	base	387	Food and Drink	Mexican Today: New and Rediscovered Recipes for Contemporary Kitchens	24.91	5	In stock	f
930	base	297	Food and Drink	Vegan Vegetarian Omnivore: Dinner for Everyone at the Table	13.66	2	In stock	f
931	base	281	Food and Drink	The Smitten Kitchen Cookbook	23.59	1	In stock	f
932	base	229	Food and Drink	The Art of Simple Food: Notes, Lessons, and Recipes from a Delicious Revolution	34.32	3	In stock	f
933	base	171	Food and Drink	Hungry Girl Clean & Hungry: Easy All-Natural Recipes for Healthy Eating in the Real World	33.14	3	In stock	f
934	base	826	Christian Fiction	Redeeming Love	20.47	5	In stock	f
935	base	798	Christian Fiction	Close to You	49.46	4	In stock	f
936	base	541	Christian Fiction	Shadows of the Past (Logan Point #1)	39.67	5	In stock	f
937	base	476	Christian Fiction	Like Never Before (Walker Family #2)	28.77	2	In stock	f
938	base	463	Christian Fiction	Counted With the Stars (Out from Egypt #1)	17.97	5	In stock	f
939	base	174	Christian Fiction	If I Run (If I Run #1)	49.97	4	In stock	f
940	base	994	Business	The Dirty Little Secrets of Getting Your Dream Job	33.34	4	In stock	f
941	base	862	Business	The Third Wave: An Entrepreneur’s Vision of the Future	12.61	5	In stock	f
942	base	836	Business	The 10% Entrepreneur: Live Your Startup Dream Without Quitting Your Day Job	27.55	3	In stock	f
943	base	831	Business	Shoe Dog: A Memoir by the Creator of NIKE	23.99	2	In stock	f
944	base	715	Business	Made to Stick: Why Some Ideas Survive and Others Die	38.85	5	In stock	f
945	base	629	Business	Quench Your Own Thirst: Business Lessons Learned Over a Beer or Two	43.14	1	In stock	f
946	base	606	Business	The Art of Startup Fundraising	21.00	3	In stock	f
947	base	588	Business	Born for This: How to Find the Work You Were Meant to Do	21.59	5	In stock	f
948	base	545	Business	The E-Myth Revisited: Why Most Small Businesses Don't Work and What to Do About It	36.91	1	In stock	f
949	base	483	Business	Rich Dad, Poor Dad	51.74	1	In stock	f
950	base	260	Business	The Lean Startup: How Today's Entrepreneurs Use Continuous Innovation to Create Radically Successful Businesses	33.92	3	In stock	f
951	base	212	Business	Rework	44.88	2	In stock	f
952	base	818	Biography	Louisa: The Extraordinary Life of Mrs. Adams	16.85	2	In stock	f
953	base	603	Biography	Setting the World on Fire: The Brief, Astonishing Life of St. Catherine of Siena	21.15	2	In stock	f
954	base	495	Biography	The Faith of Christopher Hitchens: The Restless Soul of the World's Most Notorious Atheist	39.55	1	In stock	f
955	base	460	Biography	Benjamin Franklin: An American Life	48.19	3	In stock	f
956	base	276	Biography	The Rise of Theodore Roosevelt (Theodore Roosevelt #1)	42.57	3	In stock	f
957	base	980	Thriller	In Her Wake	12.84	1	In stock	f
958	base	968	Thriller	The Elephant Tree	23.82	5	In stock	f
959	base	962	Thriller	Behind Closed Doors	52.22	4	In stock	f
960	base	784	Thriller	You (You #1)	43.61	5	In stock	f
961	base	750	Thriller	The Guilty (Will Robie #4)	13.82	2	In stock	f
962	base	744	Thriller	The 14th Colony (Cotton Malone #11)	39.24	1	In stock	f
963	base	430	Thriller	Give It Back	18.32	2	In stock	f
964	base	382	Thriller	Killing Floor (Jack Reacher #1)	31.49	4	In stock	f
965	base	343	Thriller	The Bone Hunters (Lexy Vaughan & Steven Macaulay #2)	59.71	3	In stock	f
966	base	320	Thriller	Far From True (Promise Falls Trilogy #2)	34.93	2	In stock	f
967	base	285	Thriller	The Travelers	15.77	1	In stock	f
968	base	955	Contemporary	When We Collided	31.77	1	In stock	f
969	base	735	Contemporary	Someone Like You (The Harrisons #2)	52.79	5	In stock	f
970	base	301	Contemporary	We Are All Completely Beside Ourselves	24.04	1	In stock	f
971	base	970	Spirituality	The Four Agreements: A Practical Guide to Personal Freedom	17.66	5	In stock	f
972	base	928	Spirituality	The Activist's Tao Te Ching: Ancient Advice for a Modern Revolution	32.24	5	In stock	f
973	base	797	Spirituality	Chasing Heaven: What Dying Taught Me About Living	37.80	2	In stock	f
1236	cambio_decision	766	Fiction	The Time Keeper	27.88	5	In stock	f
974	base	564	Spirituality	If I Gave You God's Phone Number....: Searching for Spirituality in America	20.91	1	In stock	f
975	base	505	Spirituality	Unreasonable Hope: Finding Faith in the God Who Brings Purpose to Your Pain	46.33	2	In stock	f
976	base	311	Spirituality	A New Earth: Awakening to Your Life's Purpose	55.65	5	In stock	f
977	base	384	Academic	Logan Kade (Fallen Crest High #5.5)	13.12	2	In stock	f
978	base	913	Self Help	Online Marketing for Busy Authors: A Step-By-Step Guide	46.35	1	In stock	f
979	base	897	Self Help	How to Be Miserable: 40 Strategies You Already Use	46.03	1	In stock	f
980	base	725	Self Help	Overload: How to Unplug, Unwind, and Unleash Yourself from the Pressure of Stress	52.15	3	In stock	f
981	base	508	Self Help	You Are a Badass: How to Stop Doubting Your Greatness and Start Living an Awesome Life	12.08	3	In stock	f
982	base	431	Self Help	How to Stop Worrying and Start Living	46.49	5	In stock	f
983	base	660	Historical	All the Light We Cannot See	29.87	5	In stock	f
984	base	443	Historical	The Girl You Left Behind (The Girl You Left Behind #1)	15.79	1	In stock	f
985	base	873	Christian	(Un)Qualified: How God Uses Broken People to Do Big Things	54.00	5	In stock	f
986	base	682	Christian	Crazy Love: Overwhelmed by a Relentless God	47.72	2	In stock	f
987	base	461	Christian	Blue Like Jazz: Nonreligious Thoughts on Christian Spirituality	25.77	1	In stock	f
988	base	542	Suspense	Silence in the Dark (Logan Point #4)	58.33	3	In stock	f
989	base	546	Short Stories	The Grownup	35.88	1	In stock	f
990	base	568	Novels	Suzie Snowflake: One beautiful flake (a self-esteem story)	54.81	5	In stock	f
991	base	931	Health	The Bulletproof Diet: Lose up to a Pound a Day, Reclaim Energy and Focus, Upgrade Your Life	49.05	3	In stock	f
992	base	688	Health	Eat Fat, Get Thin	54.07	2	In stock	f
993	base	581	Health	10-Day Green Smoothie Cleanse: Lose Up to 15 Pounds in 10 Days!	49.71	5	In stock	f
994	base	570	Health	The Art and Science of Low Carbohydrate Living	52.98	5	In stock	f
995	base	982	Politics	Libertarianism for Beginners	51.33	2	In stock	f
996	base	781	Politics	Why the Right Went Wrong: Conservatism--From Goldwater to the Tea Party and Beyond	52.65	4	In stock	f
997	base	617	Politics	Equal Is Unfair: America's Misguided Fight Against Income Inequality	56.86	1	In stock	f
998	base	788	Cultural	Amid the Chaos	36.58	1	In stock	f
999	base	800	Erotica	Dark Notes	19.19	5	In stock	f
1000	base	848	Crime	The Long Shadow of Small Ghosts: Murder and Memory in an American City	10.97	1	In stock	f
1001	cambio_decision	981	Travel	It's Only the Himalayas	45.17	2	In stock	f
1002	cambio_decision	811	Travel	Full Moon over Noah’s Ark: An Odyssey to Mount Ararat and Beyond	49.43	4	In stock	f
1003	cambio_decision	732	Travel	See America: A Celebration of Our National Parks & Treasured Sites	48.87	3	In stock	f
1004	cambio_decision	552	Travel	Vagabonding: An Uncommon Guide to the Art of Long-Term World Travel	36.94	2	In stock	f
1005	cambio_decision	504	Travel	Under the Tuscan Sun	37.33	3	In stock	f
1006	cambio_decision	458	Travel	A Summer In Europe	44.34	2	In stock	f
1007	cambio_decision	446	Travel	The Great Railway Bazaar	30.54	1	In stock	f
1008	cambio_decision	421	Travel	A Year in Provence (Provence #1)	56.88	4	In stock	f
1009	cambio_decision	277	Travel	The Road to Little Dribbling: Adventures of an American in Britain (Notes From a Small Island #2)	23.21	1	In stock	f
1010	cambio_decision	198	Travel	Neither Here nor There: Travels in Europe	38.95	3	In stock	f
1011	cambio_decision	1	Travel	1,000 Places to See Before You Die	26.08	5	In stock	f
1012	cambio_decision	997	Mystery	Sharp Objects	47.82	4	In stock	f
1013	cambio_decision	963	Mystery	In a Dark, Dark Wood	19.63	1	In stock	f
1014	cambio_decision	942	Mystery	The Past Never Ends	56.50	4	In stock	f
1015	cambio_decision	877	Mystery	A Murder in Time	16.64	1	In stock	f
1016	cambio_decision	852	Mystery	The Murder of Roger Ackroyd (Hercule Poirot #4)	44.10	4	In stock	f
1017	cambio_decision	754	Mystery	The Last Mile (Amos Decker #2)	54.21	2	In stock	f
1018	cambio_decision	743	Mystery	That Darkness (Gardiner and Renner #1)	13.92	1	In stock	f
1019	cambio_decision	742	Mystery	Tastes Like Fear (DI Marnie Rome #3)	10.69	1	In stock	f
1020	cambio_decision	657	Mystery	A Time of Torment (Charlie Parker #14)	48.35	5	In stock	f
1021	cambio_decision	656	Mystery	A Study in Scarlet (Sherlock Holmes #1)	16.73	2	In stock	f
1022	cambio_decision	627	Mystery	Poisonous (Max Revere Novels #3)	26.80	3	In stock	f
1023	cambio_decision	624	Mystery	Murder at the 42nd Street Library (Raymond Ambler #1)	54.36	4	In stock	f
1024	cambio_decision	623	Mystery	Most Wanted	35.28	3	In stock	f
1025	cambio_decision	620	Mystery	Hide Away (Eve Duncan #20)	11.84	1	In stock	f
1026	cambio_decision	613	Mystery	Boar Island (Anna Pigeon #19)	59.48	3	In stock	f
1027	cambio_decision	609	Mystery	The Widow	27.26	2	In stock	f
1028	cambio_decision	602	Mystery	Playing with Fire	13.71	3	In stock	f
1029	cambio_decision	506	Mystery	What Happened on Beale Street (Secrets of the South Mysteries #2)	25.37	5	In stock	f
1030	cambio_decision	491	Mystery	The Bachelor Girl's Guide to Murder (Herringford and Watts Mysteries #1)	52.30	5	In stock	f
1031	cambio_decision	464	Mystery	Delivering the Truth (Quaker Midwife Mystery #1)	20.89	4	In stock	f
1032	cambio_decision	452	Mystery	The Mysterious Affair at Styles (Hercule Poirot #1)	24.80	4	In stock	f
1033	cambio_decision	433	Mystery	In the Woods (Dublin Murder Squad #1)	38.38	2	In stock	f
1034	cambio_decision	280	Mystery	The Silkworm (Cormoran Strike #2)	23.05	5	In stock	f
1035	cambio_decision	247	Mystery	The Exiled	43.45	3	In stock	f
1036	cambio_decision	239	Mystery	The Cuckoo's Calling (Cormoran Strike #1)	19.21	1	In stock	f
1037	cambio_decision	154	Mystery	Extreme Prey (Lucas Davenport #26)	25.40	3	In stock	f
1038	cambio_decision	137	Mystery	Career of Evil (Cormoran Strike #3)	24.72	2	In stock	f
1039	cambio_decision	76	Mystery	The No. 1 Ladies' Detective Agency (No. 1 Ladies' Detective Agency #1)	57.70	4	In stock	f
1041	cambio_decision	65	Mystery	The Girl In The Ice (DCI Erika Foster #1)	15.85	3	In stock	f
1042	cambio_decision	8	Mystery	Blood Defense (Samantha Brinkman #1)	20.30	3	In stock	f
1043	cambio_decision	2	Mystery	1st to Die (Women's Murder Club #1)	53.98	1	In stock	f
1044	cambio_decision	999	Historical Fiction	Tipping the Velvet	53.74	1	In stock	f
1045	cambio_decision	894	Historical Fiction	Forever and Forever: The Courtship of Henry Longfellow and Fanny Appleton	29.69	3	In stock	f
1046	cambio_decision	876	Historical Fiction	A Flight of Arrows (The Pathfinders #2)	55.53	5	In stock	f
1047	cambio_decision	846	Historical Fiction	The House by the Lake	36.95	1	In stock	f
1048	cambio_decision	821	Historical Fiction	Mrs. Houdini	30.25	5	In stock	f
1049	cambio_decision	759	Historical Fiction	The Marriage of Opposites	28.08	4	In stock	f
1050	cambio_decision	696	Historical Fiction	Glory over Everything: Beyond The Kitchen House	45.84	3	In stock	f
1051	cambio_decision	622	Historical Fiction	Love, Lies and Spies	20.55	2	In stock	f
1052	cambio_decision	612	Historical Fiction	A Paris Apartment	39.01	4	In stock	f
1053	cambio_decision	597	Historical Fiction	Lilac Girls	17.28	2	In stock	f
1054	cambio_decision	493	Historical Fiction	The Constant Princess (The Tudor Court #1)	16.62	3	In stock	f
1055	cambio_decision	448	Historical Fiction	The Invention of Wings	37.34	1	In stock	f
1056	cambio_decision	420	Historical Fiction	World Without End (The Pillars of the Earth #2)	32.97	4	In stock	f
1057	cambio_decision	351	Historical Fiction	The Passion of Dolssa	28.32	5	In stock	f
1058	cambio_decision	322	Historical Fiction	Girl With a Pearl Earring	26.77	1	In stock	f
1059	cambio_decision	299	Historical Fiction	Voyager (Outlander #3)	21.07	5	In stock	f
1060	cambio_decision	273	Historical Fiction	The Red Tent	35.66	5	In stock	f
1061	cambio_decision	259	Historical Fiction	The Last Painting of Sara de Vos	55.55	2	In stock	f
1062	cambio_decision	253	Historical Fiction	The Guernsey Literary and Potato Peel Pie Society	49.53	1	In stock	f
1063	cambio_decision	160	Historical Fiction	Girl in the Blue Coat	46.83	2	In stock	f
1064	cambio_decision	128	Historical Fiction	Between Shades of Gray	20.79	5	In stock	f
1065	cambio_decision	97	Historical Fiction	While You Were Mine	41.32	5	In stock	f
1066	cambio_decision	80	Historical Fiction	The Secret Healer	34.56	3	In stock	f
1067	cambio_decision	56	Historical Fiction	Starlark	25.83	3	In stock	f
1068	cambio_decision	31	Historical Fiction	Lost Among the Living	27.70	4	In stock	f
1069	cambio_decision	3	Historical Fiction	A Spy's Devotion (The Regency Spies of London #1)	16.97	5	In stock	f
1070	cambio_decision	987	Sequential Art	Scott Pilgrim's Precious Little Life (Scott Pilgrim #1)	52.29	5	In stock	f
1071	cambio_decision	949	Sequential Art	Tsubasa: WoRLD CHRoNiCLE 2 (Tsubasa WoRLD CHRoNiCLE #2)	16.28	1	In stock	f
1072	cambio_decision	947	Sequential Art	This One Summer	19.49	4	In stock	f
1073	cambio_decision	940	Sequential Art	The Nameless City (The Nameless City #1)	38.16	4	In stock	f
1074	cambio_decision	923	Sequential Art	Saga, Volume 5 (Saga (Collected Editions) #5)	51.04	2	In stock	f
1075	cambio_decision	921	Sequential Art	Rat Queens, Vol. 3: Demons (Rat Queens (Collected Editions) #11-15)	50.40	3	In stock	f
1076	cambio_decision	920	Sequential Art	Princess Jellyfish 2-in-1 Omnibus, Vol. 01 (Princess Jellyfish 2-in-1 Omnibus #1)	13.61	5	In stock	f
1077	cambio_decision	918	Sequential Art	Pop Gun War, Volume 1: Gift	18.97	1	In stock	f
1078	cambio_decision	916	Sequential Art	Patience	10.16	3	In stock	f
1079	cambio_decision	915	Sequential Art	Outcast, Vol. 1: A Darkness Surrounds Him (Outcast #1)	15.44	4	In stock	f
1080	cambio_decision	914	Sequential Art	orange: The Complete Collection 1 (orange: The Complete Collection #1)	48.41	1	In stock	f
1081	cambio_decision	907	Sequential Art	Lumberjanes, Vol. 2: Friendship to the Max (Lumberjanes #5-8)	46.91	2	In stock	f
1082	cambio_decision	906	Sequential Art	Lumberjanes, Vol. 1: Beware the Kitten Holy (Lumberjanes #1-4)	45.61	3	In stock	f
1083	cambio_decision	905	Sequential Art	Lumberjanes Vol. 3: A Terrible Plan (Lumberjanes #9-12)	19.92	2	In stock	f
1084	cambio_decision	899	Sequential Art	I Hate Fairyland, Vol. 1: Madly Ever After (I Hate Fairyland (Compilations) #1-5)	29.17	2	In stock	f
1085	cambio_decision	898	Sequential Art	I am a Hero Omnibus Volume 1	54.63	3	In stock	f
1086	cambio_decision	895	Sequential Art	Giant Days, Vol. 2 (Giant Days #5-8)	22.11	2	In stock	f
1087	cambio_decision	889	Sequential Art	Danganronpa Volume 1	51.99	4	In stock	f
1088	cambio_decision	887	Sequential Art	Codename Baboushka, Volume 1: The Conclave of Death	36.72	4	In stock	f
1089	cambio_decision	886	Sequential Art	Camp Midnight	17.08	4	In stock	f
1090	cambio_decision	882	Sequential Art	Bitch Planet, Vol. 1: Extraordinary Machine (Bitch Planet (Collected Editions))	37.92	2	In stock	f
1091	cambio_decision	860	Sequential Art	The Shadow Hero (The Shadow Hero)	33.14	1	In stock	f
1092	cambio_decision	806	Sequential Art	Fables, Vol. 1: Legends in Exile (Fables #1)	41.62	4	In stock	f
1093	cambio_decision	793	Sequential Art	Batman: The Long Halloween (Batman)	36.50	2	In stock	f
1094	cambio_decision	792	Sequential Art	Batman: The Dark Knight Returns (Batman)	15.38	5	In stock	f
1095	cambio_decision	783	Sequential Art	Wonder Woman: Earth One, Volume One (Wonder Woman: Earth One #1)	37.34	4	In stock	f
1096	cambio_decision	778	Sequential Art	We Are Robin, Vol. 1: The Vigilante Business (We Are Robin #1)	53.90	1	In stock	f
1097	cambio_decision	772	Sequential Art	Through the Woods	25.38	2	In stock	f
1098	cambio_decision	739	Sequential Art	Superman Vol. 1: Before Truth (Superman by Gene Luen Yang #1)	11.89	5	In stock	f
1099	cambio_decision	734	Sequential Art	So Cute It Hurts!!, Vol. 6 (So Cute It Hurts!! #6)	35.43	4	In stock	f
1100	cambio_decision	730	Sequential Art	Robin War	47.82	3	In stock	f
1101	cambio_decision	729	Sequential Art	Red Hood/Arsenal, Vol. 1: Open for Business (Red Hood/Arsenal #1)	25.48	2	In stock	f
1102	cambio_decision	721	Sequential Art	Naruto (3-in-1 Edition), Vol. 14: Includes Vols. 40, 41 & 42 (Naruto: Omnibus #14)	38.39	2	In stock	f
1493	cambio_decision	737	Default	Steve Jobs	39.50	5	In stock	f
1103	cambio_decision	712	Sequential Art	Lowriders to the Center of the Earth (Lowriders in Space #2)	51.51	2	In stock	f
1104	cambio_decision	691	Sequential Art	El Deafo	57.62	5	In stock	f
1105	cambio_decision	668	Sequential Art	Batman: Europa	32.01	2	In stock	f
1106	cambio_decision	664	Sequential Art	Art Ops Vol. 1	48.80	3	In stock	f
1107	cambio_decision	659	Sequential Art	Adulthood Is a Myth: A "Sarah's Scribbles" Collection	10.90	2	In stock	f
1108	cambio_decision	563	Sequential Art	Fruits Basket, Vol. 9 (Fruits Basket #9)	33.95	4	In stock	f
1109	cambio_decision	540	Sequential Art	Roller Girl	14.10	5	In stock	f
1110	cambio_decision	468	Sequential Art	Fruits Basket, Vol. 7 (Fruits Basket #7)	19.57	1	In stock	f
1111	cambio_decision	427	Sequential Art	Fruits Basket, Vol. 6 (Fruits Basket #6)	20.96	4	In stock	f
1112	cambio_decision	425	Sequential Art	Death Note, Vol. 6: Give-and-Take (Death Note #6)	36.39	3	In stock	f
1113	cambio_decision	376	Sequential Art	Fruits Basket, Vol. 5 (Fruits Basket #5)	16.33	1	In stock	f
1114	cambio_decision	368	Sequential Art	Death Note, Vol. 5: Whiteout (Death Note #5)	52.41	1	In stock	f
1115	cambio_decision	344	Sequential Art	The Demon Prince of Momochi House, Vol. 4 (The Demon Prince of Momochi House #4)	27.88	2	In stock	f
1116	cambio_decision	321	Sequential Art	Fruits Basket, Vol. 4 (Fruits Basket #4)	50.44	4	In stock	f
1117	cambio_decision	287	Sequential Art	The Wicked + The Divine, Vol. 3: Commercial Suicide (The Wicked + The Divine)	14.41	3	In stock	f
1118	cambio_decision	279	Sequential Art	The Sandman, Vol. 3: Dream Country (The Sandman (volumes) #3)	55.55	5	In stock	f
1119	cambio_decision	216	Sequential Art	Saga, Volume 3 (Saga (Collected Editions) #3)	21.57	5	In stock	f
1120	cambio_decision	207	Sequential Art	Prodigy: The Graphic Novel (Legend: The Graphic Novel #2)	43.63	3	In stock	f
1121	cambio_decision	206	Sequential Art	Persepolis: The Story of a Childhood (Persepolis #1-2)	39.13	1	In stock	f
1122	cambio_decision	203	Sequential Art	Original Fake	31.45	3	In stock	f
1123	cambio_decision	164	Sequential Art	Grayson, Vol 3: Nemesis (Grayson #3)	42.72	1	In stock	f
1124	cambio_decision	159	Sequential Art	Fruits Basket, Vol. 3 (Fruits Basket #3)	45.17	2	In stock	f
1125	cambio_decision	130	Sequential Art	Black Butler, Vol. 1 (Black Butler #1)	49.31	1	In stock	f
1126	cambio_decision	124	Sequential Art	Awkward	38.02	2	In stock	f
1127	cambio_decision	110	Sequential Art	The Sandman, Vol. 2: The Doll's House (The Sandman (volumes) #2)	54.81	1	In stock	f
1128	cambio_decision	107	Sequential Art	Saga, Volume 2 (Saga (Collected Editions) #2)	11.75	3	In stock	f
1129	cambio_decision	100	Sequential Art	Fruits Basket, Vol. 2 (Fruits Basket #2)	11.64	5	In stock	f
1130	cambio_decision	98	Sequential Art	Y: The Last Man, Vol. 1: Unmanned (Y: The Last Man #1)	18.51	4	In stock	f
1131	cambio_decision	86	Sequential Art	The Wicked + The Divine, Vol. 1: The Faust Act (The Wicked + The Divine)	36.52	2	In stock	f
1132	cambio_decision	79	Sequential Art	The Sandman, Vol. 1: Preludes and Nocturnes (The Sandman (volumes) #1)	54.12	3	In stock	f
1133	cambio_decision	62	Sequential Art	The Complete Maus (Maus #1-2)	10.64	3	In stock	f
1134	cambio_decision	55	Sequential Art	Skip Beat!, Vol. 01 (Skip Beat! #1)	42.12	3	In stock	f
1135	cambio_decision	48	Sequential Art	Saga, Volume 1 (Saga (Collected Editions) #1)	28.48	1	In stock	f
1136	cambio_decision	46	Sequential Art	Rat Queens, Vol. 1: Sass & Sorcery (Rat Queens (Collected Editions) #1-5)	46.96	5	In stock	f
1137	cambio_decision	44	Sequential Art	Paper Girls, Vol. 1 (Paper Girls #1-5)	21.71	4	In stock	f
1138	cambio_decision	43	Sequential Art	Ouran High School Host Club, Vol. 1 (Ouran High School Host Club #1)	29.87	3	In stock	f
1139	cambio_decision	34	Sequential Art	Ms. Marvel, Vol. 1: No Normal (Ms. Marvel (2014-2015) #1)	39.39	4	In stock	f
1140	cambio_decision	24	Sequential Art	Hawkeye, Vol. 1: My Life as a Weapon (Hawkeye #1)	45.24	3	In stock	f
1141	cambio_decision	22	Sequential Art	Giant Days, Vol. 1 (Giant Days #1-4)	56.76	4	In stock	f
1142	cambio_decision	21	Sequential Art	Fruits Basket, Vol. 1 (Fruits Basket #1)	40.28	5	In stock	f
1143	cambio_decision	7	Sequential Art	Bleach, Vol. 1: Strawberry and the Soul Reapers (Bleach #1)	34.65	5	In stock	f
1144	cambio_decision	4	Sequential Art	Ajin: Demi-Human, Volume 1 (Ajin: Demi-Human #1)	57.06	4	In stock	f
1145	cambio_decision	413	Classics	The Secret Garden	15.08	4	In stock	f
1146	cambio_decision	409	Classics	The Metamorphosis	28.58	1	In stock	f
1147	cambio_decision	353	Classics	The Pilgrim's Progress	50.26	2	In stock	f
1148	cambio_decision	348	Classics	The Hound of the Baskervilles (Sherlock Holmes #5)	14.82	2	In stock	f
1149	cambio_decision	331	Classics	Little Women (Little Women #1)	28.07	4	In stock	f
1150	cambio_decision	324	Classics	Gone with the Wind	32.49	3	In stock	f
1151	cambio_decision	316	Classics	Candide	58.63	3	In stock	f
1152	cambio_decision	313	Classics	Animal Farm	57.22	3	In stock	f
1153	cambio_decision	307	Classics	Wuthering Heights	17.73	3	In stock	f
1154	cambio_decision	270	Classics	The Picture of Dorian Gray	29.70	2	In stock	f
1155	cambio_decision	238	Classics	The Complete Stories and Poems (The Works of Edgar Allan Poe [Cameo Edition])	26.78	4	In stock	f
1156	cambio_decision	126	Classics	Beowulf	38.35	2	In stock	f
1157	cambio_decision	119	Classics	And Then There Were None	35.01	2	In stock	f
1158	cambio_decision	84	Classics	The Story of Hong Gildong	43.19	4	In stock	f
1159	cambio_decision	72	Classics	The Little Prince	45.42	2	In stock	f
1160	cambio_decision	49	Classics	Sense and Sensibility	37.46	1	In stock	f
1161	cambio_decision	37	Classics	Of Mice and Men	47.11	2	In stock	f
1162	cambio_decision	17	Classics	Emma	32.93	2	In stock	f
1163	cambio_decision	5	Classics	Alice in Wonderland (Alice's Adventures in Wonderland #1)	55.53	1	In stock	f
1164	cambio_decision	966	Philosophy	Sophie's World	15.94	5	In stock	f
1165	cambio_decision	932	Philosophy	The Death of Humanity: and the Case for Life	58.11	4	In stock	f
1166	cambio_decision	861	Philosophy	The Stranger	17.44	4	In stock	f
1167	cambio_decision	538	Philosophy	Proofs of God: Classical Arguments from Tertullian to Barth	54.21	1	In stock	f
1168	cambio_decision	527	Philosophy	Kierkegaard: A Christian Missionary to Christians	47.13	1	In stock	f
1169	cambio_decision	459	Philosophy	At The Existentialist Café: Freedom, Being, and apricot cocktails with: Jean-Paul Sartre, Simone de Beauvoir, Albert Camus, Martin Heidegger, Edmund Husserl, Karl Jaspers, Maurice Merleau-Ponty and others	29.93	5	In stock	f
1170	cambio_decision	366	Philosophy	Critique of Pure Reason	20.75	1	In stock	f
1171	cambio_decision	106	Philosophy	Run, Spot, Run: The Ethics of Keeping Pets	20.02	1	In stock	f
1172	cambio_decision	75	Philosophy	The Nicomachean Ethics	36.34	1	In stock	f
1173	cambio_decision	33	Philosophy	Meditations	25.89	2	In stock	f
1174	cambio_decision	6	Philosophy	Beyond Good and Evil	43.38	1	In stock	f
1175	cambio_decision	977	Romance	Chase Me (Paris Nights #2)	25.27	5	In stock	f
1176	cambio_decision	976	Romance	Black Dust	34.53	5	In stock	f
1177	cambio_decision	896	Romance	Her Backup Boyfriend (The Sorensen Family #1)	33.97	1	In stock	f
1178	cambio_decision	893	Romance	First and First (Five Boroughs #3)	15.97	4	In stock	f
1179	cambio_decision	892	Romance	Fifty Shades Darker (Fifty Shades #2)	21.96	1	In stock	f
1180	cambio_decision	864	Romance	The Wedding Dress	24.12	1	In stock	f
1181	cambio_decision	835	Romance	Suddenly in Love (Lake Haven #1)	55.99	2	In stock	f
1182	cambio_decision	834	Romance	Something More Than This	16.24	4	In stock	f
1183	cambio_decision	802	Romance	Doing It Over (Most Likely To #1)	35.61	3	In stock	f
1184	cambio_decision	767	Romance	The Wedding Pact (The O'Malleys #2)	32.61	3	In stock	f
1185	cambio_decision	700	Romance	Hold Your Breath (Search and Rescue #1)	28.82	1	In stock	f
1186	cambio_decision	615	Romance	Dirty (Dive Bar #1)	40.83	4	In stock	f
1187	cambio_decision	605	Romance	Take Me Home Tonight (Rock Star Romance #3)	53.98	3	In stock	f
1188	cambio_decision	601	Romance	Off the Hook (Fishing for Trouble #1)	47.67	3	In stock	f
1189	cambio_decision	584	Romance	A Gentleman's Position (Society of Gentlemen #3)	14.75	5	In stock	f
1190	cambio_decision	486	Romance	Sit, Stay, Love	20.90	3	In stock	f
1191	cambio_decision	359	Romance	A Girl's Guide to Moving On (New Beginnings #2)	31.30	1	In stock	f
1192	cambio_decision	352	Romance	The Perfect Play (Play by Play #1)	59.99	3	In stock	f
1193	cambio_decision	319	Romance	Dark Lover (Black Dagger Brotherhood #1)	12.87	1	In stock	f
1194	cambio_decision	317	Romance	Changing the Game (Play by Play #2)	13.38	3	In stock	f
1195	cambio_decision	312	Romance	A Walk to Remember	56.43	1	In stock	f
1196	cambio_decision	271	Romance	The Purest Hook (Second Circle Tattoos #3)	12.25	1	In stock	f
1197	cambio_decision	268	Romance	The Obsession	45.43	1	In stock	f
1198	cambio_decision	211	Romance	Reservations for Two	11.10	3	In stock	f
1199	cambio_decision	127	Romance	Best of My Love (Fool's Gold #20)	27.41	2	In stock	f
1200	cambio_decision	96	Romance	Where Lightning Strikes (Bleeding Stars #3)	39.77	3	In stock	f
1201	cambio_decision	88	Romance	This One Moment (Pushing Limits #1)	48.71	1	In stock	f
1202	cambio_decision	47	Romance	Rhythm, Chord & Malykhin	28.34	2	In stock	f
1203	cambio_decision	35	Romance	My Perfect Mistake (Over the Top #1)	38.92	2	In stock	f
1204	cambio_decision	29	Romance	Listen to Me (Fusion #1)	58.99	3	In stock	f
1205	cambio_decision	26	Romance	Imperfect Harmony	34.74	4	In stock	f
1206	cambio_decision	18	Romance	Fighting Fate (Fighting #6)	39.24	3	In stock	f
1207	cambio_decision	15	Romance	Deep Under (Walker Security #1)	47.09	5	In stock	f
1208	cambio_decision	12	Romance	Charity's Cross (Charles Towne Belles #4)	41.24	1	In stock	f
1209	cambio_decision	9	Romance	Bounty (Colorado Mountain #7)	37.26	4	In stock	f
1210	cambio_decision	814	Womens Fiction	I Had a Nice Time And Other Lies...: How to find love & sh*t like that	57.36	4	In stock	f
1211	cambio_decision	644	Womens Fiction	Will You Won't You Want Me?	13.86	3	In stock	f
1212	cambio_decision	594	Womens Fiction	Keep Me Posted	20.46	4	In stock	f
1213	cambio_decision	592	Womens Fiction	Grey (Fifty Shades #4)	48.49	4	In stock	f
1214	cambio_decision	478	Womens Fiction	Meternity	43.58	3	In stock	f
1215	cambio_decision	341	Womens Fiction	Some Women	13.73	5	In stock	f
1216	cambio_decision	340	Womens Fiction	Shopaholic Ties the Knot (Shopaholic #3)	48.39	5	In stock	f
1217	cambio_decision	315	Womens Fiction	Can You Keep a Secret?	21.94	1	In stock	f
1218	cambio_decision	292	Womens Fiction	Twenties Girl	42.80	2	In stock	f
1219	cambio_decision	286	Womens Fiction	The Undomestic Goddess	45.75	4	In stock	f
1220	cambio_decision	265	Womens Fiction	The Nanny Diaries (Nanny #1)	52.53	5	In stock	f
1221	cambio_decision	243	Womens Fiction	The Devil Wears Prada (The Devil Wears Prada #1)	44.29	1	In stock	f
1222	cambio_decision	224	Womens Fiction	Something Borrowed (Darcy & Rachel #1)	48.96	5	In stock	f
1223	cambio_decision	223	Womens Fiction	Something Blue (Darcy & Rachel #2)	54.62	1	In stock	f
1224	cambio_decision	173	Womens Fiction	I've Got Your Number	19.69	1	In stock	f
1225	cambio_decision	63	Womens Fiction	The Edge of Reason (Bridget Jones #2)	19.18	4	In stock	f
1226	cambio_decision	10	Womens Fiction	Bridget Jones's Diary (Bridget Jones #1)	29.82	1	In stock	f
1227	cambio_decision	998	Fiction	Soumission	50.10	1	In stock	f
1228	cambio_decision	958	Fiction	Private Paris (Private #10)	47.61	5	In stock	f
1229	cambio_decision	954	Fiction	We Love You, Charlie Freeman	50.27	5	In stock	f
1230	cambio_decision	946	Fiction	Thirst	17.27	5	In stock	f
1231	cambio_decision	939	Fiction	The Murder That Never Was (Forensic Instincts #5)	54.11	3	In stock	f
1232	cambio_decision	870	Fiction	Tuesday Nights in 1980	21.04	2	In stock	f
1233	cambio_decision	863	Fiction	The Vacationers	42.15	4	In stock	f
1234	cambio_decision	858	Fiction	The Regional Office Is Under Attack!	51.36	5	In stock	f
1235	cambio_decision	807	Fiction	Finders Keepers (Bill Hodges Trilogy #2)	53.53	5	In stock	f
1237	cambio_decision	765	Fiction	The Testament of Mary	52.67	4	In stock	f
1238	cambio_decision	749	Fiction	The First Hostage (J.B. Collins #2)	25.85	3	In stock	f
1239	cambio_decision	741	Fiction	Take Me with You	45.21	3	In stock	f
1240	cambio_decision	738	Fiction	Still Life with Bread Crumbs	26.41	3	In stock	f
1241	cambio_decision	733	Fiction	Shtum	55.84	4	In stock	f
1242	cambio_decision	720	Fiction	My Name Is Lucy Barton	41.56	1	In stock	f
1243	cambio_decision	719	Fiction	My Mrs. Brown	24.48	3	In stock	f
1244	cambio_decision	717	Fiction	Mr. Mercedes (Bill Hodges Trilogy #1)	28.90	1	In stock	f
1245	cambio_decision	703	Fiction	I Am Pilgrim (Pilgrim #1)	10.60	4	In stock	f
1246	cambio_decision	692	Fiction	Eligible (The Austen Project #4)	27.09	3	In stock	f
1247	cambio_decision	690	Fiction	Eight Hundred Grapes	14.39	4	In stock	f
1248	cambio_decision	684	Fiction	Dear Mr. Knightley	11.21	5	In stock	f
1249	cambio_decision	681	Fiction	Cometh the Hour (The Clifton Chronicles #6)	25.01	3	In stock	f
1250	cambio_decision	665	Fiction	Balloon Animals	17.03	3	In stock	f
1251	cambio_decision	653	Fiction	A Man Called Ove	39.72	1	In stock	f
1252	cambio_decision	641	Fiction	The Silent Sister (Riley MacPherson #1)	46.29	5	In stock	f
1253	cambio_decision	635	Fiction	The Dinner Party	56.54	2	In stock	f
1254	cambio_decision	607	Fiction	The Improbability of Love	59.45	1	In stock	f
1255	cambio_decision	600	Fiction	Mothering Sunday	13.34	2	In stock	f
1256	cambio_decision	596	Fiction	Lies and Other Acts of Love	45.14	1	In stock	f
1257	cambio_decision	590	Fiction	Daredevils	16.34	3	In stock	f
1258	cambio_decision	583	Fiction	11/22/63	48.48	3	In stock	f
1259	cambio_decision	576	Fiction	The Shack	28.03	1	In stock	f
1260	cambio_decision	547	Fiction	The High Mountains of Portugal	51.15	1	In stock	f
1261	cambio_decision	534	Fiction	Miller's Valley	58.54	2	In stock	f
1262	cambio_decision	523	Fiction	Hystopia: A Novel	21.96	4	In stock	f
1263	cambio_decision	492	Fiction	The Bourne Identity (Jason Bourne #1)	42.78	4	In stock	f
1264	cambio_decision	485	Fiction	Sister Dear	40.20	4	In stock	f
1265	cambio_decision	477	Fiction	Memoirs of a Geisha	49.67	3	In stock	f
1266	cambio_decision	434	Fiction	Me Before You (Me Before You #1)	19.02	1	In stock	f
1267	cambio_decision	426	Fiction	Deception Point	40.32	4	In stock	f
1268	cambio_decision	407	Fiction	The Little Paris Bookshop	24.73	3	In stock	f
1269	cambio_decision	404	Fiction	The Firm	45.56	3	In stock	f
1270	cambio_decision	401	Fiction	The Expatriates	44.58	2	In stock	f
1271	cambio_decision	393	Fiction	Siddhartha	34.22	5	In stock	f
1272	cambio_decision	383	Fiction	Last One Home (New Beginnings #1)	59.98	3	In stock	f
1273	cambio_decision	369	Fiction	Digital Fortress	58.00	5	In stock	f
1274	cambio_decision	314	Fiction	Atlas Shrugged	26.58	5	In stock	f
1275	cambio_decision	290	Fiction	Three-Martini Lunch	23.21	3	In stock	f
1276	cambio_decision	267	Fiction	The Nightingale	26.26	4	In stock	f
1277	cambio_decision	257	Fiction	The Infinities	27.41	1	In stock	f
1278	cambio_decision	256	Fiction	The Husband's Secret	52.51	5	In stock	f
1279	cambio_decision	240	Fiction	The Da Vinci Code (Robert Langdon #2)	22.96	2	In stock	f
1280	cambio_decision	228	Fiction	The Art of Fielding	22.10	1	In stock	f
1281	cambio_decision	190	Fiction	Lila (Gilead #3)	12.47	3	In stock	f
1282	cambio_decision	180	Fiction	Jurassic Park (Jurassic Park #1)	44.97	1	In stock	f
1283	cambio_decision	176	Fiction	Inferno (Robert Langdon #4)	41.00	5	In stock	f
1284	cambio_decision	143	Fiction	Crazy Rich Asians (Crazy Rich Asians #1)	49.13	5	In stock	f
1285	cambio_decision	129	Fiction	Big Little Lies	22.11	1	In stock	f
1286	cambio_decision	109	Fiction	The Course of Love	16.78	3	In stock	f
1287	cambio_decision	95	Fiction	When I'm Gone	51.96	3	In stock	f
1288	cambio_decision	83	Fiction	The Silent Wife	12.34	5	In stock	f
1289	cambio_decision	59	Fiction	The Bette Davis Club	30.66	3	In stock	f
1290	cambio_decision	28	Fiction	Kitchens of the Great Midwest	57.20	5	In stock	f
1291	cambio_decision	11	Fiction	Bright Lines	39.07	5	In stock	f
1292	cambio_decision	975	Childrens	Birdsong: A Story in Pictures	54.64	3	In stock	f
1293	cambio_decision	967	Childrens	The Bear and the Piano	36.89	1	In stock	f
1294	cambio_decision	944	Childrens	The Secret of Dreadwillow Carse	56.13	1	In stock	f
1295	cambio_decision	865	Childrens	The White Cat and the Monk: A Retelling of the Poem “Pangur Bán”	58.08	4	In stock	f
1296	cambio_decision	817	Childrens	Little Red	13.47	3	In stock	f
1297	cambio_decision	777	Childrens	Walt Disney's Alice in Wonderland	12.96	5	In stock	f
1298	cambio_decision	773	Childrens	Twenty Yawns	22.08	2	In stock	f
1299	cambio_decision	728	Childrens	Rain Fish	23.57	3	In stock	f
1300	cambio_decision	724	Childrens	Once Was a Time	18.28	2	In stock	f
1301	cambio_decision	714	Childrens	Luis Paints the World	53.95	3	In stock	f
1302	cambio_decision	567	Childrens	Nap-a-Roo	25.08	1	In stock	f
1303	cambio_decision	501	Childrens	The Whale	35.96	4	In stock	f
1304	cambio_decision	484	Childrens	Shrunken Treasures: Literary Classics, Short, Sweet, and Silly	52.87	3	In stock	f
1305	cambio_decision	482	Childrens	Raymie Nightingale	34.41	2	In stock	f
1306	cambio_decision	481	Childrens	Playing from the Heart	32.38	1	In stock	f
1307	cambio_decision	386	Childrens	Maybe Something Beautiful: How Art Transformed a Neighborhood	22.54	1	In stock	f
1308	cambio_decision	288	Childrens	The Wild Robot	56.07	3	In stock	f
1309	cambio_decision	283	Childrens	The Thing About Jellyfish	48.77	1	In stock	f
1310	cambio_decision	261	Childrens	The Lonely Ones	43.59	5	In stock	f
1311	cambio_decision	241	Childrens	The Day the Crayons Came Home (Crayons)	26.33	5	In stock	f
1312	cambio_decision	235	Childrens	The Cat in the Hat (Beginner Books B-1)	16.26	2	In stock	f
1313	cambio_decision	210	Childrens	Red: The True Story of Red Riding Hood	28.54	3	In stock	f
1314	cambio_decision	168	Childrens	Horrible Bear!	37.52	2	In stock	f
1315	cambio_decision	165	Childrens	Green Eggs and Ham (Beginner Books B-16)	10.79	4	In stock	f
1316	cambio_decision	142	Childrens	Counting Thyme	10.62	1	In stock	f
1317	cambio_decision	122	Childrens	Are We There Yet?	10.66	3	In stock	f
1318	cambio_decision	99	Childrens	Diary of a Minecraft Zombie Book 1: A Scare of a Dare (An Unofficial Minecraft Book)	52.88	4	In stock	f
1319	cambio_decision	32	Childrens	Matilda	28.34	1	In stock	f
1320	cambio_decision	13	Childrens	Charlie and the Chocolate Factory (Charlie Bucket #1)	22.85	3	In stock	f
1321	cambio_decision	890	Religion	Don't Be a Jerk: And Other Practical Advice from Dogen, Japan's Greatest Zen Master	37.97	2	In stock	f
1322	cambio_decision	872	Religion	You Are What You Love: The Spiritual Power of Habit	21.87	4	In stock	f
1323	cambio_decision	697	Religion	God: The Most Unpleasant Character in All Fiction	30.03	5	In stock	f
1324	cambio_decision	571	Religion	The Book of Mormon	24.57	3	In stock	f
1325	cambio_decision	310	Religion	A History of God: The 4,000-Year Quest of Judaism, Christianity, and Islam	27.62	1	In stock	f
1326	cambio_decision	60	Religion	The Bhagavad Gita	57.49	3	In stock	f
1327	cambio_decision	14	Religion	Choosing Our Religion: The Spiritual Lives of America's Nones	28.42	4	In stock	f
1328	cambio_decision	972	Nonfiction	Worlds Elsewhere: Journeys Around Shakespeare’s Globe	40.30	5	In stock	f
1329	cambio_decision	969	Nonfiction	The Five Love Languages: How to Express Heartfelt Commitment to Your Mate	31.05	3	In stock	f
1330	cambio_decision	959	Nonfiction	Reasons to Stay Alive	26.41	2	In stock	f
1331	cambio_decision	957	Nonfiction	#HigherSelfie: Wake Up Your Life. Free Your Soul. Find Your Tribe.	23.11	5	In stock	f
1332	cambio_decision	952	Nonfiction	Unseen City: The Majesty of Pigeons, the Discreet Charm of Snails & Other Wonders of the Urban Wilderness	44.18	4	In stock	f
1333	cambio_decision	948	Nonfiction	Throwing Rocks at the Google Bus: How Growth Became the Enemy of Prosperity	31.12	3	In stock	f
1334	cambio_decision	936	Nonfiction	The Life-Changing Magic of Tidying Up: The Japanese Art of Decluttering and Organizing	16.77	3	In stock	f
1335	cambio_decision	934	Nonfiction	The Gutsy Girl: Escapades for Your Life of Epic Adventure	37.13	1	In stock	f
1336	cambio_decision	933	Nonfiction	The Electric Pencil: Drawings from Inside State Hospital No. 3	56.06	1	In stock	f
1337	cambio_decision	927	Nonfiction	Spark Joy: An Illustrated Master Class on the Art of Organizing and Tidying Up	41.83	4	In stock	f
1338	cambio_decision	922	Nonfiction	Reskilling America: Learning to Labor in the Twenty-First Century	19.83	2	In stock	f
1339	cambio_decision	901	Nonfiction	In the Country We Love: My Family Divided	22.00	4	In stock	f
1340	cambio_decision	891	Nonfiction	Everydata: The Misinformation Hidden in the Little Data You Consume Every Day	54.35	2	In stock	f
1341	cambio_decision	885	Nonfiction	Call the Nurse: True Stories of a Country Nurse on a Scottish Isle	29.14	5	In stock	f
1342	cambio_decision	880	Nonfiction	Algorithms to Live By: The Computer Science of Human Decisions	30.81	1	In stock	f
1343	cambio_decision	855	Nonfiction	The Power of Now: A Guide to Spiritual Enlightenment	43.54	2	In stock	f
1344	cambio_decision	854	Nonfiction	The Omnivore's Dilemma: A Natural History of Four Meals	38.21	2	In stock	f
1345	cambio_decision	843	Nonfiction	The Genius of Birds	17.24	1	In stock	f
1346	cambio_decision	839	Nonfiction	The Artist's Way: A Spiritual Path to Higher Creativity	38.49	5	In stock	f
1347	cambio_decision	832	Nonfiction	So You've Been Publicly Shamed	12.23	2	In stock	f
1348	cambio_decision	799	Nonfiction	Daring Greatly: How the Courage to Be Vulnerable Transforms the Way We Live, Love, Parent, and Lead	19.43	3	In stock	f
1349	cambio_decision	796	Nonfiction	Big Magic: Creative Living Beyond Fear	30.80	3	In stock	f
1350	cambio_decision	795	Nonfiction	Becoming Wise: An Inquiry into the Mystery and Art of Living	27.43	2	In stock	f
1351	cambio_decision	786	Nonfiction	Agnostic: A Spirited Manifesto	12.51	5	In stock	f
1352	cambio_decision	780	Nonfiction	Whole Lotta Creativity Going On: 60 Fun and Unusual Exercises to Awaken and Strengthen Your Creativity	38.20	4	In stock	f
1353	cambio_decision	779	Nonfiction	What's It Like in Space?: Stories from Astronauts Who've Been There	19.60	2	In stock	f
1354	cambio_decision	770	Nonfiction	The Year of Magical Thinking	43.04	2	In stock	f
1355	cambio_decision	755	Nonfiction	The Literature Book (Big Ideas Simply Explained)	17.43	3	In stock	f
1356	cambio_decision	745	Nonfiction	The Bad-Ass Librarians of Timbuktu: And Their Race to Save the World’s Most Precious Manuscripts	15.77	1	In stock	f
1357	cambio_decision	740	Nonfiction	Swell: A Year of Waves	45.58	1	In stock	f
1358	cambio_decision	722	Nonfiction	No Dream Is Too High: Life Lessons From a Man Who Walked on the Moon	21.95	2	In stock	f
1359	cambio_decision	710	Nonfiction	Looking for Lovely: Collecting the Moments that Matter	29.14	5	In stock	f
1360	cambio_decision	708	Nonfiction	Let It Out: A Journey Through Journaling	26.79	5	In stock	f
1361	cambio_decision	699	Nonfiction	Hamilton: The Revolution	58.79	3	In stock	f
1362	cambio_decision	694	Nonfiction	Far & Away: Places on the Brink of Change: Seven Continents, Twenty-Five Years	15.06	4	In stock	f
1363	cambio_decision	689	Nonfiction	Eaternity: More than 150 Deliciously Easy Vegan Recipes for a Long, Healthy, Satisfied, Joyful Life	51.75	5	In stock	f
1364	cambio_decision	670	Nonfiction	Buying In: The Secret Dialogue Between What We Buy and Who We Are	37.80	4	In stock	f
1365	cambio_decision	669	Nonfiction	Brain on Fire: My Month of Madness	49.32	5	In stock	f
1366	cambio_decision	658	Nonfiction	Abstract City	56.37	5	In stock	f
1367	cambio_decision	645	Nonfiction	13 Hours: The Inside Account of What Really Happened In Benghazi	27.06	1	In stock	f
1368	cambio_decision	639	Nonfiction	The Lonely City: Adventures in the Art of Being Alone	33.26	2	In stock	f
1369	cambio_decision	634	Nonfiction	The Diary of a Young Girl	59.90	3	In stock	f
1370	cambio_decision	631	Nonfiction	Snatched: How A Drug Queen Went Undercover for the DEA and Was Kidnapped By Colombian Guerillas	21.21	3	In stock	f
1371	cambio_decision	619	Nonfiction	Furiously Happy: A Funny Book About Horrible Things	41.46	4	In stock	f
1372	cambio_decision	608	Nonfiction	The Sleep Revolution: Transforming Your Life, One Night at a Time	11.68	4	In stock	f
1373	cambio_decision	599	Nonfiction	Mother, Can You Not?	16.89	5	In stock	f
1374	cambio_decision	585	Nonfiction	A Mother's Reckoning: Living in the Aftermath of Tragedy	19.53	3	In stock	f
1375	cambio_decision	582	Nonfiction	10% Happier: How I Tamed the Voice in My Head, Reduced Stress Without Losing My Edge, and Found Self-Help That Actually Works	24.57	2	In stock	f
1376	cambio_decision	560	Nonfiction	Chernobyl 01:23:40: The Incredible True Story of the World's Worst Nuclear Disaster	35.92	2	In stock	f
1377	cambio_decision	555	Nonfiction	Zero to One: Notes on Startups, or How to Build the Future	34.06	3	In stock	f
1378	cambio_decision	554	Nonfiction	Why Not Me?	17.76	1	In stock	f
1379	cambio_decision	553	Nonfiction	When Breath Becomes Air	39.36	2	In stock	f
1380	cambio_decision	549	Nonfiction	The Midnight Assassin: Panic, Scandal, and the Hunt for America's First Serial Killer	28.45	4	In stock	f
1381	cambio_decision	543	Nonfiction	Smarter Faster Better: The Secrets of Being Productive in Life and Business	38.89	5	In stock	f
1382	cambio_decision	539	Nonfiction	Rising Strong	21.82	3	In stock	f
1383	cambio_decision	533	Nonfiction	Man's Search for Meaning	29.48	3	In stock	f
1384	cambio_decision	532	Nonfiction	Love That Boy: What Two Presidents, Eight Road Trips, and My Son Taught Me About a Parent's Expectations	25.06	2	In stock	f
1385	cambio_decision	531	Nonfiction	Living Forward: A Proven Plan to Stop Drifting and Get the Life You Want	12.55	3	In stock	f
1386	cambio_decision	524	Nonfiction	I Will Find You	44.21	1	In stock	f
1387	cambio_decision	514	Nonfiction	Brazen: The Courage to Find the You That's Been Hiding	19.22	2	In stock	f
1388	cambio_decision	513	Nonfiction	Between the World and Me	56.91	4	In stock	f
1389	cambio_decision	512	Nonfiction	Being Mortal: Medicine and What Matters in the End	55.06	4	In stock	f
1390	cambio_decision	511	Nonfiction	A Murder Over a Girl: Justice, Gender, Junior High	13.20	3	In stock	f
1391	cambio_decision	467	Nonfiction	For the Love: Fighting for Grace in a World of Impossible Standards	45.13	3	In stock	f
1392	cambio_decision	466	Nonfiction	Finding God in the Ruins: How God Redeems Pain	46.64	2	In stock	f
1393	cambio_decision	451	Nonfiction	The Man Who Mistook His Wife for a Hat and Other Clinical Tales	59.45	4	In stock	f
1394	cambio_decision	432	Nonfiction	In Cold Blood	49.98	4	In stock	f
1395	cambio_decision	429	Nonfiction	Girl, Interrupted	42.14	3	In stock	f
1396	cambio_decision	418	Nonfiction	Why Save the Bankers?: And Other Essays on Our Economic and Political Crisis	48.67	2	In stock	f
1397	cambio_decision	394	Nonfiction	Talking to Girls About Duran Duran: One Young Man's Quest for True Love and a Cooler Haircut	25.15	4	In stock	f
1398	cambio_decision	388	Nonfiction	My Mother Was Nuts	31.63	4	In stock	f
1399	cambio_decision	367	Nonfiction	Data, A Love Story: How I Gamed Online Dating to Meet My Match	32.35	3	In stock	f
1400	cambio_decision	350	Nonfiction	The Jazz of Physics: The Secret Link Between Music and the Structure of the Universe	38.71	3	In stock	f
1401	cambio_decision	347	Nonfiction	The Gunning of America: Business and the Making of American Gun Culture	16.81	4	In stock	f
1402	cambio_decision	346	Nonfiction	The Geography of Bliss: One Grump's Search for the Happiest Places in the World	28.23	2	In stock	f
1403	cambio_decision	323	Nonfiction	God Is Not Great: How Religion Poisons Everything	27.80	1	In stock	f
1404	cambio_decision	302	Nonfiction	We the People: The Modern-Day Figures Who Have Reshaped and Affirmed the Founding Fathers' Vision of America	31.95	3	In stock	f
1405	cambio_decision	298	Nonfiction	Very Good Lives: The Fringe Benefits of Failure and the Importance of Imagination	50.66	3	In stock	f
1406	cambio_decision	296	Nonfiction	Unstuffed: Decluttering Your Home, Mind, and Soul	58.09	1	In stock	f
1407	cambio_decision	295	Nonfiction	Under the Banner of Heaven: A Story of Violent Faith	30.00	1	In stock	f
1408	cambio_decision	291	Nonfiction	Trespassing Across America: One Man's Epic, Never-Done-Before (and Sort of Illegal) Hike Across the Heartland	53.51	1	In stock	f
1409	cambio_decision	264	Nonfiction	The Name of God is Mercy	37.25	2	In stock	f
1410	cambio_decision	226	Nonfiction	Stiff: The Curious Lives of Human Cadavers	36.74	3	In stock	f
1411	cambio_decision	225	Nonfiction	Spilled Milk: Based on a True Story	49.51	1	In stock	f
1412	cambio_decision	213	Nonfiction	Rise of the Rocket Girls: The Women Who Propelled Us, from Missiles to the Moon to Mars	41.67	4	In stock	f
1413	cambio_decision	204	Nonfiction	Outliers: The Story of Success	14.16	1	In stock	f
1414	cambio_decision	200	Nonfiction	Notes from a Small Island (Notes From a Small Island #1)	40.17	1	In stock	f
1415	cambio_decision	199	Nonfiction	Night (The Night Trilogy #1)	13.51	1	In stock	f
1416	cambio_decision	195	Nonfiction	Miracles from Heaven: A Little Girl, Her Journey to Heaven, and Her Amazing Story of Healing	57.83	1	In stock	f
1417	cambio_decision	186	Nonfiction	Letter to a Christian Nation	22.20	1	In stock	f
1418	cambio_decision	185	Nonfiction	Let's Pretend This Never Happened: A Mostly True Memoir	45.11	1	In stock	f
1419	cambio_decision	179	Nonfiction	It's Never Too Late to Begin Again: Discovering Creativity and Meaning at Midlife and Beyond	42.38	1	In stock	f
1420	cambio_decision	177	Nonfiction	Into the Wild	56.70	5	In stock	f
1421	cambio_decision	175	Nonfiction	In the Garden of Beasts: Love, Terror, and an American Family in Hitler's Berlin	28.85	3	In stock	f
1422	cambio_decision	172	Nonfiction	I Am Malala: The Girl Who Stood Up for Education and Was Shot by the Taliban	28.88	2	In stock	f
1423	cambio_decision	163	Nonfiction	Gratitude	26.66	5	In stock	f
1424	cambio_decision	148	Nonfiction	Disrupted: My Misadventure in the Start-Up Bubble	15.28	5	In stock	f
1425	cambio_decision	135	Nonfiction	Brave Enough	51.32	5	In stock	f
1426	cambio_decision	133	Nonfiction	Born to Run: A Hidden Tribe, Superathletes, and the Greatest Race the World Has Never Seen	27.35	2	In stock	f
1427	cambio_decision	132	Nonfiction	Blink: The Power of Thinking Without Thinking	21.74	5	In stock	f
1494	cambio_decision	713	Default	Luckiest Girl Alive	49.83	3	In stock	f
1428	cambio_decision	131	Nonfiction	Black Flags: The Rise of ISIS	40.87	1	In stock	f
1429	cambio_decision	121	Nonfiction	Are We Smart Enough to Know How Smart Animals Are?	56.58	1	In stock	f
1430	cambio_decision	118	Nonfiction	A Walk in the Woods: Rediscovering America on the Appalachian Trail	30.48	4	In stock	f
1431	cambio_decision	112	Nonfiction	The Suffragettes (Little Black Classics, #96)	11.89	2	In stock	f
1432	cambio_decision	103	Nonfiction	Kindle Paperwhite User's Guide	34.00	3	In stock	f
1433	cambio_decision	102	Nonfiction	H is for Hawk	57.42	5	In stock	f
1434	cambio_decision	90	Nonfiction	Travels with Charley: In Search of America	57.82	5	In stock	f
1435	cambio_decision	85	Nonfiction	The Tumor	41.56	5	In stock	f
1436	cambio_decision	64	Nonfiction	The End of the Jesus Era (An Investigation #1)	14.40	1	In stock	f
1437	cambio_decision	16	Nonfiction	Eat, Pray, Love	51.32	3	In stock	f
1438	cambio_decision	986	Music	Rip it Up and Start Again	35.02	5	In stock	f
1439	cambio_decision	985	Music	Our Band Could Be Your Life: Scenes from the American Indie Underground, 1981-1991	57.25	3	In stock	f
1440	cambio_decision	979	Music	How Music Works	37.32	2	In stock	f
1441	cambio_decision	711	Music	Love Is a Mix Tape (Music #1)	18.03	1	In stock	f
1442	cambio_decision	537	Music	Please Kill Me: The Uncensored Oral History of Punk	31.19	4	In stock	f
1443	cambio_decision	528	Music	Kill 'Em and Leave: Searching for James Brown and the American Soul	45.05	5	In stock	f
1444	cambio_decision	462	Music	Chronicles, Vol. 1	52.60	2	In stock	f
1445	cambio_decision	414	Music	This Is Your Brain on Music: The Science of a Human Obsession	38.40	1	In stock	f
1446	cambio_decision	337	Music	Orchestra of Exiles: The Story of Bronislaw Huberman, the Israel Philharmonic, and the One Thousand Jews He Saved from Nazi Horrors	12.36	3	In stock	f
1447	cambio_decision	336	Music	No One Here Gets Out Alive	20.02	5	In stock	f
1448	cambio_decision	104	Music	Life	31.58	5	In stock	f
1449	cambio_decision	39	Music	Old Records Never Die: One Man's Quest for His Vinyl and His Past	55.66	2	In stock	f
1450	cambio_decision	19	Music	Forever Rockers (The Rocker #12)	28.80	3	In stock	f
1451	cambio_decision	993	Default	The Coming Woman: A Novel Based on the Life of the Infamous Feminist, Victoria Woodhull	17.93	3	In stock	f
1452	cambio_decision	992	Default	The Boys in the Boat: Nine Americans and Their Epic Quest for Gold at the 1936 Berlin Olympics	22.60	4	In stock	f
1453	cambio_decision	990	Default	Starving Hearts (Triangular Trade Trilogy, #1)	13.99	2	In stock	f
1454	cambio_decision	974	Default	America's Cradle of Quarterbacks: Western Pennsylvania's Football Factory from Johnny Unitas to Joe Montana	22.50	3	In stock	f
1455	cambio_decision	973	Default	Aladdin and His Wonderful Lamp	53.13	3	In stock	f
1456	cambio_decision	965	Default	Penny Maybe	33.29	3	In stock	f
1457	cambio_decision	964	Default	Maude (1883-1993):She Grew Up with the country	18.02	2	In stock	f
1458	cambio_decision	935	Default	The Inefficiency Assassin: Time Management Tactics for Working Smarter, Not Longer	20.59	5	In stock	f
1459	cambio_decision	926	Default	Soul Reader	39.58	2	In stock	f
1460	cambio_decision	883	Default	Bossypants	49.46	2	In stock	f
1461	cambio_decision	879	Default	A World of Flavor: Your Gluten Free Passport	42.95	1	In stock	f
1462	cambio_decision	878	Default	A Piece of Sky, a Grain of Rice: A Memoir in Four Meditations	56.76	5	In stock	f
1463	cambio_decision	869	Default	Tracing Numbers on a Train	41.60	3	In stock	f
1464	cambio_decision	866	Default	Thirteen Reasons Why	52.72	1	In stock	f
1465	cambio_decision	859	Default	The Secret (The Secret #1)	27.37	4	In stock	f
1466	cambio_decision	857	Default	The Psychopath Test: A Journey Through the Madness Industry	36.00	2	In stock	f
1467	cambio_decision	847	Default	The Kite Runner	41.82	4	In stock	f
1468	cambio_decision	844	Default	The Girl on the Train	55.02	2	In stock	f
1469	cambio_decision	842	Default	The Emerald Mystery	23.15	2	In stock	f
1470	cambio_decision	840	Default	The Bridge to Consciousness: I'm Writing the Bridge Between Science and Our Old and New Beliefs.	32.00	3	In stock	f
1471	cambio_decision	838	Default	The Art of War	33.34	5	In stock	f
1472	cambio_decision	829	Default	Secrets and Lace (Fatal Hearts #1)	20.27	1	In stock	f
1473	cambio_decision	827	Default	Romero and Juliet: A Tragic Tale of Love and Zombies	36.94	1	In stock	f
1474	cambio_decision	825	Default	Poses for Artists Volume 1 - Dynamic and Sitting Poses: An Essential Reference for Figure Drawing and the Human Form	41.06	1	In stock	f
1475	cambio_decision	819	Default	Miss Peregrine’s Home for Peculiar Children (Miss Peregrine’s Peculiar Children #1)	10.76	1	In stock	f
1476	cambio_decision	815	Default	Large Print Heart of the Pride	19.15	2	In stock	f
1477	cambio_decision	812	Default	Grumbles	22.16	2	In stock	f
1478	cambio_decision	808	Default	First Steps for New Christians (Print Edition)	29.00	1	In stock	f
1479	cambio_decision	805	Default	Eureka Trivia 6.0	54.59	4	In stock	f
1480	cambio_decision	804	Default	Drive: The Surprising Truth About What Motivates Us	34.95	4	In stock	f
1481	cambio_decision	803	Default	Done Rubbed Out (Reightman & Bailey #1)	37.72	5	In stock	f
1482	cambio_decision	794	Default	Beauty Restored (Riley Family Legacy Novellas #3)	11.11	2	In stock	f
1483	cambio_decision	791	Default	Ayumi's Violin	15.48	2	In stock	f
1484	cambio_decision	790	Default	Anonymous	46.82	4	In stock	f
1485	cambio_decision	789	Default	Amy Meets the Saints and Sages	18.46	3	In stock	f
1486	cambio_decision	787	Default	Amatus	50.54	5	In stock	f
1487	cambio_decision	776	Default	V for Vendetta (V for Vendetta Complete)	37.10	4	In stock	f
1488	cambio_decision	774	Default	Unbroken: A World War II Story of Survival, Resilience, and Redemption	45.95	2	In stock	f
1489	cambio_decision	769	Default	The Wright Brothers	56.80	4	In stock	f
1490	cambio_decision	763	Default	The Songs of the Gods	44.48	5	In stock	f
1491	cambio_decision	761	Default	The Rosie Project (Don Tillman #1)	54.04	1	In stock	f
1492	cambio_decision	760	Default	The Power of Habit: Why We Do What We Do in Life and Business	16.88	3	In stock	f
1495	cambio_decision	709	Default	Living Leadership by Insight: A Good Leader Achieves, a Great Leader Builds Monuments	46.91	4	In stock	f
1496	cambio_decision	707	Default	Lady Midnight (The Dark Artifices #1)	16.28	5	In stock	f
1497	cambio_decision	701	Default	Hush, Hush (Hush, Hush #1)	47.02	3	In stock	f
1498	cambio_decision	698	Default	Greek Mythic History	10.23	5	In stock	f
1499	cambio_decision	693	Default	Every Last Word	46.47	3	In stock	f
1500	cambio_decision	683	Default	Daily Fantasy Sports	36.58	1	In stock	f
1501	cambio_decision	679	Default	Clockwork Angel (The Infernal Devices #1)	44.14	1	In stock	f
1502	cambio_decision	677	Default	City of Fallen Angels (The Mortal Instruments #4)	11.23	4	In stock	f
1503	cambio_decision	676	Default	City of Bones (The Mortal Instruments #1)	43.28	1	In stock	f
1504	cambio_decision	675	Default	City of Ashes (The Mortal Instruments #2)	47.27	1	In stock	f
1505	cambio_decision	672	Default	Carry On, Warrior: Thoughts on Life Unarmed	31.85	3	In stock	f
1506	cambio_decision	671	Default	Carrie	46.23	2	In stock	f
1507	cambio_decision	661	Default	Angels & Demons (Robert Langdon #1)	51.48	3	In stock	f
1508	cambio_decision	649	Default	The Three Searches, Meaning, and the Story	13.33	3	In stock	f
1509	cambio_decision	630	Default	Raspberry Pi Electronics Projects for the Evil Genius	49.67	4	In stock	f
1510	cambio_decision	621	Default	How to Speak Golf: An Illustrated Guide to Links Lingo	58.32	5	In stock	f
1511	cambio_decision	616	Default	Eleanor & Park	56.51	5	In stock	f
1512	cambio_decision	610	Default	Troublemaker: Surviving Hollywood and Scientology	48.39	2	In stock	f
1513	cambio_decision	586	Default	Adultery	20.88	5	In stock	f
1514	cambio_decision	578	Default	Unlimited Intuition Now	58.87	4	In stock	f
1515	cambio_decision	577	Default	Underlying Notes	11.82	2	In stock	f
1516	cambio_decision	575	Default	The New Brand You: Your New Image Makes the Sale for You	44.05	5	In stock	f
1517	cambio_decision	573	Default	The Flowers Lied	16.68	2	In stock	f
1518	cambio_decision	566	Default	NaNo What Now? Finding your editing process, revising your NaNoWriMo book and building a writing career through publishing and beyond	10.41	4	In stock	f
1519	cambio_decision	565	Default	Modern Day Fables	47.44	2	In stock	f
1520	cambio_decision	551	Default	The Unlikely Pilgrimage of Harold Fry (Harold Fry #1)	43.62	5	In stock	f
1521	cambio_decision	548	Default	The Martian (The Martian #1)	41.39	2	In stock	f
1522	cambio_decision	529	Default	Left Behind (Left Behind #1)	40.72	2	In stock	f
1523	cambio_decision	526	Default	John Vassos: Industrial Design for Modern Life	20.22	4	In stock	f
1524	cambio_decision	525	Default	I'll Give You the Sun	56.48	1	In stock	f
1525	cambio_decision	520	Default	Heaven is for Real: A Little Boy's Astounding Story of His Trip to Heaven and Back	52.86	2	In stock	f
1526	cambio_decision	518	Default	Ender's Game (The Ender Quintet #1)	43.64	1	In stock	f
1527	cambio_decision	516	Default	Death by Leisure: A Cautionary Tale	37.51	4	In stock	f
1528	cambio_decision	507	Default	Wildlife of New York: A Five-Borough Coloring Book	22.14	2	In stock	f
1529	cambio_decision	502	Default	The Year of Living Biblically: One Man's Humble Quest to Follow the Bible as Literally as Possible	34.72	1	In stock	f
1530	cambio_decision	498	Default	The Great Gatsby	36.05	4	In stock	f
1531	cambio_decision	497	Default	The Good Girl	49.03	3	In stock	f
1532	cambio_decision	489	Default	The 7 Habits of Highly Effective People: Powerful Lessons in Personal Change	33.17	4	In stock	f
1533	cambio_decision	487	Default	Steal Like an Artist: 10 Things Nobody Told You About Being Creative	20.90	2	In stock	f
1534	cambio_decision	475	Default	Life of Pi	13.22	4	In stock	f
1535	cambio_decision	455	Default	The Sound Of Love	57.84	5	In stock	f
1536	cambio_decision	453	Default	The Perks of Being a Wallflower	55.02	3	In stock	f
1537	cambio_decision	450	Default	The Makings of a Fatherless Child	31.58	2	In stock	f
1538	cambio_decision	447	Default	The Hobbit (Middle-Earth Universe)	17.80	5	In stock	f
1539	cambio_decision	442	Default	The Fellowship of the Ring (The Lord of the Rings #1)	10.27	2	In stock	f
1540	cambio_decision	438	Default	Ship Leaves Harbor: Essays on Travel by a Recovering Journeyman	30.60	3	In stock	f
1541	cambio_decision	436	Default	Musicophilia: Tales of Music and the Brain	46.58	1	In stock	f
1542	cambio_decision	416	Default	What If?: Serious Scientific Answers to Absurd Hypothetical Questions	53.68	4	In stock	f
1543	cambio_decision	403	Default	The Fault in Our Stars	47.22	1	In stock	f
1544	cambio_decision	400	Default	The Dream Thieves (The Raven Cycle #2)	34.50	1	In stock	f
1545	cambio_decision	397	Default	The 5th Wave (The 5th Wave #1)	11.83	2	In stock	f
1546	cambio_decision	392	Default	Shiver (The Wolves of Mercy Falls #1)	16.23	5	In stock	f
1547	cambio_decision	391	Default	Remember Me?	11.48	3	In stock	f
1548	cambio_decision	379	Default	If I Stay (If I Stay #1)	38.13	5	In stock	f
1549	cambio_decision	378	Default	I Know Why the Caged Bird Sings (Maya Angelou's Autobiography #1)	36.55	2	In stock	f
1550	cambio_decision	377	Default	Harry Potter and the Deathly Hallows (Harry Potter #7)	23.32	1	In stock	f
1551	cambio_decision	374	Default	Fool Me Once	16.96	1	In stock	f
1552	cambio_decision	371	Default	Drama	38.70	2	In stock	f
1553	cambio_decision	364	Default	Blue Lily, Lily Blue (The Raven Cycle #3)	34.13	5	In stock	f
1554	cambio_decision	360	Default	Alight (The Generations Trilogy #2)	58.59	4	In stock	f
1555	cambio_decision	355	Default	Vogue Colors A to Z: A Fashion Coloring Book	52.35	4	In stock	f
1556	cambio_decision	354	Default	The Shining (The Shining #1)	27.88	3	In stock	f
1557	cambio_decision	349	Default	The Hunger Games (The Hunger Games #1)	29.85	5	In stock	f
1558	cambio_decision	338	Default	Outlander (Outlander #1)	19.67	5	In stock	f
1559	cambio_decision	333	Default	Mockingjay (The Hunger Games #3)	20.44	4	In stock	f
1560	cambio_decision	329	Default	Harry Potter and the Sorcerer's Stone (Harry Potter #1)	13.90	3	In stock	f
1829	cambio_decision	398	Poetry	The Crossover	38.77	4	In stock	f
1561	cambio_decision	318	Default	Confessions of a Shopaholic (Shopaholic #1)	48.94	2	In stock	f
1562	cambio_decision	308	Default	Zero History (Blue Ant #3)	34.77	1	In stock	f
1563	cambio_decision	306	Default	World War Z: An Oral History of the Zombie War	21.80	1	In stock	f
1564	cambio_decision	305	Default	Wild: From Lost to Found on the Pacific Crest Trail	46.02	3	In stock	f
1565	cambio_decision	304	Default	Where'd You Go, Bernadette	18.13	1	In stock	f
1566	cambio_decision	293	Default	Twilight (Twilight #1)	41.93	2	In stock	f
1567	cambio_decision	269	Default	The Paris Wife	36.80	3	In stock	f
1568	cambio_decision	263	Default	The Maze Runner (The Maze Runner #1)	20.93	1	In stock	f
1569	cambio_decision	262	Default	The Lover's Dictionary	58.09	2	In stock	f
1570	cambio_decision	252	Default	The Goldfinch	43.58	3	In stock	f
1571	cambio_decision	251	Default	The Giver (The Giver Quartet #1)	12.30	1	In stock	f
1572	cambio_decision	249	Default	The Girl Who Played with Fire (Millennium Trilogy #2)	22.14	2	In stock	f
1573	cambio_decision	242	Default	The Demon-Haunted World: Science as a Candle in the Dark	52.25	4	In stock	f
1574	cambio_decision	233	Default	The Book Thief	53.49	2	In stock	f
1575	cambio_decision	230	Default	The Autobiography of Malcolm X	23.43	2	In stock	f
1576	cambio_decision	221	Default	Shopaholic & Baby (Shopaholic #5)	46.45	2	In stock	f
1577	cambio_decision	208	Default	Quiet: The Power of Introverts in a World That Can't Stop Talking	43.55	1	In stock	f
1578	cambio_decision	205	Default	Packing for Mars: The Curious Science of Life in the Void	56.68	2	In stock	f
1579	cambio_decision	202	Default	Orange Is the New Black	24.61	2	In stock	f
1580	cambio_decision	201	Default	One for the Money (Stephanie Plum #1)	32.87	2	In stock	f
1581	cambio_decision	196	Default	Morning Star (Red Rising #3)	29.40	1	In stock	f
1582	cambio_decision	187	Default	Life After Life	26.13	2	In stock	f
1583	cambio_decision	183	Default	Lean In: Women, Work, and the Will to Lead	25.02	1	In stock	f
1584	cambio_decision	178	Default	Is Everyone Hanging Out Without Me? (And Other Concerns)	20.11	3	In stock	f
1585	cambio_decision	162	Default	Gone Girl	37.60	5	In stock	f
1586	cambio_decision	155	Default	Fellside	38.62	1	In stock	f
1587	cambio_decision	152	Default	Eclipse (Twilight #3)	18.74	1	In stock	f
1588	cambio_decision	150	Default	Dracula	52.62	3	In stock	f
1589	cambio_decision	147	Default	Dead Wake: The Last Crossing of the Lusitania	39.24	5	In stock	f
1590	cambio_decision	146	Default	David and Goliath: Underdogs, Misfits, and the Art of Battling Giants	17.81	1	In stock	f
1591	cambio_decision	144	Default	Dark Places	23.90	5	In stock	f
1592	cambio_decision	136	Default	Breaking Dawn (Twilight #4)	35.28	5	In stock	f
1593	cambio_decision	125	Default	Beautiful Creatures (Caster Chronicles #1)	21.55	5	In stock	f
1594	cambio_decision	117	Default	A Visit from the Goon Squad	14.08	5	In stock	f
1595	cambio_decision	87	Default	The Zombie Room	19.69	5	In stock	f
1596	cambio_decision	74	Default	The Name of the Wind (The Kingkiller Chronicle #1)	50.59	3	In stock	f
1597	cambio_decision	57	Default	Taking Shots (Assassins #1)	18.88	2	In stock	f
1598	cambio_decision	53	Default	Shatter Me (Shatter Me #1)	42.40	1	In stock	f
1599	cambio_decision	45	Default	Paradise Lost (Paradise #1)	24.96	1	In stock	f
1600	cambio_decision	40	Default	On the Road (Duluoz Legend)	32.36	3	In stock	f
1601	cambio_decision	27	Default	Jane Eyre	38.43	5	In stock	f
1602	cambio_decision	20	Default	Frankenstein	38.00	2	In stock	f
1603	cambio_decision	983	Science Fiction	Mesaerion: The Best Science Fiction Stories 1800-1849	37.59	1	In stock	f
1604	cambio_decision	902	Science Fiction	Join	35.67	5	In stock	f
1605	cambio_decision	871	Science Fiction	William Shakespeare's Star Wars: Verily, A New Hope (William Shakespeare's Star Wars #4)	43.30	4	In stock	f
1606	cambio_decision	856	Science Fiction	The Project	10.65	1	In stock	f
1607	cambio_decision	833	Science Fiction	Soft Apocalypse	26.12	2	In stock	f
1608	cambio_decision	604	Science Fiction	Sleeping Giants (Themis Files #1)	48.74	1	In stock	f
1609	cambio_decision	587	Science Fiction	Arena	21.36	4	In stock	f
1610	cambio_decision	375	Science Fiction	Foundation (Foundation (Publication Order) #1)	32.42	1	In stock	f
1611	cambio_decision	275	Science Fiction	The Restaurant at the End of the Universe (Hitchhiker's Guide to the Galaxy #2)	10.92	1	In stock	f
1612	cambio_decision	209	Science Fiction	Ready Player One	19.07	4	In stock	f
1613	cambio_decision	189	Science Fiction	Life, the Universe and Everything (Hitchhiker's Guide to the Galaxy #3)	33.26	2	In stock	f
1614	cambio_decision	151	Science Fiction	Dune (Dune #1)	54.86	1	In stock	f
1615	cambio_decision	149	Science Fiction	Do Androids Dream of Electric Sheep? (Blade Runner #1)	51.48	1	In stock	f
1616	cambio_decision	89	Science Fiction	Three Wishes (River of Time: California #1)	44.18	2	In stock	f
1617	cambio_decision	70	Science Fiction	The Last Girl (The Dominion Trilogy #1)	36.26	2	In stock	f
1618	cambio_decision	23	Science Fiction	Having the Barbarian's Baby (Ice Planet Barbarians #7.5)	34.96	4	In stock	f
1619	cambio_decision	232	Sports and Games	The Book of Basketball: The NBA According to The Sports Guy	44.84	5	In stock	f
1620	cambio_decision	158	Sports and Games	Friday Night Lights: A Town, a Team, and a Dream	51.22	3	In stock	f
1621	cambio_decision	108	Sports and Games	Sugar Rush (Offensive Line #2)	24.42	1	In stock	f
1622	cambio_decision	50	Sports and Games	Settling the Score (The Summer Games #1)	44.91	2	In stock	f
1623	cambio_decision	25	Sports and Games	Icing (Aces Hockey #2)	40.44	4	In stock	f
1624	cambio_decision	945	Add a comment	The Torch Is Passed: A Harding Family Story	19.09	1	In stock	f
1625	cambio_decision	937	Add a comment	The Mindfulness and Acceptance Workbook for Anxiety: A Guide to Breaking Free from Anxiety, Phobias, and Worry Using Acceptance and Commitment Therapy	23.89	4	In stock	f
1626	cambio_decision	930	Add a comment	The Art Forger	40.76	3	In stock	f
1627	cambio_decision	912	Add a comment	On a Midnight Clear	14.07	3	In stock	f
1628	cambio_decision	903	Add a comment	Judo: Seven Steps to Black Belt (an Introductory Guide for Beginners)	53.90	2	In stock	f
1629	cambio_decision	830	Add a comment	Shobu Samurai, Project Aryoku (#3)	29.06	3	In stock	f
1630	cambio_decision	820	Add a comment	Modern Romance	28.26	5	In stock	f
1631	cambio_decision	768	Add a comment	The White Queen (The Cousins' War #1)	25.91	5	In stock	f
1632	cambio_decision	762	Add a comment	The Song of Achilles	37.40	5	In stock	f
1633	cambio_decision	753	Add a comment	The Immortal Life of Henrietta Lacks	40.67	2	In stock	f
1634	cambio_decision	748	Add a comment	The Dovekeepers	48.78	1	In stock	f
1635	cambio_decision	716	Add a comment	More Than Music (Chasing the Dream #1)	37.61	2	In stock	f
1636	cambio_decision	680	Add a comment	Code Name Verity (Code Name Verity #1)	22.13	4	In stock	f
1637	cambio_decision	674	Add a comment	Cell	20.29	4	In stock	f
1638	cambio_decision	662	Add a comment	Angels Walking (Angels Walking #1)	34.20	2	In stock	f
1639	cambio_decision	655	Add a comment	A Series of Catastrophes and Miracles: A True Story of Love, Science, and Cancer	56.48	2	In stock	f
1640	cambio_decision	654	Add a comment	A People's History of the United States	40.79	2	In stock	f
1641	cambio_decision	651	Add a comment	A Brush of Wings (Angels Walking #3)	55.51	1	In stock	f
1642	cambio_decision	647	Add a comment	Rook	37.86	4	In stock	f
1643	cambio_decision	640	Add a comment	The Midnight Watch: A Novel of the Titanic and the Californian	26.20	1	In stock	f
1644	cambio_decision	638	Add a comment	The Gray Rhino: How to Recognize and Act on the Obvious Dangers We Ignore	59.15	4	In stock	f
1645	cambio_decision	633	Add a comment	The Children	11.88	3	In stock	f
1646	cambio_decision	626	Add a comment	One with You (Crossfire #5)	15.71	4	In stock	f
1647	cambio_decision	580	Add a comment	Without Shame	48.27	5	In stock	f
1648	cambio_decision	579	Add a comment	Watchmen	58.05	4	In stock	f
1649	cambio_decision	557	Add a comment	A Hero's Curse (The Unseen Chronicles #1)	50.49	3	In stock	f
1650	cambio_decision	556	Add a comment	23 Degrees South: A Tropical Tale of Changing Whether...	35.79	2	In stock	f
1651	cambio_decision	496	Add a comment	The Glass Castle	16.24	1	In stock	f
1652	cambio_decision	494	Add a comment	The Drowning Girls	35.67	3	In stock	f
1653	cambio_decision	488	Add a comment	Team of Rivals: The Political Genius of Abraham Lincoln	20.12	5	In stock	f
1654	cambio_decision	472	Add a comment	John Adams	57.43	4	In stock	f
1655	cambio_decision	469	Add a comment	Good in Bed (Cannie Shapiro #1)	37.05	5	In stock	f
1656	cambio_decision	449	Add a comment	The Joy of Cooking	43.27	4	In stock	f
1657	cambio_decision	445	Add a comment	The Golden Compass (His Dark Materials #1)	18.77	1	In stock	f
1658	cambio_decision	444	Add a comment	The God Delusion	46.85	3	In stock	f
1659	cambio_decision	437	Add a comment	Pride and Prejudice	19.27	4	In stock	f
1660	cambio_decision	435	Add a comment	Mere Christianity	48.51	3	In stock	f
1661	cambio_decision	428	Add a comment	Fun Home: A Family Tragicomic	56.59	4	In stock	f
1662	cambio_decision	412	Add a comment	The Raven King (The Raven Cycle #4)	30.57	2	In stock	f
1663	cambio_decision	373	Add a comment	Find Her (Detective D.D. Warren #8)	22.37	1	In stock	f
1664	cambio_decision	372	Add a comment	Evicted: Poverty and Profit in the American City	42.27	1	In stock	f
1665	cambio_decision	358	Add a comment	A Game of Thrones (A Song of Ice and Fire #1)	46.42	2	In stock	f
1666	cambio_decision	356	Add a comment	A Clash of Kings (A Song of Ice and Fire #2)	10.79	3	In stock	f
1667	cambio_decision	284	Add a comment	The Tipping Point: How Little Things Can Make a Big Difference	10.02	2	In stock	f
1668	cambio_decision	274	Add a comment	The Rest Is Noise: Listening to the Twentieth Century	34.77	1	In stock	f
1669	cambio_decision	272	Add a comment	The Purpose Driven Life: What on Earth Am I Here for?	37.19	3	In stock	f
1670	cambio_decision	255	Add a comment	The Hitchhiker's Guide to the Galaxy (Hitchhiker's Guide to the Galaxy #1)	47.80	3	In stock	f
1671	cambio_decision	248	Add a comment	The Girl Who Kicked the Hornet's Nest (Millennium Trilogy #3)	57.48	1	In stock	f
1672	cambio_decision	246	Add a comment	The End of Faith: Religion, Terror, and the Future of Reason	22.13	4	In stock	f
1673	cambio_decision	237	Add a comment	The Complete Poems	41.32	5	In stock	f
1674	cambio_decision	236	Add a comment	The Catcher in the Rye	24.55	1	In stock	f
1675	cambio_decision	234	Add a comment	The Case for Christ (Cases for Christianity)	47.84	1	In stock	f
1676	cambio_decision	231	Add a comment	The Blind Side: Evolution of a Game	53.71	5	In stock	f
1677	cambio_decision	220	Add a comment	Seven Days in the Art World	52.33	2	In stock	f
1678	cambio_decision	217	Add a comment	Sarah's Key	46.29	1	In stock	f
1679	cambio_decision	214	Add a comment	Rogue Lawyer (Rogue Lawyer #1)	50.11	3	In stock	f
1680	cambio_decision	192	Add a comment	Manuscript Found in Accra	34.98	2	In stock	f
1681	cambio_decision	157	Add a comment	Fire Bound (Sea Haven/Sisters of the Heart #5)	21.28	4	In stock	f
1682	cambio_decision	141	Add a comment	Cosmos	36.17	2	In stock	f
1683	cambio_decision	113	Add a comment	#GIRLBOSS	50.96	1	In stock	f
1684	cambio_decision	111	Add a comment	The Sense of an Ending	31.38	3	In stock	f
1685	cambio_decision	78	Add a comment	The Republic	33.78	3	In stock	f
1686	cambio_decision	77	Add a comment	The Odyssey	29.64	3	In stock	f
1687	cambio_decision	71	Add a comment	The Light of the Fireflies	54.43	1	In stock	f
1688	cambio_decision	69	Add a comment	The Iliad	16.16	1	In stock	f
1689	cambio_decision	61	Add a comment	The Communist Manifesto	14.76	3	In stock	f
1690	cambio_decision	30	Add a comment	Lord of the Flies	24.89	3	In stock	f
1691	cambio_decision	951	Fantasy	Unicorn Tracks	18.78	3	In stock	f
1692	cambio_decision	924	Fantasy	Saga, Volume 6 (Saga (Collected Editions) #6)	25.02	3	In stock	f
1693	cambio_decision	919	Fantasy	Princess Between Worlds (Wide-Awake Princess #5)	13.34	5	In stock	f
1694	cambio_decision	909	Fantasy	Masks and Shadows	56.40	2	In stock	f
1695	cambio_decision	888	Fantasy	Crown of Midnight (Throne of Glass #2)	43.29	3	In stock	f
1696	cambio_decision	881	Fantasy	Avatar: The Last Airbender: Smoke and Shadow, Part 3 (Smoke and Shadow #3)	28.09	2	In stock	f
1697	cambio_decision	874	Fantasy	A Court of Thorns and Roses (A Court of Thorns and Roses #1)	52.37	1	In stock	f
1698	cambio_decision	868	Fantasy	Throne of Glass (Throne of Glass #1)	35.07	3	In stock	f
1699	cambio_decision	845	Fantasy	The Glittering Court (The Glittering Court #1)	44.28	1	In stock	f
1700	cambio_decision	813	Fantasy	Hollow City (Miss Peregrine’s Peculiar Children #2)	42.98	1	In stock	f
1701	cambio_decision	764	Fantasy	The Star-Touched Queen	46.02	5	In stock	f
1702	cambio_decision	752	Fantasy	The Hidden Oracle (The Trials of Apollo #1)	52.26	2	In stock	f
1703	cambio_decision	746	Fantasy	The Bane Chronicles (The Bane Chronicles #1-11)	44.73	4	In stock	f
1704	cambio_decision	705	Fantasy	Island of Dragons (Unwanteds #7)	29.65	1	In stock	f
1705	cambio_decision	685	Fantasy	Demigods & Magicians: Percy and Annabeth Meet the Kanes (Percy Jackson & Kane Chronicles Crossover #1-3)	37.51	5	In stock	f
1706	cambio_decision	678	Fantasy	City of Glass (The Mortal Instruments #3)	56.02	4	In stock	f
1707	cambio_decision	648	Fantasy	Searching for Meaning in Gailana	38.73	1	In stock	f
1708	cambio_decision	642	Fantasy	The Star-Touched Queen	32.30	5	In stock	f
1709	cambio_decision	558	Fantasy	A Shard of Ice (The Black Symphony Saga #1)	56.63	3	In stock	f
1710	cambio_decision	473	Fantasy	King's Folly (The Kinsman Chronicles #1)	39.61	5	In stock	f
1711	cambio_decision	465	Fantasy	Every Heart a Doorway (Every Heart A Doorway #1)	12.16	5	In stock	f
1712	cambio_decision	456	Fantasy	A Gathering of Shadows (Shades of Magic #2)	44.81	4	In stock	f
1713	cambio_decision	411	Fantasy	The Raven Boys (The Raven Cycle #1)	57.74	4	In stock	f
1714	cambio_decision	402	Fantasy	The False Prince (The Ascendance Trilogy #1)	56.00	5	In stock	f
1715	cambio_decision	396	Fantasy	Tell the Wind and Fire	45.51	3	In stock	f
1716	cambio_decision	357	Fantasy	A Feast for Crows (A Song of Ice and Fire #4)	17.21	4	In stock	f
1717	cambio_decision	345	Fantasy	The Demonists (Demonist #1)	52.11	2	In stock	f
1718	cambio_decision	342	Fantasy	The Beast (Black Dagger Brotherhood #14)	46.08	5	In stock	f
1719	cambio_decision	339	Fantasy	Paper and Fire (The Great Library #2)	49.45	5	In stock	f
1720	cambio_decision	327	Fantasy	Harry Potter and the Order of the Phoenix (Harry Potter #5)	31.63	4	In stock	f
1721	cambio_decision	326	Fantasy	Harry Potter and the Half-Blood Prince (Harry Potter #6)	48.75	5	In stock	f
1722	cambio_decision	325	Fantasy	Harry Potter and the Chamber of Secrets (Harry Potter #2)	14.74	1	In stock	f
1723	cambio_decision	278	Fantasy	The Rose & the Dagger (The Wrath and the Dawn #2)	58.64	4	In stock	f
1724	cambio_decision	222	Fantasy	Soldier (Talon #3)	24.72	2	In stock	f
1725	cambio_decision	194	Fantasy	Midnight Riot (Peter Grant/ Rivers of London - books #1)	55.46	2	In stock	f
1726	cambio_decision	166	Fantasy	Heir to the Sky	44.07	4	In stock	f
1727	cambio_decision	153	Fantasy	Eragon (The Inheritance Cycle #1)	43.87	3	In stock	f
1728	cambio_decision	145	Fantasy	Darkfever (Fever #1)	56.02	1	In stock	f
1729	cambio_decision	123	Fantasy	Ash	22.06	4	In stock	f
1730	cambio_decision	116	Fantasy	A Storm of Swords (A Song of Ice and Fire #3)	31.22	2	In stock	f
1731	cambio_decision	92	Fantasy	Vampire Girl (Vampire Girl #1)	53.82	2	In stock	f
1732	cambio_decision	82	Fantasy	The Silent Twin (Detective Jennifer Knight #3)	36.25	3	In stock	f
1733	cambio_decision	73	Fantasy	The Mirror & the Maze (The Wrath and the Dawn #1.5)	29.38	1	In stock	f
1734	cambio_decision	54	Fantasy	Sister Sable (The Mad Queen #1)	13.33	3	In stock	f
1735	cambio_decision	51	Fantasy	Shadow Rites (Jane Yellowrock #10)	21.72	4	In stock	f
1736	cambio_decision	42	Fantasy	Origins (Alphas 0.5)	28.99	1	In stock	f
1737	cambio_decision	41	Fantasy	One Second (Seven #7)	52.94	2	In stock	f
1738	cambio_decision	36	Fantasy	Myriad (Prentor #1)	58.75	4	In stock	f
1739	cambio_decision	956	New Adult	Without Borders (Wanderlove #1)	45.07	2	In stock	f
1740	cambio_decision	851	New Adult	The Mistake (Off-Campus #2)	43.29	3	In stock	f
1741	cambio_decision	850	New Adult	The Matchmaker's Playbook (Wingmen Inc. #1)	55.85	1	In stock	f
1742	cambio_decision	68	New Adult	The Hook Up (Game On #1)	36.29	5	In stock	f
1743	cambio_decision	52	New Adult	Shameless	58.35	3	In stock	f
1744	cambio_decision	38	New Adult	Off Sides (Off #1)	39.45	5	In stock	f
1745	cambio_decision	995	Young Adult	The Requiem Red	22.65	1	In stock	f
1746	cambio_decision	988	Young Adult	Set Me Free	17.46	5	In stock	f
1747	cambio_decision	941	Young Adult	The Natural History of Us (The Fine Art of Pretending #2)	45.22	3	In stock	f
1748	cambio_decision	911	Young Adult	Obsidian (Lux #1)	14.86	2	In stock	f
1749	cambio_decision	884	Young Adult	Burning	28.81	3	In stock	f
1750	cambio_decision	875	Young Adult	A Fierce and Subtle Poison	28.13	4	In stock	f
1751	cambio_decision	828	Young Adult	Scarlett Epstein Hates It Here	43.55	5	In stock	f
1752	cambio_decision	823	Young Adult	Nightingale, Sing	38.28	1	In stock	f
1753	cambio_decision	816	Young Adult	Library of Souls (Miss Peregrine’s Peculiar Children #3)	48.56	5	In stock	f
1754	cambio_decision	810	Young Adult	Frostbite (Vampire Academy #2)	29.99	5	In stock	f
1755	cambio_decision	782	Young Adult	Wild Swans	14.36	2	In stock	f
1756	cambio_decision	775	Young Adult	Until Friday Night (The Field Party #1)	46.31	2	In stock	f
1757	cambio_decision	771	Young Adult	This Is Where It Ends	27.12	2	In stock	f
1758	cambio_decision	747	Young Adult	The Darkest Lie	35.35	5	In stock	f
1759	cambio_decision	718	Young Adult	My Kind of Crazy	40.36	1	In stock	f
1760	cambio_decision	687	Young Adult	Don't Get Caught	55.35	1	In stock	f
1761	cambio_decision	673	Young Adult	Catching Jordan (Hundred Oaks)	50.83	3	In stock	f
1830	cambio_decision	365	Poetry	Booked	17.49	5	In stock	f
1951	cambio_decision	212	Business	Rework	44.88	2	In stock	f
1762	cambio_decision	663	Young Adult	Aristotle and Dante Discover the Secrets of the Universe (Aristotle and Dante Discover the Secrets of the Universe #1)	58.14	4	In stock	f
1763	cambio_decision	636	Young Adult	The Epidemic (The Program 0.6)	14.44	5	In stock	f
1764	cambio_decision	632	Young Adult	Stars Above (The Lunar Chronicles #4.5)	48.05	2	In stock	f
1765	cambio_decision	625	Young Adult	No Love Allowed (Dodge Cove #1)	54.65	4	In stock	f
1766	cambio_decision	591	Young Adult	Exit, Pursued by a Bear	51.34	4	In stock	f
1767	cambio_decision	569	Young Adult	The Alien Club	54.40	1	In stock	f
1768	cambio_decision	561	Young Adult	Don't Forget Steven	33.23	1	In stock	f
1769	cambio_decision	544	Young Adult	South of Sunshine	28.93	1	In stock	f
1770	cambio_decision	535	Young Adult	My Life Next Door (My Life Next Door )	36.39	5	In stock	f
1771	cambio_decision	519	Young Adult	Future Shock (Future Shock #1)	55.65	5	In stock	f
1772	cambio_decision	480	Young Adult	Nightstruck: A Novel	50.35	4	In stock	f
1773	cambio_decision	439	Young Adult	Tell the Wolves I'm Home	50.96	2	In stock	f
1774	cambio_decision	419	Young Adult	Will Grayson, Will Grayson (Will Grayson, Will Grayson)	47.31	4	In stock	f
1775	cambio_decision	417	Young Adult	Where She Went (If I Stay #2)	41.73	4	In stock	f
1776	cambio_decision	415	Young Adult	Two Summers	14.64	1	In stock	f
1777	cambio_decision	399	Young Adult	The Darkest Corners	11.33	5	In stock	f
1778	cambio_decision	395	Young Adult	Tell Me Three Things	41.81	1	In stock	f
1779	cambio_decision	385	Young Adult	Lola and the Boy Next Door (Anna and the French Kiss #2)	23.63	4	In stock	f
1780	cambio_decision	381	Young Adult	Kill the Boy Band	15.52	5	In stock	f
1781	cambio_decision	380	Young Adult	Isla and the Happily Ever After (Anna and the French Kiss #3)	48.13	5	In stock	f
1782	cambio_decision	362	Young Adult	An Abundance of Katherines	10.00	5	In stock	f
1783	cambio_decision	328	Young Adult	Harry Potter and the Prisoner of Azkaban (Harry Potter #3)	24.17	4	In stock	f
1784	cambio_decision	300	Young Adult	Walk the Edge (Thunder Road #2)	32.36	3	In stock	f
1785	cambio_decision	294	Young Adult	Two Boys Kissing	32.74	2	In stock	f
1786	cambio_decision	266	Young Adult	The New Guy (and Other Senior Year Distractions)	44.92	3	In stock	f
1787	cambio_decision	258	Young Adult	The Land of 10,000 Madonnas	29.64	4	In stock	f
1788	cambio_decision	218	Young Adult	Scarlet (The Lunar Chronicles #2)	14.57	4	In stock	f
1789	cambio_decision	184	Young Adult	Legend (Legend #1)	43.69	4	In stock	f
1790	cambio_decision	181	Young Adult	Lady Renegades (Rebel Belle #3)	53.04	5	In stock	f
1791	cambio_decision	161	Young Adult	Golden (Heart of Dread #3)	42.21	4	In stock	f
1792	cambio_decision	139	Young Adult	Cinder (The Lunar Chronicles #1)	26.09	1	In stock	f
1793	cambio_decision	134	Young Adult	Boy Meets Boy	21.12	3	In stock	f
1794	cambio_decision	120	Young Adult	Annie on My Mind	36.83	5	In stock	f
1795	cambio_decision	105	Young Adult	New Moon (Twilight #2)	12.86	4	In stock	f
1796	cambio_decision	101	Young Adult	Girl Online On Tour (Girl Online #2)	53.47	1	In stock	f
1797	cambio_decision	67	Young Adult	The Haters	27.89	5	In stock	f
1798	cambio_decision	58	Young Adult	The Art of Not Breathing	40.83	4	In stock	f
1799	cambio_decision	938	Science	The Most Perfect Thing: Inside (and Outside) a Bird's Egg	42.96	4	In stock	f
1800	cambio_decision	900	Science	Immunity: How Elie Metchnikoff Changed the Course of Modern Medicine	57.36	5	In stock	f
1801	cambio_decision	736	Science	Sorting the Beef from the Bull: The Science of Food Fraud Forensics	44.74	4	In stock	f
1802	cambio_decision	643	Science	Tipping Point for Planet Earth: How Close Are We to the Edge?	37.55	1	In stock	f
1803	cambio_decision	572	Science	The Fabric of the Cosmos: Space, Time, and the Texture of Reality	55.91	1	In stock	f
1804	cambio_decision	517	Science	Diary of a Citizen Scientist: Chasing Tiger Beetles and Other New Ways of Engaging the World	28.41	1	In stock	f
1805	cambio_decision	499	Science	The Origin of Species	10.01	4	In stock	f
1806	cambio_decision	405	Science	The Grand Design	13.76	3	In stock	f
1807	cambio_decision	389	Science	Peak: Secrets from the New Science of Expertise	16.28	2	In stock	f
1808	cambio_decision	245	Science	The Elegant Universe: Superstrings, Hidden Dimensions, and the Quest for the Ultimate Theory	13.03	4	In stock	f
1809	cambio_decision	244	Science	The Disappearing Spoon: And Other True Tales of Madness, Love, and the History of the World from the Periodic Table of the Elements	57.35	5	In stock	f
1810	cambio_decision	227	Science	Surely You're Joking, Mr. Feynman!: Adventures of a Curious Character	25.83	2	In stock	f
1811	cambio_decision	219	Science	Seven Brief Lessons on Physics	30.60	4	In stock	f
1812	cambio_decision	81	Science	The Selfish Gene	29.45	1	In stock	f
1813	cambio_decision	1000	Poetry	A Light in the Attic	51.77	3	In stock	f
1814	cambio_decision	991	Poetry	The Black Maria	52.15	1	In stock	f
1815	cambio_decision	989	Poetry	Shakespeare's Sonnets	20.66	4	In stock	f
1816	cambio_decision	984	Poetry	Olio	23.88	1	In stock	f
1817	cambio_decision	961	Poetry	You can't bury them all: Poems	33.63	2	In stock	f
1818	cambio_decision	960	Poetry	Slow States of Collapse: Poems	57.31	3	In stock	f
1819	cambio_decision	953	Poetry	Untitled Collection: Sabbath Poems 2014	14.27	4	In stock	f
1820	cambio_decision	824	Poetry	Poems That Make Grown Women Cry	14.19	4	In stock	f
1821	cambio_decision	822	Poetry	Night Sky with Exit Wounds	41.05	1	In stock	f
1822	cambio_decision	731	Poetry	salt.	46.78	4	In stock	f
1823	cambio_decision	727	Poetry	Quarter Life Poetry: Poems for the Young, Broke and Hangry	50.89	5	In stock	f
1824	cambio_decision	536	Poetry	Out of Print: City Lights Spotlight No. 14	53.64	5	In stock	f
1825	cambio_decision	530	Poetry	Les Fleurs du Mal	29.04	5	In stock	f
1826	cambio_decision	522	Poetry	Howl and Other Poems	40.45	2	In stock	f
1827	cambio_decision	474	Poetry	Leave This Song Behind: Teen Poetry at Its Best	51.17	5	In stock	f
1828	cambio_decision	441	Poetry	The Collected Poems of W.B. Yeats (The Collected Works of W.B. Yeats #1)	15.42	5	In stock	f
1831	cambio_decision	91	Poetry	Twenty Love Poems and a Song of Despair	30.95	4	In stock	f
1832	cambio_decision	93	Paranormal	Vampire Knight, Vol. 1 (Vampire Knight #1)	15.40	1	In stock	f
1833	cambio_decision	971	Art	Wall and Piece	44.18	4	In stock	f
1834	cambio_decision	695	Art	Feathers: Displays of Brilliant Plumage	49.05	3	In stock	f
1835	cambio_decision	559	Art	Art and Fear: Observations on the Perils (and Rewards) of Artmaking	48.63	4	In stock	f
1836	cambio_decision	550	Art	The New Drawing on the Right Side of the Brain	43.02	3	In stock	f
1837	cambio_decision	521	Art	History of Beauty	10.29	4	In stock	f
1838	cambio_decision	500	Art	The Story of Art	41.14	4	In stock	f
1839	cambio_decision	490	Art	The Art Book	32.34	2	In stock	f
1840	cambio_decision	94	Art	Ways of Seeing	39.51	5	In stock	f
1841	cambio_decision	758	Psychology	The Lucifer Effect: Understanding How Good People Turn Evil	10.40	1	In stock	f
1842	cambio_decision	637	Psychology	The Golden Condom: And Other Essays on Love Lost and Found	39.43	1	In stock	f
1843	cambio_decision	593	Psychology	It Didn't Start with You: How Inherited Family Trauma Shapes Who We Are and How to End the Cycle	56.27	3	In stock	f
1844	cambio_decision	422	Psychology	An Unquiet Mind: A Memoir of Moods and Madness	21.30	3	In stock	f
1845	cambio_decision	289	Psychology	Thinking, Fast and Slow	21.14	1	In stock	f
1846	cambio_decision	140	Psychology	Civilization and Its Discontents	59.95	2	In stock	f
1847	cambio_decision	114	Psychology	8 Keys to Mental Health Through Exercise	31.04	1	In stock	f
1848	cambio_decision	837	Autobiography	The Argonauts	10.93	2	In stock	f
1849	cambio_decision	598	Autobiography	M Train	27.18	1	In stock	f
1850	cambio_decision	595	Autobiography	Lab Girl	40.85	1	In stock	f
1851	cambio_decision	363	Autobiography	Approval Junkie: Adventures in Caring Too Much	58.81	5	In stock	f
1852	cambio_decision	215	Autobiography	Running with Scissors	12.91	4	In stock	f
1853	cambio_decision	193	Autobiography	Me Talk Pretty One Day	57.60	2	In stock	f
1854	cambio_decision	191	Autobiography	Lust & Wonder	11.87	2	In stock	f
1855	cambio_decision	188	Autobiography	Life Without a Recipe	59.04	5	In stock	f
1856	cambio_decision	115	Autobiography	A Heartbreaking Work of Staggering Genius	54.29	5	In stock	f
1857	cambio_decision	138	Parenting	Catastrophic Happiness: Finding Joy in Childhood's Messy Years	37.35	2	In stock	f
1858	cambio_decision	156	Adult Fiction	Fifty Shades Freed (Fifty Shades #3)	15.36	5	In stock	f
1859	cambio_decision	757	Humor	The Long Haul (Diary of a Wimpy Kid #9)	44.07	1	In stock	f
1860	cambio_decision	723	Humor	Old School (Diary of a Wimpy Kid #10)	11.83	5	In stock	f
1861	cambio_decision	704	Humor	I Know What I'm Doing -- and Other Lies I Tell Myself: Dispatches from a Life Under Construction	25.98	4	In stock	f
1862	cambio_decision	702	Humor	Hyperbole and a Half: Unfortunate Situations, Flawed Coping Mechanisms, Mayhem, and Other Things That Happened	14.75	5	In stock	f
1863	cambio_decision	562	Humor	Dress Your Family in Corduroy and Denim	43.68	3	In stock	f
1864	cambio_decision	503	Humor	Toddlers Are A**holes: It's Not Your Fault	25.55	1	In stock	f
1865	cambio_decision	303	Humor	When You Are Engulfed in Flames	30.89	5	In stock	f
1866	cambio_decision	197	Humor	Naked	31.69	3	In stock	f
1867	cambio_decision	182	Humor	Lamb: The Gospel According to Biff, Christ's Childhood Pal	55.50	5	In stock	f
1868	cambio_decision	167	Humor	Holidays on Ice	51.07	2	In stock	f
1869	cambio_decision	925	Horror	Security	39.25	2	In stock	f
1870	cambio_decision	809	Horror	Follow You Home	21.36	1	In stock	f
1871	cambio_decision	756	Horror	The Loney	23.40	1	In stock	f
1872	cambio_decision	726	Horror	Pet Sematary	10.56	3	In stock	f
1873	cambio_decision	686	Horror	Doctor Sleep (The Shining #2)	40.12	2	In stock	f
1874	cambio_decision	628	Horror	Psycho: Sanitarium (Psycho #1.5)	36.97	5	In stock	f
1875	cambio_decision	614	Horror	Can You Keep a Secret? (Fear Street Relaunch #4)	48.64	1	In stock	f
1876	cambio_decision	390	Horror	Red Dragon (Hannibal Lecter #1)	23.37	3	In stock	f
1877	cambio_decision	370	Horror	Dracula the Un-Dead	35.63	5	In stock	f
1878	cambio_decision	335	Horror	Night Shift (Night Shift #1-20)	12.75	4	In stock	f
1879	cambio_decision	334	Horror	Needful Things	47.51	4	In stock	f
1880	cambio_decision	332	Horror	Misery	34.79	2	In stock	f
1881	cambio_decision	330	Horror	It	25.01	3	In stock	f
1882	cambio_decision	309	Horror	'Salem's Lot	49.56	4	In stock	f
1883	cambio_decision	282	Horror	The Stand	57.86	2	In stock	f
1884	cambio_decision	250	Horror	The Girl with All the Gifts	49.47	3	In stock	f
1885	cambio_decision	169	Horror	House of Leaves	54.89	1	In stock	f
1886	cambio_decision	996	History	Sapiens: A Brief History of Humankind	54.23	5	In stock	f
1887	cambio_decision	950	History	Unbound: How Eight Technologies Made Us Human, Transformed Society, and Brought Our World to the Brink	25.52	1	In stock	f
1888	cambio_decision	929	History	The Age of Genius: The Seventeenth Century and the Birth of the Modern Mind	19.73	1	In stock	f
1889	cambio_decision	917	History	Political Suicide: Missteps, Peccadilloes, Bad Calls, Backroom Hijinx, Sordid Pasts, Rotten Breaks, and Just Plain Dumb Mistakes in the Annals of American Politics	36.28	2	In stock	f
1890	cambio_decision	867	History	Thomas Jefferson and the Tripoli Pirates: The Forgotten War That Changed American History	59.64	1	In stock	f
1891	cambio_decision	785	History	Zealot: The Life and Times of Jesus of Nazareth	24.70	3	In stock	f
1892	cambio_decision	652	History	A Distant Mirror: The Calamitous 14th Century	14.58	3	In stock	f
1893	cambio_decision	650	History	1491: New Revelations of the Americas Before Columbus	21.80	3	In stock	f
1894	cambio_decision	515	History	Brilliant Beacons: A History of the American Lighthouse	11.45	3	In stock	f
1895	cambio_decision	509	History	"Most Blessed of the Patriarchs": Thomas Jefferson and the Empire of the Imagination	44.48	5	In stock	f
1896	cambio_decision	457	History	A Short History of Nearly Everything	52.40	5	In stock	f
1897	cambio_decision	454	History	The Rise and Fall of the Third Reich: A History of Nazi Germany	39.67	2	In stock	f
1898	cambio_decision	424	History	Catherine the Great: Portrait of a Woman	58.55	4	In stock	f
1899	cambio_decision	408	History	The Mathews Men: Seven Brothers and the War Against Hitler's U-boats	42.91	5	In stock	f
1900	cambio_decision	406	History	The Hiding Place	55.91	4	In stock	f
1901	cambio_decision	361	History	America's War for the Greater Middle East: A Military History	51.22	2	In stock	f
1902	cambio_decision	254	History	The Guns of August	14.54	3	In stock	f
1903	cambio_decision	170	History	House of Lost Worlds: Dinosaurs, Dynasties, and the Story of Life on Earth	43.70	2	In stock	f
1904	cambio_decision	978	Food and Drink	Foolproof Preserving: A Guide to Small Batch Jams, Jellies, Pickles, Condiments, and More: A Foolproof Guide to Making Small Batch Jams, Jellies, Pickles, Condiments, and More	30.52	3	In stock	f
1905	cambio_decision	943	Food and Drink	The Pioneer Woman Cooks: Dinnertime: Comfort Classics, Freezer Food, 16-Minute Meals, and Other Delicious Ways to Solve Supper!	56.41	1	In stock	f
1906	cambio_decision	910	Food and Drink	My Paris Kitchen: Recipes and Stories	33.37	2	In stock	f
1907	cambio_decision	908	Food and Drink	Mama Tried: Traditional Italian Cooking for the Screwed, Crude, Vegan, and Tattooed	14.02	4	In stock	f
1908	cambio_decision	904	Food and Drink	Layered: Baking, Building, and Styling Spectacular Cakes	40.11	1	In stock	f
1909	cambio_decision	853	Food and Drink	The Nerdy Nummies Cookbook: Sweet Treats for the Geek in All of Us	37.34	5	In stock	f
1910	cambio_decision	849	Food and Drink	The Love and Lemons Cookbook: An Apple-to-Zucchini Celebration of Impromptu Cooking	37.60	2	In stock	f
1911	cambio_decision	841	Food and Drink	The Cookies & Cups Cookbook: 125+ sweet & savory recipes reminding you to Always Eat Dessert First	41.25	1	In stock	f
1912	cambio_decision	801	Food and Drink	Deliciously Ella Every Day: Quick and Easy Recipes for Gluten-Free Snacks, Packed Lunches, and Simple Meals	42.16	3	In stock	f
1913	cambio_decision	751	Food and Drink	The Help Yourself Cookbook for Kids: 60 Easy Plant-Based Recipes Kids Can Make to Stay Healthy and Save the Earth	28.77	3	In stock	f
1914	cambio_decision	706	Food and Drink	It's All Easy: Healthy, Delicious Weeknight Meals in under 30 Minutes	19.55	1	In stock	f
1915	cambio_decision	667	Food and Drink	Barefoot Contessa Back to Basics	28.01	1	In stock	f
1916	cambio_decision	666	Food and Drink	Barefoot Contessa at Home: Everyday Recipes You'll Make Over and Over Again	50.62	5	In stock	f
1917	cambio_decision	646	Food and Drink	My Kitchen Year: 136 Recipes That Saved My Life	11.53	2	In stock	f
1918	cambio_decision	618	Food and Drink	Everyday Italian: 125 Simple and Delicious Recipes	20.10	5	In stock	f
1919	cambio_decision	611	Food and Drink	A la Mode: 120 Recipes in 60 Pairings: Pies, Tarts, Cakes, Crisps, and More Topped with Ice Cream, Gelato, Frozen Custard, and More	38.77	1	In stock	f
1920	cambio_decision	589	Food and Drink	Cravings: Recipes for What You Want to Eat	20.50	3	In stock	f
1921	cambio_decision	574	Food and Drink	The Moosewood Cookbook: Recipes from Moosewood Restaurant, Ithaca, New York	12.34	4	In stock	f
1922	cambio_decision	510	Food and Drink	32 Yolks	53.63	2	In stock	f
1923	cambio_decision	479	Food and Drink	Naturally Lean: 125 Nourishing Gluten-Free, Plant-Based Recipes--All Under 300 Calories	11.38	5	In stock	f
1924	cambio_decision	471	Food and Drink	How to Cook Everything Vegetarian: Simple Meatless Recipes for Great Food (How to Cook Everything)	46.01	4	In stock	f
1925	cambio_decision	470	Food and Drink	How to Be a Domestic Goddess: Baking and the Art of Comfort Cooking	28.25	2	In stock	f
1926	cambio_decision	440	Food and Drink	The Barefoot Contessa Cookbook	59.92	5	In stock	f
1927	cambio_decision	423	Food and Drink	Better Homes and Gardens New Cook Book	39.61	3	In stock	f
1928	cambio_decision	410	Food and Drink	The Power Greens Cookbook: 140 Delicious Superfood Recipes	11.05	5	In stock	f
1929	cambio_decision	387	Food and Drink	Mexican Today: New and Rediscovered Recipes for Contemporary Kitchens	24.91	5	In stock	f
1930	cambio_decision	297	Food and Drink	Vegan Vegetarian Omnivore: Dinner for Everyone at the Table	13.66	2	In stock	f
1931	cambio_decision	281	Food and Drink	The Smitten Kitchen Cookbook	23.59	1	In stock	f
1932	cambio_decision	229	Food and Drink	The Art of Simple Food: Notes, Lessons, and Recipes from a Delicious Revolution	34.32	3	In stock	f
1933	cambio_decision	171	Food and Drink	Hungry Girl Clean & Hungry: Easy All-Natural Recipes for Healthy Eating in the Real World	33.14	3	In stock	f
1934	cambio_decision	826	Christian Fiction	Redeeming Love	20.47	5	In stock	f
1935	cambio_decision	798	Christian Fiction	Close to You	49.46	4	In stock	f
1936	cambio_decision	541	Christian Fiction	Shadows of the Past (Logan Point #1)	39.67	5	In stock	f
1937	cambio_decision	476	Christian Fiction	Like Never Before (Walker Family #2)	28.77	2	In stock	f
1938	cambio_decision	463	Christian Fiction	Counted With the Stars (Out from Egypt #1)	17.97	5	In stock	f
1939	cambio_decision	174	Christian Fiction	If I Run (If I Run #1)	49.97	4	In stock	f
1940	cambio_decision	994	Business	The Dirty Little Secrets of Getting Your Dream Job	33.34	4	In stock	f
1941	cambio_decision	862	Business	The Third Wave: An Entrepreneur’s Vision of the Future	12.61	5	In stock	f
1942	cambio_decision	836	Business	The 10% Entrepreneur: Live Your Startup Dream Without Quitting Your Day Job	27.55	3	In stock	f
1943	cambio_decision	831	Business	Shoe Dog: A Memoir by the Creator of NIKE	23.99	2	In stock	f
1944	cambio_decision	715	Business	Made to Stick: Why Some Ideas Survive and Others Die	38.85	5	In stock	f
1945	cambio_decision	629	Business	Quench Your Own Thirst: Business Lessons Learned Over a Beer or Two	43.14	1	In stock	f
1946	cambio_decision	606	Business	The Art of Startup Fundraising	21.00	3	In stock	f
1947	cambio_decision	588	Business	Born for This: How to Find the Work You Were Meant to Do	21.59	5	In stock	f
1948	cambio_decision	545	Business	The E-Myth Revisited: Why Most Small Businesses Don't Work and What to Do About It	36.91	1	In stock	f
1949	cambio_decision	483	Business	Rich Dad, Poor Dad	51.74	1	In stock	f
1950	cambio_decision	260	Business	The Lean Startup: How Today's Entrepreneurs Use Continuous Innovation to Create Radically Successful Businesses	33.92	3	In stock	f
1952	cambio_decision	818	Biography	Louisa: The Extraordinary Life of Mrs. Adams	16.85	2	In stock	f
1953	cambio_decision	603	Biography	Setting the World on Fire: The Brief, Astonishing Life of St. Catherine of Siena	21.15	2	In stock	f
1954	cambio_decision	495	Biography	The Faith of Christopher Hitchens: The Restless Soul of the World's Most Notorious Atheist	39.55	1	In stock	f
1955	cambio_decision	460	Biography	Benjamin Franklin: An American Life	48.19	3	In stock	f
1956	cambio_decision	276	Biography	The Rise of Theodore Roosevelt (Theodore Roosevelt #1)	42.57	3	In stock	f
1957	cambio_decision	980	Thriller	In Her Wake	12.84	1	In stock	f
1958	cambio_decision	968	Thriller	The Elephant Tree	23.82	5	In stock	f
1959	cambio_decision	962	Thriller	Behind Closed Doors	52.22	4	In stock	f
1960	cambio_decision	784	Thriller	You (You #1)	43.61	5	In stock	f
1961	cambio_decision	750	Thriller	The Guilty (Will Robie #4)	13.82	2	In stock	f
1962	cambio_decision	744	Thriller	The 14th Colony (Cotton Malone #11)	39.24	1	In stock	f
1963	cambio_decision	430	Thriller	Give It Back	18.32	2	In stock	f
1964	cambio_decision	382	Thriller	Killing Floor (Jack Reacher #1)	31.49	4	In stock	f
1965	cambio_decision	343	Thriller	The Bone Hunters (Lexy Vaughan & Steven Macaulay #2)	59.71	3	In stock	f
1966	cambio_decision	320	Thriller	Far From True (Promise Falls Trilogy #2)	34.93	2	In stock	f
1967	cambio_decision	285	Thriller	The Travelers	15.77	1	In stock	f
1968	cambio_decision	955	Contemporary	When We Collided	31.77	1	In stock	f
1969	cambio_decision	735	Contemporary	Someone Like You (The Harrisons #2)	52.79	5	In stock	f
1970	cambio_decision	301	Contemporary	We Are All Completely Beside Ourselves	24.04	1	In stock	f
1971	cambio_decision	970	Spirituality	The Four Agreements: A Practical Guide to Personal Freedom	17.66	5	In stock	f
1972	cambio_decision	928	Spirituality	The Activist's Tao Te Ching: Ancient Advice for a Modern Revolution	32.24	5	In stock	f
1973	cambio_decision	797	Spirituality	Chasing Heaven: What Dying Taught Me About Living	37.80	2	In stock	f
1974	cambio_decision	564	Spirituality	If I Gave You God's Phone Number....: Searching for Spirituality in America	20.91	1	In stock	f
1975	cambio_decision	505	Spirituality	Unreasonable Hope: Finding Faith in the God Who Brings Purpose to Your Pain	46.33	2	In stock	f
1976	cambio_decision	311	Spirituality	A New Earth: Awakening to Your Life's Purpose	55.65	5	In stock	f
1977	cambio_decision	384	Academic	Logan Kade (Fallen Crest High #5.5)	13.12	2	In stock	f
1978	cambio_decision	913	Self Help	Online Marketing for Busy Authors: A Step-By-Step Guide	46.35	1	In stock	f
1979	cambio_decision	897	Self Help	How to Be Miserable: 40 Strategies You Already Use	46.03	1	In stock	f
1980	cambio_decision	725	Self Help	Overload: How to Unplug, Unwind, and Unleash Yourself from the Pressure of Stress	52.15	3	In stock	f
1981	cambio_decision	508	Self Help	You Are a Badass: How to Stop Doubting Your Greatness and Start Living an Awesome Life	12.08	3	In stock	f
1982	cambio_decision	431	Self Help	How to Stop Worrying and Start Living	46.49	5	In stock	f
1983	cambio_decision	660	Historical	All the Light We Cannot See	29.87	5	In stock	f
1984	cambio_decision	443	Historical	The Girl You Left Behind (The Girl You Left Behind #1)	15.79	1	In stock	f
1985	cambio_decision	873	Christian	(Un)Qualified: How God Uses Broken People to Do Big Things	54.00	5	In stock	f
1986	cambio_decision	682	Christian	Crazy Love: Overwhelmed by a Relentless God	47.72	2	In stock	f
1987	cambio_decision	461	Christian	Blue Like Jazz: Nonreligious Thoughts on Christian Spirituality	25.77	1	In stock	f
1988	cambio_decision	542	Suspense	Silence in the Dark (Logan Point #4)	58.33	3	In stock	f
1989	cambio_decision	546	Short Stories	The Grownup	35.88	1	In stock	f
1990	cambio_decision	568	Novels	Suzie Snowflake: One beautiful flake (a self-esteem story)	54.81	5	In stock	f
1991	cambio_decision	931	Health	The Bulletproof Diet: Lose up to a Pound a Day, Reclaim Energy and Focus, Upgrade Your Life	49.05	3	In stock	f
1992	cambio_decision	688	Health	Eat Fat, Get Thin	54.07	2	In stock	f
1993	cambio_decision	581	Health	10-Day Green Smoothie Cleanse: Lose Up to 15 Pounds in 10 Days!	49.71	5	In stock	f
1994	cambio_decision	570	Health	The Art and Science of Low Carbohydrate Living	52.98	5	In stock	f
1995	cambio_decision	982	Politics	Libertarianism for Beginners	51.33	2	In stock	f
1996	cambio_decision	781	Politics	Why the Right Went Wrong: Conservatism--From Goldwater to the Tea Party and Beyond	52.65	4	In stock	f
1997	cambio_decision	617	Politics	Equal Is Unfair: America's Misguided Fight Against Income Inequality	56.86	1	In stock	f
1998	cambio_decision	788	Cultural	Amid the Chaos	36.58	1	In stock	f
1999	cambio_decision	800	Erotica	Dark Notes	19.19	5	In stock	f
2000	cambio_decision	848	Crime	The Long Shadow of Small Ghosts: Murder and Memory in an American City	10.97	1	In stock	f
2001	duplicado	981	Travel	It's Only the Himalayas	45.17	2	In stock	f
2002	duplicado	811	Travel	Full Moon over Noah’s Ark: An Odyssey to Mount Ararat and Beyond	49.43	4	In stock	f
2003	duplicado	732	Travel	See America: A Celebration of Our National Parks & Treasured Sites	48.87	3	In stock	f
2004	duplicado	552	Travel	Vagabonding: An Uncommon Guide to the Art of Long-Term World Travel	36.94	2	In stock	f
2005	duplicado	504	Travel	Under the Tuscan Sun	37.33	3	In stock	f
2006	duplicado	458	Travel	A Summer In Europe	44.34	2	In stock	f
2007	duplicado	446	Travel	The Great Railway Bazaar	30.54	1	In stock	f
2008	duplicado	421	Travel	A Year in Provence (Provence #1)	56.88	4	In stock	f
2009	duplicado	277	Travel	The Road to Little Dribbling: Adventures of an American in Britain (Notes From a Small Island #2)	23.21	1	In stock	f
2010	duplicado	198	Travel	Neither Here nor There: Travels in Europe	38.95	3	In stock	f
2011	duplicado	1	Travel	1,000 Places to See Before You Die	26.08	5	In stock	f
2012	duplicado	997	Mystery	Sharp Objects	47.82	4	In stock	f
2013	duplicado	963	Mystery	In a Dark, Dark Wood	19.63	1	In stock	f
2014	duplicado	942	Mystery	The Past Never Ends	56.50	4	In stock	f
2015	duplicado	877	Mystery	A Murder in Time	16.64	1	In stock	f
2016	duplicado	852	Mystery	The Murder of Roger Ackroyd (Hercule Poirot #4)	44.10	4	In stock	f
2017	duplicado	754	Mystery	The Last Mile (Amos Decker #2)	54.21	2	In stock	f
2018	duplicado	743	Mystery	That Darkness (Gardiner and Renner #1)	13.92	1	In stock	f
2019	duplicado	742	Mystery	Tastes Like Fear (DI Marnie Rome #3)	10.69	1	In stock	f
2020	duplicado	657	Mystery	A Time of Torment (Charlie Parker #14)	48.35	5	In stock	f
2021	duplicado	656	Mystery	A Study in Scarlet (Sherlock Holmes #1)	16.73	2	In stock	f
2022	duplicado	627	Mystery	Poisonous (Max Revere Novels #3)	26.80	3	In stock	f
2023	duplicado	624	Mystery	Murder at the 42nd Street Library (Raymond Ambler #1)	54.36	4	In stock	f
2024	duplicado	623	Mystery	Most Wanted	35.28	3	In stock	f
2025	duplicado	620	Mystery	Hide Away (Eve Duncan #20)	11.84	1	In stock	f
2026	duplicado	613	Mystery	Boar Island (Anna Pigeon #19)	59.48	3	In stock	f
2027	duplicado	609	Mystery	The Widow	27.26	2	In stock	f
2028	duplicado	602	Mystery	Playing with Fire	13.71	3	In stock	f
2029	duplicado	506	Mystery	What Happened on Beale Street (Secrets of the South Mysteries #2)	25.37	5	In stock	f
2030	duplicado	491	Mystery	The Bachelor Girl's Guide to Murder (Herringford and Watts Mysteries #1)	52.30	5	In stock	f
2031	duplicado	464	Mystery	Delivering the Truth (Quaker Midwife Mystery #1)	20.89	4	In stock	f
2032	duplicado	452	Mystery	The Mysterious Affair at Styles (Hercule Poirot #1)	24.80	4	In stock	f
2033	duplicado	433	Mystery	In the Woods (Dublin Murder Squad #1)	38.38	2	In stock	f
2034	duplicado	280	Mystery	The Silkworm (Cormoran Strike #2)	23.05	5	In stock	f
2035	duplicado	247	Mystery	The Exiled	43.45	3	In stock	f
2036	duplicado	239	Mystery	The Cuckoo's Calling (Cormoran Strike #1)	19.21	1	In stock	f
2037	duplicado	154	Mystery	Extreme Prey (Lucas Davenport #26)	25.40	3	In stock	f
2038	duplicado	137	Mystery	Career of Evil (Cormoran Strike #3)	24.72	2	In stock	f
2039	duplicado	76	Mystery	The No. 1 Ladies' Detective Agency (No. 1 Ladies' Detective Agency #1)	57.70	4	In stock	f
2040	duplicado	66	Mystery	The Girl You Lost	12.29	5	In stock	f
2041	duplicado	65	Mystery	The Girl In The Ice (DCI Erika Foster #1)	15.85	3	In stock	f
2042	duplicado	8	Mystery	Blood Defense (Samantha Brinkman #1)	20.30	3	In stock	f
2043	duplicado	2	Mystery	1st to Die (Women's Murder Club #1)	53.98	1	In stock	f
2044	duplicado	999	Historical Fiction	Tipping the Velvet	53.74	1	In stock	f
2045	duplicado	894	Historical Fiction	Forever and Forever: The Courtship of Henry Longfellow and Fanny Appleton	29.69	3	In stock	f
2046	duplicado	876	Historical Fiction	A Flight of Arrows (The Pathfinders #2)	55.53	5	In stock	f
2047	duplicado	846	Historical Fiction	The House by the Lake	36.95	1	In stock	f
2048	duplicado	821	Historical Fiction	Mrs. Houdini	30.25	5	In stock	f
2049	duplicado	759	Historical Fiction	The Marriage of Opposites	28.08	4	In stock	f
2050	duplicado	696	Historical Fiction	Glory over Everything: Beyond The Kitchen House	45.84	3	In stock	f
2051	duplicado	622	Historical Fiction	Love, Lies and Spies	20.55	2	In stock	f
2052	duplicado	612	Historical Fiction	A Paris Apartment	39.01	4	In stock	f
2053	duplicado	597	Historical Fiction	Lilac Girls	17.28	2	In stock	f
2054	duplicado	493	Historical Fiction	The Constant Princess (The Tudor Court #1)	16.62	3	In stock	f
2055	duplicado	448	Historical Fiction	The Invention of Wings	37.34	1	In stock	f
2056	duplicado	420	Historical Fiction	World Without End (The Pillars of the Earth #2)	32.97	4	In stock	f
2057	duplicado	351	Historical Fiction	The Passion of Dolssa	28.32	5	In stock	f
2058	duplicado	322	Historical Fiction	Girl With a Pearl Earring	26.77	1	In stock	f
2059	duplicado	299	Historical Fiction	Voyager (Outlander #3)	21.07	5	In stock	f
2060	duplicado	273	Historical Fiction	The Red Tent	35.66	5	In stock	f
2061	duplicado	259	Historical Fiction	The Last Painting of Sara de Vos	55.55	2	In stock	f
2062	duplicado	253	Historical Fiction	The Guernsey Literary and Potato Peel Pie Society	49.53	1	In stock	f
2063	duplicado	160	Historical Fiction	Girl in the Blue Coat	46.83	2	In stock	f
2064	duplicado	128	Historical Fiction	Between Shades of Gray	20.79	5	In stock	f
2065	duplicado	97	Historical Fiction	While You Were Mine	41.32	5	In stock	f
2066	duplicado	80	Historical Fiction	The Secret Healer	34.56	3	In stock	f
2067	duplicado	56	Historical Fiction	Starlark	25.83	3	In stock	f
2068	duplicado	31	Historical Fiction	Lost Among the Living	27.70	4	In stock	f
2069	duplicado	3	Historical Fiction	A Spy's Devotion (The Regency Spies of London #1)	16.97	5	In stock	f
2070	duplicado	987	Sequential Art	Scott Pilgrim's Precious Little Life (Scott Pilgrim #1)	52.29	5	In stock	f
2071	duplicado	949	Sequential Art	Tsubasa: WoRLD CHRoNiCLE 2 (Tsubasa WoRLD CHRoNiCLE #2)	16.28	1	In stock	f
2072	duplicado	947	Sequential Art	This One Summer	19.49	4	In stock	f
2073	duplicado	940	Sequential Art	The Nameless City (The Nameless City #1)	38.16	4	In stock	f
2074	duplicado	923	Sequential Art	Saga, Volume 5 (Saga (Collected Editions) #5)	51.04	2	In stock	f
2075	duplicado	921	Sequential Art	Rat Queens, Vol. 3: Demons (Rat Queens (Collected Editions) #11-15)	50.40	3	In stock	f
2076	duplicado	920	Sequential Art	Princess Jellyfish 2-in-1 Omnibus, Vol. 01 (Princess Jellyfish 2-in-1 Omnibus #1)	13.61	5	In stock	f
2077	duplicado	918	Sequential Art	Pop Gun War, Volume 1: Gift	18.97	1	In stock	f
2078	duplicado	916	Sequential Art	Patience	10.16	3	In stock	f
2079	duplicado	915	Sequential Art	Outcast, Vol. 1: A Darkness Surrounds Him (Outcast #1)	15.44	4	In stock	f
2080	duplicado	914	Sequential Art	orange: The Complete Collection 1 (orange: The Complete Collection #1)	48.41	1	In stock	f
2081	duplicado	907	Sequential Art	Lumberjanes, Vol. 2: Friendship to the Max (Lumberjanes #5-8)	46.91	2	In stock	f
2082	duplicado	906	Sequential Art	Lumberjanes, Vol. 1: Beware the Kitten Holy (Lumberjanes #1-4)	45.61	3	In stock	f
2083	duplicado	905	Sequential Art	Lumberjanes Vol. 3: A Terrible Plan (Lumberjanes #9-12)	19.92	2	In stock	f
2084	duplicado	899	Sequential Art	I Hate Fairyland, Vol. 1: Madly Ever After (I Hate Fairyland (Compilations) #1-5)	29.17	2	In stock	f
2085	duplicado	898	Sequential Art	I am a Hero Omnibus Volume 1	54.63	3	In stock	f
2086	duplicado	895	Sequential Art	Giant Days, Vol. 2 (Giant Days #5-8)	22.11	2	In stock	f
2087	duplicado	889	Sequential Art	Danganronpa Volume 1	51.99	4	In stock	f
2088	duplicado	887	Sequential Art	Codename Baboushka, Volume 1: The Conclave of Death	36.72	4	In stock	f
2089	duplicado	886	Sequential Art	Camp Midnight	17.08	4	In stock	f
2090	duplicado	882	Sequential Art	Bitch Planet, Vol. 1: Extraordinary Machine (Bitch Planet (Collected Editions))	37.92	2	In stock	f
2091	duplicado	860	Sequential Art	The Shadow Hero (The Shadow Hero)	33.14	1	In stock	f
2092	duplicado	806	Sequential Art	Fables, Vol. 1: Legends in Exile (Fables #1)	41.62	4	In stock	f
2093	duplicado	793	Sequential Art	Batman: The Long Halloween (Batman)	36.50	2	In stock	f
2094	duplicado	792	Sequential Art	Batman: The Dark Knight Returns (Batman)	15.38	5	In stock	f
2095	duplicado	783	Sequential Art	Wonder Woman: Earth One, Volume One (Wonder Woman: Earth One #1)	37.34	4	In stock	f
2096	duplicado	778	Sequential Art	We Are Robin, Vol. 1: The Vigilante Business (We Are Robin #1)	53.90	1	In stock	f
2097	duplicado	772	Sequential Art	Through the Woods	25.38	2	In stock	f
2098	duplicado	739	Sequential Art	Superman Vol. 1: Before Truth (Superman by Gene Luen Yang #1)	11.89	5	In stock	f
2099	duplicado	734	Sequential Art	So Cute It Hurts!!, Vol. 6 (So Cute It Hurts!! #6)	35.43	4	In stock	f
2100	duplicado	730	Sequential Art	Robin War	47.82	3	In stock	f
2101	duplicado	729	Sequential Art	Red Hood/Arsenal, Vol. 1: Open for Business (Red Hood/Arsenal #1)	25.48	2	In stock	f
2102	duplicado	721	Sequential Art	Naruto (3-in-1 Edition), Vol. 14: Includes Vols. 40, 41 & 42 (Naruto: Omnibus #14)	38.39	2	In stock	f
2103	duplicado	712	Sequential Art	Lowriders to the Center of the Earth (Lowriders in Space #2)	51.51	2	In stock	f
2104	duplicado	691	Sequential Art	El Deafo	57.62	5	In stock	f
2105	duplicado	668	Sequential Art	Batman: Europa	32.01	2	In stock	f
2106	duplicado	664	Sequential Art	Art Ops Vol. 1	48.80	3	In stock	f
2107	duplicado	659	Sequential Art	Adulthood Is a Myth: A "Sarah's Scribbles" Collection	10.90	2	In stock	f
2108	duplicado	563	Sequential Art	Fruits Basket, Vol. 9 (Fruits Basket #9)	33.95	4	In stock	f
2109	duplicado	540	Sequential Art	Roller Girl	14.10	5	In stock	f
2110	duplicado	468	Sequential Art	Fruits Basket, Vol. 7 (Fruits Basket #7)	19.57	1	In stock	f
2111	duplicado	427	Sequential Art	Fruits Basket, Vol. 6 (Fruits Basket #6)	20.96	4	In stock	f
2112	duplicado	425	Sequential Art	Death Note, Vol. 6: Give-and-Take (Death Note #6)	36.39	3	In stock	f
2113	duplicado	376	Sequential Art	Fruits Basket, Vol. 5 (Fruits Basket #5)	16.33	1	In stock	f
2114	duplicado	368	Sequential Art	Death Note, Vol. 5: Whiteout (Death Note #5)	52.41	1	In stock	f
2115	duplicado	344	Sequential Art	The Demon Prince of Momochi House, Vol. 4 (The Demon Prince of Momochi House #4)	27.88	2	In stock	f
2116	duplicado	321	Sequential Art	Fruits Basket, Vol. 4 (Fruits Basket #4)	50.44	4	In stock	f
2117	duplicado	287	Sequential Art	The Wicked + The Divine, Vol. 3: Commercial Suicide (The Wicked + The Divine)	14.41	3	In stock	f
2118	duplicado	279	Sequential Art	The Sandman, Vol. 3: Dream Country (The Sandman (volumes) #3)	55.55	5	In stock	f
2119	duplicado	216	Sequential Art	Saga, Volume 3 (Saga (Collected Editions) #3)	21.57	5	In stock	f
2120	duplicado	207	Sequential Art	Prodigy: The Graphic Novel (Legend: The Graphic Novel #2)	43.63	3	In stock	f
2121	duplicado	206	Sequential Art	Persepolis: The Story of a Childhood (Persepolis #1-2)	39.13	1	In stock	f
2122	duplicado	203	Sequential Art	Original Fake	31.45	3	In stock	f
2123	duplicado	164	Sequential Art	Grayson, Vol 3: Nemesis (Grayson #3)	42.72	1	In stock	f
2124	duplicado	159	Sequential Art	Fruits Basket, Vol. 3 (Fruits Basket #3)	45.17	2	In stock	f
2125	duplicado	130	Sequential Art	Black Butler, Vol. 1 (Black Butler #1)	49.31	1	In stock	f
2126	duplicado	124	Sequential Art	Awkward	38.02	2	In stock	f
2127	duplicado	110	Sequential Art	The Sandman, Vol. 2: The Doll's House (The Sandman (volumes) #2)	54.81	1	In stock	f
2128	duplicado	107	Sequential Art	Saga, Volume 2 (Saga (Collected Editions) #2)	11.75	3	In stock	f
2129	duplicado	100	Sequential Art	Fruits Basket, Vol. 2 (Fruits Basket #2)	11.64	5	In stock	f
2130	duplicado	98	Sequential Art	Y: The Last Man, Vol. 1: Unmanned (Y: The Last Man #1)	18.51	4	In stock	f
2131	duplicado	86	Sequential Art	The Wicked + The Divine, Vol. 1: The Faust Act (The Wicked + The Divine)	36.52	2	In stock	f
2132	duplicado	79	Sequential Art	The Sandman, Vol. 1: Preludes and Nocturnes (The Sandman (volumes) #1)	54.12	3	In stock	f
2133	duplicado	62	Sequential Art	The Complete Maus (Maus #1-2)	10.64	3	In stock	f
2134	duplicado	55	Sequential Art	Skip Beat!, Vol. 01 (Skip Beat! #1)	42.12	3	In stock	f
2135	duplicado	48	Sequential Art	Saga, Volume 1 (Saga (Collected Editions) #1)	28.48	1	In stock	f
2136	duplicado	46	Sequential Art	Rat Queens, Vol. 1: Sass & Sorcery (Rat Queens (Collected Editions) #1-5)	46.96	5	In stock	f
2137	duplicado	44	Sequential Art	Paper Girls, Vol. 1 (Paper Girls #1-5)	21.71	4	In stock	f
2138	duplicado	43	Sequential Art	Ouran High School Host Club, Vol. 1 (Ouran High School Host Club #1)	29.87	3	In stock	f
2139	duplicado	34	Sequential Art	Ms. Marvel, Vol. 1: No Normal (Ms. Marvel (2014-2015) #1)	39.39	4	In stock	f
2140	duplicado	24	Sequential Art	Hawkeye, Vol. 1: My Life as a Weapon (Hawkeye #1)	45.24	3	In stock	f
2141	duplicado	22	Sequential Art	Giant Days, Vol. 1 (Giant Days #1-4)	56.76	4	In stock	f
2142	duplicado	21	Sequential Art	Fruits Basket, Vol. 1 (Fruits Basket #1)	40.28	5	In stock	f
2143	duplicado	7	Sequential Art	Bleach, Vol. 1: Strawberry and the Soul Reapers (Bleach #1)	34.65	5	In stock	f
2144	duplicado	4	Sequential Art	Ajin: Demi-Human, Volume 1 (Ajin: Demi-Human #1)	57.06	4	In stock	f
2145	duplicado	413	Classics	The Secret Garden	15.08	4	In stock	f
2146	duplicado	409	Classics	The Metamorphosis	28.58	1	In stock	f
2147	duplicado	353	Classics	The Pilgrim's Progress	50.26	2	In stock	f
2148	duplicado	348	Classics	The Hound of the Baskervilles (Sherlock Holmes #5)	14.82	2	In stock	f
2149	duplicado	331	Classics	Little Women (Little Women #1)	28.07	4	In stock	f
2150	duplicado	324	Classics	Gone with the Wind	32.49	3	In stock	f
2151	duplicado	316	Classics	Candide	58.63	3	In stock	f
2152	duplicado	313	Classics	Animal Farm	57.22	3	In stock	f
2153	duplicado	307	Classics	Wuthering Heights	17.73	3	In stock	f
2154	duplicado	270	Classics	The Picture of Dorian Gray	29.70	2	In stock	f
2155	duplicado	238	Classics	The Complete Stories and Poems (The Works of Edgar Allan Poe [Cameo Edition])	26.78	4	In stock	f
2156	duplicado	126	Classics	Beowulf	38.35	2	In stock	f
2157	duplicado	119	Classics	And Then There Were None	35.01	2	In stock	f
2158	duplicado	84	Classics	The Story of Hong Gildong	43.19	4	In stock	f
2159	duplicado	72	Classics	The Little Prince	45.42	2	In stock	f
2160	duplicado	49	Classics	Sense and Sensibility	37.46	1	In stock	f
2161	duplicado	37	Classics	Of Mice and Men	47.11	2	In stock	f
2162	duplicado	17	Classics	Emma	32.93	2	In stock	f
2163	duplicado	5	Classics	Alice in Wonderland (Alice's Adventures in Wonderland #1)	55.53	1	In stock	f
2164	duplicado	966	Philosophy	Sophie's World	15.94	5	In stock	f
2165	duplicado	932	Philosophy	The Death of Humanity: and the Case for Life	58.11	4	In stock	f
2166	duplicado	861	Philosophy	The Stranger	17.44	4	In stock	f
2167	duplicado	538	Philosophy	Proofs of God: Classical Arguments from Tertullian to Barth	54.21	1	In stock	f
2168	duplicado	527	Philosophy	Kierkegaard: A Christian Missionary to Christians	47.13	1	In stock	f
2169	duplicado	459	Philosophy	At The Existentialist Café: Freedom, Being, and apricot cocktails with: Jean-Paul Sartre, Simone de Beauvoir, Albert Camus, Martin Heidegger, Edmund Husserl, Karl Jaspers, Maurice Merleau-Ponty and others	29.93	5	In stock	f
2170	duplicado	366	Philosophy	Critique of Pure Reason	20.75	1	In stock	f
2171	duplicado	106	Philosophy	Run, Spot, Run: The Ethics of Keeping Pets	20.02	1	In stock	f
2172	duplicado	75	Philosophy	The Nicomachean Ethics	36.34	1	In stock	f
2173	duplicado	33	Philosophy	Meditations	25.89	2	In stock	f
2174	duplicado	6	Philosophy	Beyond Good and Evil	43.38	1	In stock	f
2175	duplicado	977	Romance	Chase Me (Paris Nights #2)	25.27	5	In stock	f
2176	duplicado	976	Romance	Black Dust	34.53	5	In stock	f
2177	duplicado	896	Romance	Her Backup Boyfriend (The Sorensen Family #1)	33.97	1	In stock	f
2178	duplicado	893	Romance	First and First (Five Boroughs #3)	15.97	4	In stock	f
2179	duplicado	892	Romance	Fifty Shades Darker (Fifty Shades #2)	21.96	1	In stock	f
2180	duplicado	864	Romance	The Wedding Dress	24.12	1	In stock	f
2181	duplicado	835	Romance	Suddenly in Love (Lake Haven #1)	55.99	2	In stock	f
2182	duplicado	834	Romance	Something More Than This	16.24	4	In stock	f
2183	duplicado	802	Romance	Doing It Over (Most Likely To #1)	35.61	3	In stock	f
2184	duplicado	767	Romance	The Wedding Pact (The O'Malleys #2)	32.61	3	In stock	f
2185	duplicado	700	Romance	Hold Your Breath (Search and Rescue #1)	28.82	1	In stock	f
2186	duplicado	615	Romance	Dirty (Dive Bar #1)	40.83	4	In stock	f
2187	duplicado	605	Romance	Take Me Home Tonight (Rock Star Romance #3)	53.98	3	In stock	f
2188	duplicado	601	Romance	Off the Hook (Fishing for Trouble #1)	47.67	3	In stock	f
2189	duplicado	584	Romance	A Gentleman's Position (Society of Gentlemen #3)	14.75	5	In stock	f
2190	duplicado	486	Romance	Sit, Stay, Love	20.90	3	In stock	f
2191	duplicado	359	Romance	A Girl's Guide to Moving On (New Beginnings #2)	31.30	1	In stock	f
2192	duplicado	352	Romance	The Perfect Play (Play by Play #1)	59.99	3	In stock	f
2193	duplicado	319	Romance	Dark Lover (Black Dagger Brotherhood #1)	12.87	1	In stock	f
2194	duplicado	317	Romance	Changing the Game (Play by Play #2)	13.38	3	In stock	f
2195	duplicado	312	Romance	A Walk to Remember	56.43	1	In stock	f
2196	duplicado	271	Romance	The Purest Hook (Second Circle Tattoos #3)	12.25	1	In stock	f
2197	duplicado	268	Romance	The Obsession	45.43	1	In stock	f
2198	duplicado	211	Romance	Reservations for Two	11.10	3	In stock	f
2199	duplicado	127	Romance	Best of My Love (Fool's Gold #20)	27.41	2	In stock	f
2200	duplicado	96	Romance	Where Lightning Strikes (Bleeding Stars #3)	39.77	3	In stock	f
2201	duplicado	88	Romance	This One Moment (Pushing Limits #1)	48.71	1	In stock	f
2202	duplicado	47	Romance	Rhythm, Chord & Malykhin	28.34	2	In stock	f
2203	duplicado	35	Romance	My Perfect Mistake (Over the Top #1)	38.92	2	In stock	f
2204	duplicado	29	Romance	Listen to Me (Fusion #1)	58.99	3	In stock	f
2205	duplicado	26	Romance	Imperfect Harmony	34.74	4	In stock	f
2206	duplicado	18	Romance	Fighting Fate (Fighting #6)	39.24	3	In stock	f
2207	duplicado	15	Romance	Deep Under (Walker Security #1)	47.09	5	In stock	f
2208	duplicado	12	Romance	Charity's Cross (Charles Towne Belles #4)	41.24	1	In stock	f
2209	duplicado	9	Romance	Bounty (Colorado Mountain #7)	37.26	4	In stock	f
2210	duplicado	814	Womens Fiction	I Had a Nice Time And Other Lies...: How to find love & sh*t like that	57.36	4	In stock	f
2211	duplicado	644	Womens Fiction	Will You Won't You Want Me?	13.86	3	In stock	f
2212	duplicado	594	Womens Fiction	Keep Me Posted	20.46	4	In stock	f
2213	duplicado	592	Womens Fiction	Grey (Fifty Shades #4)	48.49	4	In stock	f
2214	duplicado	478	Womens Fiction	Meternity	43.58	3	In stock	f
2215	duplicado	341	Womens Fiction	Some Women	13.73	5	In stock	f
2216	duplicado	340	Womens Fiction	Shopaholic Ties the Knot (Shopaholic #3)	48.39	5	In stock	f
2217	duplicado	315	Womens Fiction	Can You Keep a Secret?	21.94	1	In stock	f
2218	duplicado	292	Womens Fiction	Twenties Girl	42.80	2	In stock	f
2219	duplicado	286	Womens Fiction	The Undomestic Goddess	45.75	4	In stock	f
2220	duplicado	265	Womens Fiction	The Nanny Diaries (Nanny #1)	52.53	5	In stock	f
2221	duplicado	243	Womens Fiction	The Devil Wears Prada (The Devil Wears Prada #1)	44.29	1	In stock	f
2222	duplicado	224	Womens Fiction	Something Borrowed (Darcy & Rachel #1)	48.96	5	In stock	f
2223	duplicado	223	Womens Fiction	Something Blue (Darcy & Rachel #2)	54.62	1	In stock	f
2224	duplicado	173	Womens Fiction	I've Got Your Number	19.69	1	In stock	f
2225	duplicado	63	Womens Fiction	The Edge of Reason (Bridget Jones #2)	19.18	4	In stock	f
2226	duplicado	10	Womens Fiction	Bridget Jones's Diary (Bridget Jones #1)	29.82	1	In stock	f
2227	duplicado	998	Fiction	Soumission	50.10	1	In stock	f
2228	duplicado	958	Fiction	Private Paris (Private #10)	47.61	5	In stock	f
2229	duplicado	954	Fiction	We Love You, Charlie Freeman	50.27	5	In stock	f
2230	duplicado	946	Fiction	Thirst	17.27	5	In stock	f
2231	duplicado	939	Fiction	The Murder That Never Was (Forensic Instincts #5)	54.11	3	In stock	f
2232	duplicado	870	Fiction	Tuesday Nights in 1980	21.04	2	In stock	f
2233	duplicado	863	Fiction	The Vacationers	42.15	4	In stock	f
2234	duplicado	858	Fiction	The Regional Office Is Under Attack!	51.36	5	In stock	f
2235	duplicado	807	Fiction	Finders Keepers (Bill Hodges Trilogy #2)	53.53	5	In stock	f
2236	duplicado	766	Fiction	The Time Keeper	27.88	5	In stock	f
2237	duplicado	765	Fiction	The Testament of Mary	52.67	4	In stock	f
2238	duplicado	749	Fiction	The First Hostage (J.B. Collins #2)	25.85	3	In stock	f
2239	duplicado	741	Fiction	Take Me with You	45.21	3	In stock	f
2240	duplicado	738	Fiction	Still Life with Bread Crumbs	26.41	3	In stock	f
2241	duplicado	733	Fiction	Shtum	55.84	4	In stock	f
2242	duplicado	720	Fiction	My Name Is Lucy Barton	41.56	1	In stock	f
2243	duplicado	719	Fiction	My Mrs. Brown	24.48	3	In stock	f
2244	duplicado	717	Fiction	Mr. Mercedes (Bill Hodges Trilogy #1)	28.90	1	In stock	f
2245	duplicado	703	Fiction	I Am Pilgrim (Pilgrim #1)	10.60	4	In stock	f
2246	duplicado	692	Fiction	Eligible (The Austen Project #4)	27.09	3	In stock	f
2247	duplicado	690	Fiction	Eight Hundred Grapes	14.39	4	In stock	f
2248	duplicado	684	Fiction	Dear Mr. Knightley	11.21	5	In stock	f
2249	duplicado	681	Fiction	Cometh the Hour (The Clifton Chronicles #6)	25.01	3	In stock	f
2250	duplicado	665	Fiction	Balloon Animals	17.03	3	In stock	f
2251	duplicado	653	Fiction	A Man Called Ove	39.72	1	In stock	f
2252	duplicado	641	Fiction	The Silent Sister (Riley MacPherson #1)	46.29	5	In stock	f
2253	duplicado	635	Fiction	The Dinner Party	56.54	2	In stock	f
2254	duplicado	607	Fiction	The Improbability of Love	59.45	1	In stock	f
2255	duplicado	600	Fiction	Mothering Sunday	13.34	2	In stock	f
2256	duplicado	596	Fiction	Lies and Other Acts of Love	45.14	1	In stock	f
2257	duplicado	590	Fiction	Daredevils	16.34	3	In stock	f
2258	duplicado	583	Fiction	11/22/63	48.48	3	In stock	f
2259	duplicado	576	Fiction	The Shack	28.03	1	In stock	f
2260	duplicado	547	Fiction	The High Mountains of Portugal	51.15	1	In stock	f
2261	duplicado	534	Fiction	Miller's Valley	58.54	2	In stock	f
2262	duplicado	523	Fiction	Hystopia: A Novel	21.96	4	In stock	f
2263	duplicado	492	Fiction	The Bourne Identity (Jason Bourne #1)	42.78	4	In stock	f
2264	duplicado	485	Fiction	Sister Dear	40.20	4	In stock	f
2265	duplicado	477	Fiction	Memoirs of a Geisha	49.67	3	In stock	f
2266	duplicado	434	Fiction	Me Before You (Me Before You #1)	19.02	1	In stock	f
2267	duplicado	426	Fiction	Deception Point	40.32	4	In stock	f
2268	duplicado	407	Fiction	The Little Paris Bookshop	24.73	3	In stock	f
2269	duplicado	404	Fiction	The Firm	45.56	3	In stock	f
2270	duplicado	401	Fiction	The Expatriates	44.58	2	In stock	f
2271	duplicado	393	Fiction	Siddhartha	34.22	5	In stock	f
2272	duplicado	383	Fiction	Last One Home (New Beginnings #1)	59.98	3	In stock	f
2273	duplicado	369	Fiction	Digital Fortress	58.00	5	In stock	f
2274	duplicado	314	Fiction	Atlas Shrugged	26.58	5	In stock	f
2275	duplicado	290	Fiction	Three-Martini Lunch	23.21	3	In stock	f
2276	duplicado	267	Fiction	The Nightingale	26.26	4	In stock	f
2277	duplicado	257	Fiction	The Infinities	27.41	1	In stock	f
2278	duplicado	256	Fiction	The Husband's Secret	52.51	5	In stock	f
2279	duplicado	240	Fiction	The Da Vinci Code (Robert Langdon #2)	22.96	2	In stock	f
2280	duplicado	228	Fiction	The Art of Fielding	22.10	1	In stock	f
2281	duplicado	190	Fiction	Lila (Gilead #3)	12.47	3	In stock	f
2282	duplicado	180	Fiction	Jurassic Park (Jurassic Park #1)	44.97	1	In stock	f
2283	duplicado	176	Fiction	Inferno (Robert Langdon #4)	41.00	5	In stock	f
2284	duplicado	143	Fiction	Crazy Rich Asians (Crazy Rich Asians #1)	49.13	5	In stock	f
2285	duplicado	129	Fiction	Big Little Lies	22.11	1	In stock	f
2286	duplicado	109	Fiction	The Course of Love	16.78	3	In stock	f
2287	duplicado	95	Fiction	When I'm Gone	51.96	3	In stock	f
2288	duplicado	83	Fiction	The Silent Wife	12.34	5	In stock	f
2289	duplicado	59	Fiction	The Bette Davis Club	30.66	3	In stock	f
2290	duplicado	28	Fiction	Kitchens of the Great Midwest	57.20	5	In stock	f
2291	duplicado	11	Fiction	Bright Lines	39.07	5	In stock	f
2292	duplicado	975	Childrens	Birdsong: A Story in Pictures	54.64	3	In stock	f
2293	duplicado	967	Childrens	The Bear and the Piano	36.89	1	In stock	f
2294	duplicado	944	Childrens	The Secret of Dreadwillow Carse	56.13	1	In stock	f
2417	duplicado	186	Nonfiction	Letter to a Christian Nation	22.20	1	In stock	f
2295	duplicado	865	Childrens	The White Cat and the Monk: A Retelling of the Poem “Pangur Bán”	58.08	4	In stock	f
2296	duplicado	817	Childrens	Little Red	13.47	3	In stock	f
2297	duplicado	777	Childrens	Walt Disney's Alice in Wonderland	12.96	5	In stock	f
2298	duplicado	773	Childrens	Twenty Yawns	22.08	2	In stock	f
2299	duplicado	728	Childrens	Rain Fish	23.57	3	In stock	f
2300	duplicado	724	Childrens	Once Was a Time	18.28	2	In stock	f
2301	duplicado	714	Childrens	Luis Paints the World	53.95	3	In stock	f
2302	duplicado	567	Childrens	Nap-a-Roo	25.08	1	In stock	f
2303	duplicado	501	Childrens	The Whale	35.96	4	In stock	f
2304	duplicado	484	Childrens	Shrunken Treasures: Literary Classics, Short, Sweet, and Silly	52.87	3	In stock	f
2305	duplicado	482	Childrens	Raymie Nightingale	34.41	2	In stock	f
2306	duplicado	481	Childrens	Playing from the Heart	32.38	1	In stock	f
2307	duplicado	386	Childrens	Maybe Something Beautiful: How Art Transformed a Neighborhood	22.54	1	In stock	f
2308	duplicado	288	Childrens	The Wild Robot	56.07	3	In stock	f
2309	duplicado	283	Childrens	The Thing About Jellyfish	48.77	1	In stock	f
2310	duplicado	261	Childrens	The Lonely Ones	43.59	5	In stock	f
2311	duplicado	241	Childrens	The Day the Crayons Came Home (Crayons)	26.33	5	In stock	f
2312	duplicado	235	Childrens	The Cat in the Hat (Beginner Books B-1)	16.26	2	In stock	f
2313	duplicado	210	Childrens	Red: The True Story of Red Riding Hood	28.54	3	In stock	f
2314	duplicado	168	Childrens	Horrible Bear!	37.52	2	In stock	f
2315	duplicado	165	Childrens	Green Eggs and Ham (Beginner Books B-16)	10.79	4	In stock	f
2316	duplicado	142	Childrens	Counting Thyme	10.62	1	In stock	f
2317	duplicado	122	Childrens	Are We There Yet?	10.66	3	In stock	f
2318	duplicado	99	Childrens	Diary of a Minecraft Zombie Book 1: A Scare of a Dare (An Unofficial Minecraft Book)	52.88	4	In stock	f
2319	duplicado	32	Childrens	Matilda	28.34	1	In stock	f
2320	duplicado	13	Childrens	Charlie and the Chocolate Factory (Charlie Bucket #1)	22.85	3	In stock	f
2321	duplicado	890	Religion	Don't Be a Jerk: And Other Practical Advice from Dogen, Japan's Greatest Zen Master	37.97	2	In stock	f
2322	duplicado	872	Religion	You Are What You Love: The Spiritual Power of Habit	21.87	4	In stock	f
2323	duplicado	697	Religion	God: The Most Unpleasant Character in All Fiction	30.03	5	In stock	f
2324	duplicado	571	Religion	The Book of Mormon	24.57	3	In stock	f
2325	duplicado	310	Religion	A History of God: The 4,000-Year Quest of Judaism, Christianity, and Islam	27.62	1	In stock	f
2326	duplicado	60	Religion	The Bhagavad Gita	57.49	3	In stock	f
2327	duplicado	14	Religion	Choosing Our Religion: The Spiritual Lives of America's Nones	28.42	4	In stock	f
2328	duplicado	972	Nonfiction	Worlds Elsewhere: Journeys Around Shakespeare’s Globe	40.30	5	In stock	f
2329	duplicado	969	Nonfiction	The Five Love Languages: How to Express Heartfelt Commitment to Your Mate	31.05	3	In stock	f
2330	duplicado	959	Nonfiction	Reasons to Stay Alive	26.41	2	In stock	f
2331	duplicado	957	Nonfiction	#HigherSelfie: Wake Up Your Life. Free Your Soul. Find Your Tribe.	23.11	5	In stock	f
2332	duplicado	952	Nonfiction	Unseen City: The Majesty of Pigeons, the Discreet Charm of Snails & Other Wonders of the Urban Wilderness	44.18	4	In stock	f
2333	duplicado	948	Nonfiction	Throwing Rocks at the Google Bus: How Growth Became the Enemy of Prosperity	31.12	3	In stock	f
2334	duplicado	936	Nonfiction	The Life-Changing Magic of Tidying Up: The Japanese Art of Decluttering and Organizing	16.77	3	In stock	f
2335	duplicado	934	Nonfiction	The Gutsy Girl: Escapades for Your Life of Epic Adventure	37.13	1	In stock	f
2336	duplicado	933	Nonfiction	The Electric Pencil: Drawings from Inside State Hospital No. 3	56.06	1	In stock	f
2337	duplicado	927	Nonfiction	Spark Joy: An Illustrated Master Class on the Art of Organizing and Tidying Up	41.83	4	In stock	f
2338	duplicado	922	Nonfiction	Reskilling America: Learning to Labor in the Twenty-First Century	19.83	2	In stock	f
2339	duplicado	901	Nonfiction	In the Country We Love: My Family Divided	22.00	4	In stock	f
2340	duplicado	891	Nonfiction	Everydata: The Misinformation Hidden in the Little Data You Consume Every Day	54.35	2	In stock	f
2341	duplicado	885	Nonfiction	Call the Nurse: True Stories of a Country Nurse on a Scottish Isle	29.14	5	In stock	f
2342	duplicado	880	Nonfiction	Algorithms to Live By: The Computer Science of Human Decisions	30.81	1	In stock	f
2343	duplicado	855	Nonfiction	The Power of Now: A Guide to Spiritual Enlightenment	43.54	2	In stock	f
2344	duplicado	854	Nonfiction	The Omnivore's Dilemma: A Natural History of Four Meals	38.21	2	In stock	f
2345	duplicado	843	Nonfiction	The Genius of Birds	17.24	1	In stock	f
2346	duplicado	839	Nonfiction	The Artist's Way: A Spiritual Path to Higher Creativity	38.49	5	In stock	f
2347	duplicado	832	Nonfiction	So You've Been Publicly Shamed	12.23	2	In stock	f
2348	duplicado	799	Nonfiction	Daring Greatly: How the Courage to Be Vulnerable Transforms the Way We Live, Love, Parent, and Lead	19.43	3	In stock	f
2349	duplicado	796	Nonfiction	Big Magic: Creative Living Beyond Fear	30.80	3	In stock	f
2350	duplicado	795	Nonfiction	Becoming Wise: An Inquiry into the Mystery and Art of Living	27.43	2	In stock	f
2351	duplicado	786	Nonfiction	Agnostic: A Spirited Manifesto	12.51	5	In stock	f
2352	duplicado	780	Nonfiction	Whole Lotta Creativity Going On: 60 Fun and Unusual Exercises to Awaken and Strengthen Your Creativity	38.20	4	In stock	f
2353	duplicado	779	Nonfiction	What's It Like in Space?: Stories from Astronauts Who've Been There	19.60	2	In stock	f
2354	duplicado	770	Nonfiction	The Year of Magical Thinking	43.04	2	In stock	f
2355	duplicado	755	Nonfiction	The Literature Book (Big Ideas Simply Explained)	17.43	3	In stock	f
2356	duplicado	745	Nonfiction	The Bad-Ass Librarians of Timbuktu: And Their Race to Save the World’s Most Precious Manuscripts	15.77	1	In stock	f
2357	duplicado	740	Nonfiction	Swell: A Year of Waves	45.58	1	In stock	f
2358	duplicado	722	Nonfiction	No Dream Is Too High: Life Lessons From a Man Who Walked on the Moon	21.95	2	In stock	f
2359	duplicado	710	Nonfiction	Looking for Lovely: Collecting the Moments that Matter	29.14	5	In stock	f
2360	duplicado	708	Nonfiction	Let It Out: A Journey Through Journaling	26.79	5	In stock	f
2361	duplicado	699	Nonfiction	Hamilton: The Revolution	58.79	3	In stock	f
2362	duplicado	694	Nonfiction	Far & Away: Places on the Brink of Change: Seven Continents, Twenty-Five Years	15.06	4	In stock	f
2363	duplicado	689	Nonfiction	Eaternity: More than 150 Deliciously Easy Vegan Recipes for a Long, Healthy, Satisfied, Joyful Life	51.75	5	In stock	f
2364	duplicado	670	Nonfiction	Buying In: The Secret Dialogue Between What We Buy and Who We Are	37.80	4	In stock	f
2365	duplicado	669	Nonfiction	Brain on Fire: My Month of Madness	49.32	5	In stock	f
2366	duplicado	658	Nonfiction	Abstract City	56.37	5	In stock	f
2367	duplicado	645	Nonfiction	13 Hours: The Inside Account of What Really Happened In Benghazi	27.06	1	In stock	f
2368	duplicado	639	Nonfiction	The Lonely City: Adventures in the Art of Being Alone	33.26	2	In stock	f
2369	duplicado	634	Nonfiction	The Diary of a Young Girl	59.90	3	In stock	f
2370	duplicado	631	Nonfiction	Snatched: How A Drug Queen Went Undercover for the DEA and Was Kidnapped By Colombian Guerillas	21.21	3	In stock	f
2371	duplicado	619	Nonfiction	Furiously Happy: A Funny Book About Horrible Things	41.46	4	In stock	f
2372	duplicado	608	Nonfiction	The Sleep Revolution: Transforming Your Life, One Night at a Time	11.68	4	In stock	f
2373	duplicado	599	Nonfiction	Mother, Can You Not?	16.89	5	In stock	f
2374	duplicado	585	Nonfiction	A Mother's Reckoning: Living in the Aftermath of Tragedy	19.53	3	In stock	f
2375	duplicado	582	Nonfiction	10% Happier: How I Tamed the Voice in My Head, Reduced Stress Without Losing My Edge, and Found Self-Help That Actually Works	24.57	2	In stock	f
2376	duplicado	560	Nonfiction	Chernobyl 01:23:40: The Incredible True Story of the World's Worst Nuclear Disaster	35.92	2	In stock	f
2377	duplicado	555	Nonfiction	Zero to One: Notes on Startups, or How to Build the Future	34.06	3	In stock	f
2378	duplicado	554	Nonfiction	Why Not Me?	17.76	1	In stock	f
2379	duplicado	553	Nonfiction	When Breath Becomes Air	39.36	2	In stock	f
2380	duplicado	549	Nonfiction	The Midnight Assassin: Panic, Scandal, and the Hunt for America's First Serial Killer	28.45	4	In stock	f
2381	duplicado	543	Nonfiction	Smarter Faster Better: The Secrets of Being Productive in Life and Business	38.89	5	In stock	f
2382	duplicado	539	Nonfiction	Rising Strong	21.82	3	In stock	f
2383	duplicado	533	Nonfiction	Man's Search for Meaning	29.48	3	In stock	f
2384	duplicado	532	Nonfiction	Love That Boy: What Two Presidents, Eight Road Trips, and My Son Taught Me About a Parent's Expectations	25.06	2	In stock	f
2385	duplicado	531	Nonfiction	Living Forward: A Proven Plan to Stop Drifting and Get the Life You Want	12.55	3	In stock	f
2386	duplicado	524	Nonfiction	I Will Find You	44.21	1	In stock	f
2387	duplicado	514	Nonfiction	Brazen: The Courage to Find the You That's Been Hiding	19.22	2	In stock	f
2388	duplicado	513	Nonfiction	Between the World and Me	56.91	4	In stock	f
2389	duplicado	512	Nonfiction	Being Mortal: Medicine and What Matters in the End	55.06	4	In stock	f
2390	duplicado	511	Nonfiction	A Murder Over a Girl: Justice, Gender, Junior High	13.20	3	In stock	f
2391	duplicado	467	Nonfiction	For the Love: Fighting for Grace in a World of Impossible Standards	45.13	3	In stock	f
2392	duplicado	466	Nonfiction	Finding God in the Ruins: How God Redeems Pain	46.64	2	In stock	f
2393	duplicado	451	Nonfiction	The Man Who Mistook His Wife for a Hat and Other Clinical Tales	59.45	4	In stock	f
2394	duplicado	432	Nonfiction	In Cold Blood	49.98	4	In stock	f
2395	duplicado	429	Nonfiction	Girl, Interrupted	42.14	3	In stock	f
2396	duplicado	418	Nonfiction	Why Save the Bankers?: And Other Essays on Our Economic and Political Crisis	48.67	2	In stock	f
2397	duplicado	394	Nonfiction	Talking to Girls About Duran Duran: One Young Man's Quest for True Love and a Cooler Haircut	25.15	4	In stock	f
2398	duplicado	388	Nonfiction	My Mother Was Nuts	31.63	4	In stock	f
2399	duplicado	367	Nonfiction	Data, A Love Story: How I Gamed Online Dating to Meet My Match	32.35	3	In stock	f
2400	duplicado	350	Nonfiction	The Jazz of Physics: The Secret Link Between Music and the Structure of the Universe	38.71	3	In stock	f
2401	duplicado	347	Nonfiction	The Gunning of America: Business and the Making of American Gun Culture	16.81	4	In stock	f
2402	duplicado	346	Nonfiction	The Geography of Bliss: One Grump's Search for the Happiest Places in the World	28.23	2	In stock	f
2403	duplicado	323	Nonfiction	God Is Not Great: How Religion Poisons Everything	27.80	1	In stock	f
2404	duplicado	302	Nonfiction	We the People: The Modern-Day Figures Who Have Reshaped and Affirmed the Founding Fathers' Vision of America	31.95	3	In stock	f
2405	duplicado	298	Nonfiction	Very Good Lives: The Fringe Benefits of Failure and the Importance of Imagination	50.66	3	In stock	f
2406	duplicado	296	Nonfiction	Unstuffed: Decluttering Your Home, Mind, and Soul	58.09	1	In stock	f
2407	duplicado	295	Nonfiction	Under the Banner of Heaven: A Story of Violent Faith	30.00	1	In stock	f
2408	duplicado	291	Nonfiction	Trespassing Across America: One Man's Epic, Never-Done-Before (and Sort of Illegal) Hike Across the Heartland	53.51	1	In stock	f
2409	duplicado	264	Nonfiction	The Name of God is Mercy	37.25	2	In stock	f
2410	duplicado	226	Nonfiction	Stiff: The Curious Lives of Human Cadavers	36.74	3	In stock	f
2411	duplicado	225	Nonfiction	Spilled Milk: Based on a True Story	49.51	1	In stock	f
2412	duplicado	213	Nonfiction	Rise of the Rocket Girls: The Women Who Propelled Us, from Missiles to the Moon to Mars	41.67	4	In stock	f
2413	duplicado	204	Nonfiction	Outliers: The Story of Success	14.16	1	In stock	f
2414	duplicado	200	Nonfiction	Notes from a Small Island (Notes From a Small Island #1)	40.17	1	In stock	f
2415	duplicado	199	Nonfiction	Night (The Night Trilogy #1)	13.51	1	In stock	f
2416	duplicado	195	Nonfiction	Miracles from Heaven: A Little Girl, Her Journey to Heaven, and Her Amazing Story of Healing	57.83	1	In stock	f
2418	duplicado	185	Nonfiction	Let's Pretend This Never Happened: A Mostly True Memoir	45.11	1	In stock	f
2419	duplicado	179	Nonfiction	It's Never Too Late to Begin Again: Discovering Creativity and Meaning at Midlife and Beyond	42.38	1	In stock	f
2420	duplicado	177	Nonfiction	Into the Wild	56.70	5	In stock	f
2421	duplicado	175	Nonfiction	In the Garden of Beasts: Love, Terror, and an American Family in Hitler's Berlin	28.85	3	In stock	f
2422	duplicado	172	Nonfiction	I Am Malala: The Girl Who Stood Up for Education and Was Shot by the Taliban	28.88	2	In stock	f
2423	duplicado	163	Nonfiction	Gratitude	26.66	5	In stock	f
2424	duplicado	148	Nonfiction	Disrupted: My Misadventure in the Start-Up Bubble	15.28	5	In stock	f
2425	duplicado	135	Nonfiction	Brave Enough	51.32	5	In stock	f
2426	duplicado	133	Nonfiction	Born to Run: A Hidden Tribe, Superathletes, and the Greatest Race the World Has Never Seen	27.35	2	In stock	f
2427	duplicado	132	Nonfiction	Blink: The Power of Thinking Without Thinking	21.74	5	In stock	f
2428	duplicado	131	Nonfiction	Black Flags: The Rise of ISIS	40.87	1	In stock	f
2429	duplicado	121	Nonfiction	Are We Smart Enough to Know How Smart Animals Are?	56.58	1	In stock	f
2430	duplicado	118	Nonfiction	A Walk in the Woods: Rediscovering America on the Appalachian Trail	30.48	4	In stock	f
2431	duplicado	112	Nonfiction	The Suffragettes (Little Black Classics, #96)	11.89	2	In stock	f
2432	duplicado	103	Nonfiction	Kindle Paperwhite User's Guide	34.00	3	In stock	f
2433	duplicado	102	Nonfiction	H is for Hawk	57.42	5	In stock	f
2434	duplicado	90	Nonfiction	Travels with Charley: In Search of America	57.82	5	In stock	f
2435	duplicado	85	Nonfiction	The Tumor	41.56	5	In stock	f
2436	duplicado	64	Nonfiction	The End of the Jesus Era (An Investigation #1)	14.40	1	In stock	f
2437	duplicado	16	Nonfiction	Eat, Pray, Love	51.32	3	In stock	f
2438	duplicado	986	Music	Rip it Up and Start Again	35.02	5	In stock	f
2439	duplicado	985	Music	Our Band Could Be Your Life: Scenes from the American Indie Underground, 1981-1991	57.25	3	In stock	f
2440	duplicado	979	Music	How Music Works	37.32	2	In stock	f
2441	duplicado	711	Music	Love Is a Mix Tape (Music #1)	18.03	1	In stock	f
2442	duplicado	537	Music	Please Kill Me: The Uncensored Oral History of Punk	31.19	4	In stock	f
2443	duplicado	528	Music	Kill 'Em and Leave: Searching for James Brown and the American Soul	45.05	5	In stock	f
2444	duplicado	462	Music	Chronicles, Vol. 1	52.60	2	In stock	f
2445	duplicado	414	Music	This Is Your Brain on Music: The Science of a Human Obsession	38.40	1	In stock	f
2446	duplicado	337	Music	Orchestra of Exiles: The Story of Bronislaw Huberman, the Israel Philharmonic, and the One Thousand Jews He Saved from Nazi Horrors	12.36	3	In stock	f
2447	duplicado	336	Music	No One Here Gets Out Alive	20.02	5	In stock	f
2448	duplicado	104	Music	Life	31.58	5	In stock	f
2449	duplicado	39	Music	Old Records Never Die: One Man's Quest for His Vinyl and His Past	55.66	2	In stock	f
2450	duplicado	19	Music	Forever Rockers (The Rocker #12)	28.80	3	In stock	f
2451	duplicado	993	Default	The Coming Woman: A Novel Based on the Life of the Infamous Feminist, Victoria Woodhull	17.93	3	In stock	f
2452	duplicado	992	Default	The Boys in the Boat: Nine Americans and Their Epic Quest for Gold at the 1936 Berlin Olympics	22.60	4	In stock	f
2453	duplicado	990	Default	Starving Hearts (Triangular Trade Trilogy, #1)	13.99	2	In stock	f
2454	duplicado	974	Default	America's Cradle of Quarterbacks: Western Pennsylvania's Football Factory from Johnny Unitas to Joe Montana	22.50	3	In stock	f
2455	duplicado	973	Default	Aladdin and His Wonderful Lamp	53.13	3	In stock	f
2456	duplicado	965	Default	Penny Maybe	33.29	3	In stock	f
2457	duplicado	964	Default	Maude (1883-1993):She Grew Up with the country	18.02	2	In stock	f
2458	duplicado	935	Default	The Inefficiency Assassin: Time Management Tactics for Working Smarter, Not Longer	20.59	5	In stock	f
2459	duplicado	926	Default	Soul Reader	39.58	2	In stock	f
2460	duplicado	883	Default	Bossypants	49.46	2	In stock	f
2461	duplicado	879	Default	A World of Flavor: Your Gluten Free Passport	42.95	1	In stock	f
2462	duplicado	878	Default	A Piece of Sky, a Grain of Rice: A Memoir in Four Meditations	56.76	5	In stock	f
2463	duplicado	869	Default	Tracing Numbers on a Train	41.60	3	In stock	f
2464	duplicado	866	Default	Thirteen Reasons Why	52.72	1	In stock	f
2465	duplicado	859	Default	The Secret (The Secret #1)	27.37	4	In stock	f
2466	duplicado	857	Default	The Psychopath Test: A Journey Through the Madness Industry	36.00	2	In stock	f
2467	duplicado	847	Default	The Kite Runner	41.82	4	In stock	f
2468	duplicado	844	Default	The Girl on the Train	55.02	2	In stock	f
2469	duplicado	842	Default	The Emerald Mystery	23.15	2	In stock	f
2470	duplicado	840	Default	The Bridge to Consciousness: I'm Writing the Bridge Between Science and Our Old and New Beliefs.	32.00	3	In stock	f
2471	duplicado	838	Default	The Art of War	33.34	5	In stock	f
2472	duplicado	829	Default	Secrets and Lace (Fatal Hearts #1)	20.27	1	In stock	f
2473	duplicado	827	Default	Romero and Juliet: A Tragic Tale of Love and Zombies	36.94	1	In stock	f
2474	duplicado	825	Default	Poses for Artists Volume 1 - Dynamic and Sitting Poses: An Essential Reference for Figure Drawing and the Human Form	41.06	1	In stock	f
2475	duplicado	819	Default	Miss Peregrine’s Home for Peculiar Children (Miss Peregrine’s Peculiar Children #1)	10.76	1	In stock	f
2476	duplicado	815	Default	Large Print Heart of the Pride	19.15	2	In stock	f
2477	duplicado	812	Default	Grumbles	22.16	2	In stock	f
2478	duplicado	808	Default	First Steps for New Christians (Print Edition)	29.00	1	In stock	f
2479	duplicado	805	Default	Eureka Trivia 6.0	54.59	4	In stock	f
2480	duplicado	804	Default	Drive: The Surprising Truth About What Motivates Us	34.95	4	In stock	f
2481	duplicado	803	Default	Done Rubbed Out (Reightman & Bailey #1)	37.72	5	In stock	f
2482	duplicado	794	Default	Beauty Restored (Riley Family Legacy Novellas #3)	11.11	2	In stock	f
2483	duplicado	791	Default	Ayumi's Violin	15.48	2	In stock	f
2484	duplicado	790	Default	Anonymous	46.82	4	In stock	f
2485	duplicado	789	Default	Amy Meets the Saints and Sages	18.46	3	In stock	f
2486	duplicado	787	Default	Amatus	50.54	5	In stock	f
2487	duplicado	776	Default	V for Vendetta (V for Vendetta Complete)	37.10	4	In stock	f
2488	duplicado	774	Default	Unbroken: A World War II Story of Survival, Resilience, and Redemption	45.95	2	In stock	f
2489	duplicado	769	Default	The Wright Brothers	56.80	4	In stock	f
2490	duplicado	763	Default	The Songs of the Gods	44.48	5	In stock	f
2491	duplicado	761	Default	The Rosie Project (Don Tillman #1)	54.04	1	In stock	f
2492	duplicado	760	Default	The Power of Habit: Why We Do What We Do in Life and Business	16.88	3	In stock	f
2493	duplicado	737	Default	Steve Jobs	39.50	5	In stock	f
2494	duplicado	713	Default	Luckiest Girl Alive	49.83	3	In stock	f
2495	duplicado	709	Default	Living Leadership by Insight: A Good Leader Achieves, a Great Leader Builds Monuments	46.91	4	In stock	f
2496	duplicado	707	Default	Lady Midnight (The Dark Artifices #1)	16.28	5	In stock	f
2497	duplicado	701	Default	Hush, Hush (Hush, Hush #1)	47.02	3	In stock	f
2498	duplicado	698	Default	Greek Mythic History	10.23	5	In stock	f
2499	duplicado	693	Default	Every Last Word	46.47	3	In stock	f
2500	duplicado	683	Default	Daily Fantasy Sports	36.58	1	In stock	f
2501	duplicado	679	Default	Clockwork Angel (The Infernal Devices #1)	44.14	1	In stock	f
2502	duplicado	677	Default	City of Fallen Angels (The Mortal Instruments #4)	11.23	4	In stock	f
2503	duplicado	676	Default	City of Bones (The Mortal Instruments #1)	43.28	1	In stock	f
2504	duplicado	675	Default	City of Ashes (The Mortal Instruments #2)	47.27	1	In stock	f
2505	duplicado	672	Default	Carry On, Warrior: Thoughts on Life Unarmed	31.85	3	In stock	f
2506	duplicado	671	Default	Carrie	46.23	2	In stock	f
2507	duplicado	661	Default	Angels & Demons (Robert Langdon #1)	51.48	3	In stock	f
2508	duplicado	649	Default	The Three Searches, Meaning, and the Story	13.33	3	In stock	f
2509	duplicado	630	Default	Raspberry Pi Electronics Projects for the Evil Genius	49.67	4	In stock	f
2510	duplicado	621	Default	How to Speak Golf: An Illustrated Guide to Links Lingo	58.32	5	In stock	f
2511	duplicado	616	Default	Eleanor & Park	56.51	5	In stock	f
2512	duplicado	610	Default	Troublemaker: Surviving Hollywood and Scientology	48.39	2	In stock	f
2513	duplicado	586	Default	Adultery	20.88	5	In stock	f
2514	duplicado	578	Default	Unlimited Intuition Now	58.87	4	In stock	f
2515	duplicado	577	Default	Underlying Notes	11.82	2	In stock	f
2516	duplicado	575	Default	The New Brand You: Your New Image Makes the Sale for You	44.05	5	In stock	f
2517	duplicado	573	Default	The Flowers Lied	16.68	2	In stock	f
2518	duplicado	566	Default	NaNo What Now? Finding your editing process, revising your NaNoWriMo book and building a writing career through publishing and beyond	10.41	4	In stock	f
2519	duplicado	565	Default	Modern Day Fables	47.44	2	In stock	f
2520	duplicado	551	Default	The Unlikely Pilgrimage of Harold Fry (Harold Fry #1)	43.62	5	In stock	f
2521	duplicado	548	Default	The Martian (The Martian #1)	41.39	2	In stock	f
2522	duplicado	529	Default	Left Behind (Left Behind #1)	40.72	2	In stock	f
2523	duplicado	526	Default	John Vassos: Industrial Design for Modern Life	20.22	4	In stock	f
2524	duplicado	525	Default	I'll Give You the Sun	56.48	1	In stock	f
2525	duplicado	520	Default	Heaven is for Real: A Little Boy's Astounding Story of His Trip to Heaven and Back	52.86	2	In stock	f
2526	duplicado	518	Default	Ender's Game (The Ender Quintet #1)	43.64	1	In stock	f
2527	duplicado	516	Default	Death by Leisure: A Cautionary Tale	37.51	4	In stock	f
2528	duplicado	507	Default	Wildlife of New York: A Five-Borough Coloring Book	22.14	2	In stock	f
2529	duplicado	502	Default	The Year of Living Biblically: One Man's Humble Quest to Follow the Bible as Literally as Possible	34.72	1	In stock	f
2530	duplicado	498	Default	The Great Gatsby	36.05	4	In stock	f
2531	duplicado	497	Default	The Good Girl	49.03	3	In stock	f
2532	duplicado	489	Default	The 7 Habits of Highly Effective People: Powerful Lessons in Personal Change	33.17	4	In stock	f
2533	duplicado	487	Default	Steal Like an Artist: 10 Things Nobody Told You About Being Creative	20.90	2	In stock	f
2534	duplicado	475	Default	Life of Pi	13.22	4	In stock	f
2535	duplicado	455	Default	The Sound Of Love	57.84	5	In stock	f
2536	duplicado	453	Default	The Perks of Being a Wallflower	55.02	3	In stock	f
2537	duplicado	450	Default	The Makings of a Fatherless Child	31.58	2	In stock	f
2538	duplicado	447	Default	The Hobbit (Middle-Earth Universe)	17.80	5	In stock	f
2539	duplicado	442	Default	The Fellowship of the Ring (The Lord of the Rings #1)	10.27	2	In stock	f
2540	duplicado	438	Default	Ship Leaves Harbor: Essays on Travel by a Recovering Journeyman	30.60	3	In stock	f
2541	duplicado	436	Default	Musicophilia: Tales of Music and the Brain	46.58	1	In stock	f
2542	duplicado	416	Default	What If?: Serious Scientific Answers to Absurd Hypothetical Questions	53.68	4	In stock	f
2543	duplicado	403	Default	The Fault in Our Stars	47.22	1	In stock	f
2544	duplicado	400	Default	The Dream Thieves (The Raven Cycle #2)	34.50	1	In stock	f
2545	duplicado	397	Default	The 5th Wave (The 5th Wave #1)	11.83	2	In stock	f
2546	duplicado	392	Default	Shiver (The Wolves of Mercy Falls #1)	16.23	5	In stock	f
2547	duplicado	391	Default	Remember Me?	11.48	3	In stock	f
2548	duplicado	379	Default	If I Stay (If I Stay #1)	38.13	5	In stock	f
2549	duplicado	378	Default	I Know Why the Caged Bird Sings (Maya Angelou's Autobiography #1)	36.55	2	In stock	f
2550	duplicado	377	Default	Harry Potter and the Deathly Hallows (Harry Potter #7)	23.32	1	In stock	f
2551	duplicado	374	Default	Fool Me Once	16.96	1	In stock	f
2552	duplicado	371	Default	Drama	38.70	2	In stock	f
2553	duplicado	364	Default	Blue Lily, Lily Blue (The Raven Cycle #3)	34.13	5	In stock	f
2554	duplicado	360	Default	Alight (The Generations Trilogy #2)	58.59	4	In stock	f
2555	duplicado	355	Default	Vogue Colors A to Z: A Fashion Coloring Book	52.35	4	In stock	f
2556	duplicado	354	Default	The Shining (The Shining #1)	27.88	3	In stock	f
2557	duplicado	349	Default	The Hunger Games (The Hunger Games #1)	29.85	5	In stock	f
2558	duplicado	338	Default	Outlander (Outlander #1)	19.67	5	In stock	f
2559	duplicado	333	Default	Mockingjay (The Hunger Games #3)	20.44	4	In stock	f
2560	duplicado	329	Default	Harry Potter and the Sorcerer's Stone (Harry Potter #1)	13.90	3	In stock	f
2561	duplicado	318	Default	Confessions of a Shopaholic (Shopaholic #1)	48.94	2	In stock	f
2562	duplicado	308	Default	Zero History (Blue Ant #3)	34.77	1	In stock	f
2563	duplicado	306	Default	World War Z: An Oral History of the Zombie War	21.80	1	In stock	f
2564	duplicado	305	Default	Wild: From Lost to Found on the Pacific Crest Trail	46.02	3	In stock	f
2565	duplicado	304	Default	Where'd You Go, Bernadette	18.13	1	In stock	f
2566	duplicado	293	Default	Twilight (Twilight #1)	41.93	2	In stock	f
2567	duplicado	269	Default	The Paris Wife	36.80	3	In stock	f
2568	duplicado	263	Default	The Maze Runner (The Maze Runner #1)	20.93	1	In stock	f
2569	duplicado	262	Default	The Lover's Dictionary	58.09	2	In stock	f
2570	duplicado	252	Default	The Goldfinch	43.58	3	In stock	f
2571	duplicado	251	Default	The Giver (The Giver Quartet #1)	12.30	1	In stock	f
2572	duplicado	249	Default	The Girl Who Played with Fire (Millennium Trilogy #2)	22.14	2	In stock	f
2573	duplicado	242	Default	The Demon-Haunted World: Science as a Candle in the Dark	52.25	4	In stock	f
2574	duplicado	233	Default	The Book Thief	53.49	2	In stock	f
2575	duplicado	230	Default	The Autobiography of Malcolm X	23.43	2	In stock	f
2576	duplicado	221	Default	Shopaholic & Baby (Shopaholic #5)	46.45	2	In stock	f
2577	duplicado	208	Default	Quiet: The Power of Introverts in a World That Can't Stop Talking	43.55	1	In stock	f
2578	duplicado	205	Default	Packing for Mars: The Curious Science of Life in the Void	56.68	2	In stock	f
2579	duplicado	202	Default	Orange Is the New Black	24.61	2	In stock	f
2580	duplicado	201	Default	One for the Money (Stephanie Plum #1)	32.87	2	In stock	f
2581	duplicado	196	Default	Morning Star (Red Rising #3)	29.40	1	In stock	f
2582	duplicado	187	Default	Life After Life	26.13	2	In stock	f
2583	duplicado	183	Default	Lean In: Women, Work, and the Will to Lead	25.02	1	In stock	f
2584	duplicado	178	Default	Is Everyone Hanging Out Without Me? (And Other Concerns)	20.11	3	In stock	f
2585	duplicado	162	Default	Gone Girl	37.60	5	In stock	f
2586	duplicado	155	Default	Fellside	38.62	1	In stock	f
2587	duplicado	152	Default	Eclipse (Twilight #3)	18.74	1	In stock	f
2588	duplicado	150	Default	Dracula	52.62	3	In stock	f
2589	duplicado	147	Default	Dead Wake: The Last Crossing of the Lusitania	39.24	5	In stock	f
2590	duplicado	146	Default	David and Goliath: Underdogs, Misfits, and the Art of Battling Giants	17.81	1	In stock	f
2591	duplicado	144	Default	Dark Places	23.90	5	In stock	f
2592	duplicado	136	Default	Breaking Dawn (Twilight #4)	35.28	5	In stock	f
2593	duplicado	125	Default	Beautiful Creatures (Caster Chronicles #1)	21.55	5	In stock	f
2594	duplicado	117	Default	A Visit from the Goon Squad	14.08	5	In stock	f
2595	duplicado	87	Default	The Zombie Room	19.69	5	In stock	f
2596	duplicado	74	Default	The Name of the Wind (The Kingkiller Chronicle #1)	50.59	3	In stock	f
2597	duplicado	57	Default	Taking Shots (Assassins #1)	18.88	2	In stock	f
2598	duplicado	53	Default	Shatter Me (Shatter Me #1)	42.40	1	In stock	f
2599	duplicado	45	Default	Paradise Lost (Paradise #1)	24.96	1	In stock	f
2600	duplicado	40	Default	On the Road (Duluoz Legend)	32.36	3	In stock	f
2601	duplicado	27	Default	Jane Eyre	38.43	5	In stock	f
2602	duplicado	20	Default	Frankenstein	38.00	2	In stock	f
2603	duplicado	983	Science Fiction	Mesaerion: The Best Science Fiction Stories 1800-1849	37.59	1	In stock	f
2604	duplicado	902	Science Fiction	Join	35.67	5	In stock	f
2605	duplicado	871	Science Fiction	William Shakespeare's Star Wars: Verily, A New Hope (William Shakespeare's Star Wars #4)	43.30	4	In stock	f
2606	duplicado	856	Science Fiction	The Project	10.65	1	In stock	f
2607	duplicado	833	Science Fiction	Soft Apocalypse	26.12	2	In stock	f
2608	duplicado	604	Science Fiction	Sleeping Giants (Themis Files #1)	48.74	1	In stock	f
2609	duplicado	587	Science Fiction	Arena	21.36	4	In stock	f
2610	duplicado	375	Science Fiction	Foundation (Foundation (Publication Order) #1)	32.42	1	In stock	f
2611	duplicado	275	Science Fiction	The Restaurant at the End of the Universe (Hitchhiker's Guide to the Galaxy #2)	10.92	1	In stock	f
2612	duplicado	209	Science Fiction	Ready Player One	19.07	4	In stock	f
2613	duplicado	189	Science Fiction	Life, the Universe and Everything (Hitchhiker's Guide to the Galaxy #3)	33.26	2	In stock	f
2614	duplicado	151	Science Fiction	Dune (Dune #1)	54.86	1	In stock	f
2615	duplicado	149	Science Fiction	Do Androids Dream of Electric Sheep? (Blade Runner #1)	51.48	1	In stock	f
2616	duplicado	89	Science Fiction	Three Wishes (River of Time: California #1)	44.18	2	In stock	f
2617	duplicado	70	Science Fiction	The Last Girl (The Dominion Trilogy #1)	36.26	2	In stock	f
2618	duplicado	23	Science Fiction	Having the Barbarian's Baby (Ice Planet Barbarians #7.5)	34.96	4	In stock	f
2619	duplicado	232	Sports and Games	The Book of Basketball: The NBA According to The Sports Guy	44.84	5	In stock	f
2620	duplicado	158	Sports and Games	Friday Night Lights: A Town, a Team, and a Dream	51.22	3	In stock	f
2621	duplicado	108	Sports and Games	Sugar Rush (Offensive Line #2)	24.42	1	In stock	f
2622	duplicado	50	Sports and Games	Settling the Score (The Summer Games #1)	44.91	2	In stock	f
2623	duplicado	25	Sports and Games	Icing (Aces Hockey #2)	40.44	4	In stock	f
2624	duplicado	945	Add a comment	The Torch Is Passed: A Harding Family Story	19.09	1	In stock	f
2625	duplicado	937	Add a comment	The Mindfulness and Acceptance Workbook for Anxiety: A Guide to Breaking Free from Anxiety, Phobias, and Worry Using Acceptance and Commitment Therapy	23.89	4	In stock	f
2626	duplicado	930	Add a comment	The Art Forger	40.76	3	In stock	f
2627	duplicado	912	Add a comment	On a Midnight Clear	14.07	3	In stock	f
2628	duplicado	903	Add a comment	Judo: Seven Steps to Black Belt (an Introductory Guide for Beginners)	53.90	2	In stock	f
2629	duplicado	830	Add a comment	Shobu Samurai, Project Aryoku (#3)	29.06	3	In stock	f
2630	duplicado	820	Add a comment	Modern Romance	28.26	5	In stock	f
2631	duplicado	768	Add a comment	The White Queen (The Cousins' War #1)	25.91	5	In stock	f
2632	duplicado	762	Add a comment	The Song of Achilles	37.40	5	In stock	f
2633	duplicado	753	Add a comment	The Immortal Life of Henrietta Lacks	40.67	2	In stock	f
2634	duplicado	748	Add a comment	The Dovekeepers	48.78	1	In stock	f
2635	duplicado	716	Add a comment	More Than Music (Chasing the Dream #1)	37.61	2	In stock	f
2636	duplicado	680	Add a comment	Code Name Verity (Code Name Verity #1)	22.13	4	In stock	f
2637	duplicado	674	Add a comment	Cell	20.29	4	In stock	f
2638	duplicado	662	Add a comment	Angels Walking (Angels Walking #1)	34.20	2	In stock	f
2639	duplicado	655	Add a comment	A Series of Catastrophes and Miracles: A True Story of Love, Science, and Cancer	56.48	2	In stock	f
2640	duplicado	654	Add a comment	A People's History of the United States	40.79	2	In stock	f
2641	duplicado	651	Add a comment	A Brush of Wings (Angels Walking #3)	55.51	1	In stock	f
2642	duplicado	647	Add a comment	Rook	37.86	4	In stock	f
2643	duplicado	640	Add a comment	The Midnight Watch: A Novel of the Titanic and the Californian	26.20	1	In stock	f
2644	duplicado	638	Add a comment	The Gray Rhino: How to Recognize and Act on the Obvious Dangers We Ignore	59.15	4	In stock	f
2645	duplicado	633	Add a comment	The Children	11.88	3	In stock	f
2646	duplicado	626	Add a comment	One with You (Crossfire #5)	15.71	4	In stock	f
2647	duplicado	580	Add a comment	Without Shame	48.27	5	In stock	f
2648	duplicado	579	Add a comment	Watchmen	58.05	4	In stock	f
2649	duplicado	557	Add a comment	A Hero's Curse (The Unseen Chronicles #1)	50.49	3	In stock	f
2650	duplicado	556	Add a comment	23 Degrees South: A Tropical Tale of Changing Whether...	35.79	2	In stock	f
2651	duplicado	496	Add a comment	The Glass Castle	16.24	1	In stock	f
2652	duplicado	494	Add a comment	The Drowning Girls	35.67	3	In stock	f
2653	duplicado	488	Add a comment	Team of Rivals: The Political Genius of Abraham Lincoln	20.12	5	In stock	f
2654	duplicado	472	Add a comment	John Adams	57.43	4	In stock	f
2655	duplicado	469	Add a comment	Good in Bed (Cannie Shapiro #1)	37.05	5	In stock	f
2656	duplicado	449	Add a comment	The Joy of Cooking	43.27	4	In stock	f
2657	duplicado	445	Add a comment	The Golden Compass (His Dark Materials #1)	18.77	1	In stock	f
2658	duplicado	444	Add a comment	The God Delusion	46.85	3	In stock	f
2659	duplicado	437	Add a comment	Pride and Prejudice	19.27	4	In stock	f
2660	duplicado	435	Add a comment	Mere Christianity	48.51	3	In stock	f
2661	duplicado	428	Add a comment	Fun Home: A Family Tragicomic	56.59	4	In stock	f
2662	duplicado	412	Add a comment	The Raven King (The Raven Cycle #4)	30.57	2	In stock	f
2663	duplicado	373	Add a comment	Find Her (Detective D.D. Warren #8)	22.37	1	In stock	f
2664	duplicado	372	Add a comment	Evicted: Poverty and Profit in the American City	42.27	1	In stock	f
2665	duplicado	358	Add a comment	A Game of Thrones (A Song of Ice and Fire #1)	46.42	2	In stock	f
2666	duplicado	356	Add a comment	A Clash of Kings (A Song of Ice and Fire #2)	10.79	3	In stock	f
2667	duplicado	284	Add a comment	The Tipping Point: How Little Things Can Make a Big Difference	10.02	2	In stock	f
2668	duplicado	274	Add a comment	The Rest Is Noise: Listening to the Twentieth Century	34.77	1	In stock	f
2669	duplicado	272	Add a comment	The Purpose Driven Life: What on Earth Am I Here for?	37.19	3	In stock	f
2670	duplicado	255	Add a comment	The Hitchhiker's Guide to the Galaxy (Hitchhiker's Guide to the Galaxy #1)	47.80	3	In stock	f
2671	duplicado	248	Add a comment	The Girl Who Kicked the Hornet's Nest (Millennium Trilogy #3)	57.48	1	In stock	f
2672	duplicado	246	Add a comment	The End of Faith: Religion, Terror, and the Future of Reason	22.13	4	In stock	f
2673	duplicado	237	Add a comment	The Complete Poems	41.32	5	In stock	f
2674	duplicado	236	Add a comment	The Catcher in the Rye	24.55	1	In stock	f
2675	duplicado	234	Add a comment	The Case for Christ (Cases for Christianity)	47.84	1	In stock	f
2676	duplicado	231	Add a comment	The Blind Side: Evolution of a Game	53.71	5	In stock	f
2677	duplicado	220	Add a comment	Seven Days in the Art World	52.33	2	In stock	f
2678	duplicado	217	Add a comment	Sarah's Key	46.29	1	In stock	f
2679	duplicado	214	Add a comment	Rogue Lawyer (Rogue Lawyer #1)	50.11	3	In stock	f
2680	duplicado	192	Add a comment	Manuscript Found in Accra	34.98	2	In stock	f
2681	duplicado	157	Add a comment	Fire Bound (Sea Haven/Sisters of the Heart #5)	21.28	4	In stock	f
2682	duplicado	141	Add a comment	Cosmos	36.17	2	In stock	f
2683	duplicado	113	Add a comment	#GIRLBOSS	50.96	1	In stock	f
2684	duplicado	111	Add a comment	The Sense of an Ending	31.38	3	In stock	f
2685	duplicado	78	Add a comment	The Republic	33.78	3	In stock	f
2686	duplicado	77	Add a comment	The Odyssey	29.64	3	In stock	f
2687	duplicado	71	Add a comment	The Light of the Fireflies	54.43	1	In stock	f
2688	duplicado	69	Add a comment	The Iliad	16.16	1	In stock	f
2689	duplicado	61	Add a comment	The Communist Manifesto	14.76	3	In stock	f
2690	duplicado	30	Add a comment	Lord of the Flies	24.89	3	In stock	f
2691	duplicado	951	Fantasy	Unicorn Tracks	18.78	3	In stock	f
2692	duplicado	924	Fantasy	Saga, Volume 6 (Saga (Collected Editions) #6)	25.02	3	In stock	f
2693	duplicado	919	Fantasy	Princess Between Worlds (Wide-Awake Princess #5)	13.34	5	In stock	f
2694	duplicado	909	Fantasy	Masks and Shadows	56.40	2	In stock	f
2695	duplicado	888	Fantasy	Crown of Midnight (Throne of Glass #2)	43.29	3	In stock	f
2696	duplicado	881	Fantasy	Avatar: The Last Airbender: Smoke and Shadow, Part 3 (Smoke and Shadow #3)	28.09	2	In stock	f
2697	duplicado	874	Fantasy	A Court of Thorns and Roses (A Court of Thorns and Roses #1)	52.37	1	In stock	f
2698	duplicado	868	Fantasy	Throne of Glass (Throne of Glass #1)	35.07	3	In stock	f
2699	duplicado	845	Fantasy	The Glittering Court (The Glittering Court #1)	44.28	1	In stock	f
2700	duplicado	813	Fantasy	Hollow City (Miss Peregrine’s Peculiar Children #2)	42.98	1	In stock	f
2701	duplicado	764	Fantasy	The Star-Touched Queen	46.02	5	In stock	f
2702	duplicado	752	Fantasy	The Hidden Oracle (The Trials of Apollo #1)	52.26	2	In stock	f
2703	duplicado	746	Fantasy	The Bane Chronicles (The Bane Chronicles #1-11)	44.73	4	In stock	f
2704	duplicado	705	Fantasy	Island of Dragons (Unwanteds #7)	29.65	1	In stock	f
2705	duplicado	685	Fantasy	Demigods & Magicians: Percy and Annabeth Meet the Kanes (Percy Jackson & Kane Chronicles Crossover #1-3)	37.51	5	In stock	f
2706	duplicado	678	Fantasy	City of Glass (The Mortal Instruments #3)	56.02	4	In stock	f
2707	duplicado	648	Fantasy	Searching for Meaning in Gailana	38.73	1	In stock	f
2708	duplicado	642	Fantasy	The Star-Touched Queen	32.30	5	In stock	f
2709	duplicado	558	Fantasy	A Shard of Ice (The Black Symphony Saga #1)	56.63	3	In stock	f
2710	duplicado	473	Fantasy	King's Folly (The Kinsman Chronicles #1)	39.61	5	In stock	f
2711	duplicado	465	Fantasy	Every Heart a Doorway (Every Heart A Doorway #1)	12.16	5	In stock	f
2712	duplicado	456	Fantasy	A Gathering of Shadows (Shades of Magic #2)	44.81	4	In stock	f
2713	duplicado	411	Fantasy	The Raven Boys (The Raven Cycle #1)	57.74	4	In stock	f
2714	duplicado	402	Fantasy	The False Prince (The Ascendance Trilogy #1)	56.00	5	In stock	f
2715	duplicado	396	Fantasy	Tell the Wind and Fire	45.51	3	In stock	f
2716	duplicado	357	Fantasy	A Feast for Crows (A Song of Ice and Fire #4)	17.21	4	In stock	f
2717	duplicado	345	Fantasy	The Demonists (Demonist #1)	52.11	2	In stock	f
2718	duplicado	342	Fantasy	The Beast (Black Dagger Brotherhood #14)	46.08	5	In stock	f
2719	duplicado	339	Fantasy	Paper and Fire (The Great Library #2)	49.45	5	In stock	f
2720	duplicado	327	Fantasy	Harry Potter and the Order of the Phoenix (Harry Potter #5)	31.63	4	In stock	f
2721	duplicado	326	Fantasy	Harry Potter and the Half-Blood Prince (Harry Potter #6)	48.75	5	In stock	f
2722	duplicado	325	Fantasy	Harry Potter and the Chamber of Secrets (Harry Potter #2)	14.74	1	In stock	f
2723	duplicado	278	Fantasy	The Rose & the Dagger (The Wrath and the Dawn #2)	58.64	4	In stock	f
2724	duplicado	222	Fantasy	Soldier (Talon #3)	24.72	2	In stock	f
2725	duplicado	194	Fantasy	Midnight Riot (Peter Grant/ Rivers of London - books #1)	55.46	2	In stock	f
2726	duplicado	166	Fantasy	Heir to the Sky	44.07	4	In stock	f
2727	duplicado	153	Fantasy	Eragon (The Inheritance Cycle #1)	43.87	3	In stock	f
2728	duplicado	145	Fantasy	Darkfever (Fever #1)	56.02	1	In stock	f
2729	duplicado	123	Fantasy	Ash	22.06	4	In stock	f
2730	duplicado	116	Fantasy	A Storm of Swords (A Song of Ice and Fire #3)	31.22	2	In stock	f
2731	duplicado	92	Fantasy	Vampire Girl (Vampire Girl #1)	53.82	2	In stock	f
2732	duplicado	82	Fantasy	The Silent Twin (Detective Jennifer Knight #3)	36.25	3	In stock	f
2733	duplicado	73	Fantasy	The Mirror & the Maze (The Wrath and the Dawn #1.5)	29.38	1	In stock	f
2734	duplicado	54	Fantasy	Sister Sable (The Mad Queen #1)	13.33	3	In stock	f
2735	duplicado	51	Fantasy	Shadow Rites (Jane Yellowrock #10)	21.72	4	In stock	f
2736	duplicado	42	Fantasy	Origins (Alphas 0.5)	28.99	1	In stock	f
2737	duplicado	41	Fantasy	One Second (Seven #7)	52.94	2	In stock	f
2738	duplicado	36	Fantasy	Myriad (Prentor #1)	58.75	4	In stock	f
2739	duplicado	956	New Adult	Without Borders (Wanderlove #1)	45.07	2	In stock	f
2740	duplicado	851	New Adult	The Mistake (Off-Campus #2)	43.29	3	In stock	f
2741	duplicado	850	New Adult	The Matchmaker's Playbook (Wingmen Inc. #1)	55.85	1	In stock	f
2742	duplicado	68	New Adult	The Hook Up (Game On #1)	36.29	5	In stock	f
2743	duplicado	52	New Adult	Shameless	58.35	3	In stock	f
2744	duplicado	38	New Adult	Off Sides (Off #1)	39.45	5	In stock	f
2745	duplicado	995	Young Adult	The Requiem Red	22.65	1	In stock	f
2746	duplicado	988	Young Adult	Set Me Free	17.46	5	In stock	f
2747	duplicado	941	Young Adult	The Natural History of Us (The Fine Art of Pretending #2)	45.22	3	In stock	f
2748	duplicado	911	Young Adult	Obsidian (Lux #1)	14.86	2	In stock	f
2749	duplicado	884	Young Adult	Burning	28.81	3	In stock	f
2750	duplicado	875	Young Adult	A Fierce and Subtle Poison	28.13	4	In stock	f
2751	duplicado	828	Young Adult	Scarlett Epstein Hates It Here	43.55	5	In stock	f
2752	duplicado	823	Young Adult	Nightingale, Sing	38.28	1	In stock	f
2753	duplicado	816	Young Adult	Library of Souls (Miss Peregrine’s Peculiar Children #3)	48.56	5	In stock	f
2754	duplicado	810	Young Adult	Frostbite (Vampire Academy #2)	29.99	5	In stock	f
2755	duplicado	782	Young Adult	Wild Swans	14.36	2	In stock	f
2756	duplicado	775	Young Adult	Until Friday Night (The Field Party #1)	46.31	2	In stock	f
2757	duplicado	771	Young Adult	This Is Where It Ends	27.12	2	In stock	f
2758	duplicado	747	Young Adult	The Darkest Lie	35.35	5	In stock	f
2759	duplicado	718	Young Adult	My Kind of Crazy	40.36	1	In stock	f
2760	duplicado	687	Young Adult	Don't Get Caught	55.35	1	In stock	f
2761	duplicado	673	Young Adult	Catching Jordan (Hundred Oaks)	50.83	3	In stock	f
2762	duplicado	663	Young Adult	Aristotle and Dante Discover the Secrets of the Universe (Aristotle and Dante Discover the Secrets of the Universe #1)	58.14	4	In stock	f
2763	duplicado	636	Young Adult	The Epidemic (The Program 0.6)	14.44	5	In stock	f
2764	duplicado	632	Young Adult	Stars Above (The Lunar Chronicles #4.5)	48.05	2	In stock	f
2765	duplicado	625	Young Adult	No Love Allowed (Dodge Cove #1)	54.65	4	In stock	f
2766	duplicado	591	Young Adult	Exit, Pursued by a Bear	51.34	4	In stock	f
2767	duplicado	569	Young Adult	The Alien Club	54.40	1	In stock	f
2768	duplicado	561	Young Adult	Don't Forget Steven	33.23	1	In stock	f
2769	duplicado	544	Young Adult	South of Sunshine	28.93	1	In stock	f
2770	duplicado	535	Young Adult	My Life Next Door (My Life Next Door )	36.39	5	In stock	f
2771	duplicado	519	Young Adult	Future Shock (Future Shock #1)	55.65	5	In stock	f
2772	duplicado	480	Young Adult	Nightstruck: A Novel	50.35	4	In stock	f
2773	duplicado	439	Young Adult	Tell the Wolves I'm Home	50.96	2	In stock	f
2774	duplicado	419	Young Adult	Will Grayson, Will Grayson (Will Grayson, Will Grayson)	47.31	4	In stock	f
2775	duplicado	417	Young Adult	Where She Went (If I Stay #2)	41.73	4	In stock	f
2776	duplicado	415	Young Adult	Two Summers	14.64	1	In stock	f
2777	duplicado	399	Young Adult	The Darkest Corners	11.33	5	In stock	f
2778	duplicado	395	Young Adult	Tell Me Three Things	41.81	1	In stock	f
2779	duplicado	385	Young Adult	Lola and the Boy Next Door (Anna and the French Kiss #2)	23.63	4	In stock	f
2780	duplicado	381	Young Adult	Kill the Boy Band	15.52	5	In stock	f
2781	duplicado	380	Young Adult	Isla and the Happily Ever After (Anna and the French Kiss #3)	48.13	5	In stock	f
2782	duplicado	362	Young Adult	An Abundance of Katherines	10.00	5	In stock	f
2783	duplicado	328	Young Adult	Harry Potter and the Prisoner of Azkaban (Harry Potter #3)	24.17	4	In stock	f
2784	duplicado	300	Young Adult	Walk the Edge (Thunder Road #2)	32.36	3	In stock	f
2785	duplicado	294	Young Adult	Two Boys Kissing	32.74	2	In stock	f
2786	duplicado	266	Young Adult	The New Guy (and Other Senior Year Distractions)	44.92	3	In stock	f
2787	duplicado	258	Young Adult	The Land of 10,000 Madonnas	29.64	4	In stock	f
2788	duplicado	218	Young Adult	Scarlet (The Lunar Chronicles #2)	14.57	4	In stock	f
2789	duplicado	184	Young Adult	Legend (Legend #1)	43.69	4	In stock	f
2790	duplicado	181	Young Adult	Lady Renegades (Rebel Belle #3)	53.04	5	In stock	f
2791	duplicado	161	Young Adult	Golden (Heart of Dread #3)	42.21	4	In stock	f
2792	duplicado	139	Young Adult	Cinder (The Lunar Chronicles #1)	26.09	1	In stock	f
2793	duplicado	134	Young Adult	Boy Meets Boy	21.12	3	In stock	f
2794	duplicado	120	Young Adult	Annie on My Mind	36.83	5	In stock	f
2795	duplicado	105	Young Adult	New Moon (Twilight #2)	12.86	4	In stock	f
2796	duplicado	101	Young Adult	Girl Online On Tour (Girl Online #2)	53.47	1	In stock	f
2797	duplicado	67	Young Adult	The Haters	27.89	5	In stock	f
2798	duplicado	58	Young Adult	The Art of Not Breathing	40.83	4	In stock	f
2799	duplicado	938	Science	The Most Perfect Thing: Inside (and Outside) a Bird's Egg	42.96	4	In stock	f
2800	duplicado	900	Science	Immunity: How Elie Metchnikoff Changed the Course of Modern Medicine	57.36	5	In stock	f
2801	duplicado	736	Science	Sorting the Beef from the Bull: The Science of Food Fraud Forensics	44.74	4	In stock	f
2802	duplicado	643	Science	Tipping Point for Planet Earth: How Close Are We to the Edge?	37.55	1	In stock	f
2803	duplicado	572	Science	The Fabric of the Cosmos: Space, Time, and the Texture of Reality	55.91	1	In stock	f
2804	duplicado	517	Science	Diary of a Citizen Scientist: Chasing Tiger Beetles and Other New Ways of Engaging the World	28.41	1	In stock	f
2805	duplicado	499	Science	The Origin of Species	10.01	4	In stock	f
2806	duplicado	405	Science	The Grand Design	13.76	3	In stock	f
2807	duplicado	389	Science	Peak: Secrets from the New Science of Expertise	16.28	2	In stock	f
2808	duplicado	245	Science	The Elegant Universe: Superstrings, Hidden Dimensions, and the Quest for the Ultimate Theory	13.03	4	In stock	f
2809	duplicado	244	Science	The Disappearing Spoon: And Other True Tales of Madness, Love, and the History of the World from the Periodic Table of the Elements	57.35	5	In stock	f
2810	duplicado	227	Science	Surely You're Joking, Mr. Feynman!: Adventures of a Curious Character	25.83	2	In stock	f
2811	duplicado	219	Science	Seven Brief Lessons on Physics	30.60	4	In stock	f
2812	duplicado	81	Science	The Selfish Gene	29.45	1	In stock	f
2813	duplicado	1000	Poetry	A Light in the Attic	51.77	3	In stock	f
2814	duplicado	991	Poetry	The Black Maria	52.15	1	In stock	f
2815	duplicado	989	Poetry	Shakespeare's Sonnets	20.66	4	In stock	f
2816	duplicado	984	Poetry	Olio	23.88	1	In stock	f
2817	duplicado	961	Poetry	You can't bury them all: Poems	33.63	2	In stock	f
2818	duplicado	960	Poetry	Slow States of Collapse: Poems	57.31	3	In stock	f
2819	duplicado	953	Poetry	Untitled Collection: Sabbath Poems 2014	14.27	4	In stock	f
2820	duplicado	824	Poetry	Poems That Make Grown Women Cry	14.19	4	In stock	f
2821	duplicado	822	Poetry	Night Sky with Exit Wounds	41.05	1	In stock	f
2822	duplicado	731	Poetry	salt.	46.78	4	In stock	f
2823	duplicado	727	Poetry	Quarter Life Poetry: Poems for the Young, Broke and Hangry	50.89	5	In stock	f
2824	duplicado	536	Poetry	Out of Print: City Lights Spotlight No. 14	53.64	5	In stock	f
2825	duplicado	530	Poetry	Les Fleurs du Mal	29.04	5	In stock	f
2826	duplicado	530	Poetry	Les Fleurs du Mal	29.04	5	In stock	t
2827	duplicado	522	Poetry	Howl and Other Poems	40.45	2	In stock	f
2828	duplicado	474	Poetry	Leave This Song Behind: Teen Poetry at Its Best	51.17	5	In stock	f
2829	duplicado	441	Poetry	The Collected Poems of W.B. Yeats (The Collected Works of W.B. Yeats #1)	15.42	5	In stock	f
2830	duplicado	398	Poetry	The Crossover	38.77	4	In stock	f
2831	duplicado	365	Poetry	Booked	17.49	5	In stock	f
2832	duplicado	91	Poetry	Twenty Love Poems and a Song of Despair	30.95	4	In stock	f
2833	duplicado	93	Paranormal	Vampire Knight, Vol. 1 (Vampire Knight #1)	15.40	1	In stock	f
2834	duplicado	971	Art	Wall and Piece	44.18	4	In stock	f
2835	duplicado	695	Art	Feathers: Displays of Brilliant Plumage	49.05	3	In stock	f
2836	duplicado	559	Art	Art and Fear: Observations on the Perils (and Rewards) of Artmaking	48.63	4	In stock	f
2837	duplicado	550	Art	The New Drawing on the Right Side of the Brain	43.02	3	In stock	f
2838	duplicado	521	Art	History of Beauty	10.29	4	In stock	f
2839	duplicado	500	Art	The Story of Art	41.14	4	In stock	f
2840	duplicado	490	Art	The Art Book	32.34	2	In stock	f
2841	duplicado	94	Art	Ways of Seeing	39.51	5	In stock	f
2842	duplicado	758	Psychology	The Lucifer Effect: Understanding How Good People Turn Evil	10.40	1	In stock	f
2843	duplicado	637	Psychology	The Golden Condom: And Other Essays on Love Lost and Found	39.43	1	In stock	f
2844	duplicado	593	Psychology	It Didn't Start with You: How Inherited Family Trauma Shapes Who We Are and How to End the Cycle	56.27	3	In stock	f
2845	duplicado	422	Psychology	An Unquiet Mind: A Memoir of Moods and Madness	21.30	3	In stock	f
2846	duplicado	289	Psychology	Thinking, Fast and Slow	21.14	1	In stock	f
2847	duplicado	140	Psychology	Civilization and Its Discontents	59.95	2	In stock	f
2848	duplicado	114	Psychology	8 Keys to Mental Health Through Exercise	31.04	1	In stock	f
2849	duplicado	837	Autobiography	The Argonauts	10.93	2	In stock	f
2850	duplicado	598	Autobiography	M Train	27.18	1	In stock	f
2851	duplicado	595	Autobiography	Lab Girl	40.85	1	In stock	f
2852	duplicado	363	Autobiography	Approval Junkie: Adventures in Caring Too Much	58.81	5	In stock	f
2853	duplicado	215	Autobiography	Running with Scissors	12.91	4	In stock	f
2854	duplicado	193	Autobiography	Me Talk Pretty One Day	57.60	2	In stock	f
2855	duplicado	191	Autobiography	Lust & Wonder	11.87	2	In stock	f
2856	duplicado	188	Autobiography	Life Without a Recipe	59.04	5	In stock	f
2857	duplicado	115	Autobiography	A Heartbreaking Work of Staggering Genius	54.29	5	In stock	f
2858	duplicado	138	Parenting	Catastrophic Happiness: Finding Joy in Childhood's Messy Years	37.35	2	In stock	f
2859	duplicado	156	Adult Fiction	Fifty Shades Freed (Fifty Shades #3)	15.36	5	In stock	f
2860	duplicado	757	Humor	The Long Haul (Diary of a Wimpy Kid #9)	44.07	1	In stock	f
2861	duplicado	723	Humor	Old School (Diary of a Wimpy Kid #10)	11.83	5	In stock	f
2862	duplicado	704	Humor	I Know What I'm Doing -- and Other Lies I Tell Myself: Dispatches from a Life Under Construction	25.98	4	In stock	f
2863	duplicado	702	Humor	Hyperbole and a Half: Unfortunate Situations, Flawed Coping Mechanisms, Mayhem, and Other Things That Happened	14.75	5	In stock	f
2864	duplicado	562	Humor	Dress Your Family in Corduroy and Denim	43.68	3	In stock	f
2865	duplicado	503	Humor	Toddlers Are A**holes: It's Not Your Fault	25.55	1	In stock	f
2866	duplicado	303	Humor	When You Are Engulfed in Flames	30.89	5	In stock	f
2867	duplicado	197	Humor	Naked	31.69	3	In stock	f
2868	duplicado	182	Humor	Lamb: The Gospel According to Biff, Christ's Childhood Pal	55.50	5	In stock	f
2869	duplicado	167	Humor	Holidays on Ice	51.07	2	In stock	f
2870	duplicado	925	Horror	Security	39.25	2	In stock	f
2871	duplicado	809	Horror	Follow You Home	21.36	1	In stock	f
2872	duplicado	756	Horror	The Loney	23.40	1	In stock	f
2873	duplicado	726	Horror	Pet Sematary	10.56	3	In stock	f
2874	duplicado	686	Horror	Doctor Sleep (The Shining #2)	40.12	2	In stock	f
2875	duplicado	628	Horror	Psycho: Sanitarium (Psycho #1.5)	36.97	5	In stock	f
2876	duplicado	614	Horror	Can You Keep a Secret? (Fear Street Relaunch #4)	48.64	1	In stock	f
2877	duplicado	390	Horror	Red Dragon (Hannibal Lecter #1)	23.37	3	In stock	f
2878	duplicado	370	Horror	Dracula the Un-Dead	35.63	5	In stock	f
2879	duplicado	335	Horror	Night Shift (Night Shift #1-20)	12.75	4	In stock	f
2880	duplicado	334	Horror	Needful Things	47.51	4	In stock	f
2881	duplicado	332	Horror	Misery	34.79	2	In stock	f
2882	duplicado	330	Horror	It	25.01	3	In stock	f
2883	duplicado	309	Horror	'Salem's Lot	49.56	4	In stock	f
2884	duplicado	282	Horror	The Stand	57.86	2	In stock	f
2885	duplicado	250	Horror	The Girl with All the Gifts	49.47	3	In stock	f
2886	duplicado	169	Horror	House of Leaves	54.89	1	In stock	f
2887	duplicado	996	History	Sapiens: A Brief History of Humankind	54.23	5	In stock	f
2888	duplicado	950	History	Unbound: How Eight Technologies Made Us Human, Transformed Society, and Brought Our World to the Brink	25.52	1	In stock	f
2889	duplicado	929	History	The Age of Genius: The Seventeenth Century and the Birth of the Modern Mind	19.73	1	In stock	f
2890	duplicado	917	History	Political Suicide: Missteps, Peccadilloes, Bad Calls, Backroom Hijinx, Sordid Pasts, Rotten Breaks, and Just Plain Dumb Mistakes in the Annals of American Politics	36.28	2	In stock	f
2891	duplicado	867	History	Thomas Jefferson and the Tripoli Pirates: The Forgotten War That Changed American History	59.64	1	In stock	f
2892	duplicado	785	History	Zealot: The Life and Times of Jesus of Nazareth	24.70	3	In stock	f
2893	duplicado	652	History	A Distant Mirror: The Calamitous 14th Century	14.58	3	In stock	f
2894	duplicado	650	History	1491: New Revelations of the Americas Before Columbus	21.80	3	In stock	f
2895	duplicado	515	History	Brilliant Beacons: A History of the American Lighthouse	11.45	3	In stock	f
2896	duplicado	509	History	"Most Blessed of the Patriarchs": Thomas Jefferson and the Empire of the Imagination	44.48	5	In stock	f
2897	duplicado	457	History	A Short History of Nearly Everything	52.40	5	In stock	f
2898	duplicado	454	History	The Rise and Fall of the Third Reich: A History of Nazi Germany	39.67	2	In stock	f
2899	duplicado	424	History	Catherine the Great: Portrait of a Woman	58.55	4	In stock	f
2900	duplicado	408	History	The Mathews Men: Seven Brothers and the War Against Hitler's U-boats	42.91	5	In stock	f
2901	duplicado	406	History	The Hiding Place	55.91	4	In stock	f
2902	duplicado	361	History	America's War for the Greater Middle East: A Military History	51.22	2	In stock	f
2903	duplicado	254	History	The Guns of August	14.54	2	In stock	f
2904	duplicado	170	History	House of Lost Worlds: Dinosaurs, Dynasties, and the Story of Life on Earth	43.70	2	In stock	f
2905	duplicado	978	Food and Drink	Foolproof Preserving: A Guide to Small Batch Jams, Jellies, Pickles, Condiments, and More: A Foolproof Guide to Making Small Batch Jams, Jellies, Pickles, Condiments, and More	30.52	3	In stock	f
2906	duplicado	943	Food and Drink	The Pioneer Woman Cooks: Dinnertime: Comfort Classics, Freezer Food, 16-Minute Meals, and Other Delicious Ways to Solve Supper!	56.41	1	In stock	f
2907	duplicado	910	Food and Drink	My Paris Kitchen: Recipes and Stories	33.37	2	In stock	f
2908	duplicado	908	Food and Drink	Mama Tried: Traditional Italian Cooking for the Screwed, Crude, Vegan, and Tattooed	14.02	4	In stock	f
2909	duplicado	904	Food and Drink	Layered: Baking, Building, and Styling Spectacular Cakes	40.11	1	In stock	f
2910	duplicado	853	Food and Drink	The Nerdy Nummies Cookbook: Sweet Treats for the Geek in All of Us	37.34	5	In stock	f
2911	duplicado	849	Food and Drink	The Love and Lemons Cookbook: An Apple-to-Zucchini Celebration of Impromptu Cooking	37.60	2	In stock	f
2912	duplicado	841	Food and Drink	The Cookies & Cups Cookbook: 125+ sweet & savory recipes reminding you to Always Eat Dessert First	41.25	1	In stock	f
2913	duplicado	801	Food and Drink	Deliciously Ella Every Day: Quick and Easy Recipes for Gluten-Free Snacks, Packed Lunches, and Simple Meals	42.16	3	In stock	f
2914	duplicado	751	Food and Drink	The Help Yourself Cookbook for Kids: 60 Easy Plant-Based Recipes Kids Can Make to Stay Healthy and Save the Earth	28.77	3	In stock	f
2915	duplicado	706	Food and Drink	It's All Easy: Healthy, Delicious Weeknight Meals in under 30 Minutes	19.55	1	In stock	f
2916	duplicado	667	Food and Drink	Barefoot Contessa Back to Basics	28.01	1	In stock	f
2917	duplicado	666	Food and Drink	Barefoot Contessa at Home: Everyday Recipes You'll Make Over and Over Again	50.62	5	In stock	f
2918	duplicado	646	Food and Drink	My Kitchen Year: 136 Recipes That Saved My Life	11.53	2	In stock	f
2919	duplicado	618	Food and Drink	Everyday Italian: 125 Simple and Delicious Recipes	20.10	5	In stock	f
2920	duplicado	611	Food and Drink	A la Mode: 120 Recipes in 60 Pairings: Pies, Tarts, Cakes, Crisps, and More Topped with Ice Cream, Gelato, Frozen Custard, and More	38.77	1	In stock	f
2921	duplicado	589	Food and Drink	Cravings: Recipes for What You Want to Eat	20.50	3	In stock	f
2922	duplicado	574	Food and Drink	The Moosewood Cookbook: Recipes from Moosewood Restaurant, Ithaca, New York	12.34	4	In stock	f
2923	duplicado	510	Food and Drink	32 Yolks	53.63	2	In stock	f
2924	duplicado	479	Food and Drink	Naturally Lean: 125 Nourishing Gluten-Free, Plant-Based Recipes--All Under 300 Calories	11.38	5	In stock	f
2925	duplicado	471	Food and Drink	How to Cook Everything Vegetarian: Simple Meatless Recipes for Great Food (How to Cook Everything)	46.01	4	In stock	f
2926	duplicado	470	Food and Drink	How to Be a Domestic Goddess: Baking and the Art of Comfort Cooking	28.25	2	In stock	f
2927	duplicado	440	Food and Drink	The Barefoot Contessa Cookbook	59.92	5	In stock	f
2928	duplicado	423	Food and Drink	Better Homes and Gardens New Cook Book	39.61	3	In stock	f
2929	duplicado	410	Food and Drink	The Power Greens Cookbook: 140 Delicious Superfood Recipes	11.05	5	In stock	f
2930	duplicado	387	Food and Drink	Mexican Today: New and Rediscovered Recipes for Contemporary Kitchens	24.91	5	In stock	f
2931	duplicado	297	Food and Drink	Vegan Vegetarian Omnivore: Dinner for Everyone at the Table	13.66	2	In stock	f
2932	duplicado	281	Food and Drink	The Smitten Kitchen Cookbook	23.59	1	In stock	f
2933	duplicado	229	Food and Drink	The Art of Simple Food: Notes, Lessons, and Recipes from a Delicious Revolution	34.32	3	In stock	f
2934	duplicado	171	Food and Drink	Hungry Girl Clean & Hungry: Easy All-Natural Recipes for Healthy Eating in the Real World	33.14	3	In stock	f
2935	duplicado	826	Christian Fiction	Redeeming Love	20.47	5	In stock	f
2936	duplicado	798	Christian Fiction	Close to You	49.46	4	In stock	f
2937	duplicado	541	Christian Fiction	Shadows of the Past (Logan Point #1)	39.67	5	In stock	f
2938	duplicado	476	Christian Fiction	Like Never Before (Walker Family #2)	28.77	2	In stock	f
2939	duplicado	463	Christian Fiction	Counted With the Stars (Out from Egypt #1)	17.97	5	In stock	f
2940	duplicado	174	Christian Fiction	If I Run (If I Run #1)	49.97	4	In stock	f
2941	duplicado	994	Business	The Dirty Little Secrets of Getting Your Dream Job	33.34	4	In stock	f
2942	duplicado	862	Business	The Third Wave: An Entrepreneur’s Vision of the Future	12.61	5	In stock	f
2943	duplicado	836	Business	The 10% Entrepreneur: Live Your Startup Dream Without Quitting Your Day Job	27.55	3	In stock	f
2944	duplicado	831	Business	Shoe Dog: A Memoir by the Creator of NIKE	23.99	2	In stock	f
2945	duplicado	715	Business	Made to Stick: Why Some Ideas Survive and Others Die	38.85	5	In stock	f
2946	duplicado	629	Business	Quench Your Own Thirst: Business Lessons Learned Over a Beer or Two	43.14	1	In stock	f
2947	duplicado	606	Business	The Art of Startup Fundraising	21.00	3	In stock	f
2948	duplicado	588	Business	Born for This: How to Find the Work You Were Meant to Do	21.59	5	In stock	f
2949	duplicado	545	Business	The E-Myth Revisited: Why Most Small Businesses Don't Work and What to Do About It	36.91	1	In stock	f
2950	duplicado	483	Business	Rich Dad, Poor Dad	51.74	1	In stock	f
2951	duplicado	260	Business	The Lean Startup: How Today's Entrepreneurs Use Continuous Innovation to Create Radically Successful Businesses	33.92	3	In stock	f
2952	duplicado	212	Business	Rework	44.88	2	In stock	f
2953	duplicado	818	Biography	Louisa: The Extraordinary Life of Mrs. Adams	16.85	2	In stock	f
2954	duplicado	603	Biography	Setting the World on Fire: The Brief, Astonishing Life of St. Catherine of Siena	21.15	2	In stock	f
2955	duplicado	495	Biography	The Faith of Christopher Hitchens: The Restless Soul of the World's Most Notorious Atheist	39.55	1	In stock	f
2956	duplicado	460	Biography	Benjamin Franklin: An American Life	48.19	3	In stock	f
2957	duplicado	276	Biography	The Rise of Theodore Roosevelt (Theodore Roosevelt #1)	42.57	3	In stock	f
2958	duplicado	980	Thriller	In Her Wake	12.84	1	In stock	f
2959	duplicado	968	Thriller	The Elephant Tree	23.82	5	In stock	f
2960	duplicado	962	Thriller	Behind Closed Doors	52.22	4	In stock	f
2961	duplicado	784	Thriller	You (You #1)	43.61	5	In stock	f
2962	duplicado	750	Thriller	The Guilty (Will Robie #4)	13.82	2	In stock	f
2963	duplicado	744	Thriller	The 14th Colony (Cotton Malone #11)	39.24	1	In stock	f
2964	duplicado	430	Thriller	Give It Back	18.32	2	In stock	f
2965	duplicado	382	Thriller	Killing Floor (Jack Reacher #1)	31.49	4	In stock	f
2966	duplicado	343	Thriller	The Bone Hunters (Lexy Vaughan & Steven Macaulay #2)	59.71	3	In stock	f
2967	duplicado	320	Thriller	Far From True (Promise Falls Trilogy #2)	34.93	2	In stock	f
2968	duplicado	285	Thriller	The Travelers	15.77	1	In stock	f
2969	duplicado	955	Contemporary	When We Collided	31.77	1	In stock	f
2970	duplicado	735	Contemporary	Someone Like You (The Harrisons #2)	52.79	5	In stock	f
2971	duplicado	301	Contemporary	We Are All Completely Beside Ourselves	24.04	1	In stock	f
2972	duplicado	970	Spirituality	The Four Agreements: A Practical Guide to Personal Freedom	17.66	5	In stock	f
2973	duplicado	928	Spirituality	The Activist's Tao Te Ching: Ancient Advice for a Modern Revolution	32.24	5	In stock	f
2974	duplicado	797	Spirituality	Chasing Heaven: What Dying Taught Me About Living	37.80	2	In stock	f
2975	duplicado	564	Spirituality	If I Gave You God's Phone Number....: Searching for Spirituality in America	20.91	1	In stock	f
2976	duplicado	505	Spirituality	Unreasonable Hope: Finding Faith in the God Who Brings Purpose to Your Pain	46.33	2	In stock	f
2977	duplicado	311	Spirituality	A New Earth: Awakening to Your Life's Purpose	55.65	5	In stock	f
2978	duplicado	384	Academic	Logan Kade (Fallen Crest High #5.5)	13.12	2	In stock	f
2979	duplicado	913	Self Help	Online Marketing for Busy Authors: A Step-By-Step Guide	46.35	1	In stock	f
2980	duplicado	897	Self Help	How to Be Miserable: 40 Strategies You Already Use	46.03	1	In stock	f
2981	duplicado	725	Self Help	Overload: How to Unplug, Unwind, and Unleash Yourself from the Pressure of Stress	52.15	3	In stock	f
2982	duplicado	508	Self Help	You Are a Badass: How to Stop Doubting Your Greatness and Start Living an Awesome Life	12.08	3	In stock	f
2983	duplicado	431	Self Help	How to Stop Worrying and Start Living	46.49	5	In stock	f
2984	duplicado	660	Historical	All the Light We Cannot See	29.87	5	In stock	f
2985	duplicado	443	Historical	The Girl You Left Behind (The Girl You Left Behind #1)	15.79	1	In stock	f
2986	duplicado	873	Christian	(Un)Qualified: How God Uses Broken People to Do Big Things	54.00	5	In stock	f
2987	duplicado	682	Christian	Crazy Love: Overwhelmed by a Relentless God	47.72	2	In stock	f
2988	duplicado	461	Christian	Blue Like Jazz: Nonreligious Thoughts on Christian Spirituality	25.77	1	In stock	f
2989	duplicado	542	Suspense	Silence in the Dark (Logan Point #4)	58.33	3	In stock	f
2990	duplicado	546	Short Stories	The Grownup	35.88	1	In stock	f
2991	duplicado	568	Novels	Suzie Snowflake: One beautiful flake (a self-esteem story)	54.81	5	In stock	f
2992	duplicado	931	Health	The Bulletproof Diet: Lose up to a Pound a Day, Reclaim Energy and Focus, Upgrade Your Life	49.05	3	In stock	f
2993	duplicado	688	Health	Eat Fat, Get Thin	54.07	2	In stock	f
2994	duplicado	581	Health	10-Day Green Smoothie Cleanse: Lose Up to 15 Pounds in 10 Days!	49.71	5	In stock	f
2995	duplicado	570	Health	The Art and Science of Low Carbohydrate Living	52.98	5	In stock	f
2996	duplicado	982	Politics	Libertarianism for Beginners	51.33	2	In stock	f
2997	duplicado	781	Politics	Why the Right Went Wrong: Conservatism--From Goldwater to the Tea Party and Beyond	52.65	4	In stock	f
2998	duplicado	617	Politics	Equal Is Unfair: America's Misguided Fight Against Income Inequality	56.86	1	In stock	f
2999	duplicado	788	Cultural	Amid the Chaos	36.58	1	In stock	f
3000	duplicado	800	Erotica	Dark Notes	19.19	5	In stock	f
3001	duplicado	848	Crime	The Long Shadow of Small Ghosts: Murder and Memory in an American City	10.97	1	In stock	f
\.


--
-- Name: libros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.libros_id_seq', 3001, true);


--
-- Name: decision_categorias decision_categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.decision_categorias
    ADD CONSTRAINT decision_categorias_pkey PRIMARY KEY (escenario, categoria);


--
-- Name: libros libros_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libros
    ADD CONSTRAINT libros_pkey PRIMARY KEY (id);


--
-- Name: ix_libros_esc_cat; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_libros_esc_cat ON public.libros USING btree (escenario, categoria);


--
-- Name: libros libros_escenario_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.libros
    ADD CONSTRAINT libros_escenario_categoria_fkey FOREIGN KEY (escenario, categoria) REFERENCES public.decision_categorias(escenario, categoria);


--
-- PostgreSQL database dump complete
--

\unrestrict 3ib4Es5gPijQ0gJ0gWoPCbPdFvuhfkHX4o0qnzWXPr79YULCXchX7pbsk2l8PYa

