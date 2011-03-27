--
-- PostgreSQL database dump
--

-- Dumped from database version 9.0.2
-- Dumped by pg_dump version 9.0.2
-- Started on 2011-02-27 23:35:11

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 430 (class 2612 OID 11574)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

SET default_tablespace = saib;

SET default_with_oids = false;

--
-- TOC entry 1663 (class 1259 OID 27190)
-- Dependencies: 5
-- Name: animales; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE animales (
    id_ani integer NOT NULL,
    nom_ani character varying(20)
);


ALTER TABLE public.animales OWNER TO postgres;

--
-- TOC entry 1623 (class 1259 OID 27052)
-- Dependencies: 5 1663
-- Name: animales_id_ani_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE animales_id_ani_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.animales_id_ani_seq OWNER TO postgres;

--
-- TOC entry 2259 (class 0 OID 0)
-- Dependencies: 1623
-- Name: animales_id_ani_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE animales_id_ani_seq OWNED BY animales.id_ani;


--
-- TOC entry 2260 (class 0 OID 0)
-- Dependencies: 1623
-- Name: animales_id_ani_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('animales_id_ani_seq', 1, false);


--
-- TOC entry 1683 (class 1259 OID 27331)
-- Dependencies: 5
-- Name: antecedentes_pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE antecedentes_pacientes (
    id_ant_pac integer NOT NULL,
    id_ant_per integer NOT NULL,
    id_his integer NOT NULL,
    otr_ant_per character varying(20)
);


ALTER TABLE public.antecedentes_pacientes OWNER TO postgres;

--
-- TOC entry 1624 (class 1259 OID 27054)
-- Dependencies: 1683 5
-- Name: antecedentes_pacientes_id_ant_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE antecedentes_pacientes_id_ant_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antecedentes_pacientes_id_ant_pac_seq OWNER TO postgres;

--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 1624
-- Name: antecedentes_pacientes_id_ant_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE antecedentes_pacientes_id_ant_pac_seq OWNED BY antecedentes_pacientes.id_ant_pac;


--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 1624
-- Name: antecedentes_pacientes_id_ant_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('antecedentes_pacientes_id_ant_pac_seq', 1, false);


--
-- TOC entry 1664 (class 1259 OID 27196)
-- Dependencies: 5
-- Name: antecedentes_personales; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE antecedentes_personales (
    id_ant_per integer NOT NULL,
    nom_ant character varying(20)
);


ALTER TABLE public.antecedentes_personales OWNER TO postgres;

--
-- TOC entry 1622 (class 1259 OID 27050)
-- Dependencies: 1664 5
-- Name: antecedentes_personales_id_ant_per_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE antecedentes_personales_id_ant_per_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antecedentes_personales_id_ant_per_seq OWNER TO postgres;

--
-- TOC entry 2263 (class 0 OID 0)
-- Dependencies: 1622
-- Name: antecedentes_personales_id_ant_per_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE antecedentes_personales_id_ant_per_seq OWNED BY antecedentes_personales.id_ant_per;


--
-- TOC entry 2264 (class 0 OID 0)
-- Dependencies: 1622
-- Name: antecedentes_personales_id_ant_per_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('antecedentes_personales_id_ant_per_seq', 1, false);


--
-- TOC entry 1685 (class 1259 OID 27351)
-- Dependencies: 5
-- Name: auditoria_transacciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE auditoria_transacciones (
    id_aud_tra integer NOT NULL,
    fec_aud_tra timestamp without time zone,
    id_tip_usu_usu integer NOT NULL,
    id_tip_tra integer NOT NULL,
    id_mod integer NOT NULL
);


ALTER TABLE public.auditoria_transacciones OWNER TO postgres;

--
-- TOC entry 1684 (class 1259 OID 27349)
-- Dependencies: 1685 5
-- Name: auditoria_transacciones_id_aud_tra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auditoria_transacciones_id_aud_tra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditoria_transacciones_id_aud_tra_seq OWNER TO postgres;

--
-- TOC entry 2265 (class 0 OID 0)
-- Dependencies: 1684
-- Name: auditoria_transacciones_id_aud_tra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auditoria_transacciones_id_aud_tra_seq OWNED BY auditoria_transacciones.id_aud_tra;


--
-- TOC entry 2266 (class 0 OID 0)
-- Dependencies: 1684
-- Name: auditoria_transacciones_id_aud_tra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auditoria_transacciones_id_aud_tra_seq', 1, false);


--
-- TOC entry 1686 (class 1259 OID 27372)
-- Dependencies: 5
-- Name: categorias__cuerpos_micosis; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE categorias__cuerpos_micosis (
    id_cat_cue_mic integer NOT NULL,
    id_cat_cue integer NOT NULL,
    id_tip_mic integer NOT NULL
);


ALTER TABLE public.categorias__cuerpos_micosis OWNER TO postgres;

--
-- TOC entry 1625 (class 1259 OID 27056)
-- Dependencies: 5 1686
-- Name: categorias__cuerpos_micosis_id_cat_cue_mic_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categorias__cuerpos_micosis_id_cat_cue_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias__cuerpos_micosis_id_cat_cue_mic_seq OWNER TO postgres;

--
-- TOC entry 2267 (class 0 OID 0)
-- Dependencies: 1625
-- Name: categorias__cuerpos_micosis_id_cat_cue_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categorias__cuerpos_micosis_id_cat_cue_mic_seq OWNED BY categorias__cuerpos_micosis.id_cat_cue_mic;


--
-- TOC entry 2268 (class 0 OID 0)
-- Dependencies: 1625
-- Name: categorias__cuerpos_micosis_id_cat_cue_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categorias__cuerpos_micosis_id_cat_cue_mic_seq', 1, false);


--
-- TOC entry 1665 (class 1259 OID 27202)
-- Dependencies: 5
-- Name: categorias_cuerpos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE categorias_cuerpos (
    id_cat_cue integer NOT NULL,
    nom_cat_cue character varying(20)
);


ALTER TABLE public.categorias_cuerpos OWNER TO postgres;

--
-- TOC entry 1626 (class 1259 OID 27058)
-- Dependencies: 1665 5
-- Name: categorias_cuerpos_id_cat_cue_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categorias_cuerpos_id_cat_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_cuerpos_id_cat_cue_seq OWNER TO postgres;

--
-- TOC entry 2269 (class 0 OID 0)
-- Dependencies: 1626
-- Name: categorias_cuerpos_id_cat_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categorias_cuerpos_id_cat_cue_seq OWNED BY categorias_cuerpos.id_cat_cue;


--
-- TOC entry 2270 (class 0 OID 0)
-- Dependencies: 1626
-- Name: categorias_cuerpos_id_cat_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categorias_cuerpos_id_cat_cue_seq', 1, false);


--
-- TOC entry 1687 (class 1259 OID 27390)
-- Dependencies: 5
-- Name: categorias_cuerpos_partes_cuerpos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE categorias_cuerpos_partes_cuerpos (
    id_cat_cue_par_cue integer NOT NULL,
    id_par_cue integer NOT NULL,
    id_cat_cue integer NOT NULL
);


ALTER TABLE public.categorias_cuerpos_partes_cuerpos OWNER TO postgres;

--
-- TOC entry 1627 (class 1259 OID 27060)
-- Dependencies: 1687 5
-- Name: categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq OWNER TO postgres;

--
-- TOC entry 2271 (class 0 OID 0)
-- Dependencies: 1627
-- Name: categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq OWNED BY categorias_cuerpos_partes_cuerpos.id_cat_cue_par_cue;


--
-- TOC entry 2272 (class 0 OID 0)
-- Dependencies: 1627
-- Name: categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq', 1, false);


--
-- TOC entry 1666 (class 1259 OID 27208)
-- Dependencies: 5
-- Name: centro_salud; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE centro_salud (
    id_cen_sal integer NOT NULL,
    nom_cen_sal character varying(20) NOT NULL,
    des_cen_sal character varying(100)
);


ALTER TABLE public.centro_salud OWNER TO postgres;

--
-- TOC entry 1628 (class 1259 OID 27062)
-- Dependencies: 5 1666
-- Name: centro_salud_id_cen_sal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE centro_salud_id_cen_sal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.centro_salud_id_cen_sal_seq OWNER TO postgres;

--
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 1628
-- Name: centro_salud_id_cen_sal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE centro_salud_id_cen_sal_seq OWNED BY centro_salud.id_cen_sal;


--
-- TOC entry 2274 (class 0 OID 0)
-- Dependencies: 1628
-- Name: centro_salud_id_cen_sal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('centro_salud_id_cen_sal_seq', 1, false);


--
-- TOC entry 1688 (class 1259 OID 27408)
-- Dependencies: 5
-- Name: centro_salud_pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE centro_salud_pacientes (
    id_cen_sal_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_cen_sal integer NOT NULL,
    otr_cen_sal character varying(20)
);


ALTER TABLE public.centro_salud_pacientes OWNER TO postgres;

--
-- TOC entry 1629 (class 1259 OID 27064)
-- Dependencies: 1688 5
-- Name: centro_salud_pacientes_id_cen_sal_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE centro_salud_pacientes_id_cen_sal_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.centro_salud_pacientes_id_cen_sal_pac_seq OWNER TO postgres;

--
-- TOC entry 2275 (class 0 OID 0)
-- Dependencies: 1629
-- Name: centro_salud_pacientes_id_cen_sal_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE centro_salud_pacientes_id_cen_sal_pac_seq OWNED BY centro_salud_pacientes.id_cen_sal_pac;


--
-- TOC entry 2276 (class 0 OID 0)
-- Dependencies: 1629
-- Name: centro_salud_pacientes_id_cen_sal_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('centro_salud_pacientes_id_cen_sal_pac_seq', 1, false);


--
-- TOC entry 1668 (class 1259 OID 27216)
-- Dependencies: 5
-- Name: clinicas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE clinicas (
    id_cli integer NOT NULL,
    dir_cli character varying(200),
    nom_cli character varying(100)
);


ALTER TABLE public.clinicas OWNER TO postgres;

--
-- TOC entry 1690 (class 1259 OID 27428)
-- Dependencies: 5
-- Name: clinicas_doctores; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE clinicas_doctores (
    id_cli_doc integer NOT NULL,
    id_cli integer NOT NULL,
    id_doc integer NOT NULL
);


ALTER TABLE public.clinicas_doctores OWNER TO postgres;

--
-- TOC entry 1689 (class 1259 OID 27426)
-- Dependencies: 1690 5
-- Name: clinicas_doctores_id_cli_doc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE clinicas_doctores_id_cli_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clinicas_doctores_id_cli_doc_seq OWNER TO postgres;

--
-- TOC entry 2277 (class 0 OID 0)
-- Dependencies: 1689
-- Name: clinicas_doctores_id_cli_doc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE clinicas_doctores_id_cli_doc_seq OWNED BY clinicas_doctores.id_cli_doc;


--
-- TOC entry 2278 (class 0 OID 0)
-- Dependencies: 1689
-- Name: clinicas_doctores_id_cli_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('clinicas_doctores_id_cli_doc_seq', 1, false);


--
-- TOC entry 1667 (class 1259 OID 27214)
-- Dependencies: 5 1668
-- Name: clinicas_id_cli_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE clinicas_id_cli_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clinicas_id_cli_seq OWNER TO postgres;

--
-- TOC entry 2279 (class 0 OID 0)
-- Dependencies: 1667
-- Name: clinicas_id_cli_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE clinicas_id_cli_seq OWNED BY clinicas.id_cli;


--
-- TOC entry 2280 (class 0 OID 0)
-- Dependencies: 1667
-- Name: clinicas_id_cli_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('clinicas_id_cli_seq', 1, false);


--
-- TOC entry 1691 (class 1259 OID 27447)
-- Dependencies: 5
-- Name: contactos_animales; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE contactos_animales (
    id_con_ani integer NOT NULL,
    id_his integer NOT NULL,
    id_ani integer NOT NULL,
    otr_ani character varying(20)
);


ALTER TABLE public.contactos_animales OWNER TO postgres;

--
-- TOC entry 1630 (class 1259 OID 27066)
-- Dependencies: 1691 5
-- Name: contactos_animales_id_con_ani_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contactos_animales_id_con_ani_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contactos_animales_id_con_ani_seq OWNER TO postgres;

--
-- TOC entry 2281 (class 0 OID 0)
-- Dependencies: 1630
-- Name: contactos_animales_id_con_ani_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contactos_animales_id_con_ani_seq OWNED BY contactos_animales.id_con_ani;


--
-- TOC entry 2282 (class 0 OID 0)
-- Dependencies: 1630
-- Name: contactos_animales_id_con_ani_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('contactos_animales_id_con_ani_seq', 1, false);


--
-- TOC entry 1657 (class 1259 OID 27132)
-- Dependencies: 5
-- Name: doctores; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE doctores (
    id_doc integer NOT NULL,
    nom_doc character varying(100),
    ape_doc character varying(100),
    ced_doc character varying(20),
    log_dog character varying(100),
    pas_doc character varying(100),
    tef_doc character varying(100),
    cor_doc character varying(100),
    id_tip_usu integer NOT NULL
);


ALTER TABLE public.doctores OWNER TO postgres;

--
-- TOC entry 1656 (class 1259 OID 27130)
-- Dependencies: 1657 5
-- Name: doctores_id_doc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE doctores_id_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doctores_id_doc_seq OWNER TO postgres;

--
-- TOC entry 2283 (class 0 OID 0)
-- Dependencies: 1656
-- Name: doctores_id_doc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE doctores_id_doc_seq OWNED BY doctores.id_doc;


--
-- TOC entry 2284 (class 0 OID 0)
-- Dependencies: 1656
-- Name: doctores_id_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('doctores_id_doc_seq', 1, false);


--
-- TOC entry 1669 (class 1259 OID 27222)
-- Dependencies: 5
-- Name: enfermedades_micologicas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE enfermedades_micologicas (
    id_enf_mic integer NOT NULL,
    nom_enf_mic character varying(20) NOT NULL,
    id_tip_mic integer NOT NULL
);


ALTER TABLE public.enfermedades_micologicas OWNER TO postgres;

--
-- TOC entry 1631 (class 1259 OID 27068)
-- Dependencies: 5 1669
-- Name: enfermedades_micologicas_id_enf_mic_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE enfermedades_micologicas_id_enf_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enfermedades_micologicas_id_enf_mic_seq OWNER TO postgres;

--
-- TOC entry 2285 (class 0 OID 0)
-- Dependencies: 1631
-- Name: enfermedades_micologicas_id_enf_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE enfermedades_micologicas_id_enf_mic_seq OWNED BY enfermedades_micologicas.id_enf_mic;


--
-- TOC entry 2286 (class 0 OID 0)
-- Dependencies: 1631
-- Name: enfermedades_micologicas_id_enf_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('enfermedades_micologicas_id_enf_mic_seq', 1, false);


--
-- TOC entry 1692 (class 1259 OID 27465)
-- Dependencies: 5
-- Name: enfermedades_pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE enfermedades_pacientes (
    id_enf_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_enf_mic integer NOT NULL,
    otr_enf_mic character varying(20),
    esp_enf_mic character varying(20)
);


ALTER TABLE public.enfermedades_pacientes OWNER TO postgres;

--
-- TOC entry 1632 (class 1259 OID 27070)
-- Dependencies: 1692 5
-- Name: enfermedades_pacientes_id_enf_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE enfermedades_pacientes_id_enf_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enfermedades_pacientes_id_enf_pac_seq OWNER TO postgres;

--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 1632
-- Name: enfermedades_pacientes_id_enf_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE enfermedades_pacientes_id_enf_pac_seq OWNED BY enfermedades_pacientes.id_enf_pac;


--
-- TOC entry 2288 (class 0 OID 0)
-- Dependencies: 1632
-- Name: enfermedades_pacientes_id_enf_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('enfermedades_pacientes_id_enf_pac_seq', 1, false);


--
-- TOC entry 1693 (class 1259 OID 27483)
-- Dependencies: 5
-- Name: estudios_micologicos__pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE estudios_micologicos__pacientes (
    id_est_mic_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_pro_est_mic integer NOT NULL
);


ALTER TABLE public.estudios_micologicos__pacientes OWNER TO postgres;

--
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN estudios_micologicos__pacientes.id_est_mic_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN estudios_micologicos__pacientes.id_est_mic_pac IS 'Id estudio micologico del paciente';


--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN estudios_micologicos__pacientes.id_his; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN estudios_micologicos__pacientes.id_his IS 'Id historial el paciente';


--
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN estudios_micologicos__pacientes.id_pro_est_mic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN estudios_micologicos__pacientes.id_pro_est_mic IS 'Identificacion de las propiedades estudios micologicos';


--
-- TOC entry 1633 (class 1259 OID 27072)
-- Dependencies: 5 1693
-- Name: estudios_micologicos__pacientes_id_est_mic_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE estudios_micologicos__pacientes_id_est_mic_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estudios_micologicos__pacientes_id_est_mic_pac_seq OWNER TO postgres;

--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 1633
-- Name: estudios_micologicos__pacientes_id_est_mic_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estudios_micologicos__pacientes_id_est_mic_pac_seq OWNED BY estudios_micologicos__pacientes.id_est_mic_pac;


--
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 1633
-- Name: estudios_micologicos__pacientes_id_est_mic_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estudios_micologicos__pacientes_id_est_mic_pac_seq', 1, false);


--
-- TOC entry 1670 (class 1259 OID 27233)
-- Dependencies: 5
-- Name: forma_infecciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE forma_infecciones (
    id_for_inf integer NOT NULL,
    des_for_inf character varying(20)
);


ALTER TABLE public.forma_infecciones OWNER TO postgres;

--
-- TOC entry 1694 (class 1259 OID 27501)
-- Dependencies: 5
-- Name: forma_infecciones__pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE forma_infecciones__pacientes (
    id_for_pac integer NOT NULL,
    id_for_inf integer NOT NULL,
    id_his integer NOT NULL,
    otr_for_inf character varying(20)
);


ALTER TABLE public.forma_infecciones__pacientes OWNER TO postgres;

--
-- TOC entry 1635 (class 1259 OID 27076)
-- Dependencies: 5 1694
-- Name: forma_infecciones__pacientes_id_for_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE forma_infecciones__pacientes_id_for_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forma_infecciones__pacientes_id_for_pac_seq OWNER TO postgres;

--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 1635
-- Name: forma_infecciones__pacientes_id_for_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE forma_infecciones__pacientes_id_for_pac_seq OWNED BY forma_infecciones__pacientes.id_for_pac;


--
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 1635
-- Name: forma_infecciones__pacientes_id_for_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('forma_infecciones__pacientes_id_for_pac_seq', 1, false);


--
-- TOC entry 1695 (class 1259 OID 27519)
-- Dependencies: 5
-- Name: forma_infecciones__tipos_micosis; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE forma_infecciones__tipos_micosis (
    id_for_inf_tip_mic integer NOT NULL,
    id_tip_mic integer NOT NULL,
    id_for_inf integer NOT NULL
);


ALTER TABLE public.forma_infecciones__tipos_micosis OWNER TO postgres;

--
-- TOC entry 1636 (class 1259 OID 27078)
-- Dependencies: 5 1695
-- Name: forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq OWNER TO postgres;

--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 1636
-- Name: forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq OWNED BY forma_infecciones__tipos_micosis.id_for_inf_tip_mic;


--
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 1636
-- Name: forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq', 1, false);


--
-- TOC entry 1634 (class 1259 OID 27074)
-- Dependencies: 5 1670
-- Name: forma_infecciones_id_for_inf_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE forma_infecciones_id_for_inf_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forma_infecciones_id_for_inf_seq OWNER TO postgres;

--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 1634
-- Name: forma_infecciones_id_for_inf_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE forma_infecciones_id_for_inf_seq OWNED BY forma_infecciones.id_for_inf;


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 1634
-- Name: forma_infecciones_id_for_inf_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('forma_infecciones_id_for_inf_seq', 1, false);


--
-- TOC entry 1671 (class 1259 OID 27239)
-- Dependencies: 5
-- Name: historiales_pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE historiales_pacientes (
    id_his integer NOT NULL,
    id_pac integer NOT NULL,
    des_his character varying(20),
    num_his integer,
    nun_mic integer,
    fec_his date NOT NULL,
    nom_med character varying(20),
    ape_med character varying(20)
);


ALTER TABLE public.historiales_pacientes OWNER TO postgres;

--
-- TOC entry 1637 (class 1259 OID 27080)
-- Dependencies: 5 1671
-- Name: historiales_pacientes_id_his_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE historiales_pacientes_id_his_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historiales_pacientes_id_his_seq OWNER TO postgres;

--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 1637
-- Name: historiales_pacientes_id_his_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE historiales_pacientes_id_his_seq OWNED BY historiales_pacientes.id_his;


--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 1637
-- Name: historiales_pacientes_id_his_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historiales_pacientes_id_his_seq', 1, false);


--
-- TOC entry 1672 (class 1259 OID 27250)
-- Dependencies: 5
-- Name: lesiones__partes_cuerpos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE lesiones__partes_cuerpos (
    id_les_par_cue integer NOT NULL,
    nom_les_par_cue character varying(20),
    id_par_cue integer NOT NULL
);


ALTER TABLE public.lesiones__partes_cuerpos OWNER TO postgres;

--
-- TOC entry 1638 (class 1259 OID 27082)
-- Dependencies: 1672 5
-- Name: lesiones__partes_cuerpos_id_les_par_cue_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lesiones__partes_cuerpos_id_les_par_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesiones__partes_cuerpos_id_les_par_cue_seq OWNER TO postgres;

--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 1638
-- Name: lesiones__partes_cuerpos_id_les_par_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lesiones__partes_cuerpos_id_les_par_cue_seq OWNED BY lesiones__partes_cuerpos.id_les_par_cue;


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 1638
-- Name: lesiones__partes_cuerpos_id_les_par_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('lesiones__partes_cuerpos_id_les_par_cue_seq', 1, false);


--
-- TOC entry 1696 (class 1259 OID 27537)
-- Dependencies: 5
-- Name: lesiones_partes_cuerpos__pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE lesiones_partes_cuerpos__pacientes (
    id_les_par_cue_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_les_par_cue integer NOT NULL,
    otr_les_par_cue character varying(20)
);


ALTER TABLE public.lesiones_partes_cuerpos__pacientes OWNER TO postgres;

--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 1696
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac IS 'Leciones parted del cuerpo paciente';


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 1696
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.id_his; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.id_his IS 'Id de historial';


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 1696
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue IS 'Id lesiones partes del cuerpo del paciente';


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 1696
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.otr_les_par_cue; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.otr_les_par_cue IS 'Otras leciones de la parte del cuerpo del paciente';


--
-- TOC entry 1639 (class 1259 OID 27084)
-- Dependencies: 5 1696
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq OWNER TO postgres;

--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 1639
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq OWNED BY lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac;


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 1639
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq', 1, false);


--
-- TOC entry 1652 (class 1259 OID 27110)
-- Dependencies: 5
-- Name: localizaciones_cuerpos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE localizaciones_cuerpos (
    id_loc_cue integer NOT NULL,
    nom_loc_cue character varying(20) NOT NULL
);


ALTER TABLE public.localizaciones_cuerpos OWNER TO postgres;

--
-- TOC entry 1640 (class 1259 OID 27086)
-- Dependencies: 1652 5
-- Name: localizaciones_cuerpos_id_loc_cue_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE localizaciones_cuerpos_id_loc_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.localizaciones_cuerpos_id_loc_cue_seq OWNER TO postgres;

--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 1640
-- Name: localizaciones_cuerpos_id_loc_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE localizaciones_cuerpos_id_loc_cue_seq OWNED BY localizaciones_cuerpos.id_loc_cue;


--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 1640
-- Name: localizaciones_cuerpos_id_loc_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('localizaciones_cuerpos_id_loc_cue_seq', 1, false);


--
-- TOC entry 1698 (class 1259 OID 27557)
-- Dependencies: 5
-- Name: modulo_usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE modulo_usuarios (
    id_mod_usu integer NOT NULL,
    id_mod integer NOT NULL,
    id_tip_usu_usu integer NOT NULL
);


ALTER TABLE public.modulo_usuarios OWNER TO postgres;

--
-- TOC entry 1697 (class 1259 OID 27555)
-- Dependencies: 1698 5
-- Name: modulo_usuarios_id_mod_usu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE modulo_usuarios_id_mod_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modulo_usuarios_id_mod_usu_seq OWNER TO postgres;

--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 1697
-- Name: modulo_usuarios_id_mod_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE modulo_usuarios_id_mod_usu_seq OWNED BY modulo_usuarios.id_mod_usu;


--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 1697
-- Name: modulo_usuarios_id_mod_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('modulo_usuarios_id_mod_usu_seq', 1, false);


--
-- TOC entry 1674 (class 1259 OID 27263)
-- Dependencies: 5
-- Name: modulos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE modulos (
    id_mod integer NOT NULL,
    nom_mod character varying(100),
    des_mod character varying(100)
);


ALTER TABLE public.modulos OWNER TO postgres;

--
-- TOC entry 1673 (class 1259 OID 27261)
-- Dependencies: 1674 5
-- Name: modulos_id_mod_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE modulos_id_mod_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modulos_id_mod_seq OWNER TO postgres;

--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 1673
-- Name: modulos_id_mod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE modulos_id_mod_seq OWNED BY modulos.id_mod;


--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 1673
-- Name: modulos_id_mod_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('modulos_id_mod_seq', 1, false);


--
-- TOC entry 1675 (class 1259 OID 27269)
-- Dependencies: 5
-- Name: muestras_clinicas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE muestras_clinicas (
    id_mue_cli integer NOT NULL,
    nom_mue_cli character varying(20) NOT NULL
);


ALTER TABLE public.muestras_clinicas OWNER TO postgres;

--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 1675
-- Name: COLUMN muestras_clinicas.id_mue_cli; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN muestras_clinicas.id_mue_cli IS 'Identificacion de la muestra clinica';


--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 1675
-- Name: COLUMN muestras_clinicas.nom_mue_cli; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN muestras_clinicas.nom_mue_cli IS 'Nombre muestra clinica';


--
-- TOC entry 1641 (class 1259 OID 27088)
-- Dependencies: 5 1675
-- Name: muestras_clinicas_id_mue_cli_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE muestras_clinicas_id_mue_cli_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muestras_clinicas_id_mue_cli_seq OWNER TO postgres;

--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 1641
-- Name: muestras_clinicas_id_mue_cli_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE muestras_clinicas_id_mue_cli_seq OWNED BY muestras_clinicas.id_mue_cli;


--
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 1641
-- Name: muestras_clinicas_id_mue_cli_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('muestras_clinicas_id_mue_cli_seq', 1, false);


--
-- TOC entry 1699 (class 1259 OID 27575)
-- Dependencies: 5
-- Name: muestras_pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE muestras_pacientes (
    id_mue_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_mue_cli integer NOT NULL,
    otr_mue_cli character varying(20)
);


ALTER TABLE public.muestras_pacientes OWNER TO postgres;

--
-- TOC entry 2320 (class 0 OID 0)
-- Dependencies: 1699
-- Name: COLUMN muestras_pacientes.id_mue_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN muestras_pacientes.id_mue_pac IS 'Id de la meustra del paciente';


--
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 1699
-- Name: COLUMN muestras_pacientes.id_his; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN muestras_pacientes.id_his IS 'Id del historial';


--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 1699
-- Name: COLUMN muestras_pacientes.id_mue_cli; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN muestras_pacientes.id_mue_cli IS 'Id muestra cli';


--
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 1699
-- Name: COLUMN muestras_pacientes.otr_mue_cli; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN muestras_pacientes.otr_mue_cli IS 'Otra meustra clinica';


--
-- TOC entry 1642 (class 1259 OID 27090)
-- Dependencies: 5 1699
-- Name: muestras_pacientes_id_mue_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE muestras_pacientes_id_mue_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muestras_pacientes_id_mue_pac_seq OWNER TO postgres;

--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 1642
-- Name: muestras_pacientes_id_mue_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE muestras_pacientes_id_mue_pac_seq OWNED BY muestras_pacientes.id_mue_pac;


--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 1642
-- Name: muestras_pacientes_id_mue_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('muestras_pacientes_id_mue_pac_seq', 1, false);


--
-- TOC entry 1658 (class 1259 OID 27146)
-- Dependencies: 5
-- Name: pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE pacientes (
    id_pac integer NOT NULL,
    ape_pac character varying(20) NOT NULL,
    nom_pac character varying(100),
    ced_pac character varying(20),
    fec_nac_pac date NOT NULL,
    nac_pac character varying(100) NOT NULL,
    tel_hab_pac integer,
    tel_cel_pac integer,
    ocu_pac character varying(100),
    pai_pac character varying(100),
    est_pac character varying(100),
    par_pac character varying(100),
    mun_pac character varying(20),
    ciu_pac character varying(100)
);


ALTER TABLE public.pacientes OWNER TO postgres;

--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.id_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.id_pac IS 'Id paciente';


--
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.ape_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.ape_pac IS 'Apellido del paciente';


--
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.nom_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.nom_pac IS 'Nombre del paciente';


--
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.ced_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.ced_pac IS 'Cedula del paciente';


--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.fec_nac_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.fec_nac_pac IS 'Fecha de nacimiento del paciente';


--
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.nac_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.nac_pac IS 'Nacionalidad del paciente';


--
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.ocu_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.ocu_pac IS 'Ocupacion del paciente';


--
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.pai_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.pai_pac IS 'Pais del paciente';


--
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.est_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.est_pac IS 'Estado del paciente';


--
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.par_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.par_pac IS 'Parroquia del paciente';


--
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.mun_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.mun_pac IS 'Numero de paciente';


--
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 1658
-- Name: COLUMN pacientes.ciu_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pacientes.ciu_pac IS 'Ciudad del paciente';


--
-- TOC entry 1643 (class 1259 OID 27092)
-- Dependencies: 1658 5
-- Name: pacientes_id_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pacientes_id_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pacientes_id_pac_seq OWNER TO postgres;

--
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 1643
-- Name: pacientes_id_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pacientes_id_pac_seq OWNED BY pacientes.id_pac;


--
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 1643
-- Name: pacientes_id_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pacientes_id_pac_seq', 1, false);


--
-- TOC entry 1659 (class 1259 OID 27155)
-- Dependencies: 5
-- Name: partes_cuerpos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE partes_cuerpos (
    id_par_cue integer NOT NULL,
    nom_par_cue character varying(20),
    id_loc_cue integer NOT NULL
);


ALTER TABLE public.partes_cuerpos OWNER TO postgres;

--
-- TOC entry 1644 (class 1259 OID 27094)
-- Dependencies: 1659 5
-- Name: partes_cuerpos_id_par_cue_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE partes_cuerpos_id_par_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partes_cuerpos_id_par_cue_seq OWNER TO postgres;

--
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 1644
-- Name: partes_cuerpos_id_par_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE partes_cuerpos_id_par_cue_seq OWNED BY partes_cuerpos.id_par_cue;


--
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 1644
-- Name: partes_cuerpos_id_par_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('partes_cuerpos_id_par_cue_seq', 1, false);


--
-- TOC entry 1676 (class 1259 OID 27275)
-- Dependencies: 5
-- Name: propiedades_estudios_micologicos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE propiedades_estudios_micologicos (
    id_pro_est_mic integer NOT NULL,
    nom_pro_est_mic character varying(100) NOT NULL,
    id_tip_est_mic integer NOT NULL
);


ALTER TABLE public.propiedades_estudios_micologicos OWNER TO postgres;

--
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 1676
-- Name: COLUMN propiedades_estudios_micologicos.id_pro_est_mic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN propiedades_estudios_micologicos.id_pro_est_mic IS 'Id propiedad estudio micologicos';


--
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 1676
-- Name: COLUMN propiedades_estudios_micologicos.nom_pro_est_mic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN propiedades_estudios_micologicos.nom_pro_est_mic IS 'Nombre propiedad estudio micologico';


--
-- TOC entry 2344 (class 0 OID 0)
-- Dependencies: 1676
-- Name: COLUMN propiedades_estudios_micologicos.id_tip_est_mic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN propiedades_estudios_micologicos.id_tip_est_mic IS 'Id tipos de estudio micologicos';


--
-- TOC entry 1645 (class 1259 OID 27096)
-- Dependencies: 5 1676
-- Name: propiedades_estudios_micologicos_id_pro_est_mic_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE propiedades_estudios_micologicos_id_pro_est_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.propiedades_estudios_micologicos_id_pro_est_mic_seq OWNER TO postgres;

--
-- TOC entry 2345 (class 0 OID 0)
-- Dependencies: 1645
-- Name: propiedades_estudios_micologicos_id_pro_est_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE propiedades_estudios_micologicos_id_pro_est_mic_seq OWNED BY propiedades_estudios_micologicos.id_pro_est_mic;


--
-- TOC entry 2346 (class 0 OID 0)
-- Dependencies: 1645
-- Name: propiedades_estudios_micologicos_id_pro_est_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('propiedades_estudios_micologicos_id_pro_est_mic_seq', 1, false);


--
-- TOC entry 1677 (class 1259 OID 27286)
-- Dependencies: 5
-- Name: tipos_consultas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE tipos_consultas (
    id_tip_con integer NOT NULL,
    nom_tip_con character varying(50) NOT NULL
);


ALTER TABLE public.tipos_consultas OWNER TO postgres;

--
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 1677
-- Name: COLUMN tipos_consultas.id_tip_con; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipos_consultas.id_tip_con IS 'id tipos consultas';


--
-- TOC entry 1646 (class 1259 OID 27098)
-- Dependencies: 5 1677
-- Name: tipos_consultas_id_tip_con_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipos_consultas_id_tip_con_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_consultas_id_tip_con_seq OWNER TO postgres;

--
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 1646
-- Name: tipos_consultas_id_tip_con_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipos_consultas_id_tip_con_seq OWNED BY tipos_consultas.id_tip_con;


--
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 1646
-- Name: tipos_consultas_id_tip_con_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_consultas_id_tip_con_seq', 1, false);


--
-- TOC entry 1700 (class 1259 OID 27593)
-- Dependencies: 5
-- Name: tipos_consultas_pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE tipos_consultas_pacientes (
    id_tip_con_pac integer NOT NULL,
    id_tip_con integer NOT NULL,
    id_his integer NOT NULL,
    otr_tip_con character varying(50)
);


ALTER TABLE public.tipos_consultas_pacientes OWNER TO postgres;

--
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 1700
-- Name: COLUMN tipos_consultas_pacientes.id_tip_con_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipos_consultas_pacientes.id_tip_con_pac IS 'Id tipos de consulta paciente';


--
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 1700
-- Name: COLUMN tipos_consultas_pacientes.id_tip_con; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipos_consultas_pacientes.id_tip_con IS 'Id tipos de consulta';


--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 1700
-- Name: COLUMN tipos_consultas_pacientes.id_his; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipos_consultas_pacientes.id_his IS 'Id historico';


--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 1700
-- Name: COLUMN tipos_consultas_pacientes.otr_tip_con; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipos_consultas_pacientes.otr_tip_con IS 'Otro tipo de consulta';


--
-- TOC entry 1647 (class 1259 OID 27100)
-- Dependencies: 5 1700
-- Name: tipos_consultas_pacientes_id_tip_con_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipos_consultas_pacientes_id_tip_con_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_consultas_pacientes_id_tip_con_pac_seq OWNER TO postgres;

--
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 1647
-- Name: tipos_consultas_pacientes_id_tip_con_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipos_consultas_pacientes_id_tip_con_pac_seq OWNED BY tipos_consultas_pacientes.id_tip_con_pac;


--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 1647
-- Name: tipos_consultas_pacientes_id_tip_con_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_consultas_pacientes_id_tip_con_pac_seq', 1, false);


--
-- TOC entry 1660 (class 1259 OID 27166)
-- Dependencies: 5
-- Name: tipos_estudios_micologicos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE tipos_estudios_micologicos (
    id_tip_est_mic integer NOT NULL,
    id_tip_mic integer NOT NULL,
    nom_tip_est_mic character varying(20)
);


ALTER TABLE public.tipos_estudios_micologicos OWNER TO postgres;

--
-- TOC entry 1648 (class 1259 OID 27102)
-- Dependencies: 5 1660
-- Name: tipos_estudios_micologicos_id_tip_est_mic_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipos_estudios_micologicos_id_tip_est_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_estudios_micologicos_id_tip_est_mic_seq OWNER TO postgres;

--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 1648
-- Name: tipos_estudios_micologicos_id_tip_est_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipos_estudios_micologicos_id_tip_est_mic_seq OWNED BY tipos_estudios_micologicos.id_tip_est_mic;


--
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 1648
-- Name: tipos_estudios_micologicos_id_tip_est_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_estudios_micologicos_id_tip_est_mic_seq', 1, false);


--
-- TOC entry 1653 (class 1259 OID 27116)
-- Dependencies: 5
-- Name: tipos_micosis; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE tipos_micosis (
    id_tip_mic integer NOT NULL,
    nom_tip_mic character varying(20)
);


ALTER TABLE public.tipos_micosis OWNER TO postgres;

--
-- TOC entry 1649 (class 1259 OID 27104)
-- Dependencies: 5 1653
-- Name: tipos_micosis_id_tip_mic_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipos_micosis_id_tip_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_micosis_id_tip_mic_seq OWNER TO postgres;

--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 1649
-- Name: tipos_micosis_id_tip_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipos_micosis_id_tip_mic_seq OWNED BY tipos_micosis.id_tip_mic;


--
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 1649
-- Name: tipos_micosis_id_tip_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_micosis_id_tip_mic_seq', 1, false);


--
-- TOC entry 1655 (class 1259 OID 27124)
-- Dependencies: 5
-- Name: tipos_usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE tipos_usuarios (
    id_tip_usu integer NOT NULL,
    cod_tip_usu character varying(3) NOT NULL,
    des_tip_usu character varying(100)
);


ALTER TABLE public.tipos_usuarios OWNER TO postgres;

--
-- TOC entry 1679 (class 1259 OID 27294)
-- Dependencies: 5
-- Name: tipos_usuarios__usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE tipos_usuarios__usuarios (
    id_tip_usu_usu integer NOT NULL,
    id_doc integer,
    id_tip_adm integer,
    id_tip_usu integer NOT NULL
);


ALTER TABLE public.tipos_usuarios__usuarios OWNER TO postgres;

--
-- TOC entry 1678 (class 1259 OID 27292)
-- Dependencies: 1679 5
-- Name: tipos_usuarios__usuarios_id_tip_usu_usu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipos_usuarios__usuarios_id_tip_usu_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_usuarios__usuarios_id_tip_usu_usu_seq OWNER TO postgres;

--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 1678
-- Name: tipos_usuarios__usuarios_id_tip_usu_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipos_usuarios__usuarios_id_tip_usu_usu_seq OWNED BY tipos_usuarios__usuarios.id_tip_usu_usu;


--
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 1678
-- Name: tipos_usuarios__usuarios_id_tip_usu_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_usuarios__usuarios_id_tip_usu_usu_seq', 1, false);


--
-- TOC entry 1654 (class 1259 OID 27122)
-- Dependencies: 1655 5
-- Name: tipos_usuarios_id_tip_usu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipos_usuarios_id_tip_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_usuarios_id_tip_usu_seq OWNER TO postgres;

--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 1654
-- Name: tipos_usuarios_id_tip_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipos_usuarios_id_tip_usu_seq OWNED BY tipos_usuarios.id_tip_usu;


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 1654
-- Name: tipos_usuarios_id_tip_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipos_usuarios_id_tip_usu_seq', 1, false);


--
-- TOC entry 1681 (class 1259 OID 27319)
-- Dependencies: 5
-- Name: transacciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE transacciones (
    id_tip_tra integer NOT NULL,
    cod_tip_tra character varying(3) NOT NULL,
    des_tip_tra character varying(100)
);


ALTER TABLE public.transacciones OWNER TO postgres;

--
-- TOC entry 1680 (class 1259 OID 27317)
-- Dependencies: 5 1681
-- Name: transacciones_id_tip_tra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE transacciones_id_tip_tra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transacciones_id_tip_tra_seq OWNER TO postgres;

--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 1680
-- Name: transacciones_id_tip_tra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE transacciones_id_tip_tra_seq OWNED BY transacciones.id_tip_tra;


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 1680
-- Name: transacciones_id_tip_tra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('transacciones_id_tip_tra_seq', 1, false);


--
-- TOC entry 1702 (class 1259 OID 27613)
-- Dependencies: 5
-- Name: transacciones_usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE transacciones_usuarios (
    id_tip_tra_usu integer NOT NULL,
    id_tip_tra integer NOT NULL,
    id_tip_usu_usu integer NOT NULL
);


ALTER TABLE public.transacciones_usuarios OWNER TO postgres;

--
-- TOC entry 1701 (class 1259 OID 27611)
-- Dependencies: 1702 5
-- Name: transacciones_usuarios_id_tip_tra_usu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE transacciones_usuarios_id_tip_tra_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transacciones_usuarios_id_tip_tra_usu_seq OWNER TO postgres;

--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 1701
-- Name: transacciones_usuarios_id_tip_tra_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE transacciones_usuarios_id_tip_tra_usu_seq OWNED BY transacciones_usuarios.id_tip_tra_usu;


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 1701
-- Name: transacciones_usuarios_id_tip_tra_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('transacciones_usuarios_id_tip_tra_usu_seq', 1, false);


--
-- TOC entry 1682 (class 1259 OID 27325)
-- Dependencies: 5
-- Name: tratamientos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE tratamientos (
    id_tra integer NOT NULL,
    nom_tra character varying(100)
);


ALTER TABLE public.tratamientos OWNER TO postgres;

--
-- TOC entry 1650 (class 1259 OID 27106)
-- Dependencies: 5 1682
-- Name: tratamientos_id_tra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tratamientos_id_tra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tratamientos_id_tra_seq OWNER TO postgres;

--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 1650
-- Name: tratamientos_id_tra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tratamientos_id_tra_seq OWNED BY tratamientos.id_tra;


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 1650
-- Name: tratamientos_id_tra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tratamientos_id_tra_seq', 1, false);


--
-- TOC entry 1703 (class 1259 OID 27631)
-- Dependencies: 5
-- Name: tratamientos_pacientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE tratamientos_pacientes (
    id_tra_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_tra integer NOT NULL,
    otr_tra character varying(20)
);


ALTER TABLE public.tratamientos_pacientes OWNER TO postgres;

--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 1703
-- Name: COLUMN tratamientos_pacientes.id_tra_pac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tratamientos_pacientes.id_tra_pac IS 'Id transaccion paciente';


--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 1703
-- Name: COLUMN tratamientos_pacientes.id_his; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tratamientos_pacientes.id_his IS 'Id historico';


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 1703
-- Name: COLUMN tratamientos_pacientes.id_tra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tratamientos_pacientes.id_tra IS 'Id tratamiento';


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 1703
-- Name: COLUMN tratamientos_pacientes.otr_tra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tratamientos_pacientes.otr_tra IS 'Otro tratamiento';


--
-- TOC entry 1651 (class 1259 OID 27108)
-- Dependencies: 5 1703
-- Name: tratamientos_pacientes_id_tra_pac_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tratamientos_pacientes_id_tra_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tratamientos_pacientes_id_tra_pac_seq OWNER TO postgres;

--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 1651
-- Name: tratamientos_pacientes_id_tra_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tratamientos_pacientes_id_tra_pac_seq OWNED BY tratamientos_pacientes.id_tra_pac;


--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 1651
-- Name: tratamientos_pacientes_id_tra_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tratamientos_pacientes_id_tra_pac_seq', 1, false);


--
-- TOC entry 1662 (class 1259 OID 27179)
-- Dependencies: 5
-- Name: usuarios_administrativos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE TABLE usuarios_administrativos (
    id_usu_adm integer NOT NULL,
    nom_usu_adm character varying(100),
    ape_usu_adm character varying(100),
    pas_usu_adm character varying(100),
    log_usu_adm character varying(100),
    tel_usu_adm character varying(20),
    id_tip_usu integer NOT NULL
);


ALTER TABLE public.usuarios_administrativos OWNER TO postgres;

--
-- TOC entry 1661 (class 1259 OID 27177)
-- Dependencies: 1662 5
-- Name: usuarios_administrativos_id_usu_adm_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuarios_administrativos_id_usu_adm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_administrativos_id_usu_adm_seq OWNER TO postgres;

--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 1661
-- Name: usuarios_administrativos_id_usu_adm_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuarios_administrativos_id_usu_adm_seq OWNED BY usuarios_administrativos.id_usu_adm;


--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 1661
-- Name: usuarios_administrativos_id_usu_adm_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuarios_administrativos_id_usu_adm_seq', 1, false);


--
-- TOC entry 1989 (class 2604 OID 27193)
-- Dependencies: 1623 1663 1663
-- Name: id_ani; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE animales ALTER COLUMN id_ani SET DEFAULT nextval('animales_id_ani_seq'::regclass);


--
-- TOC entry 2005 (class 2604 OID 27334)
-- Dependencies: 1624 1683 1683
-- Name: id_ant_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE antecedentes_pacientes ALTER COLUMN id_ant_pac SET DEFAULT nextval('antecedentes_pacientes_id_ant_pac_seq'::regclass);


--
-- TOC entry 1990 (class 2604 OID 27199)
-- Dependencies: 1622 1664 1664
-- Name: id_ant_per; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE antecedentes_personales ALTER COLUMN id_ant_per SET DEFAULT nextval('antecedentes_personales_id_ant_per_seq'::regclass);


--
-- TOC entry 2006 (class 2604 OID 27354)
-- Dependencies: 1685 1684 1685
-- Name: id_aud_tra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE auditoria_transacciones ALTER COLUMN id_aud_tra SET DEFAULT nextval('auditoria_transacciones_id_aud_tra_seq'::regclass);


--
-- TOC entry 2007 (class 2604 OID 27375)
-- Dependencies: 1625 1686 1686
-- Name: id_cat_cue_mic; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE categorias__cuerpos_micosis ALTER COLUMN id_cat_cue_mic SET DEFAULT nextval('categorias__cuerpos_micosis_id_cat_cue_mic_seq'::regclass);


--
-- TOC entry 1991 (class 2604 OID 27205)
-- Dependencies: 1626 1665 1665
-- Name: id_cat_cue; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE categorias_cuerpos ALTER COLUMN id_cat_cue SET DEFAULT nextval('categorias_cuerpos_id_cat_cue_seq'::regclass);


--
-- TOC entry 2008 (class 2604 OID 27393)
-- Dependencies: 1687 1627 1687
-- Name: id_cat_cue_par_cue; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE categorias_cuerpos_partes_cuerpos ALTER COLUMN id_cat_cue_par_cue SET DEFAULT nextval('categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq'::regclass);


--
-- TOC entry 1992 (class 2604 OID 27211)
-- Dependencies: 1666 1628 1666
-- Name: id_cen_sal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE centro_salud ALTER COLUMN id_cen_sal SET DEFAULT nextval('centro_salud_id_cen_sal_seq'::regclass);


--
-- TOC entry 2009 (class 2604 OID 27411)
-- Dependencies: 1629 1688 1688
-- Name: id_cen_sal_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE centro_salud_pacientes ALTER COLUMN id_cen_sal_pac SET DEFAULT nextval('centro_salud_pacientes_id_cen_sal_pac_seq'::regclass);


--
-- TOC entry 1993 (class 2604 OID 27219)
-- Dependencies: 1667 1668 1668
-- Name: id_cli; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE clinicas ALTER COLUMN id_cli SET DEFAULT nextval('clinicas_id_cli_seq'::regclass);


--
-- TOC entry 2010 (class 2604 OID 27431)
-- Dependencies: 1690 1689 1690
-- Name: id_cli_doc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE clinicas_doctores ALTER COLUMN id_cli_doc SET DEFAULT nextval('clinicas_doctores_id_cli_doc_seq'::regclass);


--
-- TOC entry 2011 (class 2604 OID 27450)
-- Dependencies: 1630 1691 1691
-- Name: id_con_ani; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE contactos_animales ALTER COLUMN id_con_ani SET DEFAULT nextval('contactos_animales_id_con_ani_seq'::regclass);


--
-- TOC entry 1984 (class 2604 OID 27135)
-- Dependencies: 1657 1656 1657
-- Name: id_doc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE doctores ALTER COLUMN id_doc SET DEFAULT nextval('doctores_id_doc_seq'::regclass);


--
-- TOC entry 1994 (class 2604 OID 27225)
-- Dependencies: 1669 1631 1669
-- Name: id_enf_mic; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE enfermedades_micologicas ALTER COLUMN id_enf_mic SET DEFAULT nextval('enfermedades_micologicas_id_enf_mic_seq'::regclass);


--
-- TOC entry 2012 (class 2604 OID 27468)
-- Dependencies: 1692 1632 1692
-- Name: id_enf_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE enfermedades_pacientes ALTER COLUMN id_enf_pac SET DEFAULT nextval('enfermedades_pacientes_id_enf_pac_seq'::regclass);


--
-- TOC entry 2013 (class 2604 OID 27486)
-- Dependencies: 1633 1693 1693
-- Name: id_est_mic_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE estudios_micologicos__pacientes ALTER COLUMN id_est_mic_pac SET DEFAULT nextval('estudios_micologicos__pacientes_id_est_mic_pac_seq'::regclass);


--
-- TOC entry 1995 (class 2604 OID 27236)
-- Dependencies: 1670 1634 1670
-- Name: id_for_inf; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE forma_infecciones ALTER COLUMN id_for_inf SET DEFAULT nextval('forma_infecciones_id_for_inf_seq'::regclass);


--
-- TOC entry 2014 (class 2604 OID 27504)
-- Dependencies: 1694 1635 1694
-- Name: id_for_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE forma_infecciones__pacientes ALTER COLUMN id_for_pac SET DEFAULT nextval('forma_infecciones__pacientes_id_for_pac_seq'::regclass);


--
-- TOC entry 2015 (class 2604 OID 27522)
-- Dependencies: 1636 1695 1695
-- Name: id_for_inf_tip_mic; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE forma_infecciones__tipos_micosis ALTER COLUMN id_for_inf_tip_mic SET DEFAULT nextval('forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 27242)
-- Dependencies: 1671 1637 1671
-- Name: id_his; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE historiales_pacientes ALTER COLUMN id_his SET DEFAULT nextval('historiales_pacientes_id_his_seq'::regclass);


--
-- TOC entry 1997 (class 2604 OID 27253)
-- Dependencies: 1638 1672 1672
-- Name: id_les_par_cue; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE lesiones__partes_cuerpos ALTER COLUMN id_les_par_cue SET DEFAULT nextval('lesiones__partes_cuerpos_id_les_par_cue_seq'::regclass);


--
-- TOC entry 2016 (class 2604 OID 27540)
-- Dependencies: 1639 1696 1696
-- Name: id_les_par_cue_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE lesiones_partes_cuerpos__pacientes ALTER COLUMN id_les_par_cue_pac SET DEFAULT nextval('lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq'::regclass);


--
-- TOC entry 1981 (class 2604 OID 27113)
-- Dependencies: 1652 1640 1652
-- Name: id_loc_cue; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE localizaciones_cuerpos ALTER COLUMN id_loc_cue SET DEFAULT nextval('localizaciones_cuerpos_id_loc_cue_seq'::regclass);


--
-- TOC entry 2017 (class 2604 OID 27560)
-- Dependencies: 1697 1698 1698
-- Name: id_mod_usu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE modulo_usuarios ALTER COLUMN id_mod_usu SET DEFAULT nextval('modulo_usuarios_id_mod_usu_seq'::regclass);


--
-- TOC entry 1998 (class 2604 OID 27266)
-- Dependencies: 1673 1674 1674
-- Name: id_mod; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE modulos ALTER COLUMN id_mod SET DEFAULT nextval('modulos_id_mod_seq'::regclass);


--
-- TOC entry 1999 (class 2604 OID 27272)
-- Dependencies: 1675 1641 1675
-- Name: id_mue_cli; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE muestras_clinicas ALTER COLUMN id_mue_cli SET DEFAULT nextval('muestras_clinicas_id_mue_cli_seq'::regclass);


--
-- TOC entry 2018 (class 2604 OID 27578)
-- Dependencies: 1699 1642 1699
-- Name: id_mue_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE muestras_pacientes ALTER COLUMN id_mue_pac SET DEFAULT nextval('muestras_pacientes_id_mue_pac_seq'::regclass);


--
-- TOC entry 1985 (class 2604 OID 27149)
-- Dependencies: 1658 1643 1658
-- Name: id_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE pacientes ALTER COLUMN id_pac SET DEFAULT nextval('pacientes_id_pac_seq'::regclass);


--
-- TOC entry 1986 (class 2604 OID 27158)
-- Dependencies: 1644 1659 1659
-- Name: id_par_cue; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE partes_cuerpos ALTER COLUMN id_par_cue SET DEFAULT nextval('partes_cuerpos_id_par_cue_seq'::regclass);


--
-- TOC entry 2000 (class 2604 OID 27278)
-- Dependencies: 1645 1676 1676
-- Name: id_pro_est_mic; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE propiedades_estudios_micologicos ALTER COLUMN id_pro_est_mic SET DEFAULT nextval('propiedades_estudios_micologicos_id_pro_est_mic_seq'::regclass);


--
-- TOC entry 2001 (class 2604 OID 27289)
-- Dependencies: 1677 1646 1677
-- Name: id_tip_con; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tipos_consultas ALTER COLUMN id_tip_con SET DEFAULT nextval('tipos_consultas_id_tip_con_seq'::regclass);


--
-- TOC entry 2019 (class 2604 OID 27596)
-- Dependencies: 1647 1700 1700
-- Name: id_tip_con_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tipos_consultas_pacientes ALTER COLUMN id_tip_con_pac SET DEFAULT nextval('tipos_consultas_pacientes_id_tip_con_pac_seq'::regclass);


--
-- TOC entry 1987 (class 2604 OID 27169)
-- Dependencies: 1648 1660 1660
-- Name: id_tip_est_mic; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tipos_estudios_micologicos ALTER COLUMN id_tip_est_mic SET DEFAULT nextval('tipos_estudios_micologicos_id_tip_est_mic_seq'::regclass);


--
-- TOC entry 1982 (class 2604 OID 27119)
-- Dependencies: 1653 1649 1653
-- Name: id_tip_mic; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tipos_micosis ALTER COLUMN id_tip_mic SET DEFAULT nextval('tipos_micosis_id_tip_mic_seq'::regclass);


--
-- TOC entry 1983 (class 2604 OID 27127)
-- Dependencies: 1655 1654 1655
-- Name: id_tip_usu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tipos_usuarios ALTER COLUMN id_tip_usu SET DEFAULT nextval('tipos_usuarios_id_tip_usu_seq'::regclass);


--
-- TOC entry 2002 (class 2604 OID 27297)
-- Dependencies: 1678 1679 1679
-- Name: id_tip_usu_usu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tipos_usuarios__usuarios ALTER COLUMN id_tip_usu_usu SET DEFAULT nextval('tipos_usuarios__usuarios_id_tip_usu_usu_seq'::regclass);


--
-- TOC entry 2003 (class 2604 OID 27322)
-- Dependencies: 1680 1681 1681
-- Name: id_tip_tra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE transacciones ALTER COLUMN id_tip_tra SET DEFAULT nextval('transacciones_id_tip_tra_seq'::regclass);


--
-- TOC entry 2020 (class 2604 OID 27616)
-- Dependencies: 1702 1701 1702
-- Name: id_tip_tra_usu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE transacciones_usuarios ALTER COLUMN id_tip_tra_usu SET DEFAULT nextval('transacciones_usuarios_id_tip_tra_usu_seq'::regclass);


--
-- TOC entry 2004 (class 2604 OID 27328)
-- Dependencies: 1682 1650 1682
-- Name: id_tra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tratamientos ALTER COLUMN id_tra SET DEFAULT nextval('tratamientos_id_tra_seq'::regclass);


--
-- TOC entry 2021 (class 2604 OID 27634)
-- Dependencies: 1651 1703 1703
-- Name: id_tra_pac; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tratamientos_pacientes ALTER COLUMN id_tra_pac SET DEFAULT nextval('tratamientos_pacientes_id_tra_pac_seq'::regclass);


--
-- TOC entry 1988 (class 2604 OID 27182)
-- Dependencies: 1661 1662 1662
-- Name: id_usu_adm; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE usuarios_administrativos ALTER COLUMN id_usu_adm SET DEFAULT nextval('usuarios_administrativos_id_usu_adm_seq'::regclass);


--
-- TOC entry 2221 (class 0 OID 27190)
-- Dependencies: 1663
-- Data for Name: animales; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy animales (id_ani, nom_ani) FROM stdin;
--\.


--
-- TOC entry 2237 (class 0 OID 27331)
-- Dependencies: 1683
-- Data for Name: antecedentes_pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy antecedentes_pacientes (id_ant_pac, id_ant_per, id_his, otr_ant_per) FROM stdin;
--\.


--
-- TOC entry 2222 (class 0 OID 27196)
-- Dependencies: 1664
-- Data for Name: antecedentes_personales; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy antecedentes_personales (id_ant_per, nom_ant) FROM stdin;
--\.


--
-- TOC entry 2238 (class 0 OID 27351)
-- Dependencies: 1685
-- Data for Name: auditoria_transacciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, id_mod) FROM stdin;
--\.


--
-- TOC entry 2239 (class 0 OID 27372)
-- Dependencies: 1686
-- Data for Name: categorias__cuerpos_micosis; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy categorias__cuerpos_micosis (id_cat_cue_mic, id_cat_cue, id_tip_mic) FROM stdin;
--\.


--
-- TOC entry 2223 (class 0 OID 27202)
-- Dependencies: 1665
-- Data for Name: categorias_cuerpos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy categorias_cuerpos (id_cat_cue, nom_cat_cue) FROM stdin;
--\.


--
-- TOC entry 2240 (class 0 OID 27390)
-- Dependencies: 1687
-- Data for Name: categorias_cuerpos_partes_cuerpos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy categorias_cuerpos_partes_cuerpos (id_cat_cue_par_cue, id_par_cue, id_cat_cue) FROM stdin;
--\.


--
-- TOC entry 2224 (class 0 OID 27208)
-- Dependencies: 1666
-- Data for Name: centro_salud; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy centro_salud (id_cen_sal, nom_cen_sal, des_cen_sal) FROM stdin;
--\.


--
-- TOC entry 2241 (class 0 OID 27408)
-- Dependencies: 1688
-- Data for Name: centro_salud_pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy centro_salud_pacientes (id_cen_sal_pac, id_his, id_cen_sal, otr_cen_sal) FROM stdin;
--\.


--
-- TOC entry 2225 (class 0 OID 27216)
-- Dependencies: 1668
-- Data for Name: clinicas; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy clinicas (id_cli, dir_cli, nom_cli) FROM stdin;
--\.


--
-- TOC entry 2242 (class 0 OID 27428)
-- Dependencies: 1690
-- Data for Name: clinicas_doctores; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy clinicas_doctores (id_cli_doc, id_cli, id_doc) FROM stdin;
--\.


--
-- TOC entry 2243 (class 0 OID 27447)
-- Dependencies: 1691
-- Data for Name: contactos_animales; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy contactos_animales (id_con_ani, id_his, id_ani, otr_ani) FROM stdin;
--\.


--
-- TOC entry 2216 (class 0 OID 27132)
-- Dependencies: 1657
-- Data for Name: doctores; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy doctores (id_doc, nom_doc, ape_doc, ced_doc, log_dog, pas_doc, tef_doc, cor_doc, id_tip_usu) FROM stdin;
--\.


--
-- TOC entry 2226 (class 0 OID 27222)
-- Dependencies: 1669
-- Data for Name: enfermedades_micologicas; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) FROM stdin;
--\.


--
-- TOC entry 2244 (class 0 OID 27465)
-- Dependencies: 1692
-- Data for Name: enfermedades_pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy enfermedades_pacientes (id_enf_pac, id_his, id_enf_mic, otr_enf_mic, esp_enf_mic) FROM stdin;
--\.


--
-- TOC entry 2245 (class 0 OID 27483)
-- Dependencies: 1693
-- Data for Name: estudios_micologicos__pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy estudios_micologicos__pacientes (id_est_mic_pac, id_his, id_pro_est_mic) FROM stdin;
--\.


--
-- TOC entry 2227 (class 0 OID 27233)
-- Dependencies: 1670
-- Data for Name: forma_infecciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy forma_infecciones (id_for_inf, des_for_inf) FROM stdin;
--\.


--
-- TOC entry 2246 (class 0 OID 27501)
-- Dependencies: 1694
-- Data for Name: forma_infecciones__pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy forma_infecciones__pacientes (id_for_pac, id_for_inf, id_his, otr_for_inf) FROM stdin;
--\.


--
-- TOC entry 2247 (class 0 OID 27519)
-- Dependencies: 1695
-- Data for Name: forma_infecciones__tipos_micosis; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) FROM stdin;
--\.


--
-- TOC entry 2228 (class 0 OID 27239)
-- Dependencies: 1671
-- Data for Name: historiales_pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy historiales_pacientes (id_his, id_pac, des_his, num_his, nun_mic, fec_his, nom_med, ape_med) FROM stdin;
--\.


--
-- TOC entry 2229 (class 0 OID 27250)
-- Dependencies: 1672
-- Data for Name: lesiones__partes_cuerpos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy lesiones__partes_cuerpos (id_les_par_cue, nom_les_par_cue, id_par_cue) FROM stdin;
--\.


--
-- TOC entry 2248 (class 0 OID 27537)
-- Dependencies: 1696
-- Data for Name: lesiones_partes_cuerpos__pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, id_his, id_les_par_cue, otr_les_par_cue) FROM stdin;
--\.


--
-- TOC entry 2213 (class 0 OID 27110)
-- Dependencies: 1652
-- Data for Name: localizaciones_cuerpos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy localizaciones_cuerpos (id_loc_cue, nom_loc_cue) FROM stdin;
--\.


--
-- TOC entry 2249 (class 0 OID 27557)
-- Dependencies: 1698
-- Data for Name: modulo_usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy modulo_usuarios (id_mod_usu, id_mod, id_tip_usu_usu) FROM stdin;
--\.


--
-- TOC entry 2230 (class 0 OID 27263)
-- Dependencies: 1674
-- Data for Name: modulos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy modulos (id_mod, nom_mod, des_mod) FROM stdin;
--\.


--
-- TOC entry 2231 (class 0 OID 27269)
-- Dependencies: 1675
-- Data for Name: muestras_clinicas; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy muestras_clinicas (id_mue_cli, nom_mue_cli) FROM stdin;
--\.


--
-- TOC entry 2250 (class 0 OID 27575)
-- Dependencies: 1699
-- Data for Name: muestras_pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy muestras_pacientes (id_mue_pac, id_his, id_mue_cli, otr_mue_cli) FROM stdin;
--\.


--
-- TOC entry 2217 (class 0 OID 27146)
-- Dependencies: 1658
-- Data for Name: pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, pai_pac, est_pac, par_pac, mun_pac, ciu_pac) FROM stdin;
--\.


--
-- TOC entry 2218 (class 0 OID 27155)
-- Dependencies: 1659
-- Data for Name: partes_cuerpos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy partes_cuerpos (id_par_cue, nom_par_cue, id_loc_cue) FROM stdin;
--\.


--
-- TOC entry 2232 (class 0 OID 27275)
-- Dependencies: 1676
-- Data for Name: propiedades_estudios_micologicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy propiedades_estudios_micologicos (id_pro_est_mic, nom_pro_est_mic, id_tip_est_mic) FROM stdin;
--\.


--
-- TOC entry 2233 (class 0 OID 27286)
-- Dependencies: 1677
-- Data for Name: tipos_consultas; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy tipos_consultas (id_tip_con, nom_tip_con) FROM stdin;
--\.


--
-- TOC entry 2251 (class 0 OID 27593)
-- Dependencies: 1700
-- Data for Name: tipos_consultas_pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy tipos_consultas_pacientes (id_tip_con_pac, id_tip_con, id_his, otr_tip_con) FROM stdin;
--\.


--
-- TOC entry 2219 (class 0 OID 27166)
-- Dependencies: 1660
-- Data for Name: tipos_estudios_micologicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic) FROM stdin;
--\.


--
-- TOC entry 2214 (class 0 OID 27116)
-- Dependencies: 1653
-- Data for Name: tipos_micosis; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy tipos_micosis (id_tip_mic, nom_tip_mic) FROM stdin;
--\.


--
-- TOC entry 2215 (class 0 OID 27124)
-- Dependencies: 1655
-- Data for Name: tipos_usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy tipos_usuarios (id_tip_usu, cod_tip_usu, des_tip_usu) FROM stdin;
--\.


--
-- TOC entry 2234 (class 0 OID 27294)
-- Dependencies: 1679
-- Data for Name: tipos_usuarios__usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_tip_adm, id_tip_usu) FROM stdin;
--\.


--
-- TOC entry 2235 (class 0 OID 27319)
-- Dependencies: 1681
-- Data for Name: transacciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy transacciones (id_tip_tra, cod_tip_tra, des_tip_tra) FROM stdin;
--\.


--
-- TOC entry 2252 (class 0 OID 27613)
-- Dependencies: 1702
-- Data for Name: transacciones_usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy transacciones_usuarios (id_tip_tra_usu, id_tip_tra, id_tip_usu_usu) FROM stdin;
--\.


--
-- TOC entry 2236 (class 0 OID 27325)
-- Dependencies: 1682
-- Data for Name: tratamientos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy tratamientos (id_tra, nom_tra) FROM stdin;
--\.


--
-- TOC entry 2253 (class 0 OID 27631)
-- Dependencies: 1703
-- Data for Name: tratamientos_pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) FROM stdin;
--\.


--
-- TOC entry 2220 (class 0 OID 27179)
-- Dependencies: 1662
-- Data for Name: usuarios_administrativos; Type: TABLE DATA; Schema: public; Owner: postgres
--

--copy usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, id_tip_usu) FROM stdin;
--\.


SET default_tablespace = '';

--
-- TOC entry 2045 (class 2606 OID 27195)
-- Dependencies: 1663 1663
-- Name: animales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY animales
    ADD CONSTRAINT animales_pkey PRIMARY KEY (id_ani);


--
-- TOC entry 2091 (class 2606 OID 27336)
-- Dependencies: 1683 1683
-- Name: antecedentes_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_pkey PRIMARY KEY (id_ant_pac);


--
-- TOC entry 2093 (class 2606 OID 27338)
-- Dependencies: 1683 1683 1683
-- Name: antecedentes_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_unique UNIQUE (id_ant_per, id_his);


--
-- TOC entry 2048 (class 2606 OID 27201)
-- Dependencies: 1664 1664
-- Name: antecedentes_personales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY antecedentes_personales
    ADD CONSTRAINT antecedentes_personales_pkey PRIMARY KEY (id_ant_per);


SET default_tablespace = saib;

--
-- TOC entry 2095 (class 2606 OID 27356)
-- Dependencies: 1685 1685
-- Name: auditoria_transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: saib
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_pkey PRIMARY KEY (id_aud_tra);


SET default_tablespace = '';

--
-- TOC entry 2098 (class 2606 OID 27377)
-- Dependencies: 1686 1686
-- Name: categorias__cuerpos_micosis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_pkey PRIMARY KEY (id_cat_cue_mic);


--
-- TOC entry 2100 (class 2606 OID 27379)
-- Dependencies: 1686 1686 1686
-- Name: categorias__cuerpos_micosis_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_unique UNIQUE (id_cat_cue, id_tip_mic);


--
-- TOC entry 2102 (class 2606 OID 27395)
-- Dependencies: 1687 1687
-- Name: categorias_cuerpos_partes_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categorias_cuerpos_partes_cuerpos
    ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_pkey PRIMARY KEY (id_cat_cue_par_cue);


--
-- TOC entry 2104 (class 2606 OID 27397)
-- Dependencies: 1687 1687 1687
-- Name: categorias_cuerpos_partes_cuerpos_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categorias_cuerpos_partes_cuerpos
    ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_unique UNIQUE (id_par_cue, id_cat_cue);


--
-- TOC entry 2051 (class 2606 OID 27207)
-- Dependencies: 1665 1665
-- Name: categorias_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categorias_cuerpos
    ADD CONSTRAINT categorias_cuerpos_pkey PRIMARY KEY (id_cat_cue);


--
-- TOC entry 2107 (class 2606 OID 27413)
-- Dependencies: 1688 1688
-- Name: centro_salud_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_pkey PRIMARY KEY (id_cen_sal_pac);


--
-- TOC entry 2109 (class 2606 OID 27415)
-- Dependencies: 1688 1688 1688
-- Name: centro_salud_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_unique UNIQUE (id_his, id_cen_sal);


--
-- TOC entry 2054 (class 2606 OID 27213)
-- Dependencies: 1666 1666
-- Name: centro_salud_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY centro_salud
    ADD CONSTRAINT centro_salud_pkey PRIMARY KEY (id_cen_sal);


--
-- TOC entry 2111 (class 2606 OID 27433)
-- Dependencies: 1690 1690
-- Name: clinicas_doctores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clinicas_doctores
    ADD CONSTRAINT clinicas_doctores_pkey PRIMARY KEY (id_cli_doc);


--
-- TOC entry 2056 (class 2606 OID 27221)
-- Dependencies: 1668 1668
-- Name: clinicas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clinicas
    ADD CONSTRAINT clinicas_pkey PRIMARY KEY (id_cli);


--
-- TOC entry 2117 (class 2606 OID 27452)
-- Dependencies: 1691 1691
-- Name: contactos_animales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_pkey PRIMARY KEY (id_con_ani);


--
-- TOC entry 2119 (class 2606 OID 27454)
-- Dependencies: 1691 1691 1691
-- Name: contactos_animales_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_unique UNIQUE (id_his, id_ani);


--
-- TOC entry 2031 (class 2606 OID 27140)
-- Dependencies: 1657 1657
-- Name: doctores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY doctores
    ADD CONSTRAINT doctores_pkey PRIMARY KEY (id_doc);


--
-- TOC entry 2059 (class 2606 OID 27227)
-- Dependencies: 1669 1669
-- Name: enfermedades_micologicas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY enfermedades_micologicas
    ADD CONSTRAINT enfermedades_micologicas_pkey PRIMARY KEY (id_enf_mic);


--
-- TOC entry 2122 (class 2606 OID 27470)
-- Dependencies: 1692 1692
-- Name: enfermedades_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_pkey PRIMARY KEY (id_enf_pac);


--
-- TOC entry 2124 (class 2606 OID 27472)
-- Dependencies: 1692 1692 1692
-- Name: enfermedades_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_unique UNIQUE (id_his, id_enf_mic);


--
-- TOC entry 2127 (class 2606 OID 27488)
-- Dependencies: 1693 1693
-- Name: estudios_micologicos__pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estudios_micologicos__pacientes
    ADD CONSTRAINT estudios_micologicos__pacientes_pkey PRIMARY KEY (id_est_mic_pac);


--
-- TOC entry 2129 (class 2606 OID 27490)
-- Dependencies: 1693 1693 1693
-- Name: estudios_micologicos__pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estudios_micologicos__pacientes
    ADD CONSTRAINT estudios_micologicos__pacientes_unique UNIQUE (id_his, id_pro_est_mic);


--
-- TOC entry 2132 (class 2606 OID 27506)
-- Dependencies: 1694 1694
-- Name: forma_infecciones__pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_pkey PRIMARY KEY (id_for_pac);


--
-- TOC entry 2134 (class 2606 OID 27508)
-- Dependencies: 1694 1694 1694
-- Name: forma_infecciones__pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_unique UNIQUE (id_for_inf, id_his);


--
-- TOC entry 2137 (class 2606 OID 27524)
-- Dependencies: 1695 1695
-- Name: forma_infecciones__tipos_micosis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_pkey PRIMARY KEY (id_for_inf_tip_mic);


--
-- TOC entry 2139 (class 2606 OID 27526)
-- Dependencies: 1695 1695 1695
-- Name: forma_infecciones__tipos_micosis_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_unique UNIQUE (id_tip_mic, id_for_inf);


--
-- TOC entry 2062 (class 2606 OID 27238)
-- Dependencies: 1670 1670
-- Name: forma_infecciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones
    ADD CONSTRAINT forma_infecciones_pkey PRIMARY KEY (id_for_inf);


--
-- TOC entry 2065 (class 2606 OID 27244)
-- Dependencies: 1671 1671
-- Name: historiales_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_pkey PRIMARY KEY (id_his);


--
-- TOC entry 2068 (class 2606 OID 27255)
-- Dependencies: 1672 1672
-- Name: lesiones__partes_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lesiones__partes_cuerpos
    ADD CONSTRAINT lesiones__partes_cuerpos_pkey PRIMARY KEY (id_les_par_cue);


--
-- TOC entry 2142 (class 2606 OID 27542)
-- Dependencies: 1696 1696
-- Name: lesiones_partes_cuerpos__pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_pkey PRIMARY KEY (id_les_par_cue_pac);


--
-- TOC entry 2144 (class 2606 OID 27544)
-- Dependencies: 1696 1696 1696
-- Name: lesiones_partes_cuerpos__pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_unique UNIQUE (id_his, id_les_par_cue);


--
-- TOC entry 2024 (class 2606 OID 27115)
-- Dependencies: 1652 1652
-- Name: localizaciones_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY localizaciones_cuerpos
    ADD CONSTRAINT localizaciones_cuerpos_pkey PRIMARY KEY (id_loc_cue);


--
-- TOC entry 2146 (class 2606 OID 27562)
-- Dependencies: 1698 1698
-- Name: modulo_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modulo_usuarios
    ADD CONSTRAINT modulo_usuarios_pkey PRIMARY KEY (id_mod_usu);


--
-- TOC entry 2070 (class 2606 OID 27268)
-- Dependencies: 1674 1674
-- Name: modulos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_pkey PRIMARY KEY (id_mod);


--
-- TOC entry 2073 (class 2606 OID 27274)
-- Dependencies: 1675 1675
-- Name: muestras_clinicas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY muestras_clinicas
    ADD CONSTRAINT muestras_clinicas_pkey PRIMARY KEY (id_mue_cli);


--
-- TOC entry 2150 (class 2606 OID 27580)
-- Dependencies: 1699 1699
-- Name: muestras_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_pkey PRIMARY KEY (id_mue_pac);


--
-- TOC entry 2152 (class 2606 OID 27582)
-- Dependencies: 1699 1699 1699
-- Name: muestras_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_unique UNIQUE (id_his, id_mue_cli);


--
-- TOC entry 2034 (class 2606 OID 27154)
-- Dependencies: 1658 1658
-- Name: pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (id_pac);


--
-- TOC entry 2037 (class 2606 OID 27160)
-- Dependencies: 1659 1659
-- Name: partes_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY partes_cuerpos
    ADD CONSTRAINT partes_cuerpos_pkey PRIMARY KEY (id_par_cue);


--
-- TOC entry 2076 (class 2606 OID 27280)
-- Dependencies: 1676 1676
-- Name: propiedades_estudios_micologicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY propiedades_estudios_micologicos
    ADD CONSTRAINT propiedades_estudios_micologicos_pkey PRIMARY KEY (id_pro_est_mic);


--
-- TOC entry 2155 (class 2606 OID 27598)
-- Dependencies: 1700 1700
-- Name: tipos_consultas_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_pkey PRIMARY KEY (id_tip_con_pac);


--
-- TOC entry 2157 (class 2606 OID 27600)
-- Dependencies: 1700 1700 1700
-- Name: tipos_consultas_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_unique UNIQUE (id_tip_con, id_his);


--
-- TOC entry 2079 (class 2606 OID 27291)
-- Dependencies: 1677 1677
-- Name: tipos_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_consultas
    ADD CONSTRAINT tipos_consultas_pkey PRIMARY KEY (id_tip_con);


--
-- TOC entry 2040 (class 2606 OID 27171)
-- Dependencies: 1660 1660
-- Name: tipos_estudios_micologicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_pkey PRIMARY KEY (id_tip_est_mic);


--
-- TOC entry 2027 (class 2606 OID 27121)
-- Dependencies: 1653 1653
-- Name: tipos_micosis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_micosis
    ADD CONSTRAINT tipos_micosis_pkey PRIMARY KEY (id_tip_mic);


--
-- TOC entry 2081 (class 2606 OID 27299)
-- Dependencies: 1679 1679
-- Name: tipos_usuarios__usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_pkey PRIMARY KEY (id_tip_usu_usu);


--
-- TOC entry 2029 (class 2606 OID 27129)
-- Dependencies: 1655 1655
-- Name: tipos_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_usuarios
    ADD CONSTRAINT tipos_usuarios_pkey PRIMARY KEY (id_tip_usu);


--
-- TOC entry 2085 (class 2606 OID 27324)
-- Dependencies: 1681 1681
-- Name: transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (id_tip_tra);


--
-- TOC entry 2159 (class 2606 OID 27618)
-- Dependencies: 1702 1702
-- Name: transacciones_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_pkey PRIMARY KEY (id_tip_tra_usu);


--
-- TOC entry 2164 (class 2606 OID 27636)
-- Dependencies: 1703 1703
-- Name: tratamientos_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_pkey PRIMARY KEY (id_tra_pac);


--
-- TOC entry 2166 (class 2606 OID 27638)
-- Dependencies: 1703 1703 1703
-- Name: tratamientos_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_unique UNIQUE (id_his, id_tra);


--
-- TOC entry 2088 (class 2606 OID 27330)
-- Dependencies: 1682 1682
-- Name: tratamientos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tratamientos
    ADD CONSTRAINT tratamientos_pkey PRIMARY KEY (id_tra);


--
-- TOC entry 2114 (class 2606 OID 27435)
-- Dependencies: 1690 1690 1690
-- Name: unique_clinicas_doctores; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clinicas_doctores
    ADD CONSTRAINT unique_clinicas_doctores UNIQUE (id_cli, id_doc);


--
-- TOC entry 2148 (class 2606 OID 27564)
-- Dependencies: 1698 1698 1698
-- Name: unique_modulo_usuarios; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modulo_usuarios
    ADD CONSTRAINT unique_modulo_usuarios UNIQUE (id_mod, id_tip_usu_usu);


--
-- TOC entry 2083 (class 2606 OID 27301)
-- Dependencies: 1679 1679 1679 1679
-- Name: unique_tipos_usuarios__usuarios; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT unique_tipos_usuarios__usuarios UNIQUE (id_doc, id_tip_adm, id_tip_usu);


--
-- TOC entry 2161 (class 2606 OID 27620)
-- Dependencies: 1702 1702 1702
-- Name: unique_transacciones_usuarios; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT unique_transacciones_usuarios UNIQUE (id_tip_tra, id_tip_usu_usu);


SET default_tablespace = saib;

--
-- TOC entry 2042 (class 2606 OID 27184)
-- Dependencies: 1662 1662
-- Name: usuarios_administrativos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: saib
--

ALTER TABLE ONLY usuarios_administrativos
    ADD CONSTRAINT usuarios_administrativos_pkey PRIMARY KEY (id_usu_adm);


--
-- TOC entry 2043 (class 1259 OID 27670)
-- Dependencies: 1663
-- Name: animales_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX animales_index ON animales USING btree (id_ani);


--
-- TOC entry 2089 (class 1259 OID 27671)
-- Dependencies: 1683 1683 1683
-- Name: antecedentes_pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX antecedentes_pacientes_index ON antecedentes_pacientes USING btree (id_ant_pac, id_ant_per, id_his);


--
-- TOC entry 2046 (class 1259 OID 27672)
-- Dependencies: 1664
-- Name: antecedentes_personales_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX antecedentes_personales_index ON antecedentes_personales USING btree (id_ant_per);


--
-- TOC entry 2096 (class 1259 OID 27673)
-- Dependencies: 1686
-- Name: categorias__cuerpos_micosis_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX categorias__cuerpos_micosis_index ON categorias__cuerpos_micosis USING btree (id_cat_cue_mic);


--
-- TOC entry 2049 (class 1259 OID 27674)
-- Dependencies: 1665
-- Name: categorias_cuerpos_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX categorias_cuerpos_index ON categorias_cuerpos USING btree (id_cat_cue);


--
-- TOC entry 2052 (class 1259 OID 27675)
-- Dependencies: 1666
-- Name: centro_salud_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX centro_salud_index ON centro_salud USING btree (id_cen_sal);


--
-- TOC entry 2105 (class 1259 OID 27676)
-- Dependencies: 1688 1688 1688
-- Name: centro_salud_pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX centro_salud_pacientes_index ON centro_salud_pacientes USING btree (id_cen_sal_pac, id_his, id_cen_sal);


--
-- TOC entry 2115 (class 1259 OID 27677)
-- Dependencies: 1691 1691 1691
-- Name: contactos_animales_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX contactos_animales_index ON contactos_animales USING btree (id_con_ani, id_his, id_ani);


--
-- TOC entry 2057 (class 1259 OID 27678)
-- Dependencies: 1669
-- Name: enfermedades_micologicas_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX enfermedades_micologicas_index ON enfermedades_micologicas USING btree (id_enf_mic);


--
-- TOC entry 2120 (class 1259 OID 27679)
-- Dependencies: 1692 1692 1692
-- Name: enfermedades_pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX enfermedades_pacientes_index ON enfermedades_pacientes USING btree (id_enf_pac, id_his, id_enf_mic);


--
-- TOC entry 2125 (class 1259 OID 27680)
-- Dependencies: 1693
-- Name: estudios_micologicos__pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX estudios_micologicos__pacientes_index ON estudios_micologicos__pacientes USING btree (id_est_mic_pac);


--
-- TOC entry 2130 (class 1259 OID 27682)
-- Dependencies: 1694
-- Name: forma_infecciones__pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX forma_infecciones__pacientes_index ON forma_infecciones__pacientes USING btree (id_for_pac);


--
-- TOC entry 2135 (class 1259 OID 27683)
-- Dependencies: 1695
-- Name: forma_infecciones__tipos_micosis_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX forma_infecciones__tipos_micosis_index ON forma_infecciones__tipos_micosis USING btree (id_for_inf_tip_mic);


--
-- TOC entry 2060 (class 1259 OID 27681)
-- Dependencies: 1670
-- Name: forma_infecciones_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX forma_infecciones_index ON forma_infecciones USING btree (id_for_inf);


--
-- TOC entry 2063 (class 1259 OID 27684)
-- Dependencies: 1671
-- Name: historiales_pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX historiales_pacientes_index ON historiales_pacientes USING btree (id_his);


SET default_tablespace = '';

--
-- TOC entry 2112 (class 1259 OID 27446)
-- Dependencies: 1690
-- Name: index_clinicas_doctores; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_clinicas_doctores ON clinicas_doctores USING btree (id_cli_doc);


SET default_tablespace = saib;

--
-- TOC entry 2066 (class 1259 OID 27685)
-- Dependencies: 1672
-- Name: lesiones__partes_cuerpos_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX lesiones__partes_cuerpos_index ON lesiones__partes_cuerpos USING btree (id_les_par_cue);


--
-- TOC entry 2140 (class 1259 OID 27686)
-- Dependencies: 1696
-- Name: lesiones_partes_cuerpos__pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX lesiones_partes_cuerpos__pacientes_index ON lesiones_partes_cuerpos__pacientes USING btree (id_les_par_cue_pac);


--
-- TOC entry 2022 (class 1259 OID 27687)
-- Dependencies: 1652
-- Name: localizaciones_cuerpos_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX localizaciones_cuerpos_index ON localizaciones_cuerpos USING btree (id_loc_cue);


--
-- TOC entry 2071 (class 1259 OID 27688)
-- Dependencies: 1675
-- Name: muestras_clinicas_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX muestras_clinicas_index ON muestras_clinicas USING btree (id_mue_cli);


--
-- TOC entry 2032 (class 1259 OID 27689)
-- Dependencies: 1658
-- Name: pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX pacientes_index ON pacientes USING btree (id_pac);


--
-- TOC entry 2035 (class 1259 OID 27690)
-- Dependencies: 1659
-- Name: partes_cuerpos_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX partes_cuerpos_index ON partes_cuerpos USING btree (id_par_cue);


--
-- TOC entry 2074 (class 1259 OID 27691)
-- Dependencies: 1676
-- Name: propiedades_estudios_micologicos_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX propiedades_estudios_micologicos_index ON propiedades_estudios_micologicos USING btree (id_pro_est_mic);


--
-- TOC entry 2077 (class 1259 OID 27692)
-- Dependencies: 1677
-- Name: tipos_consultas_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX tipos_consultas_index ON tipos_consultas USING btree (id_tip_con);


--
-- TOC entry 2153 (class 1259 OID 27693)
-- Dependencies: 1700 1700 1700
-- Name: tipos_consultas_pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX tipos_consultas_pacientes_index ON tipos_consultas_pacientes USING btree (id_tip_con_pac, id_tip_con, id_his);


--
-- TOC entry 2038 (class 1259 OID 27694)
-- Dependencies: 1660
-- Name: tipos_estudios_micologicos_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX tipos_estudios_micologicos_index ON tipos_estudios_micologicos USING btree (id_tip_est_mic);


--
-- TOC entry 2025 (class 1259 OID 27695)
-- Dependencies: 1653
-- Name: tipos_micosis_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX tipos_micosis_index ON tipos_micosis USING btree (id_tip_mic);


--
-- TOC entry 2086 (class 1259 OID 27696)
-- Dependencies: 1682
-- Name: tratamientos_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX tratamientos_index ON tratamientos USING btree (id_tra);


--
-- TOC entry 2162 (class 1259 OID 27697)
-- Dependencies: 1703 1703 1703
-- Name: tratamientos_pacientes_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: saib
--

CREATE INDEX tratamientos_pacientes_index ON tratamientos_pacientes USING btree (id_tra_pac, id_his, id_tra);


--
-- TOC entry 2179 (class 2606 OID 27344)
-- Dependencies: 1664 1683 2047
-- Name: antecedentes_pacientes_id_ant_per_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_id_ant_per_fkey FOREIGN KEY (id_ant_per) REFERENCES antecedentes_personales(id_ant_per) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2178 (class 2606 OID 27339)
-- Dependencies: 1671 1683 2064
-- Name: antecedentes_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2182 (class 2606 OID 27367)
-- Dependencies: 1685 2069 1674
-- Name: auditoria_transacciones_id_mod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_id_mod_fkey FOREIGN KEY (id_mod) REFERENCES modulos(id_mod);


--
-- TOC entry 2181 (class 2606 OID 27362)
-- Dependencies: 2084 1681 1685
-- Name: auditoria_transacciones_id_tip_tra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_id_tip_tra_fkey FOREIGN KEY (id_tip_tra) REFERENCES transacciones(id_tip_tra);


--
-- TOC entry 2180 (class 2606 OID 27357)
-- Dependencies: 1685 1679 2080
-- Name: auditoria_transacciones_id_tip_usu_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu) REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu);


--
-- TOC entry 2184 (class 2606 OID 27385)
-- Dependencies: 2050 1665 1686
-- Name: categorias__cuerpos_micosis_id_cat_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2183 (class 2606 OID 27380)
-- Dependencies: 1686 1653 2026
-- Name: categorias__cuerpos_micosis_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2185 (class 2606 OID 27398)
-- Dependencies: 1665 1687 2050
-- Name: categorias_cuerpos_partes_cuerpos_id_cat_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_cuerpos_partes_cuerpos
    ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2186 (class 2606 OID 27403)
-- Dependencies: 2036 1687 1659
-- Name: categorias_cuerpos_partes_cuerpos_id_par_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias_cuerpos_partes_cuerpos
    ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_id_par_cue_fkey FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2188 (class 2606 OID 27421)
-- Dependencies: 1688 2053 1666
-- Name: centro_salud_pacientes_id_cen_sal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_id_cen_sal_fkey FOREIGN KEY (id_cen_sal) REFERENCES centro_salud(id_cen_sal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2187 (class 2606 OID 27416)
-- Dependencies: 2064 1671 1688
-- Name: centro_salud_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2189 (class 2606 OID 27436)
-- Dependencies: 1668 2055 1690
-- Name: clinicas_doctores_id_cli_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clinicas_doctores
    ADD CONSTRAINT clinicas_doctores_id_cli_fkey FOREIGN KEY (id_cli) REFERENCES clinicas(id_cli) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2190 (class 2606 OID 27441)
-- Dependencies: 2030 1690 1657
-- Name: clinicas_doctores_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clinicas_doctores
    ADD CONSTRAINT clinicas_doctores_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2192 (class 2606 OID 27460)
-- Dependencies: 1663 2044 1691
-- Name: contactos_animales_id_ani_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_id_ani_fkey FOREIGN KEY (id_ani) REFERENCES animales(id_ani) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2191 (class 2606 OID 27455)
-- Dependencies: 1671 1691 2064
-- Name: contactos_animales_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2167 (class 2606 OID 27141)
-- Dependencies: 2028 1655 1657
-- Name: doctores_id_tip_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY doctores
    ADD CONSTRAINT doctores_id_tip_usu_fkey FOREIGN KEY (id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2171 (class 2606 OID 27228)
-- Dependencies: 1669 1653 2026
-- Name: enfermedades_micologicas_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY enfermedades_micologicas
    ADD CONSTRAINT enfermedades_micologicas_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2194 (class 2606 OID 27478)
-- Dependencies: 1692 1669 2058
-- Name: enfermedades_pacientes_id_enf_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_id_enf_mic_fkey FOREIGN KEY (id_enf_mic) REFERENCES enfermedades_micologicas(id_enf_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2193 (class 2606 OID 27473)
-- Dependencies: 1692 2064 1671
-- Name: enfermedades_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2195 (class 2606 OID 27491)
-- Dependencies: 1693 2064 1671
-- Name: estudios_micologicos__pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudios_micologicos__pacientes
    ADD CONSTRAINT estudios_micologicos__pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2196 (class 2606 OID 27496)
-- Dependencies: 1693 1676 2075
-- Name: estudios_micologicos__pacientes_id_pro_est_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estudios_micologicos__pacientes
    ADD CONSTRAINT estudios_micologicos__pacientes_id_pro_est_mic_fkey FOREIGN KEY (id_pro_est_mic) REFERENCES propiedades_estudios_micologicos(id_pro_est_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2197 (class 2606 OID 27509)
-- Dependencies: 1670 2061 1694
-- Name: forma_infecciones__pacientes_id_for_inf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_id_for_inf_fkey FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2198 (class 2606 OID 27514)
-- Dependencies: 1694 1671 2064
-- Name: forma_infecciones__pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2200 (class 2606 OID 27532)
-- Dependencies: 1695 1670 2061
-- Name: forma_infecciones__tipos_micosis_id_for_inf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_id_for_inf_fkey FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2199 (class 2606 OID 27527)
-- Dependencies: 1653 1695 2026
-- Name: forma_infecciones__tipos_micosis_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2172 (class 2606 OID 27245)
-- Dependencies: 1671 2033 1658
-- Name: historiales_pacientes_id_pac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_id_pac_fkey FOREIGN KEY (id_pac) REFERENCES pacientes(id_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2173 (class 2606 OID 27256)
-- Dependencies: 1659 2036 1672
-- Name: lesiones__partes_cuerpos_id_par_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lesiones__partes_cuerpos
    ADD CONSTRAINT lesiones__partes_cuerpos_id_par_cue_fkey FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2201 (class 2606 OID 27545)
-- Dependencies: 1696 2064 1671
-- Name: lesiones_partes_cuerpos__pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2202 (class 2606 OID 27550)
-- Dependencies: 2067 1696 1672
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_les_par_cue_fkey FOREIGN KEY (id_les_par_cue) REFERENCES lesiones__partes_cuerpos(id_les_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2203 (class 2606 OID 27565)
-- Dependencies: 2069 1674 1698
-- Name: modulo_usuarios_id_mod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY modulo_usuarios
    ADD CONSTRAINT modulo_usuarios_id_mod_fkey FOREIGN KEY (id_mod) REFERENCES modulos(id_mod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2204 (class 2606 OID 27570)
-- Dependencies: 1698 2080 1679
-- Name: modulo_usuarios_id_tip_usu_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY modulo_usuarios
    ADD CONSTRAINT modulo_usuarios_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu) REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu);


--
-- TOC entry 2205 (class 2606 OID 27583)
-- Dependencies: 1671 1699 2064
-- Name: muestras_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2206 (class 2606 OID 27588)
-- Dependencies: 2072 1675 1699
-- Name: muestras_pacientes_id_mue_cli_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_id_mue_cli_fkey FOREIGN KEY (id_mue_cli) REFERENCES muestras_clinicas(id_mue_cli) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2168 (class 2606 OID 27161)
-- Dependencies: 1652 1659 2023
-- Name: partes_cuerpos_id_loc_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY partes_cuerpos
    ADD CONSTRAINT partes_cuerpos_id_loc_cue_fkey FOREIGN KEY (id_loc_cue) REFERENCES localizaciones_cuerpos(id_loc_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2174 (class 2606 OID 27281)
-- Dependencies: 1676 2039 1660
-- Name: propiedades_estudios_micologicos_id_tip_est_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY propiedades_estudios_micologicos
    ADD CONSTRAINT propiedades_estudios_micologicos_id_tip_est_mic_fkey FOREIGN KEY (id_tip_est_mic) REFERENCES tipos_estudios_micologicos(id_tip_est_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2208 (class 2606 OID 27606)
-- Dependencies: 2064 1671 1700
-- Name: tipos_consultas_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2207 (class 2606 OID 27601)
-- Dependencies: 2078 1700 1677
-- Name: tipos_consultas_pacientes_id_tip_con_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_id_tip_con_fkey FOREIGN KEY (id_tip_con) REFERENCES tipos_consultas(id_tip_con) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2169 (class 2606 OID 27172)
-- Dependencies: 2026 1660 1653
-- Name: tipos_estudios_micologicos_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2175 (class 2606 OID 27302)
-- Dependencies: 1657 1679 2030
-- Name: tipos_usuarios__usuarios_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON DELETE CASCADE;


--
-- TOC entry 2177 (class 2606 OID 27312)
-- Dependencies: 2041 1662 1679
-- Name: tipos_usuarios__usuarios_id_tip_adm_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_tip_adm_fkey FOREIGN KEY (id_tip_adm) REFERENCES usuarios_administrativos(id_usu_adm);


--
-- TOC entry 2176 (class 2606 OID 27307)
-- Dependencies: 2028 1679 1655
-- Name: tipos_usuarios__usuarios_id_tip_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_tip_usu_fkey FOREIGN KEY (id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu);


--
-- TOC entry 2210 (class 2606 OID 27626)
-- Dependencies: 2084 1702 1681
-- Name: transacciones_usuarios_id_tip_tra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_id_tip_tra_fkey FOREIGN KEY (id_tip_tra) REFERENCES transacciones(id_tip_tra) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2209 (class 2606 OID 27621)
-- Dependencies: 2080 1702 1679
-- Name: transacciones_usuarios_id_tip_usu_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu) REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu);


--
-- TOC entry 2211 (class 2606 OID 27639)
-- Dependencies: 1703 1671 2064
-- Name: tratamientos_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2212 (class 2606 OID 27644)
-- Dependencies: 1682 1703 2087
-- Name: tratamientos_pacientes_id_tra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_id_tra_fkey FOREIGN KEY (id_tra) REFERENCES tratamientos(id_tra) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2170 (class 2606 OID 27185)
-- Dependencies: 1655 1662 2028
-- Name: usuarios_administrativos_id_tip_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_administrativos
    ADD CONSTRAINT usuarios_administrativos_id_tip_usu_fkey FOREIGN KEY (id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu) ON DELETE RESTRICT;


--
-- TOC entry 2258 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2011-02-27 23:35:12

--
-- PostgreSQL database dump complete
--

