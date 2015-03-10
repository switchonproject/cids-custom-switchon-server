--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.5
-- Dumped by pg_dump version 9.3.1
-- Started on 2015-03-10 17:53:28

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 250 (class 1259 OID 52012)
-- Name: cs_all_attr_mapping; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_all_attr_mapping (
    class_id integer NOT NULL,
    object_id integer NOT NULL,
    attr_class_id integer NOT NULL,
    attr_object_id integer NOT NULL,
    id integer DEFAULT nextval('cs_all_attr_mapping_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_all_attr_mapping OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 52016)
-- Name: cs_attr; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_attr (
    id integer DEFAULT nextval(('cs_attr_sequence'::text)::regclass) NOT NULL,
    class_id integer NOT NULL,
    type_id integer NOT NULL,
    name character varying(100) NOT NULL,
    field_name character varying(50) NOT NULL,
    foreign_key boolean DEFAULT false NOT NULL,
    substitute boolean DEFAULT false NOT NULL,
    foreign_key_references_to integer,
    descr text,
    visible boolean DEFAULT true NOT NULL,
    indexed boolean DEFAULT false NOT NULL,
    isarray boolean DEFAULT false NOT NULL,
    array_key character varying(30),
    editor integer,
    tostring integer,
    complex_editor integer,
    optional boolean DEFAULT true NOT NULL,
    default_value character varying(100),
    from_string integer,
    pos integer DEFAULT 0,
    "precision" integer,
    scale integer,
    extension_attr boolean DEFAULT false NOT NULL
);


ALTER TABLE public.cs_attr OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 52031)
-- Name: cs_attr_object; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_attr_object (
    class_id integer NOT NULL,
    object_id integer NOT NULL,
    attr_class_id integer NOT NULL,
    attr_object_id integer NOT NULL
);


ALTER TABLE public.cs_attr_object OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 52034)
-- Name: cs_attr_object_derived; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_attr_object_derived (
    class_id integer NOT NULL,
    object_id integer NOT NULL,
    attr_class_id integer NOT NULL,
    attr_object_id integer NOT NULL
);


ALTER TABLE public.cs_attr_object_derived OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 52039)
-- Name: cs_attr_string; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_attr_string (
    class_id integer NOT NULL,
    attr_id integer NOT NULL,
    object_id integer NOT NULL,
    string_val text NOT NULL
);


ALTER TABLE public.cs_attr_string OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 52047)
-- Name: cs_cat_link; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_cat_link (
    id_from integer NOT NULL,
    id_to integer NOT NULL,
    org text,
    domain_to integer,
    id integer DEFAULT nextval('cs_cat_link_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_cat_link OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 52054)
-- Name: cs_cat_node; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_cat_node (
    id integer DEFAULT nextval(('cs_cat_node_sequence'::text)::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    descr integer DEFAULT 1,
    class_id integer,
    object_id integer,
    node_type character(1) DEFAULT 'N'::bpchar NOT NULL,
    is_root boolean DEFAULT false NOT NULL,
    org text,
    dynamic_children text,
    sql_sort boolean,
    policy integer,
    derive_permissions_from_class boolean DEFAULT true,
    iconfactory integer,
    icon character varying(512),
    artifical_id character varying(200)
);


ALTER TABLE public.cs_cat_node OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 52067)
-- Name: cs_class; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_class (
    id integer DEFAULT nextval(('cs_class_sequence'::text)::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    descr text,
    class_icon_id integer NOT NULL,
    object_icon_id integer NOT NULL,
    table_name character varying(100) NOT NULL,
    primary_key_field character varying(100) DEFAULT 'ID'::character varying NOT NULL,
    indexed boolean DEFAULT false NOT NULL,
    tostring integer,
    editor integer,
    renderer integer,
    array_link boolean DEFAULT false NOT NULL,
    policy integer,
    attribute_policy integer
);


ALTER TABLE public.cs_class OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 52079)
-- Name: cs_class_attr; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_class_attr (
    id integer DEFAULT nextval('cs_class_attr_sequence'::regclass) NOT NULL,
    class_id integer NOT NULL,
    type_id integer NOT NULL,
    attr_key character varying(100) NOT NULL,
    attr_value text
);


ALTER TABLE public.cs_class_attr OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 52094)
-- Name: cs_config_attr_exempt; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_exempt (
    id integer DEFAULT nextval('cs_config_attr_exempt_sequence'::regclass) NOT NULL,
    usr_id integer NOT NULL,
    key_id integer,
    ug_id integer NOT NULL
);


ALTER TABLE public.cs_config_attr_exempt OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 52100)
-- Name: cs_config_attr_jt; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_jt (
    id integer DEFAULT nextval('cs_config_attr_jt_sequence'::regclass) NOT NULL,
    usr_id integer,
    ug_id integer,
    dom_id integer NOT NULL,
    key_id integer NOT NULL,
    val_id integer NOT NULL,
    type_id integer
);


ALTER TABLE public.cs_config_attr_jt OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 52106)
-- Name: cs_config_attr_key; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_key (
    id integer DEFAULT nextval('cs_config_attr_key_sequence'::regclass) NOT NULL,
    key character varying(200) NOT NULL
);


ALTER TABLE public.cs_config_attr_key OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 52112)
-- Name: cs_config_attr_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_type (
    id integer DEFAULT nextval('cs_config_attr_type_sequence'::regclass) NOT NULL,
    type character(1) NOT NULL,
    descr character varying(200)
);


ALTER TABLE public.cs_config_attr_type OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 52118)
-- Name: cs_config_attr_value; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_value (
    id integer DEFAULT nextval('cs_config_attr_value_sequence'::regclass) NOT NULL,
    value text
);


ALTER TABLE public.cs_config_attr_value OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 52127)
-- Name: cs_domain; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_domain (
    id integer DEFAULT nextval('cs_domain_sequence'::regclass) NOT NULL,
    name character varying(30)
);


ALTER TABLE public.cs_domain OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 52131)
-- Name: cs_dynamic_children_helper; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_dynamic_children_helper (
    id integer NOT NULL,
    name character varying(256),
    code text
);


ALTER TABLE public.cs_dynamic_children_helper OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 52137)
-- Name: cs_dynamic_children_helper_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_dynamic_children_helper_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_dynamic_children_helper_id_seq OWNER TO postgres;

--
-- TOC entry 4090 (class 0 OID 0)
-- Dependencies: 278
-- Name: cs_dynamic_children_helper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cs_dynamic_children_helper_id_seq OWNED BY cs_dynamic_children_helper.id;


--
-- TOC entry 279 (class 1259 OID 52139)
-- Name: cs_history; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_history (
    class_id integer NOT NULL,
    object_id integer NOT NULL,
    usr_id integer,
    ug_id integer,
    valid_from timestamp without time zone NOT NULL,
    json_data text NOT NULL
);


ALTER TABLE public.cs_history OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 52147)
-- Name: cs_icon; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_icon (
    id integer DEFAULT nextval('cs_icon_sequence'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    file_name character varying(100) DEFAULT 'default_icon.gif'::character varying NOT NULL
);


ALTER TABLE public.cs_icon OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 52154)
-- Name: cs_java_class; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_java_class (
    id integer DEFAULT nextval('cs_java_class_sequence'::regclass) NOT NULL,
    qualifier character varying(100),
    type character varying(100) DEFAULT 'unknown'::character varying NOT NULL,
    notice character varying(500)
);


ALTER TABLE public.cs_java_class OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 52164)
-- Name: cs_locks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_locks (
    class_id integer,
    object_id integer,
    user_string character varying(256),
    additional_info character varying(256),
    id integer DEFAULT nextval('cs_locks_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_locks OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 52171)
-- Name: cs_method; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_method (
    id integer DEFAULT nextval(('cs_method_sequence'::text)::regclass) NOT NULL,
    descr text,
    mult boolean DEFAULT false NOT NULL,
    class_mult boolean DEFAULT false NOT NULL,
    plugin_id character varying(30) DEFAULT ''::character varying NOT NULL,
    method_id character varying(100) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.cs_method OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 52184)
-- Name: cs_method_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_method_class_assoc (
    class_id integer NOT NULL,
    method_id integer NOT NULL,
    id integer DEFAULT nextval('cs_method_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_method_class_assoc OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 52192)
-- Name: cs_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_permission (
    id integer DEFAULT nextval('cs_permission_sequence'::regclass) NOT NULL,
    key character varying(10),
    description character varying(100)
);


ALTER TABLE public.cs_permission OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 52198)
-- Name: cs_policy; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_policy (
    id integer DEFAULT nextval('cs_policy_sequence'::regclass) NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.cs_policy OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 52204)
-- Name: cs_policy_rule; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_policy_rule (
    id integer DEFAULT nextval('cs_policy_rule_sequence'::regclass) NOT NULL,
    policy integer NOT NULL,
    permission integer NOT NULL,
    default_value boolean NOT NULL
);


ALTER TABLE public.cs_policy_rule OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 52208)
-- Name: cs_query; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query (
    id integer DEFAULT nextval(('cs_query_sequence'::text)::regclass) NOT NULL,
    name character varying(256) NOT NULL,
    descr text,
    statement text,
    result integer,
    is_update boolean DEFAULT false NOT NULL,
    is_union boolean DEFAULT false NOT NULL,
    is_root boolean DEFAULT false NOT NULL,
    is_batch boolean DEFAULT false NOT NULL,
    conjunction boolean DEFAULT false NOT NULL,
    is_search boolean DEFAULT false NOT NULL
);


ALTER TABLE public.cs_query OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 52223)
-- Name: cs_query_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_class_assoc (
    class_id integer NOT NULL,
    query_id integer NOT NULL,
    id integer DEFAULT nextval('cs_query_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_query_class_assoc OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 52229)
-- Name: cs_query_link; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_link (
    id integer DEFAULT nextval('cs_query_link_sequence'::regclass) NOT NULL,
    id_from integer NOT NULL,
    id_to integer NOT NULL,
    domain_to integer
);


ALTER TABLE public.cs_query_link OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 52233)
-- Name: cs_query_parameter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_parameter (
    id integer DEFAULT nextval(('cs_query_parameter_sequence'::text)::regclass) NOT NULL,
    query_id integer NOT NULL,
    param_key character varying(100) NOT NULL,
    descr text,
    is_query_result boolean DEFAULT false NOT NULL,
    type_id integer,
    query_position integer DEFAULT 0
);


ALTER TABLE public.cs_query_parameter OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 52248)
-- Name: cs_query_store; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_store (
    id integer DEFAULT nextval('cs_query_store_sequence'::regclass) NOT NULL,
    user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    file_name character varying(100) NOT NULL
);


ALTER TABLE public.cs_query_store OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 52254)
-- Name: cs_query_store_ug_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_store_ug_assoc (
    ug_id integer NOT NULL,
    query_store_id integer NOT NULL,
    permission integer,
    domain integer,
    id integer DEFAULT nextval('cs_query_store_ug_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_query_store_ug_assoc OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 52260)
-- Name: cs_query_ug_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_ug_assoc (
    ug_id integer NOT NULL,
    query_id integer NOT NULL,
    permission integer,
    domain integer,
    id integer DEFAULT nextval('cs_query_ug_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_query_ug_assoc OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 52264)
-- Name: cs_stringrepcache; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_stringrepcache (
    class_id integer NOT NULL,
    object_id integer NOT NULL,
    stringrep character varying(512)
);


ALTER TABLE public.cs_stringrepcache OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 52270)
-- Name: cs_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_type (
    id integer DEFAULT nextval(('cs_type_sequence'::text)::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    class_id integer,
    complex_type boolean DEFAULT false NOT NULL,
    descr text,
    editor integer,
    renderer integer
);


ALTER TABLE public.cs_type OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 52282)
-- Name: cs_ug; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_ug (
    id integer DEFAULT nextval('cs_ug_sequence'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    descr text,
    domain integer NOT NULL,
    prio integer NOT NULL
);


ALTER TABLE public.cs_ug OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 52289)
-- Name: cs_ug_attr_perm; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_ug_attr_perm (
    id integer DEFAULT nextval(('cs_ug_attr_perm_sequence'::text)::regclass) NOT NULL,
    ug_id integer NOT NULL,
    attr_id integer NOT NULL,
    permission integer,
    domain integer
);


ALTER TABLE public.cs_ug_attr_perm OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 52295)
-- Name: cs_ug_cat_node_perm; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_ug_cat_node_perm (
    id integer DEFAULT nextval(('cs_ug_cat_node_perm_sequence'::text)::regclass) NOT NULL,
    ug_id integer NOT NULL,
    domain integer,
    cat_node_id integer NOT NULL,
    permission integer
);


ALTER TABLE public.cs_ug_cat_node_perm OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 52303)
-- Name: cs_ug_class_perm; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_ug_class_perm (
    id integer DEFAULT nextval('cs_ug_class_perm_sequence'::regclass) NOT NULL,
    ug_id integer NOT NULL,
    class_id integer NOT NULL,
    permission integer,
    domain integer
);


ALTER TABLE public.cs_ug_class_perm OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 52309)
-- Name: cs_ug_membership; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_ug_membership (
    ug_id integer NOT NULL,
    usr_id integer NOT NULL,
    ug_domain integer,
    id integer DEFAULT nextval('cs_ug_membership_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_ug_membership OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 52313)
-- Name: cs_ug_method_perm; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_ug_method_perm (
    id integer DEFAULT nextval(('cs_ug_method_perm_sequence'::text)::regclass) NOT NULL,
    ug_id integer NOT NULL,
    domain integer,
    method_id integer NOT NULL,
    permission integer
);


ALTER TABLE public.cs_ug_method_perm OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 52319)
-- Name: cs_usr; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_usr (
    id integer DEFAULT nextval(('cs_usr_sequence'::text)::regclass) NOT NULL,
    login_name character varying(32) NOT NULL,
    password character varying(16),
    last_pwd_change timestamp without time zone NOT NULL,
    administrator boolean DEFAULT false NOT NULL
);


ALTER TABLE public.cs_usr OWNER TO postgres;

--
-- TOC entry 3769 (class 2604 OID 52473)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_dynamic_children_helper ALTER COLUMN id SET DEFAULT nextval('cs_dynamic_children_helper_id_seq'::regclass);


--
-- TOC entry 4044 (class 0 OID 52012)
-- Dependencies: 250
-- Data for Name: cs_all_attr_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4045 (class 0 OID 52016)
-- Dependencies: 251
-- Data for Name: cs_attr; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_attr VALUES (1, 1, 2, 'ID', 'ID', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (2, 1, 1, 'GEO_STRING', 'GEO_FIELD', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (3, 3, 2, 'ID', 'ID', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (4, 3, 8, 'PROT_PREFIX', 'PROT_PREFIX', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (5, 3, 9, 'PATH', 'PATH', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (6, 3, 9, 'SERVER', 'SERVER', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (7, 2, 2, 'ID', 'ID', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (8, 2, 9, 'OBJECT_NAME', 'OBJECT_NAME', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (9, 2, 17, 'URL_BASE_ID', 'URL_BASE_ID', true, false, 3, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (10, 4, 8, 'organisation', 'organisation', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 100, NULL, false);
INSERT INTO cs_attr VALUES (11, 4, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, 100, NULL, false);
INSERT INTO cs_attr VALUES (12, 4, 8, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, 200, NULL, false);
INSERT INTO cs_attr VALUES (13, 4, 8, 'email', 'email', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (14, 4, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (15, 4, 8, 'url', 'url', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, 1024, NULL, false);
INSERT INTO cs_attr VALUES (16, 5, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (17, 5, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 64, NULL, false);
INSERT INTO cs_attr VALUES (18, 5, 8, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, 800, NULL, false);
INSERT INTO cs_attr VALUES (19, 6, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 200, NULL, false);
INSERT INTO cs_attr VALUES (20, 6, 21, 'taggroup', 'taggroup', true, false, 5, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (21, 6, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (22, 6, 9, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (24, 4, 22, 'role', 'role', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (25, 7, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (29, 7, 8, 'contentLocation', 'contentlocation', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 13, 1024, NULL, false);
INSERT INTO cs_attr VALUES (30, 7, 8, 'temporalResolution', 'temporalresolution', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 10, 100, NULL, false);
INSERT INTO cs_attr VALUES (31, 7, 22, 'protocol', 'protocol', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (32, 7, 9, 'content', 'content', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (33, 7, 2, 'spatialScale', 'spatialscale', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr VALUES (34, 7, 22, 'function', 'function', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (36, 7, 8, 'spatialResolution', 'spatialresolution', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 11, 100, NULL, false);
INSERT INTO cs_attr VALUES (37, 7, 22, 'applicationprofile', 'applicationprofile', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 8, NULL, NULL, false);
INSERT INTO cs_attr VALUES (38, 7, 22, 'type', 'type', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (39, 8, 22, 'tag', 'tagid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (40, 8, 2, 'representation_reference', 'representation_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (41, 8, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (42, 7, 24, 'tags', 'tags', true, false, 8, NULL, true, false, true, 'representation_reference', NULL, NULL, NULL, true, NULL, NULL, 14, NULL, NULL, false);
INSERT INTO cs_attr VALUES (43, 9, 22, 'tag', 'tagid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (44, 9, 2, 'resource_reference', 'resource_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (45, 9, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (46, 10, 22, 'tag', 'tagid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (47, 10, 2, 'metadata_reference', 'metadata_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (48, 10, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (49, 11, 22, 'tag', 'tagid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (50, 11, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (51, 11, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (53, 12, 2, 'resource_reference', 'resource_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (54, 12, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (55, 13, 22, 'type', 'type', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 9, NULL, NULL, false);
INSERT INTO cs_attr VALUES (56, 13, 14, 'fromDate', 'fromdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (57, 13, 22, 'location', 'location', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 10, NULL, NULL, false);
INSERT INTO cs_attr VALUES (58, 13, 22, 'topiccategory', 'topiccategory', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 11, NULL, NULL, false);
INSERT INTO cs_attr VALUES (59, 13, 14, 'creationdate', 'creationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr VALUES (62, 13, 20, 'contact', 'contact', true, false, 4, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 16, NULL, NULL, false);
INSERT INTO cs_attr VALUES (63, 13, 22, 'accessconditions', 'accessconditions', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (64, 13, 14, 'lastModificationDate', 'lastmodificationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 19, NULL, NULL, false);
INSERT INTO cs_attr VALUES (65, 13, 22, 'geography', 'geography', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 17, NULL, NULL, false);
INSERT INTO cs_attr VALUES (68, 13, 22, 'conformity', 'conformity', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (69, 13, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (70, 13, 22, 'srid', 'srid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (72, 13, 22, 'language', 'language', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (73, 13, 25, 'tags', 'tags', true, false, 9, NULL, true, false, true, 'resource_reference', NULL, NULL, NULL, true, NULL, NULL, 15, NULL, NULL, false);
INSERT INTO cs_attr VALUES (74, 13, 9, 'licensestatement', 'licensestatement', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 14, NULL, NULL, false);
INSERT INTO cs_attr VALUES (75, 13, 14, 'toDate', 'todate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (76, 14, 2, 'resource_reference', 'resource_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (77, 14, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (78, 15, 8, 'contentLocation', 'contentlocation', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 9, 1024, NULL, false);
INSERT INTO cs_attr VALUES (79, 15, 22, 'language', 'language', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (80, 15, 22, 'type', 'type', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (81, 15, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (82, 15, 9, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (83, 15, 26, 'tags', 'tags', true, false, 10, NULL, true, false, true, 'metadata_reference', NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (84, 15, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 150, NULL, false);
INSERT INTO cs_attr VALUES (86, 15, 22, 'standard', 'standard', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (89, 13, 22, 'collection', 'collection', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 24, NULL, NULL, false);
INSERT INTO cs_attr VALUES (90, 13, 8, 'uuid', 'uuid', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 23, 200, NULL, false);
INSERT INTO cs_attr VALUES (92, 13, 22, 'accesslimitations', 'accesslimitations', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 22, NULL, NULL, false);
INSERT INTO cs_attr VALUES (87, 15, 20, 'contact', 'contact', true, false, 4, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (66, 13, 8, 'name', 'name', false, false, NULL, NULL, true, true, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 13, 150, NULL, false);
INSERT INTO cs_attr VALUES (60, 13, 9, 'description', 'description', false, false, NULL, NULL, true, true, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 8, NULL, NULL, false);
INSERT INTO cs_attr VALUES (67, 13, 19, 'spatialCoverage', 'spatialcoverage', true, false, 1, NULL, true, true, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (93, 13, 30, 'metadata', 'metadata', true, false, 14, NULL, true, false, true, 'resource_reference', NULL, NULL, NULL, true, NULL, NULL, 20, NULL, NULL, false);
INSERT INTO cs_attr VALUES (95, 16, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (96, 16, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (98, 17, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (99, 17, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (88, 14, 31, 'metadata', 'metadataid', true, false, 15, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (97, 17, 31, 'metadata', 'metadataid', true, false, 15, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (94, 16, 29, 'resource', 'resourceid', true, false, 13, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (85, 15, 8, 'uuid', 'uuid', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 8, 200, NULL, false);
INSERT INTO cs_attr VALUES (61, 13, 28, 'representation', 'representation', true, false, 12, NULL, true, false, true, 'resource_reference', NULL, NULL, NULL, true, NULL, NULL, 18, NULL, NULL, false);
INSERT INTO cs_attr VALUES (52, 12, 23, 'representation', 'representationid', true, false, 7, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (100, 18, 33, 'metadata', 'metadata', true, false, 17, NULL, true, false, true, 'relationship_reference', NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (101, 18, 32, 'fromResources', 'fromresources', true, false, 16, NULL, true, false, true, 'relationship_reference', NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (102, 18, 8, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, 200, NULL, false);
INSERT INTO cs_attr VALUES (103, 18, 29, 'toResource', 'toresource', true, false, 13, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (104, 18, 2, 'id', 'ID', false, false, NULL, 'PrimÃ¤rschlÃ¼ssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (105, 18, 27, 'tags', 'tags', true, false, 11, NULL, true, false, true, 'relationship_reference', NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (106, 18, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 150, NULL, false);
INSERT INTO cs_attr VALUES (107, 18, 22, 'type', 'type', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (108, 7, 22, 'contentType', 'contenttype', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 15, NULL, NULL, false);
INSERT INTO cs_attr VALUES (109, 15, 22, 'contenttype', 'contenttype', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 11, NULL, NULL, false);
INSERT INTO cs_attr VALUES (111, 15, 9, 'content', 'content', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr VALUES (23, 7, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, 200, NULL, false);
INSERT INTO cs_attr VALUES (28, 7, 9, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (26, 13, 14, 'publicationdate', 'publicationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 25, NULL, NULL, false);
INSERT INTO cs_attr VALUES (35, 7, 8, 'uuid', 'uuid', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 9, 200, NULL, false);
INSERT INTO cs_attr VALUES (115, 7, 22, 'uploadStatus', 'uploadstatus', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 16, NULL, NULL, false);
INSERT INTO cs_attr VALUES (116, 7, 9, 'uploadMessage', 'uploadmessage', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 17, NULL, NULL, false);
INSERT INTO cs_attr VALUES (110, 15, 14, 'creationdate', 'creationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 10, NULL, NULL, false);


--
-- TOC entry 4046 (class 0 OID 52031)
-- Dependencies: 252
-- Data for Name: cs_attr_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_attr_object VALUES (13, 7205, 1, 7230);
INSERT INTO cs_attr_object VALUES (13, 7204, 1, 7231);
INSERT INTO cs_attr_object VALUES (13, 7206, 1, 7232);
INSERT INTO cs_attr_object VALUES (13, 7203, 1, 7233);
INSERT INTO cs_attr_object VALUES (13, 7202, 1, 7234);
INSERT INTO cs_attr_object VALUES (13, 7207, 1, 7235);
INSERT INTO cs_attr_object VALUES (13, 7208, 1, 7236);


--
-- TOC entry 4047 (class 0 OID 52034)
-- Dependencies: 253
-- Data for Name: cs_attr_object_derived; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4048 (class 0 OID 52039)
-- Dependencies: 255
-- Data for Name: cs_attr_string; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_attr_string VALUES (13, 60, 7205, 'Positions for gauging stations in Europe. Locations adjusted according to E-HYPE2.5 subbasin division.');
INSERT INTO cs_attr_string VALUES (13, 66, 7205, 'Observed discharge');
INSERT INTO cs_attr_string VALUES (13, 60, 7204, 'Time series descriping corrected presipitation for each E-HYPE subbasin. The data describes daily values for each subbasin.
Unit of measurement: mm');
INSERT INTO cs_attr_string VALUES (13, 66, 7204, 'Corrected precipitation');
INSERT INTO cs_attr_string VALUES (13, 60, 7206, 'Soils based on subbasin division. The data shows proportions of soil classes for each land-use class and subbasin.
Unit of measurement: %');
INSERT INTO cs_attr_string VALUES (13, 66, 7206, 'Soils on subbasins');
INSERT INTO cs_attr_string VALUES (13, 60, 7203, 'Land use based on subbasin division. The data shows proportions of land-use for each land-use class and subbasin.
Unit of measurement: %');
INSERT INTO cs_attr_string VALUES (13, 66, 7203, 'Land-use on subbasins');
INSERT INTO cs_attr_string VALUES (13, 60, 7202, 'Time series descriping modeled river discharge for each E-HYPE subbasin. The data describes daily values for each subbasin. 
Unit of measurement: m3/s');
INSERT INTO cs_attr_string VALUES (13, 66, 7202, 'River discharge');
INSERT INTO cs_attr_string VALUES (13, 60, 7207, 'Polygons and links between them has been developed at SMHI based on the hydrological corrected databases Hydrosheds and Hydro1K with some manual adjustments and quality control against published values of catchment areas for European gauging stations.');
INSERT INTO cs_attr_string VALUES (13, 66, 7207, 'Subbasin division');
INSERT INTO cs_attr_string VALUES (13, 60, 7208, 'Time series descriping corrected air temperature for each E-HYPE subbasin. The data describes daily values for each subbasin.
Unit of measurement: degress Celsius');
INSERT INTO cs_attr_string VALUES (13, 66, 7208, 'Corrected temperature');


--
-- TOC entry 4049 (class 0 OID 52047)
-- Dependencies: 257
-- Data for Name: cs_cat_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_cat_link VALUES (1, 2, NULL, 1, 1);
INSERT INTO cs_cat_link VALUES (1, 3, NULL, 1, 2);
INSERT INTO cs_cat_link VALUES (7, 8, NULL, 1, 6);
INSERT INTO cs_cat_link VALUES (7, 9, NULL, 1, 7);


--
-- TOC entry 4050 (class 0 OID 52054)
-- Dependencies: 258
-- Data for Name: cs_cat_node; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_cat_node VALUES (1, 'SWITCH-ON', NULL, NULL, NULL, 'N', true, NULL, NULL, true, NULL, false, NULL, NULL, NULL);
INSERT INTO cs_cat_node VALUES (7, 'Administration', NULL, NULL, NULL, 'N', true, NULL, NULL, false, NULL, false, NULL, NULL, NULL);
INSERT INTO cs_cat_node VALUES (8, 'Entities', NULL, NULL, NULL, 'N', false, NULL, 'SELECT 
 	-1 as id, 
 	cs_class.name, 
 	cs_class.id as class_id, 
 	null as object_id, 
 	''N'' as node_type, 
 	null as url, 
 	csdc.cidsobjects(cs_class.id::varchar , cs_class.table_name) as dynamic_children, 
 	true as sql_sort,
        true AS derive_permissions_from_class   
     FROM 
 	cs_class,
 	cs_attr
     WHERE cs_class.id = cs_attr.class_id
 	AND cs_attr.field_name ilike ''name''
     ORDER BY cs_class.name;', true, NULL, false, NULL, NULL, NULL);
INSERT INTO cs_cat_node VALUES (2, 'Internal', NULL, NULL, NULL, 'N', false, NULL, 'SELECT 
 	-1 as id, 
 	tag.name, 
 	cs_class.id as class_id, 
 	null as object_id, 
 	''N'' as node_type, 
 	null as url, 
 	csdc.hydrologicalconcepts(tag.id) as dynamic_children,
 	true as sql_sort,
        true AS derive_permissions_from_class
     FROM 
 	tag
 	LEFT JOIN taggroup ON
 		tag.taggroup = taggroup.id,
         cs_class
     WHERE
        cs_class.name = ''tag'' AND
 	taggroup.name = ''geography''
     GROUP BY 
 	tag.name,
 	tag.id,
        cs_class.id
     ORDER BY tag.name ASC;', true, NULL, false, NULL, NULL, NULL);
INSERT INTO cs_cat_node VALUES (3, 'External', NULL, NULL, NULL, 'N', false, NULL, 'SELECT 
        -1 as id, 
	tag.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.collectionsexternal(tag.id) as dynamic_children,
	true as sql_sort,
        true AS derive_permissions_from_class
    FROM 
	tag
	LEFT JOIN taggroup ON
		tag.taggroup = taggroup.id
        LEFT JOIN resource  ON
             resource.collection = tag.id,
        cs_class        
    WHERE
        cs_class.name = ''tag'' AND
	taggroup.name = ''collection'' AND
        resource."type" = (
            SELECT tag.id FROM tag 
            LEFT JOIN taggroup ON tag.taggroup = taggroup.id
            WHERE taggroup.name = ''resource type'' AND
                  tag.name = ''external data'')
    GROUP BY 
	tag.name,
	tag.id,
        cs_class.id 
    HAVING ( COUNT(resource.id) > 0 )
    ORDER BY tag.name ASC;', true, NULL, false, NULL, NULL, NULL);
INSERT INTO cs_cat_node VALUES (9, 'Taggroups and Tags', NULL, NULL, NULL, 'N', false, NULL, 'SELECT 
 	-1 as id, 
 	taggroup.name, 
 	cs_class.id as class_id, 
 	null as object_id, 
 	''N'' as node_type, 
 	null as url, 
 	csdc.tags(taggroup.id) as dynamic_children,
 	false as sql_sort 
     FROM 
 	taggroup,
        cs_class
     WHERE
         cs_class.name = ''taggroup''
     ORDER BY taggroup.name;', false, NULL, false, NULL, NULL, NULL);
INSERT INTO cs_cat_node VALUES (5, 'Entities', NULL, NULL, NULL, 'N', false, NULL, 'SELECT 
	-1 as id, 
	cs_class.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.cidsobjects(cs_class.id::varchar , cs_class.table_name) as dynamic_children, 
	true as sql_sort,
        true AS derive_permissions_from_class
    FROM 
	cs_class,
	cs_attr
    WHERE cs_class.id = cs_attr.class_id
	AND cs_attr.field_name ilike ''name''
    ORDER BY cs_class.name;', true, NULL, false, NULL, NULL, NULL);


--
-- TOC entry 4051 (class 0 OID 52067)
-- Dependencies: 260
-- Data for Name: cs_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_class VALUES (1, 'GEOM', 'Cids Geodatentyp', 1, 1, 'GEOM', 'ID', true, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (2, 'URL', NULL, 2, 2, 'URL', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (3, 'URL_BASE', NULL, 2, 2, 'URL_BASE', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (5, 'taggroup', '', 2, 2, 'TAGGROUP', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (6, 'tag', '', 2, 2, 'TAG', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (7, 'representation', '', 2, 2, 'REPRESENTATION', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (8, 'jt_representation_tag', '', 2, 2, 'JT_REPRESENTATION_TAG', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (9, 'jt_resource_tag', '', 2, 2, 'JT_RESOURCE_TAG', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (10, 'jt_metadata_tag', '', 2, 2, 'JT_METADATA_TAG', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (11, 'jt_relationship_tag', '', 2, 2, 'JT_RELATIONSHIP_TAG', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (12, 'jt_resource_representation', '', 2, 2, 'JT_RESOURCE_REPRESENTATION', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (15, 'metadata', '', 2, 2, 'METADATA', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (14, 'jt_metadata_resource', '', 2, 2, 'JT_METADATA_RESOURCE', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (16, 'jt_fromresource_relationship', '', 2, 2, 'JT_FROMRESOURCE_RELATIONSHIP', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (17, 'jt_metadata_relationship', '', 2, 2, 'JT_METADATA_RELATIONSHIP', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (18, 'relationship', '', 2, 2, 'RELATIONSHIP', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (4, 'contact', '', 2, 2, 'CONTACT', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (13, 'resource', '', 2, 2, 'RESOURCE', 'ID', true, NULL, NULL, NULL, false, NULL, NULL);


--
-- TOC entry 4052 (class 0 OID 52079)
-- Dependencies: 262
-- Data for Name: cs_class_attr; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_class_attr VALUES (1, 13, 7, 'tostringcache', 'id, name from resource');


--
-- TOC entry 4053 (class 0 OID 52094)
-- Dependencies: 266
-- Data for Name: cs_config_attr_exempt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4054 (class 0 OID 52100)
-- Dependencies: 268
-- Data for Name: cs_config_attr_jt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4055 (class 0 OID 52106)
-- Dependencies: 270
-- Data for Name: cs_config_attr_key; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4056 (class 0 OID 52112)
-- Dependencies: 272
-- Data for Name: cs_config_attr_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_config_attr_type VALUES (1, 'C', 'regular configuration attribute, a simple string value');
INSERT INTO cs_config_attr_type VALUES (2, 'A', 'action tag configuration attribute, value of no relevance');
INSERT INTO cs_config_attr_type VALUES (3, 'X', 'XML configuration attribute, XML content wrapped by some root element');


--
-- TOC entry 4057 (class 0 OID 52118)
-- Dependencies: 274
-- Data for Name: cs_config_attr_value; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4058 (class 0 OID 52127)
-- Dependencies: 276
-- Data for Name: cs_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_domain VALUES (1, 'LOCAL');


--
-- TOC entry 4059 (class 0 OID 52131)
-- Dependencies: 277
-- Data for Name: cs_dynamic_children_helper; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_dynamic_children_helper VALUES (6, 'CidsObjects(class_id varchar, table_name varchar)', 'SELECT -1 AS id,
 	null AS name,
 	<ds::param name=''class_id''>1</ds::param> AS class_id,
 	id AS object_id,
 	''O'' AS node_type,
 	null AS url,
 	null AS dynamic_children,
 	false AS sql_sort,
 	true AS derive_permissions_from_class
 	from <ds::param name=''table_name''>2</ds::param>;');
INSERT INTO cs_dynamic_children_helper VALUES (7, 'HydrologicalConcepts(level_id integer)', 'SELECT -1 AS id,
	tag.name AS name,
	cs_class.id AS class_id,
	NULL AS object_id,
	''N'' AS node_type,
	null AS url,
        csdc.entities(<ds::param name=''level_id''>1</ds::param> , tag.id) as dynamic_children, 
	true AS sql_sort,
	true AS derive_permissions_from_class
  FROM
	tag
	LEFT JOIN  taggroup ON
		tag.taggroup = taggroup.id,
    cs_class
  WHERE
    cs_class.name = ''tag'' AND
    taggroup.name = ''hydrological concept''
  GROUP BY 
  	tag.name,
  	tag.id,
    cs_class.id
  ORDER BY tag.name ASC;');
INSERT INTO cs_dynamic_children_helper VALUES (8, 'Entities(level_id integer, hydroCon_id integer)', 'SELECT DISTINCT -1 AS id,
	resource.name AS name,
	cs_class.id AS class_id,
	resource.id AS object_id,
	''O'' AS node_type,
	null AS url,
	NULL as dynamic_children,
	false AS sql_sort,
	true AS derive_permissions_from_class
    FROM 
	resource
	LEFT JOIN tag as tag_1 ON
		resource.geography = tag_1.id
	LEFT JOIN jt_resource_tag as jtrt_2 ON
		jtrt_2.resource_reference = resource.id
	LEFT JOIN tag as tag_2 ON
		jtrt_2.tagid = tag_2.id,
        tag as rType,
        cs_class
    WHERE
        cs_class.name = ''resource'' AND
	tag_1.id = <ds::param name=''level_id''>1</ds::param> AND
	tag_2.id = <ds::param name=''hydroCon_id''>2</ds::param> AND
        resource.type = rType.id AND
        rType.name != ''external data''
  GROUP BY
  	resource.name,
  	resource.id,
    cs_class.id;');
INSERT INTO cs_dynamic_children_helper VALUES (9, 'collectionsExternal(collection_id integer)', 'SELECT -1 AS id,
	resource.name AS name,
	cs_class.id AS class_id,
	resource.id AS object_id,
	''O'' AS node_type,
	null AS url,
	NULL as dynamic_children,
	false AS sql_sort,
	true AS derive_permissions_from_class
    FROM 
	resource,
        tag as rType,
        cs_class
    WHERE
        cs_class.name = ''resource'' AND
	collection = <ds::param name=''collection_id''>1</ds::param> AND
        resource.type = rType.id AND
        rType.name = ''external data''
  GROUP BY
	resource.name,
	resource.id,
        cs_class.id
	ORDER BY resource.name ASC;');
INSERT INTO cs_dynamic_children_helper VALUES (10, 'tags(taggroup_id integer)', 'SELECT 
  -1 as id, 
	tag.name, 
	cs_class.id as class_id, 
	tag.id as object_id, 
	''O'' as node_type, 
	null as url, 
	null dynamic_children,
	true as sql_sort,
  true AS derive_permissions_from_class
FROM 
	tag
	LEFT JOIN taggroup ON
		tag.taggroup = taggroup.id,    
  cs_class
WHERE
  cs_class.name = ''tag'' AND
	taggroup.id = 	<ds::param name=''taggroup_id''>1</ds::param> 
GROUP BY 
  	tag.name,
  	tag.id,
    cs_class.id 
ORDER BY tag.name ASC;');


--
-- TOC entry 4091 (class 0 OID 0)
-- Dependencies: 278
-- Name: cs_dynamic_children_helper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cs_dynamic_children_helper_id_seq', 10, true);


--
-- TOC entry 4061 (class 0 OID 52139)
-- Dependencies: 279
-- Data for Name: cs_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4062 (class 0 OID 52147)
-- Dependencies: 281
-- Data for Name: cs_icon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_icon VALUES (1, 'Georeferenz', 'georeferenz.gif');
INSERT INTO cs_icon VALUES (2, 'Erde', 'erde.gif');


--
-- TOC entry 4063 (class 0 OID 52154)
-- Dependencies: 283
-- Data for Name: cs_java_class; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4064 (class 0 OID 52164)
-- Dependencies: 285
-- Data for Name: cs_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4065 (class 0 OID 52171)
-- Dependencies: 286
-- Data for Name: cs_method; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4066 (class 0 OID 52184)
-- Dependencies: 288
-- Data for Name: cs_method_class_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4067 (class 0 OID 52192)
-- Dependencies: 291
-- Data for Name: cs_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_permission VALUES (0, 'read', 'Leserecht');
INSERT INTO cs_permission VALUES (1, 'write', 'Schreibrecht');


--
-- TOC entry 4068 (class 0 OID 52198)
-- Dependencies: 293
-- Data for Name: cs_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_policy VALUES (0, 'STANDARD');
INSERT INTO cs_policy VALUES (1, 'WIKI');
INSERT INTO cs_policy VALUES (2, 'SECURE');


--
-- TOC entry 4069 (class 0 OID 52204)
-- Dependencies: 295
-- Data for Name: cs_policy_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_policy_rule VALUES (1, 0, 0, true);
INSERT INTO cs_policy_rule VALUES (2, 0, 1, false);
INSERT INTO cs_policy_rule VALUES (3, 1, 0, true);
INSERT INTO cs_policy_rule VALUES (4, 1, 1, true);
INSERT INTO cs_policy_rule VALUES (5, 2, 0, false);
INSERT INTO cs_policy_rule VALUES (6, 2, 1, false);


--
-- TOC entry 4070 (class 0 OID 52208)
-- Dependencies: 296
-- Data for Name: cs_query; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4071 (class 0 OID 52223)
-- Dependencies: 298
-- Data for Name: cs_query_class_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4072 (class 0 OID 52229)
-- Dependencies: 300
-- Data for Name: cs_query_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4073 (class 0 OID 52233)
-- Dependencies: 301
-- Data for Name: cs_query_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4074 (class 0 OID 52248)
-- Dependencies: 305
-- Data for Name: cs_query_store; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4075 (class 0 OID 52254)
-- Dependencies: 307
-- Data for Name: cs_query_store_ug_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4076 (class 0 OID 52260)
-- Dependencies: 309
-- Data for Name: cs_query_ug_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4077 (class 0 OID 52264)
-- Dependencies: 310
-- Data for Name: cs_stringrepcache; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_stringrepcache VALUES (13, 374, '1850ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 47, 'CEH Information Gateway');
INSERT INTO cs_stringrepcache VALUES (13, 375, '1860ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 100, 'Netherlands 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 376, '1870ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 65, 'Eco-pedological Map for the Alpine Territory (ECALP) 100X100km');
INSERT INTO cs_stringrepcache VALUES (13, 84, 'Croatia 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 85, 'Cyprus 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 86, 'Czech Republic 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 377, '1880ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 378, '1890ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 87, 'Denmark 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 304, 'HydroSHEDS (BAS) - Drainage basins (watershed boundaries) at 15s resolution');
INSERT INTO cs_stringrepcache VALUES (13, 88, 'Estonia 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 89, 'Finland 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 90, 'France 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 91, 'Germany 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 48, 'ERA Interim, Daily fields');
INSERT INTO cs_stringrepcache VALUES (13, 49, 'ERA-40, Daily Fields');
INSERT INTO cs_stringrepcache VALUES (13, 50, 'TIGGE Data Retrieval');
INSERT INTO cs_stringrepcache VALUES (13, 51, 'CERA Gateway');
INSERT INTO cs_stringrepcache VALUES (13, 52, 'WCRP CMIP3 Multi-Model Data');
INSERT INTO cs_stringrepcache VALUES (13, 92, 'Greece 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 93, 'Hungary 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 53, 'grid-mntp-1880-current-v3.2.2.dat');
INSERT INTO cs_stringrepcache VALUES (13, 67, 'Eco-pedological Map for the Alpine Territory (ECALP) 1x1km');
INSERT INTO cs_stringrepcache VALUES (13, 54, 'ghcnm.tavg.v3.1.0.20111105.qca.tar');
INSERT INTO cs_stringrepcache VALUES (13, 55, 'HR Layer Imperviousness - Degree of Imperviousness 2009 -Pan-European - P-EL-03');
INSERT INTO cs_stringrepcache VALUES (13, 56, 'ghcnm.tavg.latest.qca.tar');
INSERT INTO cs_stringrepcache VALUES (13, 94, 'Ireland 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 57, 'ghcnm.tavg.latest.qcu.tar');
INSERT INTO cs_stringrepcache VALUES (13, 58, 'ghcnm.tmax.latest.qca.tar');
INSERT INTO cs_stringrepcache VALUES (13, 59, 'ghcnm.tmax.latest.qcu.tar');
INSERT INTO cs_stringrepcache VALUES (13, 60, 'ghcnm.tmin.latest.qca.tar');
INSERT INTO cs_stringrepcache VALUES (13, 95, 'Italy 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 61, 'ghcnm.tmin.latest.qcu.tar');
INSERT INTO cs_stringrepcache VALUES (13, 62, 'Raster Library 10kmx10km, EU25 library');
INSERT INTO cs_stringrepcache VALUES (13, 63, 'Soil Profile Analytical Database of Europe of Measured parameters');
INSERT INTO cs_stringrepcache VALUES (13, 64, 'Soil Sealing & food security (Loss of Potential Agricultural Production Capability)');
INSERT INTO cs_stringrepcache VALUES (13, 96, 'Latvia 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 97, 'Lithuania 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 66, 'Eco-pedological Map for the Alpine Territory (ECALP) 10x10km');
INSERT INTO cs_stringrepcache VALUES (13, 68, 'Support to Renewable Energy Directive');
INSERT INTO cs_stringrepcache VALUES (13, 69, 'Biochar Meta-analysis Database');
INSERT INTO cs_stringrepcache VALUES (13, 70, 'Population on 1 January by age and sex - NUTS 2 regions');
INSERT INTO cs_stringrepcache VALUES (13, 98, 'Luxembourg 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 99, 'Malta 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 71, 'Total Population - Both Sexes');
INSERT INTO cs_stringrepcache VALUES (13, 103, 'Romania 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 104, 'Slovakia 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 72, 'Total Population - Male');
INSERT INTO cs_stringrepcache VALUES (13, 73, 'Total Population - Female');
INSERT INTO cs_stringrepcache VALUES (13, 74, 'Population Growth Rate');
INSERT INTO cs_stringrepcache VALUES (13, 75, 'Rate of Natural Population Increase');
INSERT INTO cs_stringrepcache VALUES (13, 76, 'Sex Ratio of Total Population');
INSERT INTO cs_stringrepcache VALUES (13, 77, 'Median Age of Population');
INSERT INTO cs_stringrepcache VALUES (13, 78, 'Population Density');
INSERT INTO cs_stringrepcache VALUES (13, 79, 'Bathing water quality - data viewer');
INSERT INTO cs_stringrepcache VALUES (13, 80, 'Albania 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 81, 'Austria 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 82, 'Belgium 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 83, 'Bulgaria 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 101, 'Poland 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 102, 'Portugal 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 105, 'Slovenia 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 106, 'Spain 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 107, 'Sweden 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 108, 'Switzerland 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 109, 'United Kingdom 2013 bathing water report');
INSERT INTO cs_stringrepcache VALUES (13, 379, '1900ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 380, '1910ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 305, 'HydroSHEDS (DEM) - Void-filled elevation model at 15s resolution');
INSERT INTO cs_stringrepcache VALUES (13, 117, 'Indices data');
INSERT INTO cs_stringrepcache VALUES (13, 118, 'Gridded data');
INSERT INTO cs_stringrepcache VALUES (13, 119, 'Personal Geodatabase file (Access)');
INSERT INTO cs_stringrepcache VALUES (13, 120, 'Lakes');
INSERT INTO cs_stringrepcache VALUES (13, 121, 'FEC');
INSERT INTO cs_stringrepcache VALUES (13, 122, 'Aggregation catchments');
INSERT INTO cs_stringrepcache VALUES (13, 123, 'NOBS Total Full V6 (1.0x1.0)');
INSERT INTO cs_stringrepcache VALUES (13, 124, 'NOBS Total Full V6 (0.5x0.5)');
INSERT INTO cs_stringrepcache VALUES (13, 125, 'LTM Total Full V6 (1.0x1.0)');
INSERT INTO cs_stringrepcache VALUES (13, 126, 'LTM Total Full V6 (0.5x0.5)');
INSERT INTO cs_stringrepcache VALUES (13, 127, 'NOBS Full V6 (2.5x2.5)');
INSERT INTO cs_stringrepcache VALUES (13, 128, 'LTM Total Full V6 (2.5x2.5)');
INSERT INTO cs_stringrepcache VALUES (13, 129, 'AirBase_v8_stations.zip');
INSERT INTO cs_stringrepcache VALUES (13, 184, 'CCM2 Download');
INSERT INTO cs_stringrepcache VALUES (13, 185, 'Rivers');
INSERT INTO cs_stringrepcache VALUES (13, 130, 'GlobCover 2009 (Global Land Cover Map)');
INSERT INTO cs_stringrepcache VALUES (13, 131, 'First Guess (1.0x1.0)');
INSERT INTO cs_stringrepcache VALUES (13, 132, 'Global Land Cover Product (2005 to 2006)');
INSERT INTO cs_stringrepcache VALUES (13, 133, 'Global Lakes and Wetlands Database: Large Lake Polygons (Level 1)');
INSERT INTO cs_stringrepcache VALUES (13, 134, 'Unvalidated real-time air quality map');
INSERT INTO cs_stringrepcache VALUES (13, 135, 'AirBase_AL_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 136, 'AirBase_v8_measurement_configurations.zip');
INSERT INTO cs_stringrepcache VALUES (13, 137, 'AirBase_AT_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 138, 'AirBase_v8_statistics.zip');
INSERT INTO cs_stringrepcache VALUES (13, 139, 'AirBase_BE_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 168, 'Corine Land Cover 2000 (raster 100m) - version 17, Dec. 2013');
INSERT INTO cs_stringrepcache VALUES (13, 140, 'AirBase_CY_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 354, '1200ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 141, 'AirBase_BG_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 142, 'AirBase_HR_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 143, 'AirBase_EE_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 144, 'AirBase_CZ_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 145, 'AirBase_DK_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 355, '1300ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 146, 'AirBase_FI_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 147, 'AirBase_HU_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 148, 'AirBase_GR_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 149, 'AirBase_DE_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 150, 'AirBase_IE_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 356, '1400ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 151, 'AirBase_LU_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 152, 'AirBase_LT_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 153, 'AirBase_LI_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 154, 'AirBase_LV_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 155, 'AirBase_MT_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 357, '1500ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 156, 'AirBase_MK_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 157, 'AirBase_ME_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 158, 'AirBase_NL_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 159, 'AirBase_RO_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 169, 'Corine Land Cover 1990 (raster 100m) - version 17, Dec. 2013');
INSERT INTO cs_stringrepcache VALUES (13, 160, 'AirBase_PL_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 358, '1600ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 161, 'AirBase_PT_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 162, 'AirBase_SI_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 163, 'AirBase_RS_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 164, 'AirBase_ES_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 165, 'AirBase_CH_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 359, '1700ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 166, 'AirBase_SE_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 167, 'AirBase_GB_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 170, 'Global Lakes and Wetlands Database: Lakes and Wetlands Grid (Level 3)');
INSERT INTO cs_stringrepcache VALUES (13, 171, 'Total Full V6 (1.0x1.0)');
INSERT INTO cs_stringrepcache VALUES (13, 360, '1710ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 172, 'AirBase_BA_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 173, 'AirBase_AD_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 174, 'Total Full V6 (2.5x2.5)');
INSERT INTO cs_stringrepcache VALUES (13, 175, 'Total Full V6 (0.5x0.5)');
INSERT INTO cs_stringrepcache VALUES (13, 176, 'Monitoring (1.0x1.0)');
INSERT INTO cs_stringrepcache VALUES (13, 177, 'LAI FAPAR FCOVER NDVI');
INSERT INTO cs_stringrepcache VALUES (13, 361, '1720ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 178, 'Predefined subsets in ASCII');
INSERT INTO cs_stringrepcache VALUES (13, 179, 'Corine Land Cover 2006 (raster 100m) - version 17, Dec. 2013');
INSERT INTO cs_stringrepcache VALUES (13, 180, 'AirBase_TR_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 181, 'Monitoring (2.5x2.5)');
INSERT INTO cs_stringrepcache VALUES (13, 182, 'AirBase_IT_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 183, 'Global Lakes and Wetlands Database: Small Lake Polygons (Level 2)');
INSERT INTO cs_stringrepcache VALUES (13, 186, 'Waterbase - Lakes');
INSERT INTO cs_stringrepcache VALUES (13, 187, 'AirBase_XK_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 364, '1750ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 188, 'AirBase_SK_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 189, 'AirBase_NO_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 190, 'AirBase_FR_v8.zip');
INSERT INTO cs_stringrepcache VALUES (13, 362, '1730ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 293, 'TG 0.25 deg. regular grid');
INSERT INTO cs_stringrepcache VALUES (13, 363, '1740ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 294, 'RR 0.25 deg. regular grid');
INSERT INTO cs_stringrepcache VALUES (13, 295, 'TG 0.50 deg. regular grid');
INSERT INTO cs_stringrepcache VALUES (13, 296, 'RR 0.50 deg. regular grid');
INSERT INTO cs_stringrepcache VALUES (13, 297, 'TG 0.22 deg. rotated grid');
INSERT INTO cs_stringrepcache VALUES (13, 298, 'RR 0.22 deg. rotated grid');
INSERT INTO cs_stringrepcache VALUES (13, 299, 'TG 0.44 deg. rotated grid');
INSERT INTO cs_stringrepcache VALUES (13, 300, 'RR 0.44 deg. rotated grid');
INSERT INTO cs_stringrepcache VALUES (13, 301, 'HydroSHEDS (ACC) - Flow accumulation [cells] at 15s resolution (eu_acc_15s)');
INSERT INTO cs_stringrepcache VALUES (13, 302, 'HydroSHEDS (RIV) - River network (stream lines) at 15s resolution');
INSERT INTO cs_stringrepcache VALUES (13, 303, 'HydroSHEDS (DIR) - Drainage directions at 15s resolution');
INSERT INTO cs_stringrepcache VALUES (13, 365, '1760ad_pop-zip');
INSERT INTO cs_stringrepcache VALUES (13, 306, 'Ecrins drainage lines, EcrRiv.mdb');
INSERT INTO cs_stringrepcache VALUES (13, 307, 'ECRINS lakes, EcrLak.mdb');
INSERT INTO cs_stringrepcache VALUES (13, 308, 'ECRINS FECs, EcrFEC.mdb');
INSERT INTO cs_stringrepcache VALUES (13, 309, 'ECRINS aggregated feature classes, EcrAgg.mdb');
INSERT INTO cs_stringrepcache VALUES (13, 310, 'EcrAncl, EcrAncl.rar');
INSERT INTO cs_stringrepcache VALUES (13, 311, 'Ecrins gazeteer - river names, EcrGaz.mdb');
INSERT INTO cs_stringrepcache VALUES (13, 366, '1770ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 312, 'CRUTEM4 Land air temperature anomalies on a 5° by 5° grid-box basis');
INSERT INTO cs_stringrepcache VALUES (13, 313, 'CRUTEM4v Variance adjusted version of CRUTEM4');
INSERT INTO cs_stringrepcache VALUES (13, 314, 'HadCRUT4');
INSERT INTO cs_stringrepcache VALUES (13, 315, 'HadSST3');
INSERT INTO cs_stringrepcache VALUES (13, 316, 'HadSST2');
INSERT INTO cs_stringrepcache VALUES (13, 317, 'Global Land Precipitation');
INSERT INTO cs_stringrepcache VALUES (13, 318, 'Tropical Land and Ocean Precipitation');
INSERT INTO cs_stringrepcache VALUES (13, 319, 'Global_monthly_ET_halfdeg_1983.h5');
INSERT INTO cs_stringrepcache VALUES (13, 320, 'Global_monthly_ET_halfdeg_1984.h5');
INSERT INTO cs_stringrepcache VALUES (13, 321, 'Global_monthly_ET_halfdeg_1985.h5');
INSERT INTO cs_stringrepcache VALUES (13, 367, '1780ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 368, '1790ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 322, 'Global_monthly_ET_halfdeg_1986.h5');
INSERT INTO cs_stringrepcache VALUES (13, 323, 'Global_monthly_ET_halfdeg_1987.h5');
INSERT INTO cs_stringrepcache VALUES (13, 324, 'Global_monthly_ET_halfdeg_1988.h5');
INSERT INTO cs_stringrepcache VALUES (13, 325, 'Global_monthly_ET_halfdeg_1989.h5');
INSERT INTO cs_stringrepcache VALUES (13, 369, '1800ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 326, 'Global_monthly_ET_halfdeg_1990.h5');
INSERT INTO cs_stringrepcache VALUES (13, 327, 'Global_monthly_ET_halfdeg_1991.h5');
INSERT INTO cs_stringrepcache VALUES (13, 328, 'Global_monthly_ET_halfdeg_1992.h5');
INSERT INTO cs_stringrepcache VALUES (13, 329, 'Global_monthly_ET_halfdeg_1993.h5');
INSERT INTO cs_stringrepcache VALUES (13, 370, '1810ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 330, 'Global_monthly_ET_halfdeg_1994.h5');
INSERT INTO cs_stringrepcache VALUES (13, 331, 'Global_monthly_ET_halfdeg_1995.h5');
INSERT INTO cs_stringrepcache VALUES (13, 332, 'Global_monthly_ET_halfdeg_1996.h5');
INSERT INTO cs_stringrepcache VALUES (13, 333, 'Global_monthly_ET_halfdeg_1997.h5');
INSERT INTO cs_stringrepcache VALUES (13, 371, '1820ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 334, 'Global_monthly_ET_halfdeg_1998.h5');
INSERT INTO cs_stringrepcache VALUES (13, 335, 'Global_monthly_ET_halfdeg_1999.h5');
INSERT INTO cs_stringrepcache VALUES (13, 336, 'Global_monthly_ET_halfdeg_2000.h5');
INSERT INTO cs_stringrepcache VALUES (13, 337, 'Global_monthly_ET_halfdeg_2001.h5');
INSERT INTO cs_stringrepcache VALUES (13, 372, '1830ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 338, 'Global_monthly_ET_halfdeg_2002.h5');
INSERT INTO cs_stringrepcache VALUES (13, 339, 'Global_monthly_ET_halfdeg_2003.h5');
INSERT INTO cs_stringrepcache VALUES (13, 340, 'Global_monthly_ET_halfdeg_2004.h5');
INSERT INTO cs_stringrepcache VALUES (13, 341, 'Global_monthly_ET_halfdeg_2005.h5');
INSERT INTO cs_stringrepcache VALUES (13, 373, '1840ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 342, 'Global_monthly_ET_halfdeg_2006.h5');
INSERT INTO cs_stringrepcache VALUES (13, 343, '100ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 344, '200ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 345, '300ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 346, '400ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 347, '500ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 348, '600ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 349, '700ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 350, '800ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 351, '900ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 352, '1000ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 353, '1100ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 381, '1920ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 382, '1930ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 383, '1940ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 384, '1950ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 385, '1960ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 386, '1970ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 387, '1980ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 388, '1990ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 389, '2000ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 390, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_01_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 7191, '6000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 7196, '5000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 391, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_02_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 392, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_03_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 393, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_04_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 394, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_05_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 7192, 'HYDE 3.1 Summary of historical population data (totals, percentages, etc), Global historical population estimates 10k BC - 2 k AD (in millions)');
INSERT INTO cs_stringrepcache VALUES (13, 395, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_06_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 396, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_07_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 397, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_08_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 398, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_09_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 7193, '9000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 399, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_10_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 400, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_11_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 401, 'MONTHLY_GROWING_AREA_TOTAL_MONTH_12_HA.ASC');
INSERT INTO cs_stringrepcache VALUES (13, 402, 'CELL_SPECIFIC_CROPPING_CALENDARS_30MN.TXT');
INSERT INTO cs_stringrepcache VALUES (13, 7194, '8000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 403, 'cropping_calendar_irrigated.txt');
INSERT INTO cs_stringrepcache VALUES (13, 404, 'cropping_calendar_rainfed.txt');
INSERT INTO cs_stringrepcache VALUES (13, 405, 'unit_code.asc');
INSERT INTO cs_stringrepcache VALUES (13, 406, 'unit_name.txt');
INSERT INTO cs_stringrepcache VALUES (13, 7195, '7000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 407, 'AMSRE_36V_AM_FT_2002_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 408, 'AMSRE_36V_AM_FT_2002_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 409, 'AMSRE_36V_AM_FT_2002_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 410, 'AMSRE_36V_AM_FT_2002_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 411, 'AMSRE_36V_AM_FT_2002_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 412, 'AMSRE_36V_AM_FT_2002_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 413, 'AMSRE_36V_AM_FT_2002_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 414, 'AMSRE_36V_AM_FT_2002_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 415, 'AMSRE_36V_AM_FT_2002_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 416, 'AMSRE_36V_AM_FT_2002_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 7197, '4000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 417, 'AMSRE_36V_AM_FT_2002_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 418, 'AMSRE_36V_AM_FT_2002_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 419, 'AMSRE_36V_AM_FT_2002_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 420, 'AMSRE_36V_AM_FT_2002_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 7204, 'Corrected precipitation');
INSERT INTO cs_stringrepcache VALUES (13, 7206, 'Soils on subbasins');
INSERT INTO cs_stringrepcache VALUES (13, 421, 'AMSRE_36V_AM_FT_2002_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 7198, '2000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 422, 'AMSRE_36V_AM_FT_2002_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 423, 'AMSRE_36V_AM_FT_2002_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 424, 'AMSRE_36V_AM_FT_2002_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 7208, 'Corrected temperature');
INSERT INTO cs_stringrepcache VALUES (13, 425, 'AMSRE_36V_AM_FT_2002_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 426, 'AMSRE_36V_AM_FT_2002_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 7199, '1000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 427, 'AMSRE_36V_AM_FT_2002_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 428, 'AMSRE_36V_AM_FT_2002_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 429, 'AMSRE_36V_AM_FT_2002_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 430, 'AMSRE_36V_AM_FT_2002_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 431, 'AMSRE_36V_AM_FT_2002_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 7200, '10000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 432, 'AMSRE_36V_AM_FT_2002_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 433, 'AMSRE_36V_AM_FT_2002_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 434, 'AMSRE_36V_AM_FT_2002_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 435, 'AMSRE_36V_AM_FT_2002_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 436, 'AMSRE_36V_AM_FT_2002_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 7201, '3000bc_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 437, 'AMSRE_36V_AM_FT_2002_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 438, 'AMSRE_36V_AM_FT_2002_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 439, 'AMSRE_36V_AM_FT_2002_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 440, 'AMSRE_36V_AM_FT_2002_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 441, 'AMSRE_36V_AM_FT_2002_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 442, 'AMSRE_36V_AM_FT_2002_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 443, 'AMSRE_36V_AM_FT_2002_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 444, 'AMSRE_36V_AM_FT_2002_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 445, 'AMSRE_36V_AM_FT_2002_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 446, 'AMSRE_36V_AM_FT_2002_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 447, 'AMSRE_36V_AM_FT_2002_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 448, 'AMSRE_36V_AM_FT_2002_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 449, 'AMSRE_36V_AM_FT_2002_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 450, 'AMSRE_36V_AM_FT_2002_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 451, 'AMSRE_36V_AM_FT_2002_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 452, 'AMSRE_36V_AM_FT_2002_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 453, 'AMSRE_36V_AM_FT_2002_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 454, 'AMSRE_36V_AM_FT_2002_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 455, 'AMSRE_36V_AM_FT_2002_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 456, 'AMSRE_36V_AM_FT_2002_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 457, 'AMSRE_36V_AM_FT_2002_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 458, 'AMSRE_36V_AM_FT_2002_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 459, 'AMSRE_36V_AM_FT_2002_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 460, 'AMSRE_36V_AM_FT_2002_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 461, 'AMSRE_36V_AM_FT_2002_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 462, 'AMSRE_36V_AM_FT_2002_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 463, 'AMSRE_36V_AM_FT_2002_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 464, 'AMSRE_36V_AM_FT_2002_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 465, 'AMSRE_36V_AM_FT_2002_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 466, 'AMSRE_36V_AM_FT_2002_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 467, 'AMSRE_36V_AM_FT_2002_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 468, 'AMSRE_36V_AM_FT_2002_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 469, 'AMSRE_36V_AM_FT_2002_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 470, 'AMSRE_36V_AM_FT_2002_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 471, 'AMSRE_36V_AM_FT_2002_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 472, 'AMSRE_36V_AM_FT_2002_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 473, 'AMSRE_36V_AM_FT_2002_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 474, 'AMSRE_36V_AM_FT_2002_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 475, 'AMSRE_36V_AM_FT_2002_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 476, 'AMSRE_36V_AM_FT_2002_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 477, 'AMSRE_36V_AM_FT_2002_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 478, 'AMSRE_36V_AM_FT_2002_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 479, 'AMSRE_36V_AM_FT_2002_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 480, 'AMSRE_36V_AM_FT_2002_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 481, 'AMSRE_36V_AM_FT_2002_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 482, 'AMSRE_36V_AM_FT_2002_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 483, 'AMSRE_36V_AM_FT_2002_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 484, 'AMSRE_36V_AM_FT_2002_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 485, 'AMSRE_36V_AM_FT_2002_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 486, 'AMSRE_36V_AM_FT_2002_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 487, 'AMSRE_36V_AM_FT_2002_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 488, 'AMSRE_36V_AM_FT_2002_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 489, 'AMSRE_36V_AM_FT_2002_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 490, 'AMSRE_36V_AM_FT_2002_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 491, 'AMSRE_36V_AM_FT_2002_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 492, 'AMSRE_36V_AM_FT_2002_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 493, 'AMSRE_36V_AM_FT_2002_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 494, 'AMSRE_36V_AM_FT_2002_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 495, 'AMSRE_36V_AM_FT_2002_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 496, 'AMSRE_36V_AM_FT_2002_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 497, 'AMSRE_36V_AM_FT_2002_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 498, 'AMSRE_36V_AM_FT_2002_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 499, 'AMSRE_36V_AM_FT_2002_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 500, 'AMSRE_36V_AM_FT_2002_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 501, 'AMSRE_36V_AM_FT_2002_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 502, 'AMSRE_36V_AM_FT_2002_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 503, 'AMSRE_36V_AM_FT_2002_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 504, 'AMSRE_36V_AM_FT_2002_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 505, 'AMSRE_36V_AM_FT_2002_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 506, 'AMSRE_36V_AM_FT_2002_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 507, 'AMSRE_36V_AM_FT_2002_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 508, 'AMSRE_36V_AM_FT_2002_day271.h5');
INSERT INTO cs_stringrepcache VALUES (13, 509, 'AMSRE_36V_AM_FT_2002_day272.h5');
INSERT INTO cs_stringrepcache VALUES (13, 510, 'AMSRE_36V_AM_FT_2002_day273.h5');
INSERT INTO cs_stringrepcache VALUES (13, 511, 'AMSRE_36V_AM_FT_2002_day274.h5');
INSERT INTO cs_stringrepcache VALUES (13, 512, 'AMSRE_36V_AM_FT_2002_day275.h5');
INSERT INTO cs_stringrepcache VALUES (13, 513, 'AMSRE_36V_AM_FT_2002_day276.h5');
INSERT INTO cs_stringrepcache VALUES (13, 514, 'AMSRE_36V_AM_FT_2002_day277.h5');
INSERT INTO cs_stringrepcache VALUES (13, 515, 'AMSRE_36V_AM_FT_2002_day278.h5');
INSERT INTO cs_stringrepcache VALUES (13, 516, 'AMSRE_36V_AM_FT_2002_day279.h5');
INSERT INTO cs_stringrepcache VALUES (13, 517, 'AMSRE_36V_AM_FT_2002_day280.h5');
INSERT INTO cs_stringrepcache VALUES (13, 518, 'AMSRE_36V_AM_FT_2002_day281.h5');
INSERT INTO cs_stringrepcache VALUES (13, 519, 'AMSRE_36V_AM_FT_2002_day282.h5');
INSERT INTO cs_stringrepcache VALUES (13, 520, 'AMSRE_36V_AM_FT_2002_day283.h5');
INSERT INTO cs_stringrepcache VALUES (13, 521, 'AMSRE_36V_AM_FT_2002_day284.h5');
INSERT INTO cs_stringrepcache VALUES (13, 522, 'AMSRE_36V_AM_FT_2002_day285.h5');
INSERT INTO cs_stringrepcache VALUES (13, 523, 'AMSRE_36V_AM_FT_2002_day286.h5');
INSERT INTO cs_stringrepcache VALUES (13, 524, 'AMSRE_36V_AM_FT_2002_day287.h5');
INSERT INTO cs_stringrepcache VALUES (13, 525, 'AMSRE_36V_AM_FT_2002_day288.h5');
INSERT INTO cs_stringrepcache VALUES (13, 526, 'AMSRE_36V_AM_FT_2002_day289.h5');
INSERT INTO cs_stringrepcache VALUES (13, 527, 'AMSRE_36V_AM_FT_2002_day290.h5');
INSERT INTO cs_stringrepcache VALUES (13, 528, 'AMSRE_36V_AM_FT_2002_day291.h5');
INSERT INTO cs_stringrepcache VALUES (13, 529, 'AMSRE_36V_AM_FT_2002_day292.h5');
INSERT INTO cs_stringrepcache VALUES (13, 530, 'AMSRE_36V_AM_FT_2002_day293.h5');
INSERT INTO cs_stringrepcache VALUES (13, 531, 'AMSRE_36V_AM_FT_2002_day294.h5');
INSERT INTO cs_stringrepcache VALUES (13, 532, 'AMSRE_36V_AM_FT_2002_day295.h5');
INSERT INTO cs_stringrepcache VALUES (13, 533, 'AMSRE_36V_AM_FT_2002_day296.h5');
INSERT INTO cs_stringrepcache VALUES (13, 534, 'AMSRE_36V_AM_FT_2002_day297.h5');
INSERT INTO cs_stringrepcache VALUES (13, 535, 'AMSRE_36V_AM_FT_2002_day298.h5');
INSERT INTO cs_stringrepcache VALUES (13, 536, 'AMSRE_36V_AM_FT_2002_day299.h5');
INSERT INTO cs_stringrepcache VALUES (13, 537, 'AMSRE_36V_AM_FT_2002_day300.h5');
INSERT INTO cs_stringrepcache VALUES (13, 538, 'AMSRE_36V_AM_FT_2002_day301.h5');
INSERT INTO cs_stringrepcache VALUES (13, 539, 'AMSRE_36V_AM_FT_2002_day302.h5');
INSERT INTO cs_stringrepcache VALUES (13, 540, 'AMSRE_36V_AM_FT_2002_day303.h5');
INSERT INTO cs_stringrepcache VALUES (13, 541, 'AMSRE_36V_AM_FT_2002_day304.h5');
INSERT INTO cs_stringrepcache VALUES (13, 542, 'AMSRE_36V_AM_FT_2002_day305.h5');
INSERT INTO cs_stringrepcache VALUES (13, 543, 'AMSRE_36V_AM_FT_2002_day306.h5');
INSERT INTO cs_stringrepcache VALUES (13, 544, 'AMSRE_36V_AM_FT_2002_day307.h5');
INSERT INTO cs_stringrepcache VALUES (13, 545, 'AMSRE_36V_AM_FT_2002_day308.h5');
INSERT INTO cs_stringrepcache VALUES (13, 546, 'AMSRE_36V_AM_FT_2002_day309.h5');
INSERT INTO cs_stringrepcache VALUES (13, 547, 'AMSRE_36V_AM_FT_2002_day310.h5');
INSERT INTO cs_stringrepcache VALUES (13, 548, 'AMSRE_36V_AM_FT_2002_day311.h5');
INSERT INTO cs_stringrepcache VALUES (13, 549, 'AMSRE_36V_AM_FT_2002_day312.h5');
INSERT INTO cs_stringrepcache VALUES (13, 550, 'AMSRE_36V_AM_FT_2002_day313.h5');
INSERT INTO cs_stringrepcache VALUES (13, 551, 'AMSRE_36V_AM_FT_2002_day314.h5');
INSERT INTO cs_stringrepcache VALUES (13, 552, 'AMSRE_36V_AM_FT_2002_day315.h5');
INSERT INTO cs_stringrepcache VALUES (13, 553, 'AMSRE_36V_AM_FT_2002_day316.h5');
INSERT INTO cs_stringrepcache VALUES (13, 554, 'AMSRE_36V_AM_FT_2002_day317.h5');
INSERT INTO cs_stringrepcache VALUES (13, 555, 'AMSRE_36V_AM_FT_2002_day318.h5');
INSERT INTO cs_stringrepcache VALUES (13, 556, 'AMSRE_36V_AM_FT_2002_day319.h5');
INSERT INTO cs_stringrepcache VALUES (13, 557, 'AMSRE_36V_AM_FT_2002_day320.h5');
INSERT INTO cs_stringrepcache VALUES (13, 558, 'AMSRE_36V_AM_FT_2002_day321.h5');
INSERT INTO cs_stringrepcache VALUES (13, 559, 'AMSRE_36V_AM_FT_2002_day322.h5');
INSERT INTO cs_stringrepcache VALUES (13, 560, 'AMSRE_36V_AM_FT_2002_day323.h5');
INSERT INTO cs_stringrepcache VALUES (13, 561, 'AMSRE_36V_AM_FT_2002_day324.h5');
INSERT INTO cs_stringrepcache VALUES (13, 562, 'AMSRE_36V_AM_FT_2002_day325.h5');
INSERT INTO cs_stringrepcache VALUES (13, 563, 'AMSRE_36V_AM_FT_2002_day326.h5');
INSERT INTO cs_stringrepcache VALUES (13, 564, 'AMSRE_36V_AM_FT_2002_day327.h5');
INSERT INTO cs_stringrepcache VALUES (13, 565, 'AMSRE_36V_AM_FT_2002_day328.h5');
INSERT INTO cs_stringrepcache VALUES (13, 566, 'AMSRE_36V_AM_FT_2002_day329.h5');
INSERT INTO cs_stringrepcache VALUES (13, 567, 'AMSRE_36V_AM_FT_2002_day330.h5');
INSERT INTO cs_stringrepcache VALUES (13, 568, 'AMSRE_36V_AM_FT_2002_day331.h5');
INSERT INTO cs_stringrepcache VALUES (13, 569, 'AMSRE_36V_AM_FT_2002_day332.h5');
INSERT INTO cs_stringrepcache VALUES (13, 570, 'AMSRE_36V_AM_FT_2002_day333.h5');
INSERT INTO cs_stringrepcache VALUES (13, 571, 'AMSRE_36V_AM_FT_2002_day334.h5');
INSERT INTO cs_stringrepcache VALUES (13, 572, 'AMSRE_36V_AM_FT_2002_day335.h5');
INSERT INTO cs_stringrepcache VALUES (13, 573, 'AMSRE_36V_AM_FT_2002_day336.h5');
INSERT INTO cs_stringrepcache VALUES (13, 574, 'AMSRE_36V_AM_FT_2002_day337.h5');
INSERT INTO cs_stringrepcache VALUES (13, 575, 'AMSRE_36V_AM_FT_2002_day338.h5');
INSERT INTO cs_stringrepcache VALUES (13, 576, 'AMSRE_36V_AM_FT_2002_day339.h5');
INSERT INTO cs_stringrepcache VALUES (13, 577, 'AMSRE_36V_AM_FT_2002_day340.h5');
INSERT INTO cs_stringrepcache VALUES (13, 578, 'AMSRE_36V_AM_FT_2002_day341.h5');
INSERT INTO cs_stringrepcache VALUES (13, 579, 'AMSRE_36V_AM_FT_2002_day342.h5');
INSERT INTO cs_stringrepcache VALUES (13, 580, 'AMSRE_36V_AM_FT_2002_day343.h5');
INSERT INTO cs_stringrepcache VALUES (13, 581, 'AMSRE_36V_AM_FT_2002_day344.h5');
INSERT INTO cs_stringrepcache VALUES (13, 582, 'AMSRE_36V_AM_FT_2002_day345.h5');
INSERT INTO cs_stringrepcache VALUES (13, 583, 'AMSRE_36V_AM_FT_2002_day346.h5');
INSERT INTO cs_stringrepcache VALUES (13, 584, 'AMSRE_36V_AM_FT_2002_day347.h5');
INSERT INTO cs_stringrepcache VALUES (13, 585, 'AMSRE_36V_AM_FT_2002_day348.h5');
INSERT INTO cs_stringrepcache VALUES (13, 586, 'AMSRE_36V_AM_FT_2002_day349.h5');
INSERT INTO cs_stringrepcache VALUES (13, 587, 'AMSRE_36V_AM_FT_2002_day350.h5');
INSERT INTO cs_stringrepcache VALUES (13, 588, 'AMSRE_36V_AM_FT_2002_day351.h5');
INSERT INTO cs_stringrepcache VALUES (13, 589, 'AMSRE_36V_AM_FT_2002_day352.h5');
INSERT INTO cs_stringrepcache VALUES (13, 590, 'AMSRE_36V_AM_FT_2002_day353.h5');
INSERT INTO cs_stringrepcache VALUES (13, 591, 'AMSRE_36V_AM_FT_2002_day354.h5');
INSERT INTO cs_stringrepcache VALUES (13, 592, 'AMSRE_36V_AM_FT_2002_day355.h5');
INSERT INTO cs_stringrepcache VALUES (13, 593, 'AMSRE_36V_AM_FT_2002_day356.h5');
INSERT INTO cs_stringrepcache VALUES (13, 594, 'AMSRE_36V_AM_FT_2002_day357.h5');
INSERT INTO cs_stringrepcache VALUES (13, 595, 'AMSRE_36V_AM_FT_2002_day358.h5');
INSERT INTO cs_stringrepcache VALUES (13, 596, 'AMSRE_36V_AM_FT_2002_day359.h5');
INSERT INTO cs_stringrepcache VALUES (13, 597, 'AMSRE_36V_AM_FT_2002_day360.h5');
INSERT INTO cs_stringrepcache VALUES (13, 598, 'AMSRE_36V_AM_FT_2002_day361.h5');
INSERT INTO cs_stringrepcache VALUES (13, 599, 'AMSRE_36V_AM_FT_2002_day362.h5');
INSERT INTO cs_stringrepcache VALUES (13, 600, 'AMSRE_36V_AM_FT_2002_day363.h5');
INSERT INTO cs_stringrepcache VALUES (13, 601, 'AMSRE_36V_AM_FT_2002_day364.h5');
INSERT INTO cs_stringrepcache VALUES (13, 602, 'AMSRE_36V_AM_FT_2002_day365.h5');
INSERT INTO cs_stringrepcache VALUES (13, 603, 'AMSRE_36V_AM_FT_2003_day1.h5');
INSERT INTO cs_stringrepcache VALUES (13, 604, 'AMSRE_36V_AM_FT_2003_day2.h5');
INSERT INTO cs_stringrepcache VALUES (13, 605, 'AMSRE_36V_AM_FT_2003_day3.h5');
INSERT INTO cs_stringrepcache VALUES (13, 606, 'AMSRE_36V_AM_FT_2003_day4.h5');
INSERT INTO cs_stringrepcache VALUES (13, 607, 'AMSRE_36V_AM_FT_2003_day5.h5');
INSERT INTO cs_stringrepcache VALUES (13, 608, 'AMSRE_36V_AM_FT_2003_day6.h5');
INSERT INTO cs_stringrepcache VALUES (13, 609, 'AMSRE_36V_AM_FT_2003_day7.h5');
INSERT INTO cs_stringrepcache VALUES (13, 610, 'AMSRE_36V_AM_FT_2003_day8.h5');
INSERT INTO cs_stringrepcache VALUES (13, 611, 'AMSRE_36V_AM_FT_2003_day9.h5');
INSERT INTO cs_stringrepcache VALUES (13, 612, 'AMSRE_36V_AM_FT_2003_day10.h5');
INSERT INTO cs_stringrepcache VALUES (13, 613, 'AMSRE_36V_AM_FT_2003_day11.h5');
INSERT INTO cs_stringrepcache VALUES (13, 614, 'AMSRE_36V_AM_FT_2003_day12.h5');
INSERT INTO cs_stringrepcache VALUES (13, 615, 'AMSRE_36V_AM_FT_2003_day13.h5');
INSERT INTO cs_stringrepcache VALUES (13, 616, 'AMSRE_36V_AM_FT_2003_day14.h5');
INSERT INTO cs_stringrepcache VALUES (13, 617, 'AMSRE_36V_AM_FT_2003_day15.h5');
INSERT INTO cs_stringrepcache VALUES (13, 618, 'AMSRE_36V_AM_FT_2003_day16.h5');
INSERT INTO cs_stringrepcache VALUES (13, 619, 'AMSRE_36V_AM_FT_2003_day17.h5');
INSERT INTO cs_stringrepcache VALUES (13, 620, 'AMSRE_36V_AM_FT_2003_day18.h5');
INSERT INTO cs_stringrepcache VALUES (13, 621, 'AMSRE_36V_AM_FT_2003_day19.h5');
INSERT INTO cs_stringrepcache VALUES (13, 622, 'AMSRE_36V_AM_FT_2003_day20.h5');
INSERT INTO cs_stringrepcache VALUES (13, 623, 'AMSRE_36V_AM_FT_2003_day21.h5');
INSERT INTO cs_stringrepcache VALUES (13, 624, 'AMSRE_36V_AM_FT_2003_day22.h5');
INSERT INTO cs_stringrepcache VALUES (13, 625, 'AMSRE_36V_AM_FT_2003_day23.h5');
INSERT INTO cs_stringrepcache VALUES (13, 626, 'AMSRE_36V_AM_FT_2003_day24.h5');
INSERT INTO cs_stringrepcache VALUES (13, 627, 'AMSRE_36V_AM_FT_2003_day25.h5');
INSERT INTO cs_stringrepcache VALUES (13, 628, 'AMSRE_36V_AM_FT_2003_day26.h5');
INSERT INTO cs_stringrepcache VALUES (13, 629, 'AMSRE_36V_AM_FT_2003_day27.h5');
INSERT INTO cs_stringrepcache VALUES (13, 630, 'AMSRE_36V_AM_FT_2003_day28.h5');
INSERT INTO cs_stringrepcache VALUES (13, 631, 'AMSRE_36V_AM_FT_2003_day29.h5');
INSERT INTO cs_stringrepcache VALUES (13, 632, 'AMSRE_36V_AM_FT_2003_day30.h5');
INSERT INTO cs_stringrepcache VALUES (13, 633, 'AMSRE_36V_AM_FT_2003_day31.h5');
INSERT INTO cs_stringrepcache VALUES (13, 634, 'AMSRE_36V_AM_FT_2003_day32.h5');
INSERT INTO cs_stringrepcache VALUES (13, 635, 'AMSRE_36V_AM_FT_2003_day33.h5');
INSERT INTO cs_stringrepcache VALUES (13, 636, 'AMSRE_36V_AM_FT_2003_day34.h5');
INSERT INTO cs_stringrepcache VALUES (13, 637, 'AMSRE_36V_AM_FT_2003_day35.h5');
INSERT INTO cs_stringrepcache VALUES (13, 638, 'AMSRE_36V_AM_FT_2003_day36.h5');
INSERT INTO cs_stringrepcache VALUES (13, 639, 'AMSRE_36V_AM_FT_2003_day37.h5');
INSERT INTO cs_stringrepcache VALUES (13, 640, 'AMSRE_36V_AM_FT_2003_day38.h5');
INSERT INTO cs_stringrepcache VALUES (13, 641, 'AMSRE_36V_AM_FT_2003_day39.h5');
INSERT INTO cs_stringrepcache VALUES (13, 642, 'AMSRE_36V_AM_FT_2003_day40.h5');
INSERT INTO cs_stringrepcache VALUES (13, 643, 'AMSRE_36V_AM_FT_2003_day41.h5');
INSERT INTO cs_stringrepcache VALUES (13, 644, 'AMSRE_36V_AM_FT_2003_day42.h5');
INSERT INTO cs_stringrepcache VALUES (13, 645, 'AMSRE_36V_AM_FT_2003_day43.h5');
INSERT INTO cs_stringrepcache VALUES (13, 646, 'AMSRE_36V_AM_FT_2003_day44.h5');
INSERT INTO cs_stringrepcache VALUES (13, 647, 'AMSRE_36V_AM_FT_2003_day45.h5');
INSERT INTO cs_stringrepcache VALUES (13, 648, 'AMSRE_36V_AM_FT_2003_day46.h5');
INSERT INTO cs_stringrepcache VALUES (13, 649, 'AMSRE_36V_AM_FT_2003_day47.h5');
INSERT INTO cs_stringrepcache VALUES (13, 650, 'AMSRE_36V_AM_FT_2003_day48.h5');
INSERT INTO cs_stringrepcache VALUES (13, 651, 'AMSRE_36V_AM_FT_2003_day49.h5');
INSERT INTO cs_stringrepcache VALUES (13, 652, 'AMSRE_36V_AM_FT_2003_day50.h5');
INSERT INTO cs_stringrepcache VALUES (13, 653, 'AMSRE_36V_AM_FT_2003_day51.h5');
INSERT INTO cs_stringrepcache VALUES (13, 654, 'AMSRE_36V_AM_FT_2003_day52.h5');
INSERT INTO cs_stringrepcache VALUES (13, 655, 'AMSRE_36V_AM_FT_2003_day53.h5');
INSERT INTO cs_stringrepcache VALUES (13, 656, 'AMSRE_36V_AM_FT_2003_day54.h5');
INSERT INTO cs_stringrepcache VALUES (13, 657, 'AMSRE_36V_AM_FT_2003_day55.h5');
INSERT INTO cs_stringrepcache VALUES (13, 658, 'AMSRE_36V_AM_FT_2003_day56.h5');
INSERT INTO cs_stringrepcache VALUES (13, 659, 'AMSRE_36V_AM_FT_2003_day57.h5');
INSERT INTO cs_stringrepcache VALUES (13, 660, 'AMSRE_36V_AM_FT_2003_day58.h5');
INSERT INTO cs_stringrepcache VALUES (13, 661, 'AMSRE_36V_AM_FT_2003_day59.h5');
INSERT INTO cs_stringrepcache VALUES (13, 662, 'AMSRE_36V_AM_FT_2003_day60.h5');
INSERT INTO cs_stringrepcache VALUES (13, 663, 'AMSRE_36V_AM_FT_2003_day61.h5');
INSERT INTO cs_stringrepcache VALUES (13, 664, 'AMSRE_36V_AM_FT_2003_day62.h5');
INSERT INTO cs_stringrepcache VALUES (13, 665, 'AMSRE_36V_AM_FT_2003_day63.h5');
INSERT INTO cs_stringrepcache VALUES (13, 666, 'AMSRE_36V_AM_FT_2003_day64.h5');
INSERT INTO cs_stringrepcache VALUES (13, 667, 'AMSRE_36V_AM_FT_2003_day65.h5');
INSERT INTO cs_stringrepcache VALUES (13, 668, 'AMSRE_36V_AM_FT_2003_day66.h5');
INSERT INTO cs_stringrepcache VALUES (13, 669, 'AMSRE_36V_AM_FT_2003_day67.h5');
INSERT INTO cs_stringrepcache VALUES (13, 670, 'AMSRE_36V_AM_FT_2003_day68.h5');
INSERT INTO cs_stringrepcache VALUES (13, 671, 'AMSRE_36V_AM_FT_2003_day69.h5');
INSERT INTO cs_stringrepcache VALUES (13, 672, 'AMSRE_36V_AM_FT_2003_day70.h5');
INSERT INTO cs_stringrepcache VALUES (13, 673, 'AMSRE_36V_AM_FT_2003_day71.h5');
INSERT INTO cs_stringrepcache VALUES (13, 674, 'AMSRE_36V_AM_FT_2003_day72.h5');
INSERT INTO cs_stringrepcache VALUES (13, 675, 'AMSRE_36V_AM_FT_2003_day73.h5');
INSERT INTO cs_stringrepcache VALUES (13, 676, 'AMSRE_36V_AM_FT_2003_day74.h5');
INSERT INTO cs_stringrepcache VALUES (13, 677, 'AMSRE_36V_AM_FT_2003_day75.h5');
INSERT INTO cs_stringrepcache VALUES (13, 678, 'AMSRE_36V_AM_FT_2003_day76.h5');
INSERT INTO cs_stringrepcache VALUES (13, 679, 'AMSRE_36V_AM_FT_2003_day77.h5');
INSERT INTO cs_stringrepcache VALUES (13, 680, 'AMSRE_36V_AM_FT_2003_day78.h5');
INSERT INTO cs_stringrepcache VALUES (13, 681, 'AMSRE_36V_AM_FT_2003_day79.h5');
INSERT INTO cs_stringrepcache VALUES (13, 682, 'AMSRE_36V_AM_FT_2003_day80.h5');
INSERT INTO cs_stringrepcache VALUES (13, 683, 'AMSRE_36V_AM_FT_2003_day81.h5');
INSERT INTO cs_stringrepcache VALUES (13, 684, 'AMSRE_36V_AM_FT_2003_day82.h5');
INSERT INTO cs_stringrepcache VALUES (13, 685, 'AMSRE_36V_AM_FT_2003_day83.h5');
INSERT INTO cs_stringrepcache VALUES (13, 686, 'AMSRE_36V_AM_FT_2003_day84.h5');
INSERT INTO cs_stringrepcache VALUES (13, 687, 'AMSRE_36V_AM_FT_2003_day85.h5');
INSERT INTO cs_stringrepcache VALUES (13, 688, 'AMSRE_36V_AM_FT_2003_day86.h5');
INSERT INTO cs_stringrepcache VALUES (13, 689, 'AMSRE_36V_AM_FT_2003_day87.h5');
INSERT INTO cs_stringrepcache VALUES (13, 690, 'AMSRE_36V_AM_FT_2003_day88.h5');
INSERT INTO cs_stringrepcache VALUES (13, 691, 'AMSRE_36V_AM_FT_2003_day89.h5');
INSERT INTO cs_stringrepcache VALUES (13, 692, 'AMSRE_36V_AM_FT_2003_day90.h5');
INSERT INTO cs_stringrepcache VALUES (13, 693, 'AMSRE_36V_AM_FT_2003_day91.h5');
INSERT INTO cs_stringrepcache VALUES (13, 694, 'AMSRE_36V_AM_FT_2003_day92.h5');
INSERT INTO cs_stringrepcache VALUES (13, 695, 'AMSRE_36V_AM_FT_2003_day93.h5');
INSERT INTO cs_stringrepcache VALUES (13, 696, 'AMSRE_36V_AM_FT_2003_day94.h5');
INSERT INTO cs_stringrepcache VALUES (13, 697, 'AMSRE_36V_AM_FT_2003_day95.h5');
INSERT INTO cs_stringrepcache VALUES (13, 698, 'AMSRE_36V_AM_FT_2003_day96.h5');
INSERT INTO cs_stringrepcache VALUES (13, 699, 'AMSRE_36V_AM_FT_2003_day97.h5');
INSERT INTO cs_stringrepcache VALUES (13, 700, 'AMSRE_36V_AM_FT_2003_day98.h5');
INSERT INTO cs_stringrepcache VALUES (13, 701, 'AMSRE_36V_AM_FT_2003_day99.h5');
INSERT INTO cs_stringrepcache VALUES (13, 702, 'AMSRE_36V_AM_FT_2003_day100.h5');
INSERT INTO cs_stringrepcache VALUES (13, 703, 'AMSRE_36V_AM_FT_2003_day101.h5');
INSERT INTO cs_stringrepcache VALUES (13, 704, 'AMSRE_36V_AM_FT_2003_day102.h5');
INSERT INTO cs_stringrepcache VALUES (13, 705, 'AMSRE_36V_AM_FT_2003_day103.h5');
INSERT INTO cs_stringrepcache VALUES (13, 706, 'AMSRE_36V_AM_FT_2003_day104.h5');
INSERT INTO cs_stringrepcache VALUES (13, 707, 'AMSRE_36V_AM_FT_2003_day105.h5');
INSERT INTO cs_stringrepcache VALUES (13, 708, 'AMSRE_36V_AM_FT_2003_day106.h5');
INSERT INTO cs_stringrepcache VALUES (13, 709, 'AMSRE_36V_AM_FT_2003_day107.h5');
INSERT INTO cs_stringrepcache VALUES (13, 710, 'AMSRE_36V_AM_FT_2003_day108.h5');
INSERT INTO cs_stringrepcache VALUES (13, 711, 'AMSRE_36V_AM_FT_2003_day109.h5');
INSERT INTO cs_stringrepcache VALUES (13, 712, 'AMSRE_36V_AM_FT_2003_day110.h5');
INSERT INTO cs_stringrepcache VALUES (13, 713, 'AMSRE_36V_AM_FT_2003_day111.h5');
INSERT INTO cs_stringrepcache VALUES (13, 714, 'AMSRE_36V_AM_FT_2003_day112.h5');
INSERT INTO cs_stringrepcache VALUES (13, 715, 'AMSRE_36V_AM_FT_2003_day113.h5');
INSERT INTO cs_stringrepcache VALUES (13, 716, 'AMSRE_36V_AM_FT_2003_day114.h5');
INSERT INTO cs_stringrepcache VALUES (13, 717, 'AMSRE_36V_AM_FT_2003_day115.h5');
INSERT INTO cs_stringrepcache VALUES (13, 718, 'AMSRE_36V_AM_FT_2003_day116.h5');
INSERT INTO cs_stringrepcache VALUES (13, 719, 'AMSRE_36V_AM_FT_2003_day117.h5');
INSERT INTO cs_stringrepcache VALUES (13, 720, 'AMSRE_36V_AM_FT_2003_day118.h5');
INSERT INTO cs_stringrepcache VALUES (13, 721, 'AMSRE_36V_AM_FT_2003_day119.h5');
INSERT INTO cs_stringrepcache VALUES (13, 722, 'AMSRE_36V_AM_FT_2003_day120.h5');
INSERT INTO cs_stringrepcache VALUES (13, 723, 'AMSRE_36V_AM_FT_2003_day121.h5');
INSERT INTO cs_stringrepcache VALUES (13, 724, 'AMSRE_36V_AM_FT_2003_day122.h5');
INSERT INTO cs_stringrepcache VALUES (13, 725, 'AMSRE_36V_AM_FT_2003_day123.h5');
INSERT INTO cs_stringrepcache VALUES (13, 726, 'AMSRE_36V_AM_FT_2003_day124.h5');
INSERT INTO cs_stringrepcache VALUES (13, 727, 'AMSRE_36V_AM_FT_2003_day125.h5');
INSERT INTO cs_stringrepcache VALUES (13, 728, 'AMSRE_36V_AM_FT_2003_day126.h5');
INSERT INTO cs_stringrepcache VALUES (13, 729, 'AMSRE_36V_AM_FT_2003_day127.h5');
INSERT INTO cs_stringrepcache VALUES (13, 730, 'AMSRE_36V_AM_FT_2003_day128.h5');
INSERT INTO cs_stringrepcache VALUES (13, 731, 'AMSRE_36V_AM_FT_2003_day129.h5');
INSERT INTO cs_stringrepcache VALUES (13, 732, 'AMSRE_36V_AM_FT_2003_day130.h5');
INSERT INTO cs_stringrepcache VALUES (13, 733, 'AMSRE_36V_AM_FT_2003_day131.h5');
INSERT INTO cs_stringrepcache VALUES (13, 734, 'AMSRE_36V_AM_FT_2003_day132.h5');
INSERT INTO cs_stringrepcache VALUES (13, 735, 'AMSRE_36V_AM_FT_2003_day133.h5');
INSERT INTO cs_stringrepcache VALUES (13, 736, 'AMSRE_36V_AM_FT_2003_day134.h5');
INSERT INTO cs_stringrepcache VALUES (13, 737, 'AMSRE_36V_AM_FT_2003_day135.h5');
INSERT INTO cs_stringrepcache VALUES (13, 738, 'AMSRE_36V_AM_FT_2003_day136.h5');
INSERT INTO cs_stringrepcache VALUES (13, 739, 'AMSRE_36V_AM_FT_2003_day137.h5');
INSERT INTO cs_stringrepcache VALUES (13, 740, 'AMSRE_36V_AM_FT_2003_day138.h5');
INSERT INTO cs_stringrepcache VALUES (13, 741, 'AMSRE_36V_AM_FT_2003_day139.h5');
INSERT INTO cs_stringrepcache VALUES (13, 742, 'AMSRE_36V_AM_FT_2003_day140.h5');
INSERT INTO cs_stringrepcache VALUES (13, 743, 'AMSRE_36V_AM_FT_2003_day141.h5');
INSERT INTO cs_stringrepcache VALUES (13, 744, 'AMSRE_36V_AM_FT_2003_day142.h5');
INSERT INTO cs_stringrepcache VALUES (13, 745, 'AMSRE_36V_AM_FT_2003_day143.h5');
INSERT INTO cs_stringrepcache VALUES (13, 746, 'AMSRE_36V_AM_FT_2003_day144.h5');
INSERT INTO cs_stringrepcache VALUES (13, 747, 'AMSRE_36V_AM_FT_2003_day145.h5');
INSERT INTO cs_stringrepcache VALUES (13, 748, 'AMSRE_36V_AM_FT_2003_day146.h5');
INSERT INTO cs_stringrepcache VALUES (13, 749, 'AMSRE_36V_AM_FT_2003_day147.h5');
INSERT INTO cs_stringrepcache VALUES (13, 750, 'AMSRE_36V_AM_FT_2003_day148.h5');
INSERT INTO cs_stringrepcache VALUES (13, 751, 'AMSRE_36V_AM_FT_2003_day149.h5');
INSERT INTO cs_stringrepcache VALUES (13, 752, 'AMSRE_36V_AM_FT_2003_day150.h5');
INSERT INTO cs_stringrepcache VALUES (13, 753, 'AMSRE_36V_AM_FT_2003_day151.h5');
INSERT INTO cs_stringrepcache VALUES (13, 754, 'AMSRE_36V_AM_FT_2003_day152.h5');
INSERT INTO cs_stringrepcache VALUES (13, 755, 'AMSRE_36V_AM_FT_2003_day153.h5');
INSERT INTO cs_stringrepcache VALUES (13, 756, 'AMSRE_36V_AM_FT_2003_day154.h5');
INSERT INTO cs_stringrepcache VALUES (13, 757, 'AMSRE_36V_AM_FT_2003_day155.h5');
INSERT INTO cs_stringrepcache VALUES (13, 758, 'AMSRE_36V_AM_FT_2003_day156.h5');
INSERT INTO cs_stringrepcache VALUES (13, 759, 'AMSRE_36V_AM_FT_2003_day157.h5');
INSERT INTO cs_stringrepcache VALUES (13, 760, 'AMSRE_36V_AM_FT_2003_day158.h5');
INSERT INTO cs_stringrepcache VALUES (13, 761, 'AMSRE_36V_AM_FT_2003_day159.h5');
INSERT INTO cs_stringrepcache VALUES (13, 762, 'AMSRE_36V_AM_FT_2003_day160.h5');
INSERT INTO cs_stringrepcache VALUES (13, 763, 'AMSRE_36V_AM_FT_2003_day161.h5');
INSERT INTO cs_stringrepcache VALUES (13, 764, 'AMSRE_36V_AM_FT_2003_day162.h5');
INSERT INTO cs_stringrepcache VALUES (13, 765, 'AMSRE_36V_AM_FT_2003_day163.h5');
INSERT INTO cs_stringrepcache VALUES (13, 766, 'AMSRE_36V_AM_FT_2003_day164.h5');
INSERT INTO cs_stringrepcache VALUES (13, 767, 'AMSRE_36V_AM_FT_2003_day165.h5');
INSERT INTO cs_stringrepcache VALUES (13, 768, 'AMSRE_36V_AM_FT_2003_day166.h5');
INSERT INTO cs_stringrepcache VALUES (13, 769, 'AMSRE_36V_AM_FT_2003_day167.h5');
INSERT INTO cs_stringrepcache VALUES (13, 770, 'AMSRE_36V_AM_FT_2003_day168.h5');
INSERT INTO cs_stringrepcache VALUES (13, 771, 'AMSRE_36V_AM_FT_2003_day169.h5');
INSERT INTO cs_stringrepcache VALUES (13, 772, 'AMSRE_36V_AM_FT_2003_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 773, 'AMSRE_36V_AM_FT_2003_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 774, 'AMSRE_36V_AM_FT_2003_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 775, 'AMSRE_36V_AM_FT_2003_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 776, 'AMSRE_36V_AM_FT_2003_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 777, 'AMSRE_36V_AM_FT_2003_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 778, 'AMSRE_36V_AM_FT_2003_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 779, 'AMSRE_36V_AM_FT_2003_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 780, 'AMSRE_36V_AM_FT_2003_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 781, 'AMSRE_36V_AM_FT_2003_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 782, 'AMSRE_36V_AM_FT_2003_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 783, 'AMSRE_36V_AM_FT_2003_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 784, 'AMSRE_36V_AM_FT_2003_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 785, 'AMSRE_36V_AM_FT_2003_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 786, 'AMSRE_36V_AM_FT_2003_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 787, 'AMSRE_36V_AM_FT_2003_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 788, 'AMSRE_36V_AM_FT_2003_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 789, 'AMSRE_36V_AM_FT_2003_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 790, 'AMSRE_36V_AM_FT_2003_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 791, 'AMSRE_36V_AM_FT_2003_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 792, 'AMSRE_36V_AM_FT_2003_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 793, 'AMSRE_36V_AM_FT_2003_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 794, 'AMSRE_36V_AM_FT_2003_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 795, 'AMSRE_36V_AM_FT_2003_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 796, 'AMSRE_36V_AM_FT_2003_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 797, 'AMSRE_36V_AM_FT_2003_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 798, 'AMSRE_36V_AM_FT_2003_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 799, 'AMSRE_36V_AM_FT_2003_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 800, 'AMSRE_36V_AM_FT_2003_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 801, 'AMSRE_36V_AM_FT_2003_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 802, 'AMSRE_36V_AM_FT_2003_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 803, 'AMSRE_36V_AM_FT_2003_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 804, 'AMSRE_36V_AM_FT_2003_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 805, 'AMSRE_36V_AM_FT_2003_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 806, 'AMSRE_36V_AM_FT_2003_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 807, 'AMSRE_36V_AM_FT_2003_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 808, 'AMSRE_36V_AM_FT_2003_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 809, 'AMSRE_36V_AM_FT_2003_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 810, 'AMSRE_36V_AM_FT_2003_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 811, 'AMSRE_36V_AM_FT_2003_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 812, 'AMSRE_36V_AM_FT_2003_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 813, 'AMSRE_36V_AM_FT_2003_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 814, 'AMSRE_36V_AM_FT_2003_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 815, 'AMSRE_36V_AM_FT_2003_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 816, 'AMSRE_36V_AM_FT_2003_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 817, 'AMSRE_36V_AM_FT_2003_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 818, 'AMSRE_36V_AM_FT_2003_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 819, 'AMSRE_36V_AM_FT_2003_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 820, 'AMSRE_36V_AM_FT_2003_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 821, 'AMSRE_36V_AM_FT_2003_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 822, 'AMSRE_36V_AM_FT_2003_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 823, 'AMSRE_36V_AM_FT_2003_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 824, 'AMSRE_36V_AM_FT_2003_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 825, 'AMSRE_36V_AM_FT_2003_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 826, 'AMSRE_36V_AM_FT_2003_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 827, 'AMSRE_36V_AM_FT_2003_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 828, 'AMSRE_36V_AM_FT_2003_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 829, 'AMSRE_36V_AM_FT_2003_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 830, 'AMSRE_36V_AM_FT_2003_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 831, 'AMSRE_36V_AM_FT_2003_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 832, 'AMSRE_36V_AM_FT_2003_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 833, 'AMSRE_36V_AM_FT_2003_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 834, 'AMSRE_36V_AM_FT_2003_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 835, 'AMSRE_36V_AM_FT_2003_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 836, 'AMSRE_36V_AM_FT_2003_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 837, 'AMSRE_36V_AM_FT_2003_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 838, 'AMSRE_36V_AM_FT_2003_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 839, 'AMSRE_36V_AM_FT_2003_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 840, 'AMSRE_36V_AM_FT_2003_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 841, 'AMSRE_36V_AM_FT_2003_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 842, 'AMSRE_36V_AM_FT_2003_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 843, 'AMSRE_36V_AM_FT_2003_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 844, 'AMSRE_36V_AM_FT_2003_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 845, 'AMSRE_36V_AM_FT_2003_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 846, 'AMSRE_36V_AM_FT_2003_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 847, 'AMSRE_36V_AM_FT_2003_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 848, 'AMSRE_36V_AM_FT_2003_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 849, 'AMSRE_36V_AM_FT_2003_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 850, 'AMSRE_36V_AM_FT_2003_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 851, 'AMSRE_36V_AM_FT_2003_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 852, 'AMSRE_36V_AM_FT_2003_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 853, 'AMSRE_36V_AM_FT_2003_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 854, 'AMSRE_36V_AM_FT_2003_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 855, 'AMSRE_36V_AM_FT_2003_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 856, 'AMSRE_36V_AM_FT_2003_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 857, 'AMSRE_36V_AM_FT_2003_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 858, 'AMSRE_36V_AM_FT_2003_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 859, 'AMSRE_36V_AM_FT_2003_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 860, 'AMSRE_36V_AM_FT_2003_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 861, 'AMSRE_36V_AM_FT_2003_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 862, 'AMSRE_36V_AM_FT_2003_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 863, 'AMSRE_36V_AM_FT_2003_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 864, 'AMSRE_36V_AM_FT_2003_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 865, 'AMSRE_36V_AM_FT_2003_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 866, 'AMSRE_36V_AM_FT_2003_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 867, 'AMSRE_36V_AM_FT_2003_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 868, 'AMSRE_36V_AM_FT_2003_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 869, 'AMSRE_36V_AM_FT_2003_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 870, 'AMSRE_36V_AM_FT_2003_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 871, 'AMSRE_36V_AM_FT_2003_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 872, 'AMSRE_36V_AM_FT_2003_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 873, 'AMSRE_36V_AM_FT_2003_day271.h5');
INSERT INTO cs_stringrepcache VALUES (13, 874, 'AMSRE_36V_AM_FT_2003_day272.h5');
INSERT INTO cs_stringrepcache VALUES (13, 875, 'AMSRE_36V_AM_FT_2003_day273.h5');
INSERT INTO cs_stringrepcache VALUES (13, 876, 'AMSRE_36V_AM_FT_2003_day274.h5');
INSERT INTO cs_stringrepcache VALUES (13, 877, 'AMSRE_36V_AM_FT_2003_day275.h5');
INSERT INTO cs_stringrepcache VALUES (13, 878, 'AMSRE_36V_AM_FT_2003_day276.h5');
INSERT INTO cs_stringrepcache VALUES (13, 879, 'AMSRE_36V_AM_FT_2003_day277.h5');
INSERT INTO cs_stringrepcache VALUES (13, 880, 'AMSRE_36V_AM_FT_2003_day278.h5');
INSERT INTO cs_stringrepcache VALUES (13, 881, 'AMSRE_36V_AM_FT_2003_day279.h5');
INSERT INTO cs_stringrepcache VALUES (13, 882, 'AMSRE_36V_AM_FT_2003_day280.h5');
INSERT INTO cs_stringrepcache VALUES (13, 883, 'AMSRE_36V_AM_FT_2003_day281.h5');
INSERT INTO cs_stringrepcache VALUES (13, 884, 'AMSRE_36V_AM_FT_2003_day282.h5');
INSERT INTO cs_stringrepcache VALUES (13, 885, 'AMSRE_36V_AM_FT_2003_day283.h5');
INSERT INTO cs_stringrepcache VALUES (13, 886, 'AMSRE_36V_AM_FT_2003_day284.h5');
INSERT INTO cs_stringrepcache VALUES (13, 887, 'AMSRE_36V_AM_FT_2003_day285.h5');
INSERT INTO cs_stringrepcache VALUES (13, 888, 'AMSRE_36V_AM_FT_2003_day286.h5');
INSERT INTO cs_stringrepcache VALUES (13, 889, 'AMSRE_36V_AM_FT_2003_day287.h5');
INSERT INTO cs_stringrepcache VALUES (13, 890, 'AMSRE_36V_AM_FT_2003_day288.h5');
INSERT INTO cs_stringrepcache VALUES (13, 891, 'AMSRE_36V_AM_FT_2003_day289.h5');
INSERT INTO cs_stringrepcache VALUES (13, 892, 'AMSRE_36V_AM_FT_2003_day290.h5');
INSERT INTO cs_stringrepcache VALUES (13, 893, 'AMSRE_36V_AM_FT_2003_day291.h5');
INSERT INTO cs_stringrepcache VALUES (13, 894, 'AMSRE_36V_AM_FT_2003_day292.h5');
INSERT INTO cs_stringrepcache VALUES (13, 895, 'AMSRE_36V_AM_FT_2003_day293.h5');
INSERT INTO cs_stringrepcache VALUES (13, 896, 'AMSRE_36V_AM_FT_2003_day294.h5');
INSERT INTO cs_stringrepcache VALUES (13, 897, 'AMSRE_36V_AM_FT_2003_day295.h5');
INSERT INTO cs_stringrepcache VALUES (13, 898, 'AMSRE_36V_AM_FT_2003_day296.h5');
INSERT INTO cs_stringrepcache VALUES (13, 899, 'AMSRE_36V_AM_FT_2003_day297.h5');
INSERT INTO cs_stringrepcache VALUES (13, 900, 'AMSRE_36V_AM_FT_2003_day298.h5');
INSERT INTO cs_stringrepcache VALUES (13, 901, 'AMSRE_36V_AM_FT_2003_day299.h5');
INSERT INTO cs_stringrepcache VALUES (13, 902, 'AMSRE_36V_AM_FT_2003_day300.h5');
INSERT INTO cs_stringrepcache VALUES (13, 903, 'AMSRE_36V_AM_FT_2003_day301.h5');
INSERT INTO cs_stringrepcache VALUES (13, 904, 'AMSRE_36V_AM_FT_2003_day302.h5');
INSERT INTO cs_stringrepcache VALUES (13, 905, 'AMSRE_36V_AM_FT_2003_day303.h5');
INSERT INTO cs_stringrepcache VALUES (13, 906, 'AMSRE_36V_AM_FT_2003_day304.h5');
INSERT INTO cs_stringrepcache VALUES (13, 907, 'AMSRE_36V_AM_FT_2003_day305.h5');
INSERT INTO cs_stringrepcache VALUES (13, 908, 'AMSRE_36V_AM_FT_2003_day306.h5');
INSERT INTO cs_stringrepcache VALUES (13, 909, 'AMSRE_36V_AM_FT_2003_day307.h5');
INSERT INTO cs_stringrepcache VALUES (13, 910, 'AMSRE_36V_AM_FT_2003_day308.h5');
INSERT INTO cs_stringrepcache VALUES (13, 911, 'AMSRE_36V_AM_FT_2003_day309.h5');
INSERT INTO cs_stringrepcache VALUES (13, 912, 'AMSRE_36V_AM_FT_2003_day310.h5');
INSERT INTO cs_stringrepcache VALUES (13, 913, 'AMSRE_36V_AM_FT_2003_day311.h5');
INSERT INTO cs_stringrepcache VALUES (13, 914, 'AMSRE_36V_AM_FT_2003_day312.h5');
INSERT INTO cs_stringrepcache VALUES (13, 915, 'AMSRE_36V_AM_FT_2003_day313.h5');
INSERT INTO cs_stringrepcache VALUES (13, 916, 'AMSRE_36V_AM_FT_2003_day314.h5');
INSERT INTO cs_stringrepcache VALUES (13, 917, 'AMSRE_36V_AM_FT_2003_day315.h5');
INSERT INTO cs_stringrepcache VALUES (13, 918, 'AMSRE_36V_AM_FT_2003_day316.h5');
INSERT INTO cs_stringrepcache VALUES (13, 919, 'AMSRE_36V_AM_FT_2003_day317.h5');
INSERT INTO cs_stringrepcache VALUES (13, 920, 'AMSRE_36V_AM_FT_2003_day318.h5');
INSERT INTO cs_stringrepcache VALUES (13, 921, 'AMSRE_36V_AM_FT_2003_day319.h5');
INSERT INTO cs_stringrepcache VALUES (13, 922, 'AMSRE_36V_AM_FT_2003_day320.h5');
INSERT INTO cs_stringrepcache VALUES (13, 923, 'AMSRE_36V_AM_FT_2003_day321.h5');
INSERT INTO cs_stringrepcache VALUES (13, 924, 'AMSRE_36V_AM_FT_2003_day322.h5');
INSERT INTO cs_stringrepcache VALUES (13, 925, 'AMSRE_36V_AM_FT_2003_day323.h5');
INSERT INTO cs_stringrepcache VALUES (13, 926, 'AMSRE_36V_AM_FT_2003_day324.h5');
INSERT INTO cs_stringrepcache VALUES (13, 927, 'AMSRE_36V_AM_FT_2003_day325.h5');
INSERT INTO cs_stringrepcache VALUES (13, 928, 'AMSRE_36V_AM_FT_2003_day326.h5');
INSERT INTO cs_stringrepcache VALUES (13, 929, 'AMSRE_36V_AM_FT_2003_day327.h5');
INSERT INTO cs_stringrepcache VALUES (13, 930, 'AMSRE_36V_AM_FT_2003_day328.h5');
INSERT INTO cs_stringrepcache VALUES (13, 931, 'AMSRE_36V_AM_FT_2003_day329.h5');
INSERT INTO cs_stringrepcache VALUES (13, 932, 'AMSRE_36V_AM_FT_2003_day330.h5');
INSERT INTO cs_stringrepcache VALUES (13, 933, 'AMSRE_36V_AM_FT_2003_day331.h5');
INSERT INTO cs_stringrepcache VALUES (13, 934, 'AMSRE_36V_AM_FT_2003_day332.h5');
INSERT INTO cs_stringrepcache VALUES (13, 935, 'AMSRE_36V_AM_FT_2003_day333.h5');
INSERT INTO cs_stringrepcache VALUES (13, 936, 'AMSRE_36V_AM_FT_2003_day334.h5');
INSERT INTO cs_stringrepcache VALUES (13, 937, 'AMSRE_36V_AM_FT_2003_day335.h5');
INSERT INTO cs_stringrepcache VALUES (13, 938, 'AMSRE_36V_AM_FT_2003_day336.h5');
INSERT INTO cs_stringrepcache VALUES (13, 939, 'AMSRE_36V_AM_FT_2003_day337.h5');
INSERT INTO cs_stringrepcache VALUES (13, 940, 'AMSRE_36V_AM_FT_2003_day338.h5');
INSERT INTO cs_stringrepcache VALUES (13, 941, 'AMSRE_36V_AM_FT_2003_day339.h5');
INSERT INTO cs_stringrepcache VALUES (13, 942, 'AMSRE_36V_AM_FT_2003_day340.h5');
INSERT INTO cs_stringrepcache VALUES (13, 943, 'AMSRE_36V_AM_FT_2003_day341.h5');
INSERT INTO cs_stringrepcache VALUES (13, 944, 'AMSRE_36V_AM_FT_2003_day342.h5');
INSERT INTO cs_stringrepcache VALUES (13, 945, 'AMSRE_36V_AM_FT_2003_day343.h5');
INSERT INTO cs_stringrepcache VALUES (13, 946, 'AMSRE_36V_AM_FT_2003_day344.h5');
INSERT INTO cs_stringrepcache VALUES (13, 947, 'AMSRE_36V_AM_FT_2003_day345.h5');
INSERT INTO cs_stringrepcache VALUES (13, 948, 'AMSRE_36V_AM_FT_2003_day346.h5');
INSERT INTO cs_stringrepcache VALUES (13, 949, 'AMSRE_36V_AM_FT_2003_day347.h5');
INSERT INTO cs_stringrepcache VALUES (13, 950, 'AMSRE_36V_AM_FT_2003_day348.h5');
INSERT INTO cs_stringrepcache VALUES (13, 951, 'AMSRE_36V_AM_FT_2003_day349.h5');
INSERT INTO cs_stringrepcache VALUES (13, 952, 'AMSRE_36V_AM_FT_2003_day350.h5');
INSERT INTO cs_stringrepcache VALUES (13, 953, 'AMSRE_36V_AM_FT_2003_day351.h5');
INSERT INTO cs_stringrepcache VALUES (13, 954, 'AMSRE_36V_AM_FT_2003_day352.h5');
INSERT INTO cs_stringrepcache VALUES (13, 955, 'AMSRE_36V_AM_FT_2003_day353.h5');
INSERT INTO cs_stringrepcache VALUES (13, 956, 'AMSRE_36V_AM_FT_2003_day354.h5');
INSERT INTO cs_stringrepcache VALUES (13, 957, 'AMSRE_36V_AM_FT_2003_day355.h5');
INSERT INTO cs_stringrepcache VALUES (13, 958, 'AMSRE_36V_AM_FT_2003_day356.h5');
INSERT INTO cs_stringrepcache VALUES (13, 959, 'AMSRE_36V_AM_FT_2003_day357.h5');
INSERT INTO cs_stringrepcache VALUES (13, 960, 'AMSRE_36V_AM_FT_2003_day358.h5');
INSERT INTO cs_stringrepcache VALUES (13, 961, 'AMSRE_36V_AM_FT_2003_day359.h5');
INSERT INTO cs_stringrepcache VALUES (13, 962, 'AMSRE_36V_AM_FT_2003_day360.h5');
INSERT INTO cs_stringrepcache VALUES (13, 963, 'AMSRE_36V_AM_FT_2003_day361.h5');
INSERT INTO cs_stringrepcache VALUES (13, 964, 'AMSRE_36V_AM_FT_2003_day362.h5');
INSERT INTO cs_stringrepcache VALUES (13, 965, 'AMSRE_36V_AM_FT_2003_day363.h5');
INSERT INTO cs_stringrepcache VALUES (13, 966, 'AMSRE_36V_AM_FT_2003_day364.h5');
INSERT INTO cs_stringrepcache VALUES (13, 967, 'AMSRE_36V_AM_FT_2003_day365.h5');
INSERT INTO cs_stringrepcache VALUES (13, 968, 'AMSRE_36V_AM_FT_2004_day1.h5');
INSERT INTO cs_stringrepcache VALUES (13, 969, 'AMSRE_36V_AM_FT_2004_day2.h5');
INSERT INTO cs_stringrepcache VALUES (13, 970, 'AMSRE_36V_AM_FT_2004_day3.h5');
INSERT INTO cs_stringrepcache VALUES (13, 971, 'AMSRE_36V_AM_FT_2004_day4.h5');
INSERT INTO cs_stringrepcache VALUES (13, 972, 'AMSRE_36V_AM_FT_2004_day5.h5');
INSERT INTO cs_stringrepcache VALUES (13, 973, 'AMSRE_36V_AM_FT_2004_day6.h5');
INSERT INTO cs_stringrepcache VALUES (13, 974, 'AMSRE_36V_AM_FT_2004_day7.h5');
INSERT INTO cs_stringrepcache VALUES (13, 975, 'AMSRE_36V_AM_FT_2004_day8.h5');
INSERT INTO cs_stringrepcache VALUES (13, 976, 'AMSRE_36V_AM_FT_2004_day9.h5');
INSERT INTO cs_stringrepcache VALUES (13, 977, 'AMSRE_36V_AM_FT_2004_day10.h5');
INSERT INTO cs_stringrepcache VALUES (13, 978, 'AMSRE_36V_AM_FT_2004_day11.h5');
INSERT INTO cs_stringrepcache VALUES (13, 979, 'AMSRE_36V_AM_FT_2004_day12.h5');
INSERT INTO cs_stringrepcache VALUES (13, 980, 'AMSRE_36V_AM_FT_2004_day13.h5');
INSERT INTO cs_stringrepcache VALUES (13, 981, 'AMSRE_36V_AM_FT_2004_day14.h5');
INSERT INTO cs_stringrepcache VALUES (13, 982, 'AMSRE_36V_AM_FT_2004_day15.h5');
INSERT INTO cs_stringrepcache VALUES (13, 983, 'AMSRE_36V_AM_FT_2004_day16.h5');
INSERT INTO cs_stringrepcache VALUES (13, 984, 'AMSRE_36V_AM_FT_2004_day17.h5');
INSERT INTO cs_stringrepcache VALUES (13, 985, 'AMSRE_36V_AM_FT_2004_day18.h5');
INSERT INTO cs_stringrepcache VALUES (13, 986, 'AMSRE_36V_AM_FT_2004_day19.h5');
INSERT INTO cs_stringrepcache VALUES (13, 987, 'AMSRE_36V_AM_FT_2004_day20.h5');
INSERT INTO cs_stringrepcache VALUES (13, 988, 'AMSRE_36V_AM_FT_2004_day21.h5');
INSERT INTO cs_stringrepcache VALUES (13, 989, 'AMSRE_36V_AM_FT_2004_day22.h5');
INSERT INTO cs_stringrepcache VALUES (13, 990, 'AMSRE_36V_AM_FT_2004_day23.h5');
INSERT INTO cs_stringrepcache VALUES (13, 991, 'AMSRE_36V_AM_FT_2004_day24.h5');
INSERT INTO cs_stringrepcache VALUES (13, 992, 'AMSRE_36V_AM_FT_2004_day25.h5');
INSERT INTO cs_stringrepcache VALUES (13, 993, 'AMSRE_36V_AM_FT_2004_day26.h5');
INSERT INTO cs_stringrepcache VALUES (13, 994, 'AMSRE_36V_AM_FT_2004_day27.h5');
INSERT INTO cs_stringrepcache VALUES (13, 995, 'AMSRE_36V_AM_FT_2004_day28.h5');
INSERT INTO cs_stringrepcache VALUES (13, 996, 'AMSRE_36V_AM_FT_2004_day29.h5');
INSERT INTO cs_stringrepcache VALUES (13, 997, 'AMSRE_36V_AM_FT_2004_day30.h5');
INSERT INTO cs_stringrepcache VALUES (13, 998, 'AMSRE_36V_AM_FT_2004_day31.h5');
INSERT INTO cs_stringrepcache VALUES (13, 999, 'AMSRE_36V_AM_FT_2004_day32.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1000, 'AMSRE_36V_AM_FT_2004_day33.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1001, 'AMSRE_36V_AM_FT_2004_day34.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1002, 'AMSRE_36V_AM_FT_2004_day35.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1003, 'AMSRE_36V_AM_FT_2004_day36.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1004, 'AMSRE_36V_AM_FT_2004_day37.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1005, 'AMSRE_36V_AM_FT_2004_day38.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1006, 'AMSRE_36V_AM_FT_2004_day39.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1007, 'AMSRE_36V_AM_FT_2004_day40.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1008, 'AMSRE_36V_AM_FT_2004_day41.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1009, 'AMSRE_36V_AM_FT_2004_day42.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1010, 'AMSRE_36V_AM_FT_2004_day43.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1011, 'AMSRE_36V_AM_FT_2004_day44.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1012, 'AMSRE_36V_AM_FT_2004_day45.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1013, 'AMSRE_36V_AM_FT_2004_day46.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1014, 'AMSRE_36V_AM_FT_2004_day47.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1015, 'AMSRE_36V_AM_FT_2004_day48.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1016, 'AMSRE_36V_AM_FT_2004_day49.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1017, 'AMSRE_36V_AM_FT_2004_day50.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1018, 'AMSRE_36V_AM_FT_2004_day51.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1019, 'AMSRE_36V_AM_FT_2004_day52.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1020, 'AMSRE_36V_AM_FT_2004_day53.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1021, 'AMSRE_36V_AM_FT_2004_day54.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1022, 'AMSRE_36V_AM_FT_2004_day55.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1023, 'AMSRE_36V_AM_FT_2004_day56.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1024, 'AMSRE_36V_AM_FT_2004_day57.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1025, 'AMSRE_36V_AM_FT_2004_day58.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1026, 'AMSRE_36V_AM_FT_2004_day59.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1027, 'AMSRE_36V_AM_FT_2004_day60.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1028, 'AMSRE_36V_AM_FT_2004_day61.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1029, 'AMSRE_36V_AM_FT_2004_day62.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1030, 'AMSRE_36V_AM_FT_2004_day63.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1031, 'AMSRE_36V_AM_FT_2004_day64.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1032, 'AMSRE_36V_AM_FT_2004_day65.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1033, 'AMSRE_36V_AM_FT_2004_day66.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1034, 'AMSRE_36V_AM_FT_2004_day67.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1035, 'AMSRE_36V_AM_FT_2004_day68.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1036, 'AMSRE_36V_AM_FT_2004_day69.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1037, 'AMSRE_36V_AM_FT_2004_day70.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1038, 'AMSRE_36V_AM_FT_2004_day71.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1039, 'AMSRE_36V_AM_FT_2004_day72.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1040, 'AMSRE_36V_AM_FT_2004_day73.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1041, 'AMSRE_36V_AM_FT_2004_day74.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1042, 'AMSRE_36V_AM_FT_2004_day75.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1043, 'AMSRE_36V_AM_FT_2004_day76.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1044, 'AMSRE_36V_AM_FT_2004_day77.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1045, 'AMSRE_36V_AM_FT_2004_day78.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1046, 'AMSRE_36V_AM_FT_2004_day79.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1047, 'AMSRE_36V_AM_FT_2004_day80.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1048, 'AMSRE_36V_AM_FT_2004_day81.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1049, 'AMSRE_36V_AM_FT_2004_day82.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1050, 'AMSRE_36V_AM_FT_2004_day83.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1051, 'AMSRE_36V_AM_FT_2004_day84.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1052, 'AMSRE_36V_AM_FT_2004_day85.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1053, 'AMSRE_36V_AM_FT_2004_day86.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1054, 'AMSRE_36V_AM_FT_2004_day87.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1055, 'AMSRE_36V_AM_FT_2004_day88.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1056, 'AMSRE_36V_AM_FT_2004_day89.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1057, 'AMSRE_36V_AM_FT_2004_day90.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1058, 'AMSRE_36V_AM_FT_2004_day91.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1059, 'AMSRE_36V_AM_FT_2004_day92.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1060, 'AMSRE_36V_AM_FT_2004_day93.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1061, 'AMSRE_36V_AM_FT_2004_day94.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1062, 'AMSRE_36V_AM_FT_2004_day95.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1063, 'AMSRE_36V_AM_FT_2004_day96.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1064, 'AMSRE_36V_AM_FT_2004_day97.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1065, 'AMSRE_36V_AM_FT_2004_day98.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1066, 'AMSRE_36V_AM_FT_2004_day99.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1067, 'AMSRE_36V_AM_FT_2004_day100.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1068, 'AMSRE_36V_AM_FT_2004_day101.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1069, 'AMSRE_36V_AM_FT_2004_day102.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1070, 'AMSRE_36V_AM_FT_2004_day103.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1071, 'AMSRE_36V_AM_FT_2004_day104.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1072, 'AMSRE_36V_AM_FT_2004_day105.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1073, 'AMSRE_36V_AM_FT_2004_day106.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1074, 'AMSRE_36V_AM_FT_2004_day107.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1075, 'AMSRE_36V_AM_FT_2004_day108.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1076, 'AMSRE_36V_AM_FT_2004_day109.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1077, 'AMSRE_36V_AM_FT_2004_day110.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1078, 'AMSRE_36V_AM_FT_2004_day111.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1079, 'AMSRE_36V_AM_FT_2004_day112.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1080, 'AMSRE_36V_AM_FT_2004_day113.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1081, 'AMSRE_36V_AM_FT_2004_day114.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1082, 'AMSRE_36V_AM_FT_2004_day115.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1083, 'AMSRE_36V_AM_FT_2004_day116.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1084, 'AMSRE_36V_AM_FT_2004_day117.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1085, 'AMSRE_36V_AM_FT_2004_day118.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1086, 'AMSRE_36V_AM_FT_2004_day119.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1087, 'AMSRE_36V_AM_FT_2004_day120.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1088, 'AMSRE_36V_AM_FT_2004_day121.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1089, 'AMSRE_36V_AM_FT_2004_day122.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1090, 'AMSRE_36V_AM_FT_2004_day123.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1091, 'AMSRE_36V_AM_FT_2004_day124.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1092, 'AMSRE_36V_AM_FT_2004_day125.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1093, 'AMSRE_36V_AM_FT_2004_day126.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1094, 'AMSRE_36V_AM_FT_2004_day127.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1095, 'AMSRE_36V_AM_FT_2004_day128.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1096, 'AMSRE_36V_AM_FT_2004_day129.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1097, 'AMSRE_36V_AM_FT_2004_day130.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1098, 'AMSRE_36V_AM_FT_2004_day131.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1099, 'AMSRE_36V_AM_FT_2004_day132.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1100, 'AMSRE_36V_AM_FT_2004_day133.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1101, 'AMSRE_36V_AM_FT_2004_day134.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1102, 'AMSRE_36V_AM_FT_2004_day135.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1103, 'AMSRE_36V_AM_FT_2004_day136.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1104, 'AMSRE_36V_AM_FT_2004_day137.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1105, 'AMSRE_36V_AM_FT_2004_day138.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1106, 'AMSRE_36V_AM_FT_2004_day139.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1107, 'AMSRE_36V_AM_FT_2004_day140.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1108, 'AMSRE_36V_AM_FT_2004_day141.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1109, 'AMSRE_36V_AM_FT_2004_day142.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1110, 'AMSRE_36V_AM_FT_2004_day143.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1111, 'AMSRE_36V_AM_FT_2004_day144.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1112, 'AMSRE_36V_AM_FT_2004_day145.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1113, 'AMSRE_36V_AM_FT_2004_day146.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1114, 'AMSRE_36V_AM_FT_2004_day147.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1115, 'AMSRE_36V_AM_FT_2004_day148.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1116, 'AMSRE_36V_AM_FT_2004_day149.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1117, 'AMSRE_36V_AM_FT_2004_day150.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1118, 'AMSRE_36V_AM_FT_2004_day151.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1119, 'AMSRE_36V_AM_FT_2004_day152.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1120, 'AMSRE_36V_AM_FT_2004_day153.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1121, 'AMSRE_36V_AM_FT_2004_day154.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1122, 'AMSRE_36V_AM_FT_2004_day155.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1123, 'AMSRE_36V_AM_FT_2004_day156.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1124, 'AMSRE_36V_AM_FT_2004_day157.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1125, 'AMSRE_36V_AM_FT_2004_day158.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1126, 'AMSRE_36V_AM_FT_2004_day159.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1127, 'AMSRE_36V_AM_FT_2004_day160.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1128, 'AMSRE_36V_AM_FT_2004_day161.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1129, 'AMSRE_36V_AM_FT_2004_day162.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1130, 'AMSRE_36V_AM_FT_2004_day163.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1131, 'AMSRE_36V_AM_FT_2004_day164.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1132, 'AMSRE_36V_AM_FT_2004_day165.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1133, 'AMSRE_36V_AM_FT_2004_day166.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1134, 'AMSRE_36V_AM_FT_2004_day167.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1135, 'AMSRE_36V_AM_FT_2004_day168.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1136, 'AMSRE_36V_AM_FT_2004_day169.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1137, 'AMSRE_36V_AM_FT_2004_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1138, 'AMSRE_36V_AM_FT_2004_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1139, 'AMSRE_36V_AM_FT_2004_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1140, 'AMSRE_36V_AM_FT_2004_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1141, 'AMSRE_36V_AM_FT_2004_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1142, 'AMSRE_36V_AM_FT_2004_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1143, 'AMSRE_36V_AM_FT_2004_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1144, 'AMSRE_36V_AM_FT_2004_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1145, 'AMSRE_36V_AM_FT_2004_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1146, 'AMSRE_36V_AM_FT_2004_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1147, 'AMSRE_36V_AM_FT_2004_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1148, 'AMSRE_36V_AM_FT_2004_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1149, 'AMSRE_36V_AM_FT_2004_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1150, 'AMSRE_36V_AM_FT_2004_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1151, 'AMSRE_36V_AM_FT_2004_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1152, 'AMSRE_36V_AM_FT_2004_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1153, 'AMSRE_36V_AM_FT_2004_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1154, 'AMSRE_36V_AM_FT_2004_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1155, 'AMSRE_36V_AM_FT_2004_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1156, 'AMSRE_36V_AM_FT_2004_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1157, 'AMSRE_36V_AM_FT_2004_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1158, 'AMSRE_36V_AM_FT_2004_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1159, 'AMSRE_36V_AM_FT_2004_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1160, 'AMSRE_36V_AM_FT_2004_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1161, 'AMSRE_36V_AM_FT_2004_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1162, 'AMSRE_36V_AM_FT_2004_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1163, 'AMSRE_36V_AM_FT_2004_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1164, 'AMSRE_36V_AM_FT_2004_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1165, 'AMSRE_36V_AM_FT_2004_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1166, 'AMSRE_36V_AM_FT_2004_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1167, 'AMSRE_36V_AM_FT_2004_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1168, 'AMSRE_36V_AM_FT_2004_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1169, 'AMSRE_36V_AM_FT_2004_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1170, 'AMSRE_36V_AM_FT_2004_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1171, 'AMSRE_36V_AM_FT_2004_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1172, 'AMSRE_36V_AM_FT_2004_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1173, 'AMSRE_36V_AM_FT_2004_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1174, 'AMSRE_36V_AM_FT_2004_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1175, 'AMSRE_36V_AM_FT_2004_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1176, 'AMSRE_36V_AM_FT_2004_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1177, 'AMSRE_36V_AM_FT_2004_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1178, 'AMSRE_36V_AM_FT_2004_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1179, 'AMSRE_36V_AM_FT_2004_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1180, 'AMSRE_36V_AM_FT_2004_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1181, 'AMSRE_36V_AM_FT_2004_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1182, 'AMSRE_36V_AM_FT_2004_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1183, 'AMSRE_36V_AM_FT_2004_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1184, 'AMSRE_36V_AM_FT_2004_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1185, 'AMSRE_36V_AM_FT_2004_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1186, 'AMSRE_36V_AM_FT_2004_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1187, 'AMSRE_36V_AM_FT_2004_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1188, 'AMSRE_36V_AM_FT_2004_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1189, 'AMSRE_36V_AM_FT_2004_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1190, 'AMSRE_36V_AM_FT_2004_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1191, 'AMSRE_36V_AM_FT_2004_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1192, 'AMSRE_36V_AM_FT_2004_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1193, 'AMSRE_36V_AM_FT_2004_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1194, 'AMSRE_36V_AM_FT_2004_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1195, 'AMSRE_36V_AM_FT_2004_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1196, 'AMSRE_36V_AM_FT_2004_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1197, 'AMSRE_36V_AM_FT_2004_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1198, 'AMSRE_36V_AM_FT_2004_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1199, 'AMSRE_36V_AM_FT_2004_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1200, 'AMSRE_36V_AM_FT_2004_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1201, 'AMSRE_36V_AM_FT_2004_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1202, 'AMSRE_36V_AM_FT_2004_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1203, 'AMSRE_36V_AM_FT_2004_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1204, 'AMSRE_36V_AM_FT_2004_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1205, 'AMSRE_36V_AM_FT_2004_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1206, 'AMSRE_36V_AM_FT_2004_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1207, 'AMSRE_36V_AM_FT_2004_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1208, 'AMSRE_36V_AM_FT_2004_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1209, 'AMSRE_36V_AM_FT_2004_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1210, 'AMSRE_36V_AM_FT_2004_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1211, 'AMSRE_36V_AM_FT_2004_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1212, 'AMSRE_36V_AM_FT_2004_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1213, 'AMSRE_36V_AM_FT_2004_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1214, 'AMSRE_36V_AM_FT_2004_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1215, 'AMSRE_36V_AM_FT_2004_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1216, 'AMSRE_36V_AM_FT_2004_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1217, 'AMSRE_36V_AM_FT_2004_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1218, 'AMSRE_36V_AM_FT_2004_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1219, 'AMSRE_36V_AM_FT_2004_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1220, 'AMSRE_36V_AM_FT_2004_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1221, 'AMSRE_36V_AM_FT_2004_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1222, 'AMSRE_36V_AM_FT_2004_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1223, 'AMSRE_36V_AM_FT_2004_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1224, 'AMSRE_36V_AM_FT_2004_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1225, 'AMSRE_36V_AM_FT_2004_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1226, 'AMSRE_36V_AM_FT_2004_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1227, 'AMSRE_36V_AM_FT_2004_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1228, 'AMSRE_36V_AM_FT_2004_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1229, 'AMSRE_36V_AM_FT_2004_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1230, 'AMSRE_36V_AM_FT_2004_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1231, 'AMSRE_36V_AM_FT_2004_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1232, 'AMSRE_36V_AM_FT_2004_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1233, 'AMSRE_36V_AM_FT_2004_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1234, 'AMSRE_36V_AM_FT_2004_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1235, 'AMSRE_36V_AM_FT_2004_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1236, 'AMSRE_36V_AM_FT_2004_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1237, 'AMSRE_36V_AM_FT_2004_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1238, 'AMSRE_36V_AM_FT_2004_day271.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1239, 'AMSRE_36V_AM_FT_2004_day272.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1240, 'AMSRE_36V_AM_FT_2004_day273.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1241, 'AMSRE_36V_AM_FT_2004_day274.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1242, 'AMSRE_36V_AM_FT_2004_day275.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1243, 'AMSRE_36V_AM_FT_2004_day276.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1244, 'AMSRE_36V_AM_FT_2004_day277.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1245, 'AMSRE_36V_AM_FT_2004_day278.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1246, 'AMSRE_36V_AM_FT_2004_day279.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1247, 'AMSRE_36V_AM_FT_2004_day280.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1248, 'AMSRE_36V_AM_FT_2004_day281.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1249, 'AMSRE_36V_AM_FT_2004_day282.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1250, 'AMSRE_36V_AM_FT_2004_day283.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1251, 'AMSRE_36V_AM_FT_2004_day284.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1252, 'AMSRE_36V_AM_FT_2004_day285.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1253, 'AMSRE_36V_AM_FT_2004_day286.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1254, 'AMSRE_36V_AM_FT_2004_day287.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1255, 'AMSRE_36V_AM_FT_2004_day288.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1256, 'AMSRE_36V_AM_FT_2004_day289.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1257, 'AMSRE_36V_AM_FT_2004_day290.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1258, 'AMSRE_36V_AM_FT_2004_day291.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1259, 'AMSRE_36V_AM_FT_2004_day292.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1260, 'AMSRE_36V_AM_FT_2004_day293.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1261, 'AMSRE_36V_AM_FT_2004_day294.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1262, 'AMSRE_36V_AM_FT_2004_day295.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1263, 'AMSRE_36V_AM_FT_2004_day296.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1264, 'AMSRE_36V_AM_FT_2004_day297.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1265, 'AMSRE_36V_AM_FT_2004_day298.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1266, 'AMSRE_36V_AM_FT_2004_day299.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1267, 'AMSRE_36V_AM_FT_2004_day300.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1268, 'AMSRE_36V_AM_FT_2004_day301.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1269, 'AMSRE_36V_AM_FT_2004_day302.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1270, 'AMSRE_36V_AM_FT_2004_day303.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1271, 'AMSRE_36V_AM_FT_2004_day304.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1272, 'AMSRE_36V_AM_FT_2004_day305.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1273, 'AMSRE_36V_AM_FT_2004_day306.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1274, 'AMSRE_36V_AM_FT_2004_day307.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1275, 'AMSRE_36V_AM_FT_2004_day308.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1276, 'AMSRE_36V_AM_FT_2004_day309.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1277, 'AMSRE_36V_AM_FT_2004_day310.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1278, 'AMSRE_36V_AM_FT_2004_day311.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1279, 'AMSRE_36V_AM_FT_2004_day312.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1280, 'AMSRE_36V_AM_FT_2004_day313.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1281, 'AMSRE_36V_AM_FT_2004_day314.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1282, 'AMSRE_36V_AM_FT_2004_day315.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1283, 'AMSRE_36V_AM_FT_2004_day316.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1284, 'AMSRE_36V_AM_FT_2004_day317.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1285, 'AMSRE_36V_AM_FT_2004_day318.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1286, 'AMSRE_36V_AM_FT_2004_day319.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1287, 'AMSRE_36V_AM_FT_2004_day320.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1288, 'AMSRE_36V_AM_FT_2004_day321.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1289, 'AMSRE_36V_AM_FT_2004_day322.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1290, 'AMSRE_36V_AM_FT_2004_day323.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1291, 'AMSRE_36V_AM_FT_2004_day324.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1292, 'AMSRE_36V_AM_FT_2004_day325.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1293, 'AMSRE_36V_AM_FT_2004_day326.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1294, 'AMSRE_36V_AM_FT_2004_day327.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1295, 'AMSRE_36V_AM_FT_2004_day328.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1296, 'AMSRE_36V_AM_FT_2004_day329.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1297, 'AMSRE_36V_AM_FT_2004_day330.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1298, 'AMSRE_36V_AM_FT_2004_day331.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1299, 'AMSRE_36V_AM_FT_2004_day332.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1300, 'AMSRE_36V_AM_FT_2004_day333.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1301, 'AMSRE_36V_AM_FT_2004_day334.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1302, 'AMSRE_36V_AM_FT_2004_day335.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1303, 'AMSRE_36V_AM_FT_2004_day336.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1304, 'AMSRE_36V_AM_FT_2004_day337.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1305, 'AMSRE_36V_AM_FT_2004_day338.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1306, 'AMSRE_36V_AM_FT_2004_day339.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1307, 'AMSRE_36V_AM_FT_2004_day340.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1308, 'AMSRE_36V_AM_FT_2004_day341.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1309, 'AMSRE_36V_AM_FT_2004_day342.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1310, 'AMSRE_36V_AM_FT_2004_day343.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1311, 'AMSRE_36V_AM_FT_2004_day344.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1312, 'AMSRE_36V_AM_FT_2004_day345.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1313, 'AMSRE_36V_AM_FT_2004_day346.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1314, 'AMSRE_36V_AM_FT_2004_day347.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1315, 'AMSRE_36V_AM_FT_2004_day348.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1316, 'AMSRE_36V_AM_FT_2004_day349.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1317, 'AMSRE_36V_AM_FT_2004_day350.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1318, 'AMSRE_36V_AM_FT_2004_day351.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1319, 'AMSRE_36V_AM_FT_2004_day352.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1320, 'AMSRE_36V_AM_FT_2004_day353.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1321, 'AMSRE_36V_AM_FT_2004_day354.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1322, 'AMSRE_36V_AM_FT_2004_day355.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1323, 'AMSRE_36V_AM_FT_2004_day356.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1324, 'AMSRE_36V_AM_FT_2004_day357.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1325, 'AMSRE_36V_AM_FT_2004_day358.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1326, 'AMSRE_36V_AM_FT_2004_day359.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1327, 'AMSRE_36V_AM_FT_2004_day360.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1328, 'AMSRE_36V_AM_FT_2004_day361.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1329, 'AMSRE_36V_AM_FT_2004_day362.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1330, 'AMSRE_36V_AM_FT_2004_day363.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1331, 'AMSRE_36V_AM_FT_2004_day364.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1332, 'AMSRE_36V_AM_FT_2004_day365.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1333, 'AMSRE_36V_AM_FT_2005_day1.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1334, 'AMSRE_36V_AM_FT_2005_day2.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1335, 'AMSRE_36V_AM_FT_2005_day3.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1336, 'AMSRE_36V_AM_FT_2005_day4.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1337, 'AMSRE_36V_AM_FT_2005_day5.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1338, 'AMSRE_36V_AM_FT_2005_day6.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1339, 'AMSRE_36V_AM_FT_2005_day7.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1340, 'AMSRE_36V_AM_FT_2005_day8.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1341, 'AMSRE_36V_AM_FT_2005_day9.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1342, 'AMSRE_36V_AM_FT_2005_day10.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1343, 'AMSRE_36V_AM_FT_2005_day11.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1344, 'AMSRE_36V_AM_FT_2005_day12.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1345, 'AMSRE_36V_AM_FT_2005_day13.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1346, 'AMSRE_36V_AM_FT_2005_day14.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1347, 'AMSRE_36V_AM_FT_2005_day15.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1348, 'AMSRE_36V_AM_FT_2005_day16.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1349, 'AMSRE_36V_AM_FT_2005_day17.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1350, 'AMSRE_36V_AM_FT_2005_day18.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1351, 'AMSRE_36V_AM_FT_2005_day19.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1352, 'AMSRE_36V_AM_FT_2005_day20.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1353, 'AMSRE_36V_AM_FT_2005_day21.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1354, 'AMSRE_36V_AM_FT_2005_day22.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1355, 'AMSRE_36V_AM_FT_2005_day23.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1356, 'AMSRE_36V_AM_FT_2005_day24.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1357, 'AMSRE_36V_AM_FT_2005_day25.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1358, 'AMSRE_36V_AM_FT_2005_day26.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1359, 'AMSRE_36V_AM_FT_2005_day27.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1360, 'AMSRE_36V_AM_FT_2005_day28.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1361, 'AMSRE_36V_AM_FT_2005_day29.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1362, 'AMSRE_36V_AM_FT_2005_day30.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1363, 'AMSRE_36V_AM_FT_2005_day31.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1364, 'AMSRE_36V_AM_FT_2005_day32.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1365, 'AMSRE_36V_AM_FT_2005_day33.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1366, 'AMSRE_36V_AM_FT_2005_day34.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1367, 'AMSRE_36V_AM_FT_2005_day35.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1368, 'AMSRE_36V_AM_FT_2005_day36.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1369, 'AMSRE_36V_AM_FT_2005_day37.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1370, 'AMSRE_36V_AM_FT_2005_day38.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1371, 'AMSRE_36V_AM_FT_2005_day39.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1372, 'AMSRE_36V_AM_FT_2005_day40.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1373, 'AMSRE_36V_AM_FT_2005_day41.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1374, 'AMSRE_36V_AM_FT_2005_day42.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1375, 'AMSRE_36V_AM_FT_2005_day43.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1376, 'AMSRE_36V_AM_FT_2005_day44.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1377, 'AMSRE_36V_AM_FT_2005_day45.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1378, 'AMSRE_36V_AM_FT_2005_day46.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1379, 'AMSRE_36V_AM_FT_2005_day47.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1380, 'AMSRE_36V_AM_FT_2005_day48.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1381, 'AMSRE_36V_AM_FT_2005_day49.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1382, 'AMSRE_36V_AM_FT_2005_day50.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1383, 'AMSRE_36V_AM_FT_2005_day51.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1384, 'AMSRE_36V_AM_FT_2005_day52.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1385, 'AMSRE_36V_AM_FT_2005_day53.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1386, 'AMSRE_36V_AM_FT_2005_day54.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1387, 'AMSRE_36V_AM_FT_2005_day55.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1388, 'AMSRE_36V_AM_FT_2005_day56.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1389, 'AMSRE_36V_AM_FT_2005_day57.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1390, 'AMSRE_36V_AM_FT_2005_day58.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1391, 'AMSRE_36V_AM_FT_2005_day59.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1392, 'AMSRE_36V_AM_FT_2005_day60.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1393, 'AMSRE_36V_AM_FT_2005_day61.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1394, 'AMSRE_36V_AM_FT_2005_day62.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1395, 'AMSRE_36V_AM_FT_2005_day63.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1396, 'AMSRE_36V_AM_FT_2005_day64.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1397, 'AMSRE_36V_AM_FT_2005_day65.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1398, 'AMSRE_36V_AM_FT_2005_day66.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1399, 'AMSRE_36V_AM_FT_2005_day67.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1400, 'AMSRE_36V_AM_FT_2005_day68.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1401, 'AMSRE_36V_AM_FT_2005_day69.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1402, 'AMSRE_36V_AM_FT_2005_day70.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1403, 'AMSRE_36V_AM_FT_2005_day71.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1404, 'AMSRE_36V_AM_FT_2005_day72.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1405, 'AMSRE_36V_AM_FT_2005_day73.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1406, 'AMSRE_36V_AM_FT_2005_day74.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1407, 'AMSRE_36V_AM_FT_2005_day75.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1408, 'AMSRE_36V_AM_FT_2005_day76.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1409, 'AMSRE_36V_AM_FT_2005_day77.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1410, 'AMSRE_36V_AM_FT_2005_day78.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1411, 'AMSRE_36V_AM_FT_2005_day79.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1412, 'AMSRE_36V_AM_FT_2005_day80.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1413, 'AMSRE_36V_AM_FT_2005_day81.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1414, 'AMSRE_36V_AM_FT_2005_day82.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1415, 'AMSRE_36V_AM_FT_2005_day83.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1416, 'AMSRE_36V_AM_FT_2005_day84.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1417, 'AMSRE_36V_AM_FT_2005_day85.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1418, 'AMSRE_36V_AM_FT_2005_day86.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1419, 'AMSRE_36V_AM_FT_2005_day87.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1420, 'AMSRE_36V_AM_FT_2005_day88.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1421, 'AMSRE_36V_AM_FT_2005_day89.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1422, 'AMSRE_36V_AM_FT_2005_day90.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1423, 'AMSRE_36V_AM_FT_2005_day91.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1424, 'AMSRE_36V_AM_FT_2005_day92.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1425, 'AMSRE_36V_AM_FT_2005_day93.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1426, 'AMSRE_36V_AM_FT_2005_day94.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1427, 'AMSRE_36V_AM_FT_2005_day95.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1428, 'AMSRE_36V_AM_FT_2005_day96.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1429, 'AMSRE_36V_AM_FT_2005_day97.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1430, 'AMSRE_36V_AM_FT_2005_day98.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1431, 'AMSRE_36V_AM_FT_2005_day99.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1432, 'AMSRE_36V_AM_FT_2005_day100.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1433, 'AMSRE_36V_AM_FT_2005_day101.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1434, 'AMSRE_36V_AM_FT_2005_day102.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1435, 'AMSRE_36V_AM_FT_2005_day103.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1436, 'AMSRE_36V_AM_FT_2005_day104.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1437, 'AMSRE_36V_AM_FT_2005_day105.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1438, 'AMSRE_36V_AM_FT_2005_day106.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1439, 'AMSRE_36V_AM_FT_2005_day107.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1440, 'AMSRE_36V_AM_FT_2005_day108.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1441, 'AMSRE_36V_AM_FT_2005_day109.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1442, 'AMSRE_36V_AM_FT_2005_day110.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1443, 'AMSRE_36V_AM_FT_2005_day111.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1444, 'AMSRE_36V_AM_FT_2005_day112.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1445, 'AMSRE_36V_AM_FT_2005_day113.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1446, 'AMSRE_36V_AM_FT_2005_day114.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1447, 'AMSRE_36V_AM_FT_2005_day115.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1448, 'AMSRE_36V_AM_FT_2005_day116.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1449, 'AMSRE_36V_AM_FT_2005_day117.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1450, 'AMSRE_36V_AM_FT_2005_day118.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1451, 'AMSRE_36V_AM_FT_2005_day119.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1452, 'AMSRE_36V_AM_FT_2005_day120.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1453, 'AMSRE_36V_AM_FT_2005_day121.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1454, 'AMSRE_36V_AM_FT_2005_day122.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1455, 'AMSRE_36V_AM_FT_2005_day123.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1456, 'AMSRE_36V_AM_FT_2005_day124.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1457, 'AMSRE_36V_AM_FT_2005_day125.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1458, 'AMSRE_36V_AM_FT_2005_day126.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1459, 'AMSRE_36V_AM_FT_2005_day127.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1460, 'AMSRE_36V_AM_FT_2005_day128.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1461, 'AMSRE_36V_AM_FT_2005_day129.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1462, 'AMSRE_36V_AM_FT_2005_day130.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1463, 'AMSRE_36V_AM_FT_2005_day131.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1464, 'AMSRE_36V_AM_FT_2005_day132.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1465, 'AMSRE_36V_AM_FT_2005_day133.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1466, 'AMSRE_36V_AM_FT_2005_day134.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1467, 'AMSRE_36V_AM_FT_2005_day135.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1468, 'AMSRE_36V_AM_FT_2005_day136.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1469, 'AMSRE_36V_AM_FT_2005_day137.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1470, 'AMSRE_36V_AM_FT_2005_day138.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1471, 'AMSRE_36V_AM_FT_2005_day139.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1472, 'AMSRE_36V_AM_FT_2005_day140.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1473, 'AMSRE_36V_AM_FT_2005_day141.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1474, 'AMSRE_36V_AM_FT_2005_day142.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1475, 'AMSRE_36V_AM_FT_2005_day143.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1476, 'AMSRE_36V_AM_FT_2005_day144.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1477, 'AMSRE_36V_AM_FT_2005_day145.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1478, 'AMSRE_36V_AM_FT_2005_day146.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1479, 'AMSRE_36V_AM_FT_2005_day147.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1480, 'AMSRE_36V_AM_FT_2005_day148.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1481, 'AMSRE_36V_AM_FT_2005_day149.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1482, 'AMSRE_36V_AM_FT_2005_day150.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1483, 'AMSRE_36V_AM_FT_2005_day151.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1484, 'AMSRE_36V_AM_FT_2005_day152.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1485, 'AMSRE_36V_AM_FT_2005_day153.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1486, 'AMSRE_36V_AM_FT_2005_day154.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1487, 'AMSRE_36V_AM_FT_2005_day155.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1488, 'AMSRE_36V_AM_FT_2005_day156.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1489, 'AMSRE_36V_AM_FT_2005_day157.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1490, 'AMSRE_36V_AM_FT_2005_day158.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1491, 'AMSRE_36V_AM_FT_2005_day159.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1492, 'AMSRE_36V_AM_FT_2005_day160.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1493, 'AMSRE_36V_AM_FT_2005_day161.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1494, 'AMSRE_36V_AM_FT_2005_day162.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1495, 'AMSRE_36V_AM_FT_2005_day163.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1496, 'AMSRE_36V_AM_FT_2005_day164.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1497, 'AMSRE_36V_AM_FT_2005_day165.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1498, 'AMSRE_36V_AM_FT_2005_day166.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1499, 'AMSRE_36V_AM_FT_2005_day167.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1500, 'AMSRE_36V_AM_FT_2005_day168.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1501, 'AMSRE_36V_AM_FT_2005_day169.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1502, 'AMSRE_36V_AM_FT_2005_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1503, 'AMSRE_36V_AM_FT_2005_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1504, 'AMSRE_36V_AM_FT_2005_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1505, 'AMSRE_36V_AM_FT_2005_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1506, 'AMSRE_36V_AM_FT_2005_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1507, 'AMSRE_36V_AM_FT_2005_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1508, 'AMSRE_36V_AM_FT_2005_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1509, 'AMSRE_36V_AM_FT_2005_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1510, 'AMSRE_36V_AM_FT_2005_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1511, 'AMSRE_36V_AM_FT_2005_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1512, 'AMSRE_36V_AM_FT_2005_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1513, 'AMSRE_36V_AM_FT_2005_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1514, 'AMSRE_36V_AM_FT_2005_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1515, 'AMSRE_36V_AM_FT_2005_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1516, 'AMSRE_36V_AM_FT_2005_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1517, 'AMSRE_36V_AM_FT_2005_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1518, 'AMSRE_36V_AM_FT_2005_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1519, 'AMSRE_36V_AM_FT_2005_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1520, 'AMSRE_36V_AM_FT_2005_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1521, 'AMSRE_36V_AM_FT_2005_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1522, 'AMSRE_36V_AM_FT_2005_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1523, 'AMSRE_36V_AM_FT_2005_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1524, 'AMSRE_36V_AM_FT_2005_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1525, 'AMSRE_36V_AM_FT_2005_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1526, 'AMSRE_36V_AM_FT_2005_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1527, 'AMSRE_36V_AM_FT_2005_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1528, 'AMSRE_36V_AM_FT_2005_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1529, 'AMSRE_36V_AM_FT_2005_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1530, 'AMSRE_36V_AM_FT_2005_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1531, 'AMSRE_36V_AM_FT_2005_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1532, 'AMSRE_36V_AM_FT_2005_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1533, 'AMSRE_36V_AM_FT_2005_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1534, 'AMSRE_36V_AM_FT_2005_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1535, 'AMSRE_36V_AM_FT_2005_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1536, 'AMSRE_36V_AM_FT_2005_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1537, 'AMSRE_36V_AM_FT_2005_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1538, 'AMSRE_36V_AM_FT_2005_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1539, 'AMSRE_36V_AM_FT_2005_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1540, 'AMSRE_36V_AM_FT_2005_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1541, 'AMSRE_36V_AM_FT_2005_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1542, 'AMSRE_36V_AM_FT_2005_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1543, 'AMSRE_36V_AM_FT_2005_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1544, 'AMSRE_36V_AM_FT_2005_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1545, 'AMSRE_36V_AM_FT_2005_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1546, 'AMSRE_36V_AM_FT_2005_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1547, 'AMSRE_36V_AM_FT_2005_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1548, 'AMSRE_36V_AM_FT_2005_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1549, 'AMSRE_36V_AM_FT_2005_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1550, 'AMSRE_36V_AM_FT_2005_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1551, 'AMSRE_36V_AM_FT_2005_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1552, 'AMSRE_36V_AM_FT_2005_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1553, 'AMSRE_36V_AM_FT_2005_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1554, 'AMSRE_36V_AM_FT_2005_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1555, 'AMSRE_36V_AM_FT_2005_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1556, 'AMSRE_36V_AM_FT_2005_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1557, 'AMSRE_36V_AM_FT_2005_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1558, 'AMSRE_36V_AM_FT_2005_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1559, 'AMSRE_36V_AM_FT_2005_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1560, 'AMSRE_36V_AM_FT_2005_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1561, 'AMSRE_36V_AM_FT_2005_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1562, 'AMSRE_36V_AM_FT_2005_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1563, 'AMSRE_36V_AM_FT_2005_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1564, 'AMSRE_36V_AM_FT_2005_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1565, 'AMSRE_36V_AM_FT_2005_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1566, 'AMSRE_36V_AM_FT_2005_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1567, 'AMSRE_36V_AM_FT_2005_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1568, 'AMSRE_36V_AM_FT_2005_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1569, 'AMSRE_36V_AM_FT_2005_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1570, 'AMSRE_36V_AM_FT_2005_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1571, 'AMSRE_36V_AM_FT_2005_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1572, 'AMSRE_36V_AM_FT_2005_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1573, 'AMSRE_36V_AM_FT_2005_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1574, 'AMSRE_36V_AM_FT_2005_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1575, 'AMSRE_36V_AM_FT_2005_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1576, 'AMSRE_36V_AM_FT_2005_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1577, 'AMSRE_36V_AM_FT_2005_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1578, 'AMSRE_36V_AM_FT_2005_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1579, 'AMSRE_36V_AM_FT_2005_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1580, 'AMSRE_36V_AM_FT_2005_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1581, 'AMSRE_36V_AM_FT_2005_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1582, 'AMSRE_36V_AM_FT_2005_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1583, 'AMSRE_36V_AM_FT_2005_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1584, 'AMSRE_36V_AM_FT_2005_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1585, 'AMSRE_36V_AM_FT_2005_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1586, 'AMSRE_36V_AM_FT_2005_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1587, 'AMSRE_36V_AM_FT_2005_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1588, 'AMSRE_36V_AM_FT_2005_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1589, 'AMSRE_36V_AM_FT_2005_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1590, 'AMSRE_36V_AM_FT_2005_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1591, 'AMSRE_36V_AM_FT_2005_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1592, 'AMSRE_36V_AM_FT_2005_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1593, 'AMSRE_36V_AM_FT_2005_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1594, 'AMSRE_36V_AM_FT_2005_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1595, 'AMSRE_36V_AM_FT_2005_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1596, 'AMSRE_36V_AM_FT_2005_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1597, 'AMSRE_36V_AM_FT_2005_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1598, 'AMSRE_36V_AM_FT_2005_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1599, 'AMSRE_36V_AM_FT_2005_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1600, 'AMSRE_36V_AM_FT_2005_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1601, 'AMSRE_36V_AM_FT_2005_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1602, 'AMSRE_36V_AM_FT_2005_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1603, 'AMSRE_36V_AM_FT_2005_day271.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1604, 'AMSRE_36V_AM_FT_2005_day272.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1605, 'AMSRE_36V_AM_FT_2005_day273.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1606, 'AMSRE_36V_AM_FT_2005_day274.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1607, 'AMSRE_36V_AM_FT_2005_day275.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1608, 'AMSRE_36V_AM_FT_2005_day276.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1609, 'AMSRE_36V_AM_FT_2005_day277.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1610, 'AMSRE_36V_AM_FT_2005_day278.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1611, 'AMSRE_36V_AM_FT_2005_day279.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1612, 'AMSRE_36V_AM_FT_2005_day280.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1613, 'AMSRE_36V_AM_FT_2005_day281.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1614, 'AMSRE_36V_AM_FT_2005_day282.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1615, 'AMSRE_36V_AM_FT_2005_day283.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1616, 'AMSRE_36V_AM_FT_2005_day284.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1617, 'AMSRE_36V_AM_FT_2005_day285.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1618, 'AMSRE_36V_AM_FT_2005_day286.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1619, 'AMSRE_36V_AM_FT_2005_day287.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1620, 'AMSRE_36V_AM_FT_2005_day288.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1621, 'AMSRE_36V_AM_FT_2005_day289.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1622, 'AMSRE_36V_AM_FT_2005_day290.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1623, 'AMSRE_36V_AM_FT_2005_day291.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1624, 'AMSRE_36V_AM_FT_2005_day292.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1625, 'AMSRE_36V_AM_FT_2005_day293.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1626, 'AMSRE_36V_AM_FT_2005_day294.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1627, 'AMSRE_36V_AM_FT_2005_day295.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1628, 'AMSRE_36V_AM_FT_2005_day296.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1629, 'AMSRE_36V_AM_FT_2005_day297.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1630, 'AMSRE_36V_AM_FT_2005_day298.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1631, 'AMSRE_36V_AM_FT_2005_day299.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1632, 'AMSRE_36V_AM_FT_2005_day300.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1633, 'AMSRE_36V_AM_FT_2005_day301.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1634, 'AMSRE_36V_AM_FT_2005_day302.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1635, 'AMSRE_36V_AM_FT_2005_day303.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1636, 'AMSRE_36V_AM_FT_2005_day304.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1637, 'AMSRE_36V_AM_FT_2005_day305.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1638, 'AMSRE_36V_AM_FT_2005_day306.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1639, 'AMSRE_36V_AM_FT_2005_day307.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1640, 'AMSRE_36V_AM_FT_2005_day308.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1641, 'AMSRE_36V_AM_FT_2005_day309.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1642, 'AMSRE_36V_AM_FT_2005_day310.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1643, 'AMSRE_36V_AM_FT_2005_day311.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1644, 'AMSRE_36V_AM_FT_2005_day312.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1645, 'AMSRE_36V_AM_FT_2005_day313.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1646, 'AMSRE_36V_AM_FT_2005_day314.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1647, 'AMSRE_36V_AM_FT_2005_day315.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1648, 'AMSRE_36V_AM_FT_2005_day316.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1649, 'AMSRE_36V_AM_FT_2005_day317.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1650, 'AMSRE_36V_AM_FT_2005_day318.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1651, 'AMSRE_36V_AM_FT_2005_day319.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1652, 'AMSRE_36V_AM_FT_2005_day320.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1653, 'AMSRE_36V_AM_FT_2005_day321.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1654, 'AMSRE_36V_AM_FT_2005_day322.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1655, 'AMSRE_36V_AM_FT_2005_day323.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1656, 'AMSRE_36V_AM_FT_2005_day324.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1657, 'AMSRE_36V_AM_FT_2005_day325.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1658, 'AMSRE_36V_AM_FT_2005_day326.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1659, 'AMSRE_36V_AM_FT_2005_day327.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1660, 'AMSRE_36V_AM_FT_2005_day328.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1661, 'AMSRE_36V_AM_FT_2005_day329.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1662, 'AMSRE_36V_AM_FT_2005_day330.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1663, 'AMSRE_36V_AM_FT_2005_day331.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1664, 'AMSRE_36V_AM_FT_2005_day332.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1665, 'AMSRE_36V_AM_FT_2005_day333.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1666, 'AMSRE_36V_AM_FT_2005_day334.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1667, 'AMSRE_36V_AM_FT_2005_day335.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1668, 'AMSRE_36V_AM_FT_2005_day336.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1669, 'AMSRE_36V_AM_FT_2005_day337.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1670, 'AMSRE_36V_AM_FT_2005_day338.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1671, 'AMSRE_36V_AM_FT_2005_day339.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1672, 'AMSRE_36V_AM_FT_2005_day340.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1673, 'AMSRE_36V_AM_FT_2005_day341.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1674, 'AMSRE_36V_AM_FT_2005_day342.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1675, 'AMSRE_36V_AM_FT_2005_day343.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1676, 'AMSRE_36V_AM_FT_2005_day344.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1677, 'AMSRE_36V_AM_FT_2005_day345.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1678, 'AMSRE_36V_AM_FT_2005_day346.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1679, 'AMSRE_36V_AM_FT_2005_day347.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1680, 'AMSRE_36V_AM_FT_2005_day348.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1681, 'AMSRE_36V_AM_FT_2005_day349.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1682, 'AMSRE_36V_AM_FT_2005_day350.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1683, 'AMSRE_36V_AM_FT_2005_day351.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1684, 'AMSRE_36V_AM_FT_2005_day352.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1685, 'AMSRE_36V_AM_FT_2005_day353.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1686, 'AMSRE_36V_AM_FT_2005_day354.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1687, 'AMSRE_36V_AM_FT_2005_day355.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1688, 'AMSRE_36V_AM_FT_2005_day356.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1689, 'AMSRE_36V_AM_FT_2005_day357.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1690, 'AMSRE_36V_AM_FT_2005_day358.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1691, 'AMSRE_36V_AM_FT_2005_day359.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1692, 'AMSRE_36V_AM_FT_2005_day360.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1693, 'AMSRE_36V_AM_FT_2005_day361.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1694, 'AMSRE_36V_AM_FT_2005_day362.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1695, 'AMSRE_36V_AM_FT_2005_day363.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1696, 'AMSRE_36V_AM_FT_2005_day364.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1697, 'AMSRE_36V_AM_FT_2005_day365.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1698, 'AMSRE_36V_AM_FT_2006_day1.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1699, 'AMSRE_36V_AM_FT_2006_day2.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1700, 'AMSRE_36V_AM_FT_2006_day3.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1701, 'AMSRE_36V_AM_FT_2006_day4.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1702, 'AMSRE_36V_AM_FT_2006_day5.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1703, 'AMSRE_36V_AM_FT_2006_day6.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1704, 'AMSRE_36V_AM_FT_2006_day7.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1705, 'AMSRE_36V_AM_FT_2006_day8.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1706, 'AMSRE_36V_AM_FT_2006_day9.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1707, 'AMSRE_36V_AM_FT_2006_day10.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1708, 'AMSRE_36V_AM_FT_2006_day11.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1709, 'AMSRE_36V_AM_FT_2006_day12.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1710, 'AMSRE_36V_AM_FT_2006_day13.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1711, 'AMSRE_36V_AM_FT_2006_day14.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1712, 'AMSRE_36V_AM_FT_2006_day15.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1713, 'AMSRE_36V_AM_FT_2006_day16.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1714, 'AMSRE_36V_AM_FT_2006_day17.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1715, 'AMSRE_36V_AM_FT_2006_day18.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1716, 'AMSRE_36V_AM_FT_2006_day19.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1717, 'AMSRE_36V_AM_FT_2006_day20.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1718, 'AMSRE_36V_AM_FT_2006_day21.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1719, 'AMSRE_36V_AM_FT_2006_day22.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1720, 'AMSRE_36V_AM_FT_2006_day23.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1721, 'AMSRE_36V_AM_FT_2006_day24.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1722, 'AMSRE_36V_AM_FT_2006_day25.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1723, 'AMSRE_36V_AM_FT_2006_day26.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1724, 'AMSRE_36V_AM_FT_2006_day27.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1725, 'AMSRE_36V_AM_FT_2006_day28.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1726, 'AMSRE_36V_AM_FT_2006_day29.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1727, 'AMSRE_36V_AM_FT_2006_day30.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1728, 'AMSRE_36V_AM_FT_2006_day31.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1729, 'AMSRE_36V_AM_FT_2006_day32.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1730, 'AMSRE_36V_AM_FT_2006_day33.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1731, 'AMSRE_36V_AM_FT_2006_day34.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1732, 'AMSRE_36V_AM_FT_2006_day35.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1733, 'AMSRE_36V_AM_FT_2006_day36.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1734, 'AMSRE_36V_AM_FT_2006_day37.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1735, 'AMSRE_36V_AM_FT_2006_day38.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1736, 'AMSRE_36V_AM_FT_2006_day39.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1737, 'AMSRE_36V_AM_FT_2006_day40.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1738, 'AMSRE_36V_AM_FT_2006_day41.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1739, 'AMSRE_36V_AM_FT_2006_day42.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1740, 'AMSRE_36V_AM_FT_2006_day43.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1741, 'AMSRE_36V_AM_FT_2006_day44.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1742, 'AMSRE_36V_AM_FT_2006_day45.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1743, 'AMSRE_36V_AM_FT_2006_day46.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1744, 'AMSRE_36V_AM_FT_2006_day47.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1745, 'AMSRE_36V_AM_FT_2006_day48.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1746, 'AMSRE_36V_AM_FT_2006_day49.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1747, 'AMSRE_36V_AM_FT_2006_day50.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1748, 'AMSRE_36V_AM_FT_2006_day51.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1749, 'AMSRE_36V_AM_FT_2006_day52.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1750, 'AMSRE_36V_AM_FT_2006_day53.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1751, 'AMSRE_36V_AM_FT_2006_day54.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1752, 'AMSRE_36V_AM_FT_2006_day55.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1753, 'AMSRE_36V_AM_FT_2006_day56.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1754, 'AMSRE_36V_AM_FT_2006_day57.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1755, 'AMSRE_36V_AM_FT_2006_day58.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1756, 'AMSRE_36V_AM_FT_2006_day59.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1757, 'AMSRE_36V_AM_FT_2006_day60.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1758, 'AMSRE_36V_AM_FT_2006_day61.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1759, 'AMSRE_36V_AM_FT_2006_day62.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1760, 'AMSRE_36V_AM_FT_2006_day63.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1761, 'AMSRE_36V_AM_FT_2006_day64.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1762, 'AMSRE_36V_AM_FT_2006_day65.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1763, 'AMSRE_36V_AM_FT_2006_day66.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1764, 'AMSRE_36V_AM_FT_2006_day67.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1765, 'AMSRE_36V_AM_FT_2006_day68.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1766, 'AMSRE_36V_AM_FT_2006_day69.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1767, 'AMSRE_36V_AM_FT_2006_day70.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1768, 'AMSRE_36V_AM_FT_2006_day71.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1769, 'AMSRE_36V_AM_FT_2006_day72.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1770, 'AMSRE_36V_AM_FT_2006_day73.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1771, 'AMSRE_36V_AM_FT_2006_day74.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1772, 'AMSRE_36V_AM_FT_2006_day75.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1773, 'AMSRE_36V_AM_FT_2006_day76.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1774, 'AMSRE_36V_AM_FT_2006_day77.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1775, 'AMSRE_36V_AM_FT_2006_day78.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1776, 'AMSRE_36V_AM_FT_2006_day79.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1777, 'AMSRE_36V_AM_FT_2006_day80.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1778, 'AMSRE_36V_AM_FT_2006_day81.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1779, 'AMSRE_36V_AM_FT_2006_day82.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1780, 'AMSRE_36V_AM_FT_2006_day83.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1781, 'AMSRE_36V_AM_FT_2006_day84.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1782, 'AMSRE_36V_AM_FT_2006_day85.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1783, 'AMSRE_36V_AM_FT_2006_day86.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1784, 'AMSRE_36V_AM_FT_2006_day87.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1785, 'AMSRE_36V_AM_FT_2006_day88.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1786, 'AMSRE_36V_AM_FT_2006_day89.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1787, 'AMSRE_36V_AM_FT_2006_day90.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1788, 'AMSRE_36V_AM_FT_2006_day91.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1789, 'AMSRE_36V_AM_FT_2006_day92.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1790, 'AMSRE_36V_AM_FT_2006_day93.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1791, 'AMSRE_36V_AM_FT_2006_day94.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1792, 'AMSRE_36V_AM_FT_2006_day95.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1793, 'AMSRE_36V_AM_FT_2006_day96.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1794, 'AMSRE_36V_AM_FT_2006_day97.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1795, 'AMSRE_36V_AM_FT_2006_day98.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1796, 'AMSRE_36V_AM_FT_2006_day99.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1797, 'AMSRE_36V_AM_FT_2006_day100.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1798, 'AMSRE_36V_AM_FT_2006_day101.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1799, 'AMSRE_36V_AM_FT_2006_day102.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1800, 'AMSRE_36V_AM_FT_2006_day103.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1801, 'AMSRE_36V_AM_FT_2006_day104.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1802, 'AMSRE_36V_AM_FT_2006_day105.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1803, 'AMSRE_36V_AM_FT_2006_day106.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1804, 'AMSRE_36V_AM_FT_2006_day107.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1805, 'AMSRE_36V_AM_FT_2006_day108.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1806, 'AMSRE_36V_AM_FT_2006_day109.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1807, 'AMSRE_36V_AM_FT_2006_day110.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1808, 'AMSRE_36V_AM_FT_2006_day111.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1809, 'AMSRE_36V_AM_FT_2006_day112.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1810, 'AMSRE_36V_AM_FT_2006_day113.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1811, 'AMSRE_36V_AM_FT_2006_day114.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1812, 'AMSRE_36V_AM_FT_2006_day115.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1813, 'AMSRE_36V_AM_FT_2006_day116.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1814, 'AMSRE_36V_AM_FT_2006_day117.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1815, 'AMSRE_36V_AM_FT_2006_day118.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1816, 'AMSRE_36V_AM_FT_2006_day119.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1817, 'AMSRE_36V_AM_FT_2006_day120.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1818, 'AMSRE_36V_AM_FT_2006_day121.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1819, 'AMSRE_36V_AM_FT_2006_day122.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1820, 'AMSRE_36V_AM_FT_2006_day123.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1821, 'AMSRE_36V_AM_FT_2006_day124.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1822, 'AMSRE_36V_AM_FT_2006_day125.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1823, 'AMSRE_36V_AM_FT_2006_day126.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1824, 'AMSRE_36V_AM_FT_2006_day127.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1825, 'AMSRE_36V_AM_FT_2006_day128.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1826, 'AMSRE_36V_AM_FT_2006_day129.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1827, 'AMSRE_36V_AM_FT_2006_day130.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1828, 'AMSRE_36V_AM_FT_2006_day131.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1829, 'AMSRE_36V_AM_FT_2006_day132.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1830, 'AMSRE_36V_AM_FT_2006_day133.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1831, 'AMSRE_36V_AM_FT_2006_day134.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1832, 'AMSRE_36V_AM_FT_2006_day135.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1833, 'AMSRE_36V_AM_FT_2006_day136.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1834, 'AMSRE_36V_AM_FT_2006_day137.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1835, 'AMSRE_36V_AM_FT_2006_day138.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1836, 'AMSRE_36V_AM_FT_2006_day139.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1837, 'AMSRE_36V_AM_FT_2006_day140.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1838, 'AMSRE_36V_AM_FT_2006_day141.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1839, 'AMSRE_36V_AM_FT_2006_day142.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1840, 'AMSRE_36V_AM_FT_2006_day143.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1841, 'AMSRE_36V_AM_FT_2006_day144.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1842, 'AMSRE_36V_AM_FT_2006_day145.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1843, 'AMSRE_36V_AM_FT_2006_day146.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1844, 'AMSRE_36V_AM_FT_2006_day147.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1845, 'AMSRE_36V_AM_FT_2006_day148.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1846, 'AMSRE_36V_AM_FT_2006_day149.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1847, 'AMSRE_36V_AM_FT_2006_day150.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1848, 'AMSRE_36V_AM_FT_2006_day151.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1849, 'AMSRE_36V_AM_FT_2006_day152.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1850, 'AMSRE_36V_AM_FT_2006_day153.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1851, 'AMSRE_36V_AM_FT_2006_day154.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1852, 'AMSRE_36V_AM_FT_2006_day155.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1853, 'AMSRE_36V_AM_FT_2006_day156.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1854, 'AMSRE_36V_AM_FT_2006_day157.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1855, 'AMSRE_36V_AM_FT_2006_day158.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1856, 'AMSRE_36V_AM_FT_2006_day159.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1857, 'AMSRE_36V_AM_FT_2006_day160.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1858, 'AMSRE_36V_AM_FT_2006_day161.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1859, 'AMSRE_36V_AM_FT_2006_day162.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1860, 'AMSRE_36V_AM_FT_2006_day163.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1861, 'AMSRE_36V_AM_FT_2006_day164.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1862, 'AMSRE_36V_AM_FT_2006_day165.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1863, 'AMSRE_36V_AM_FT_2006_day166.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1864, 'AMSRE_36V_AM_FT_2006_day167.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1865, 'AMSRE_36V_AM_FT_2006_day168.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1866, 'AMSRE_36V_AM_FT_2006_day169.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1867, 'AMSRE_36V_AM_FT_2006_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1868, 'AMSRE_36V_AM_FT_2006_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1869, 'AMSRE_36V_AM_FT_2006_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1870, 'AMSRE_36V_AM_FT_2006_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1871, 'AMSRE_36V_AM_FT_2006_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1872, 'AMSRE_36V_AM_FT_2006_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1873, 'AMSRE_36V_AM_FT_2006_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1874, 'AMSRE_36V_AM_FT_2006_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1875, 'AMSRE_36V_AM_FT_2006_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1876, 'AMSRE_36V_AM_FT_2006_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1877, 'AMSRE_36V_AM_FT_2006_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1878, 'AMSRE_36V_AM_FT_2006_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1879, 'AMSRE_36V_AM_FT_2006_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1880, 'AMSRE_36V_AM_FT_2006_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1881, 'AMSRE_36V_AM_FT_2006_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1882, 'AMSRE_36V_AM_FT_2006_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1883, 'AMSRE_36V_AM_FT_2006_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1884, 'AMSRE_36V_AM_FT_2006_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1885, 'AMSRE_36V_AM_FT_2006_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1886, 'AMSRE_36V_AM_FT_2006_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1887, 'AMSRE_36V_AM_FT_2006_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1888, 'AMSRE_36V_AM_FT_2006_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1889, 'AMSRE_36V_AM_FT_2006_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1890, 'AMSRE_36V_AM_FT_2006_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1891, 'AMSRE_36V_AM_FT_2006_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1892, 'AMSRE_36V_AM_FT_2006_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1893, 'AMSRE_36V_AM_FT_2006_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1894, 'AMSRE_36V_AM_FT_2006_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1895, 'AMSRE_36V_AM_FT_2006_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1896, 'AMSRE_36V_AM_FT_2006_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1897, 'AMSRE_36V_AM_FT_2006_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1898, 'AMSRE_36V_AM_FT_2006_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1899, 'AMSRE_36V_AM_FT_2006_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1900, 'AMSRE_36V_AM_FT_2006_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1901, 'AMSRE_36V_AM_FT_2006_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1902, 'AMSRE_36V_AM_FT_2006_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1903, 'AMSRE_36V_AM_FT_2006_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1904, 'AMSRE_36V_AM_FT_2006_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1905, 'AMSRE_36V_AM_FT_2006_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1906, 'AMSRE_36V_AM_FT_2006_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1907, 'AMSRE_36V_AM_FT_2006_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1908, 'AMSRE_36V_AM_FT_2006_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1909, 'AMSRE_36V_AM_FT_2006_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1910, 'AMSRE_36V_AM_FT_2006_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1911, 'AMSRE_36V_AM_FT_2006_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1912, 'AMSRE_36V_AM_FT_2006_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1913, 'AMSRE_36V_AM_FT_2006_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1914, 'AMSRE_36V_AM_FT_2006_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1915, 'AMSRE_36V_AM_FT_2006_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1916, 'AMSRE_36V_AM_FT_2006_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1917, 'AMSRE_36V_AM_FT_2006_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1918, 'AMSRE_36V_AM_FT_2006_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1919, 'AMSRE_36V_AM_FT_2006_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1920, 'AMSRE_36V_AM_FT_2006_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1921, 'AMSRE_36V_AM_FT_2006_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1922, 'AMSRE_36V_AM_FT_2006_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1923, 'AMSRE_36V_AM_FT_2006_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1924, 'AMSRE_36V_AM_FT_2006_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1925, 'AMSRE_36V_AM_FT_2006_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1926, 'AMSRE_36V_AM_FT_2006_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1927, 'AMSRE_36V_AM_FT_2006_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1928, 'AMSRE_36V_AM_FT_2006_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1929, 'AMSRE_36V_AM_FT_2006_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1930, 'AMSRE_36V_AM_FT_2006_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1931, 'AMSRE_36V_AM_FT_2006_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1932, 'AMSRE_36V_AM_FT_2006_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1933, 'AMSRE_36V_AM_FT_2006_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1934, 'AMSRE_36V_AM_FT_2006_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1935, 'AMSRE_36V_AM_FT_2006_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1936, 'AMSRE_36V_AM_FT_2006_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1937, 'AMSRE_36V_AM_FT_2006_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1938, 'AMSRE_36V_AM_FT_2006_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1939, 'AMSRE_36V_AM_FT_2006_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1940, 'AMSRE_36V_AM_FT_2006_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1941, 'AMSRE_36V_AM_FT_2006_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1942, 'AMSRE_36V_AM_FT_2006_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1943, 'AMSRE_36V_AM_FT_2006_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1944, 'AMSRE_36V_AM_FT_2006_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1945, 'AMSRE_36V_AM_FT_2006_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1946, 'AMSRE_36V_AM_FT_2006_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1947, 'AMSRE_36V_AM_FT_2006_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1948, 'AMSRE_36V_AM_FT_2006_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1949, 'AMSRE_36V_AM_FT_2006_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1950, 'AMSRE_36V_AM_FT_2006_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1951, 'AMSRE_36V_AM_FT_2006_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1952, 'AMSRE_36V_AM_FT_2006_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1953, 'AMSRE_36V_AM_FT_2006_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1954, 'AMSRE_36V_AM_FT_2006_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1955, 'AMSRE_36V_AM_FT_2006_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1956, 'AMSRE_36V_AM_FT_2006_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1957, 'AMSRE_36V_AM_FT_2006_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1958, 'AMSRE_36V_AM_FT_2006_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1959, 'AMSRE_36V_AM_FT_2006_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1960, 'AMSRE_36V_AM_FT_2006_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1961, 'AMSRE_36V_AM_FT_2006_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1962, 'AMSRE_36V_AM_FT_2006_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1963, 'AMSRE_36V_AM_FT_2006_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1964, 'AMSRE_36V_AM_FT_2006_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1965, 'AMSRE_36V_AM_FT_2006_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1966, 'AMSRE_36V_AM_FT_2006_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1967, 'AMSRE_36V_AM_FT_2006_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1968, 'AMSRE_36V_AM_FT_2006_day271.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1969, 'AMSRE_36V_AM_FT_2006_day272.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1970, 'AMSRE_36V_AM_FT_2006_day273.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1971, 'AMSRE_36V_AM_FT_2006_day274.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1972, 'AMSRE_36V_AM_FT_2006_day275.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1973, 'AMSRE_36V_AM_FT_2006_day276.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1974, 'AMSRE_36V_AM_FT_2006_day277.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1975, 'AMSRE_36V_AM_FT_2006_day278.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1976, 'AMSRE_36V_AM_FT_2006_day279.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1977, 'AMSRE_36V_AM_FT_2006_day280.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1978, 'AMSRE_36V_AM_FT_2006_day281.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1979, 'AMSRE_36V_AM_FT_2006_day282.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1980, 'AMSRE_36V_AM_FT_2006_day283.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1981, 'AMSRE_36V_AM_FT_2006_day284.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1982, 'AMSRE_36V_AM_FT_2006_day285.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1983, 'AMSRE_36V_AM_FT_2006_day286.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1984, 'AMSRE_36V_AM_FT_2006_day287.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1985, 'AMSRE_36V_AM_FT_2006_day288.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1986, 'AMSRE_36V_AM_FT_2006_day289.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1987, 'AMSRE_36V_AM_FT_2006_day290.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1988, 'AMSRE_36V_AM_FT_2006_day291.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1989, 'AMSRE_36V_AM_FT_2006_day292.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1990, 'AMSRE_36V_AM_FT_2006_day293.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1991, 'AMSRE_36V_AM_FT_2006_day294.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1992, 'AMSRE_36V_AM_FT_2006_day295.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1993, 'AMSRE_36V_AM_FT_2006_day296.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1994, 'AMSRE_36V_AM_FT_2006_day297.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1995, 'AMSRE_36V_AM_FT_2006_day298.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1996, 'AMSRE_36V_AM_FT_2006_day299.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1997, 'AMSRE_36V_AM_FT_2006_day300.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1998, 'AMSRE_36V_AM_FT_2006_day301.h5');
INSERT INTO cs_stringrepcache VALUES (13, 1999, 'AMSRE_36V_AM_FT_2006_day302.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2000, 'AMSRE_36V_AM_FT_2006_day303.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2001, 'AMSRE_36V_AM_FT_2006_day304.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2002, 'AMSRE_36V_AM_FT_2006_day305.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2003, 'AMSRE_36V_AM_FT_2006_day306.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2004, 'AMSRE_36V_AM_FT_2006_day307.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2005, 'AMSRE_36V_AM_FT_2006_day308.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2006, 'AMSRE_36V_AM_FT_2006_day309.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2007, 'AMSRE_36V_AM_FT_2006_day310.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2008, 'AMSRE_36V_AM_FT_2006_day311.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2009, 'AMSRE_36V_AM_FT_2006_day312.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2010, 'AMSRE_36V_AM_FT_2006_day313.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2011, 'AMSRE_36V_AM_FT_2006_day314.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2012, 'AMSRE_36V_AM_FT_2006_day315.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2013, 'AMSRE_36V_AM_FT_2006_day316.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2014, 'AMSRE_36V_AM_FT_2006_day317.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2015, 'AMSRE_36V_AM_FT_2006_day318.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2016, 'AMSRE_36V_AM_FT_2006_day319.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2017, 'AMSRE_36V_AM_FT_2006_day320.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2018, 'AMSRE_36V_AM_FT_2006_day321.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2019, 'AMSRE_36V_AM_FT_2006_day322.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2020, 'AMSRE_36V_AM_FT_2006_day323.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2021, 'AMSRE_36V_AM_FT_2006_day324.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2022, 'AMSRE_36V_AM_FT_2006_day325.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2023, 'AMSRE_36V_AM_FT_2006_day326.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2024, 'AMSRE_36V_AM_FT_2006_day327.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2025, 'AMSRE_36V_AM_FT_2006_day328.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2026, 'AMSRE_36V_AM_FT_2006_day329.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2027, 'AMSRE_36V_AM_FT_2006_day330.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2028, 'AMSRE_36V_AM_FT_2006_day331.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2029, 'AMSRE_36V_AM_FT_2006_day332.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2030, 'AMSRE_36V_AM_FT_2006_day333.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2031, 'AMSRE_36V_AM_FT_2006_day334.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2032, 'AMSRE_36V_AM_FT_2006_day335.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2033, 'AMSRE_36V_AM_FT_2006_day336.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2034, 'AMSRE_36V_AM_FT_2006_day337.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2035, 'AMSRE_36V_AM_FT_2006_day338.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2036, 'AMSRE_36V_AM_FT_2006_day339.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2037, 'AMSRE_36V_AM_FT_2006_day340.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2038, 'AMSRE_36V_AM_FT_2006_day341.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2039, 'AMSRE_36V_AM_FT_2006_day342.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2040, 'AMSRE_36V_AM_FT_2006_day343.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2041, 'AMSRE_36V_AM_FT_2006_day344.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2042, 'AMSRE_36V_AM_FT_2006_day345.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2043, 'AMSRE_36V_AM_FT_2006_day346.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2044, 'AMSRE_36V_AM_FT_2006_day347.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2045, 'AMSRE_36V_AM_FT_2006_day348.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2046, 'AMSRE_36V_AM_FT_2006_day349.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2047, 'AMSRE_36V_AM_FT_2006_day350.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2048, 'AMSRE_36V_AM_FT_2006_day351.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2049, 'AMSRE_36V_AM_FT_2006_day352.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2050, 'AMSRE_36V_AM_FT_2006_day353.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2051, 'AMSRE_36V_AM_FT_2006_day354.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2052, 'AMSRE_36V_AM_FT_2006_day355.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2053, 'AMSRE_36V_AM_FT_2006_day356.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2054, 'AMSRE_36V_AM_FT_2006_day357.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2055, 'AMSRE_36V_AM_FT_2006_day358.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2056, 'AMSRE_36V_AM_FT_2006_day359.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2057, 'AMSRE_36V_AM_FT_2006_day360.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2058, 'AMSRE_36V_AM_FT_2006_day361.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2059, 'AMSRE_36V_AM_FT_2006_day362.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2060, 'AMSRE_36V_AM_FT_2006_day363.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2061, 'AMSRE_36V_AM_FT_2006_day364.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2062, 'AMSRE_36V_AM_FT_2006_day365.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2063, 'AMSRE_36V_AM_FT_2007_day1.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2064, 'AMSRE_36V_AM_FT_2007_day2.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2065, 'AMSRE_36V_AM_FT_2007_day3.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2066, 'AMSRE_36V_AM_FT_2007_day4.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2067, 'AMSRE_36V_AM_FT_2007_day5.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2068, 'AMSRE_36V_AM_FT_2007_day6.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2069, 'AMSRE_36V_AM_FT_2007_day7.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2070, 'AMSRE_36V_AM_FT_2007_day8.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2071, 'AMSRE_36V_AM_FT_2007_day9.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2072, 'AMSRE_36V_AM_FT_2007_day10.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2073, 'AMSRE_36V_AM_FT_2007_day11.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2074, 'AMSRE_36V_AM_FT_2007_day12.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2075, 'AMSRE_36V_AM_FT_2007_day13.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2076, 'AMSRE_36V_AM_FT_2007_day14.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2077, 'AMSRE_36V_AM_FT_2007_day15.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2078, 'AMSRE_36V_AM_FT_2007_day16.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2079, 'AMSRE_36V_AM_FT_2007_day17.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2080, 'AMSRE_36V_AM_FT_2007_day18.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2081, 'AMSRE_36V_AM_FT_2007_day19.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2082, 'AMSRE_36V_AM_FT_2007_day20.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2083, 'AMSRE_36V_AM_FT_2007_day21.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2084, 'AMSRE_36V_AM_FT_2007_day22.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2085, 'AMSRE_36V_AM_FT_2007_day23.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2086, 'AMSRE_36V_AM_FT_2007_day24.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2087, 'AMSRE_36V_AM_FT_2007_day25.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2088, 'AMSRE_36V_AM_FT_2007_day26.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2089, 'AMSRE_36V_AM_FT_2007_day27.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2090, 'AMSRE_36V_AM_FT_2007_day28.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2091, 'AMSRE_36V_AM_FT_2007_day29.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2092, 'AMSRE_36V_AM_FT_2007_day30.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2093, 'AMSRE_36V_AM_FT_2007_day31.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2094, 'AMSRE_36V_AM_FT_2007_day32.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2095, 'AMSRE_36V_AM_FT_2007_day33.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2096, 'AMSRE_36V_AM_FT_2007_day34.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2097, 'AMSRE_36V_AM_FT_2007_day35.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2098, 'AMSRE_36V_AM_FT_2007_day36.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2099, 'AMSRE_36V_AM_FT_2007_day37.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2100, 'AMSRE_36V_AM_FT_2007_day38.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2101, 'AMSRE_36V_AM_FT_2007_day39.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2102, 'AMSRE_36V_AM_FT_2007_day40.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2103, 'AMSRE_36V_AM_FT_2007_day41.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2104, 'AMSRE_36V_AM_FT_2007_day42.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2105, 'AMSRE_36V_AM_FT_2007_day43.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2106, 'AMSRE_36V_AM_FT_2007_day44.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2107, 'AMSRE_36V_AM_FT_2007_day45.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2108, 'AMSRE_36V_AM_FT_2007_day46.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2109, 'AMSRE_36V_AM_FT_2007_day47.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2110, 'AMSRE_36V_AM_FT_2007_day48.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2111, 'AMSRE_36V_AM_FT_2007_day49.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2112, 'AMSRE_36V_AM_FT_2007_day50.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2113, 'AMSRE_36V_AM_FT_2007_day51.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2114, 'AMSRE_36V_AM_FT_2007_day52.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2115, 'AMSRE_36V_AM_FT_2007_day53.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2116, 'AMSRE_36V_AM_FT_2007_day54.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2117, 'AMSRE_36V_AM_FT_2007_day55.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2118, 'AMSRE_36V_AM_FT_2007_day56.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2119, 'AMSRE_36V_AM_FT_2007_day57.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2120, 'AMSRE_36V_AM_FT_2007_day58.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2121, 'AMSRE_36V_AM_FT_2007_day59.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2122, 'AMSRE_36V_AM_FT_2007_day60.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2123, 'AMSRE_36V_AM_FT_2007_day61.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2124, 'AMSRE_36V_AM_FT_2007_day62.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2125, 'AMSRE_36V_AM_FT_2007_day63.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2126, 'AMSRE_36V_AM_FT_2007_day64.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2127, 'AMSRE_36V_AM_FT_2007_day65.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2128, 'AMSRE_36V_AM_FT_2007_day66.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2129, 'AMSRE_36V_AM_FT_2007_day67.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2130, 'AMSRE_36V_AM_FT_2007_day68.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2131, 'AMSRE_36V_AM_FT_2007_day69.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2132, 'AMSRE_36V_AM_FT_2007_day70.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2133, 'AMSRE_36V_AM_FT_2007_day71.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2134, 'AMSRE_36V_AM_FT_2007_day72.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2135, 'AMSRE_36V_AM_FT_2007_day73.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2136, 'AMSRE_36V_AM_FT_2007_day74.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2137, 'AMSRE_36V_AM_FT_2007_day75.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2138, 'AMSRE_36V_AM_FT_2007_day76.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2139, 'AMSRE_36V_AM_FT_2007_day77.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2140, 'AMSRE_36V_AM_FT_2007_day78.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2141, 'AMSRE_36V_AM_FT_2007_day79.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2142, 'AMSRE_36V_AM_FT_2007_day80.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2143, 'AMSRE_36V_AM_FT_2007_day81.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2144, 'AMSRE_36V_AM_FT_2007_day82.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2145, 'AMSRE_36V_AM_FT_2007_day83.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2146, 'AMSRE_36V_AM_FT_2007_day84.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2147, 'AMSRE_36V_AM_FT_2007_day85.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2148, 'AMSRE_36V_AM_FT_2007_day86.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2149, 'AMSRE_36V_AM_FT_2007_day87.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2150, 'AMSRE_36V_AM_FT_2007_day88.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2151, 'AMSRE_36V_AM_FT_2007_day89.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2152, 'AMSRE_36V_AM_FT_2007_day90.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2153, 'AMSRE_36V_AM_FT_2007_day91.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2154, 'AMSRE_36V_AM_FT_2007_day92.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2155, 'AMSRE_36V_AM_FT_2007_day93.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2156, 'AMSRE_36V_AM_FT_2007_day94.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2157, 'AMSRE_36V_AM_FT_2007_day95.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2158, 'AMSRE_36V_AM_FT_2007_day96.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2159, 'AMSRE_36V_AM_FT_2007_day97.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2160, 'AMSRE_36V_AM_FT_2007_day98.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2161, 'AMSRE_36V_AM_FT_2007_day99.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2162, 'AMSRE_36V_AM_FT_2007_day100.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2163, 'AMSRE_36V_AM_FT_2007_day101.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2164, 'AMSRE_36V_AM_FT_2007_day102.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2165, 'AMSRE_36V_AM_FT_2007_day103.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2166, 'AMSRE_36V_AM_FT_2007_day104.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2167, 'AMSRE_36V_AM_FT_2007_day105.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2168, 'AMSRE_36V_AM_FT_2007_day106.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2169, 'AMSRE_36V_AM_FT_2007_day107.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2170, 'AMSRE_36V_AM_FT_2007_day108.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2171, 'AMSRE_36V_AM_FT_2007_day109.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2172, 'AMSRE_36V_AM_FT_2007_day110.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2173, 'AMSRE_36V_AM_FT_2007_day111.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2174, 'AMSRE_36V_AM_FT_2007_day112.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2175, 'AMSRE_36V_AM_FT_2007_day113.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2176, 'AMSRE_36V_AM_FT_2007_day114.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2177, 'AMSRE_36V_AM_FT_2007_day115.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2178, 'AMSRE_36V_AM_FT_2007_day116.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2179, 'AMSRE_36V_AM_FT_2007_day117.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2180, 'AMSRE_36V_AM_FT_2007_day118.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2181, 'AMSRE_36V_AM_FT_2007_day119.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2182, 'AMSRE_36V_AM_FT_2007_day120.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2183, 'AMSRE_36V_AM_FT_2007_day121.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2184, 'AMSRE_36V_AM_FT_2007_day122.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2185, 'AMSRE_36V_AM_FT_2007_day123.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2186, 'AMSRE_36V_AM_FT_2007_day124.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2187, 'AMSRE_36V_AM_FT_2007_day125.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2188, 'AMSRE_36V_AM_FT_2007_day126.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2189, 'AMSRE_36V_AM_FT_2007_day127.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2190, 'AMSRE_36V_AM_FT_2007_day128.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2191, 'AMSRE_36V_AM_FT_2007_day129.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2192, 'AMSRE_36V_AM_FT_2007_day130.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2193, 'AMSRE_36V_AM_FT_2007_day131.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2194, 'AMSRE_36V_AM_FT_2007_day132.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2195, 'AMSRE_36V_AM_FT_2007_day133.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2196, 'AMSRE_36V_AM_FT_2007_day134.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2197, 'AMSRE_36V_AM_FT_2007_day135.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2198, 'AMSRE_36V_AM_FT_2007_day136.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2199, 'AMSRE_36V_AM_FT_2007_day137.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2200, 'AMSRE_36V_AM_FT_2007_day138.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2201, 'AMSRE_36V_AM_FT_2007_day139.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2202, 'AMSRE_36V_AM_FT_2007_day140.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2203, 'AMSRE_36V_AM_FT_2007_day141.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2204, 'AMSRE_36V_AM_FT_2007_day142.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2205, 'AMSRE_36V_AM_FT_2007_day143.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2206, 'AMSRE_36V_AM_FT_2007_day144.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2207, 'AMSRE_36V_AM_FT_2007_day145.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2208, 'AMSRE_36V_AM_FT_2007_day146.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2209, 'AMSRE_36V_AM_FT_2007_day147.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2210, 'AMSRE_36V_AM_FT_2007_day148.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2211, 'AMSRE_36V_AM_FT_2007_day149.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2212, 'AMSRE_36V_AM_FT_2007_day150.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2213, 'AMSRE_36V_AM_FT_2007_day151.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2214, 'AMSRE_36V_AM_FT_2007_day152.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2215, 'AMSRE_36V_AM_FT_2007_day153.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2216, 'AMSRE_36V_AM_FT_2007_day154.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2217, 'AMSRE_36V_AM_FT_2007_day155.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2218, 'AMSRE_36V_AM_FT_2007_day156.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2219, 'AMSRE_36V_AM_FT_2007_day157.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2220, 'AMSRE_36V_AM_FT_2007_day158.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2221, 'AMSRE_36V_AM_FT_2007_day159.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2222, 'AMSRE_36V_AM_FT_2007_day160.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2223, 'AMSRE_36V_AM_FT_2007_day161.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2224, 'AMSRE_36V_AM_FT_2007_day162.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2225, 'AMSRE_36V_AM_FT_2007_day163.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2226, 'AMSRE_36V_AM_FT_2007_day164.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2227, 'AMSRE_36V_AM_FT_2007_day165.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2228, 'AMSRE_36V_AM_FT_2007_day166.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2229, 'AMSRE_36V_AM_FT_2007_day167.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2230, 'AMSRE_36V_AM_FT_2007_day168.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2231, 'AMSRE_36V_AM_FT_2007_day169.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2232, 'AMSRE_36V_AM_FT_2007_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2233, 'AMSRE_36V_AM_FT_2007_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2234, 'AMSRE_36V_AM_FT_2007_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2235, 'AMSRE_36V_AM_FT_2007_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2236, 'AMSRE_36V_AM_FT_2007_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2237, 'AMSRE_36V_AM_FT_2007_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2238, 'AMSRE_36V_AM_FT_2007_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2239, 'AMSRE_36V_AM_FT_2007_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2240, 'AMSRE_36V_AM_FT_2007_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2241, 'AMSRE_36V_AM_FT_2007_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2242, 'AMSRE_36V_AM_FT_2007_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2243, 'AMSRE_36V_AM_FT_2007_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2244, 'AMSRE_36V_AM_FT_2007_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2245, 'AMSRE_36V_AM_FT_2007_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2246, 'AMSRE_36V_AM_FT_2007_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2247, 'AMSRE_36V_AM_FT_2007_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2248, 'AMSRE_36V_AM_FT_2007_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2249, 'AMSRE_36V_AM_FT_2007_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2250, 'AMSRE_36V_AM_FT_2007_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2251, 'AMSRE_36V_AM_FT_2007_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2252, 'AMSRE_36V_AM_FT_2007_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2253, 'AMSRE_36V_AM_FT_2007_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2254, 'AMSRE_36V_AM_FT_2007_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2255, 'AMSRE_36V_AM_FT_2007_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2256, 'AMSRE_36V_AM_FT_2007_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2257, 'AMSRE_36V_AM_FT_2007_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2258, 'AMSRE_36V_AM_FT_2007_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2259, 'AMSRE_36V_AM_FT_2007_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2260, 'AMSRE_36V_AM_FT_2007_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2261, 'AMSRE_36V_AM_FT_2007_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2262, 'AMSRE_36V_AM_FT_2007_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2263, 'AMSRE_36V_AM_FT_2007_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2264, 'AMSRE_36V_AM_FT_2007_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2265, 'AMSRE_36V_AM_FT_2007_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2266, 'AMSRE_36V_AM_FT_2007_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2267, 'AMSRE_36V_AM_FT_2007_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2268, 'AMSRE_36V_AM_FT_2007_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2269, 'AMSRE_36V_AM_FT_2007_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2270, 'AMSRE_36V_AM_FT_2007_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2271, 'AMSRE_36V_AM_FT_2007_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2272, 'AMSRE_36V_AM_FT_2007_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2273, 'AMSRE_36V_AM_FT_2007_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2274, 'AMSRE_36V_AM_FT_2007_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2275, 'AMSRE_36V_AM_FT_2007_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2276, 'AMSRE_36V_AM_FT_2007_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2277, 'AMSRE_36V_AM_FT_2007_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2278, 'AMSRE_36V_AM_FT_2007_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2279, 'AMSRE_36V_AM_FT_2007_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2280, 'AMSRE_36V_AM_FT_2007_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2281, 'AMSRE_36V_AM_FT_2007_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2282, 'AMSRE_36V_AM_FT_2007_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2283, 'AMSRE_36V_AM_FT_2007_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2284, 'AMSRE_36V_AM_FT_2007_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2285, 'AMSRE_36V_AM_FT_2007_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2286, 'AMSRE_36V_AM_FT_2007_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2287, 'AMSRE_36V_AM_FT_2007_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2288, 'AMSRE_36V_AM_FT_2007_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2289, 'AMSRE_36V_AM_FT_2007_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2290, 'AMSRE_36V_AM_FT_2007_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2291, 'AMSRE_36V_AM_FT_2007_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2292, 'AMSRE_36V_AM_FT_2007_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2293, 'AMSRE_36V_AM_FT_2007_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2294, 'AMSRE_36V_AM_FT_2007_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2295, 'AMSRE_36V_AM_FT_2007_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2296, 'AMSRE_36V_AM_FT_2007_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2297, 'AMSRE_36V_AM_FT_2007_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2298, 'AMSRE_36V_AM_FT_2007_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2299, 'AMSRE_36V_AM_FT_2007_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2300, 'AMSRE_36V_AM_FT_2007_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2301, 'AMSRE_36V_AM_FT_2007_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2302, 'AMSRE_36V_AM_FT_2007_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2303, 'AMSRE_36V_AM_FT_2007_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2304, 'AMSRE_36V_AM_FT_2007_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2305, 'AMSRE_36V_AM_FT_2007_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2306, 'AMSRE_36V_AM_FT_2007_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2307, 'AMSRE_36V_AM_FT_2007_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2308, 'AMSRE_36V_AM_FT_2007_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2309, 'AMSRE_36V_AM_FT_2007_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2310, 'AMSRE_36V_AM_FT_2007_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2311, 'AMSRE_36V_AM_FT_2007_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2312, 'AMSRE_36V_AM_FT_2007_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2313, 'AMSRE_36V_AM_FT_2007_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2314, 'AMSRE_36V_AM_FT_2007_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2315, 'AMSRE_36V_AM_FT_2007_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2316, 'AMSRE_36V_AM_FT_2007_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2317, 'AMSRE_36V_AM_FT_2007_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2318, 'AMSRE_36V_AM_FT_2007_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2319, 'AMSRE_36V_AM_FT_2007_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2320, 'AMSRE_36V_AM_FT_2007_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2321, 'AMSRE_36V_AM_FT_2007_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2322, 'AMSRE_36V_AM_FT_2007_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2323, 'AMSRE_36V_AM_FT_2007_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2324, 'AMSRE_36V_AM_FT_2007_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2325, 'AMSRE_36V_AM_FT_2007_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2326, 'AMSRE_36V_AM_FT_2007_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2327, 'AMSRE_36V_AM_FT_2007_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2328, 'AMSRE_36V_AM_FT_2007_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2329, 'AMSRE_36V_AM_FT_2007_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2330, 'AMSRE_36V_AM_FT_2007_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2331, 'AMSRE_36V_AM_FT_2007_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2332, 'AMSRE_36V_AM_FT_2007_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2333, 'AMSRE_36V_AM_FT_2007_day271.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2334, 'AMSRE_36V_AM_FT_2007_day272.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2335, 'AMSRE_36V_AM_FT_2007_day273.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2336, 'AMSRE_36V_AM_FT_2007_day274.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2337, 'AMSRE_36V_AM_FT_2007_day275.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2338, 'AMSRE_36V_AM_FT_2007_day276.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2339, 'AMSRE_36V_AM_FT_2007_day277.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2340, 'AMSRE_36V_AM_FT_2007_day278.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2341, 'AMSRE_36V_AM_FT_2007_day279.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2342, 'AMSRE_36V_AM_FT_2007_day280.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2343, 'AMSRE_36V_AM_FT_2007_day281.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2344, 'AMSRE_36V_AM_FT_2007_day282.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2345, 'AMSRE_36V_AM_FT_2007_day283.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2346, 'AMSRE_36V_AM_FT_2007_day284.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2347, 'AMSRE_36V_AM_FT_2007_day285.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2348, 'AMSRE_36V_AM_FT_2007_day286.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2349, 'AMSRE_36V_AM_FT_2007_day287.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2350, 'AMSRE_36V_AM_FT_2007_day288.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2351, 'AMSRE_36V_AM_FT_2007_day289.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2352, 'AMSRE_36V_AM_FT_2007_day290.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2353, 'AMSRE_36V_AM_FT_2007_day291.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2354, 'AMSRE_36V_AM_FT_2007_day292.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2355, 'AMSRE_36V_AM_FT_2007_day293.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2356, 'AMSRE_36V_AM_FT_2007_day294.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2357, 'AMSRE_36V_AM_FT_2007_day295.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2358, 'AMSRE_36V_AM_FT_2007_day296.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2359, 'AMSRE_36V_AM_FT_2007_day297.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2360, 'AMSRE_36V_AM_FT_2007_day298.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2361, 'AMSRE_36V_AM_FT_2007_day299.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2362, 'AMSRE_36V_AM_FT_2007_day300.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2363, 'AMSRE_36V_AM_FT_2007_day301.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2364, 'AMSRE_36V_AM_FT_2007_day302.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2365, 'AMSRE_36V_AM_FT_2007_day303.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2366, 'AMSRE_36V_AM_FT_2007_day304.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2367, 'AMSRE_36V_AM_FT_2007_day305.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2368, 'AMSRE_36V_AM_FT_2007_day306.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2369, 'AMSRE_36V_AM_FT_2007_day307.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2370, 'AMSRE_36V_AM_FT_2007_day308.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2371, 'AMSRE_36V_AM_FT_2007_day309.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2372, 'AMSRE_36V_AM_FT_2007_day310.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2373, 'AMSRE_36V_AM_FT_2007_day311.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2374, 'AMSRE_36V_AM_FT_2007_day312.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2375, 'AMSRE_36V_AM_FT_2007_day313.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2376, 'AMSRE_36V_AM_FT_2007_day314.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2377, 'AMSRE_36V_AM_FT_2007_day315.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2378, 'AMSRE_36V_AM_FT_2007_day316.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2379, 'AMSRE_36V_AM_FT_2007_day317.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2380, 'AMSRE_36V_AM_FT_2007_day318.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2381, 'AMSRE_36V_AM_FT_2007_day319.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2382, 'AMSRE_36V_AM_FT_2007_day320.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2383, 'AMSRE_36V_AM_FT_2007_day321.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2384, 'AMSRE_36V_AM_FT_2007_day322.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2385, 'AMSRE_36V_AM_FT_2007_day323.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2386, 'AMSRE_36V_AM_FT_2007_day324.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2387, 'AMSRE_36V_AM_FT_2007_day325.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2388, 'AMSRE_36V_AM_FT_2007_day326.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2389, 'AMSRE_36V_AM_FT_2007_day327.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2390, 'AMSRE_36V_AM_FT_2007_day328.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2391, 'AMSRE_36V_AM_FT_2007_day329.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2392, 'AMSRE_36V_AM_FT_2007_day330.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2393, 'AMSRE_36V_AM_FT_2007_day331.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2394, 'AMSRE_36V_AM_FT_2007_day332.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2395, 'AMSRE_36V_AM_FT_2007_day333.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2396, 'AMSRE_36V_AM_FT_2007_day334.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2397, 'AMSRE_36V_AM_FT_2007_day335.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2398, 'AMSRE_36V_AM_FT_2007_day336.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2399, 'AMSRE_36V_AM_FT_2007_day337.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2400, 'AMSRE_36V_AM_FT_2007_day338.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2401, 'AMSRE_36V_AM_FT_2007_day339.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2402, 'AMSRE_36V_AM_FT_2007_day340.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2403, 'AMSRE_36V_AM_FT_2007_day341.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2404, 'AMSRE_36V_AM_FT_2007_day342.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2405, 'AMSRE_36V_AM_FT_2007_day343.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2406, 'AMSRE_36V_AM_FT_2007_day344.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2407, 'AMSRE_36V_AM_FT_2007_day345.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2408, 'AMSRE_36V_AM_FT_2007_day346.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2409, 'AMSRE_36V_AM_FT_2007_day347.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2410, 'AMSRE_36V_AM_FT_2007_day348.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2411, 'AMSRE_36V_AM_FT_2007_day349.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2412, 'AMSRE_36V_AM_FT_2007_day350.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2413, 'AMSRE_36V_AM_FT_2007_day351.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2414, 'AMSRE_36V_AM_FT_2007_day352.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2415, 'AMSRE_36V_AM_FT_2007_day353.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2416, 'AMSRE_36V_AM_FT_2007_day354.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2417, 'AMSRE_36V_AM_FT_2007_day355.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2418, 'AMSRE_36V_AM_FT_2007_day356.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2419, 'AMSRE_36V_AM_FT_2007_day357.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2420, 'AMSRE_36V_AM_FT_2007_day358.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2421, 'AMSRE_36V_AM_FT_2007_day359.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2422, 'AMSRE_36V_AM_FT_2007_day360.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2423, 'AMSRE_36V_AM_FT_2007_day361.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2424, 'AMSRE_36V_AM_FT_2007_day362.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2425, 'AMSRE_36V_AM_FT_2007_day363.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2426, 'AMSRE_36V_AM_FT_2007_day364.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2427, 'AMSRE_36V_AM_FT_2007_day365.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2428, 'AMSRE_36V_AM_FT_2008_day1.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2429, 'AMSRE_36V_AM_FT_2008_day2.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2430, 'AMSRE_36V_AM_FT_2008_day3.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2431, 'AMSRE_36V_AM_FT_2008_day4.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2432, 'AMSRE_36V_AM_FT_2008_day5.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2433, 'AMSRE_36V_AM_FT_2008_day6.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2434, 'AMSRE_36V_AM_FT_2008_day7.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2435, 'AMSRE_36V_AM_FT_2008_day8.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2436, 'AMSRE_36V_AM_FT_2008_day9.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2437, 'AMSRE_36V_AM_FT_2008_day10.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2438, 'AMSRE_36V_AM_FT_2008_day11.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2439, 'AMSRE_36V_AM_FT_2008_day12.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2440, 'AMSRE_36V_AM_FT_2008_day13.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2441, 'AMSRE_36V_AM_FT_2008_day14.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2442, 'AMSRE_36V_AM_FT_2008_day15.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2443, 'AMSRE_36V_AM_FT_2008_day16.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2444, 'AMSRE_36V_AM_FT_2008_day17.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2445, 'AMSRE_36V_AM_FT_2008_day18.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2446, 'AMSRE_36V_AM_FT_2008_day19.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2447, 'AMSRE_36V_AM_FT_2008_day20.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2448, 'AMSRE_36V_AM_FT_2008_day21.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2449, 'AMSRE_36V_AM_FT_2008_day22.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2450, 'AMSRE_36V_AM_FT_2008_day23.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2451, 'AMSRE_36V_AM_FT_2008_day24.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2452, 'AMSRE_36V_AM_FT_2008_day25.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2453, 'AMSRE_36V_AM_FT_2008_day26.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2454, 'AMSRE_36V_AM_FT_2008_day27.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2455, 'AMSRE_36V_AM_FT_2008_day28.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2456, 'AMSRE_36V_AM_FT_2008_day29.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2457, 'AMSRE_36V_AM_FT_2008_day30.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2458, 'AMSRE_36V_AM_FT_2008_day31.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2459, 'AMSRE_36V_AM_FT_2008_day32.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2460, 'AMSRE_36V_AM_FT_2008_day33.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2461, 'AMSRE_36V_AM_FT_2008_day34.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2462, 'AMSRE_36V_AM_FT_2008_day35.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2463, 'AMSRE_36V_AM_FT_2008_day36.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2464, 'AMSRE_36V_AM_FT_2008_day37.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2465, 'AMSRE_36V_AM_FT_2008_day38.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2466, 'AMSRE_36V_AM_FT_2008_day39.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2467, 'AMSRE_36V_AM_FT_2008_day40.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2468, 'AMSRE_36V_AM_FT_2008_day41.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2469, 'AMSRE_36V_AM_FT_2008_day42.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2470, 'AMSRE_36V_AM_FT_2008_day43.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2471, 'AMSRE_36V_AM_FT_2008_day44.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2472, 'AMSRE_36V_AM_FT_2008_day45.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2473, 'AMSRE_36V_AM_FT_2008_day46.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2474, 'AMSRE_36V_AM_FT_2008_day47.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2475, 'AMSRE_36V_AM_FT_2008_day48.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2476, 'AMSRE_36V_AM_FT_2008_day49.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2477, 'AMSRE_36V_AM_FT_2008_day50.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2478, 'AMSRE_36V_AM_FT_2008_day51.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2479, 'AMSRE_36V_AM_FT_2008_day52.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2480, 'AMSRE_36V_AM_FT_2008_day53.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2481, 'AMSRE_36V_AM_FT_2008_day54.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2482, 'AMSRE_36V_AM_FT_2008_day55.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2483, 'AMSRE_36V_AM_FT_2008_day56.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2484, 'AMSRE_36V_AM_FT_2008_day57.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2485, 'AMSRE_36V_AM_FT_2008_day58.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2486, 'AMSRE_36V_AM_FT_2008_day59.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2487, 'AMSRE_36V_AM_FT_2008_day60.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2488, 'AMSRE_36V_AM_FT_2008_day61.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2489, 'AMSRE_36V_AM_FT_2008_day62.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2490, 'AMSRE_36V_AM_FT_2008_day63.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2491, 'AMSRE_36V_AM_FT_2008_day64.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2492, 'AMSRE_36V_AM_FT_2008_day65.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2493, 'AMSRE_36V_AM_FT_2008_day66.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2494, 'AMSRE_36V_AM_FT_2008_day67.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2495, 'AMSRE_36V_AM_FT_2008_day68.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2496, 'AMSRE_36V_AM_FT_2008_day69.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2497, 'AMSRE_36V_AM_FT_2008_day70.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2498, 'AMSRE_36V_AM_FT_2008_day71.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2499, 'AMSRE_36V_AM_FT_2008_day72.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2500, 'AMSRE_36V_AM_FT_2008_day73.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2501, 'AMSRE_36V_AM_FT_2008_day74.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2502, 'AMSRE_36V_AM_FT_2008_day75.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2503, 'AMSRE_36V_AM_FT_2008_day76.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2504, 'AMSRE_36V_AM_FT_2008_day77.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2505, 'AMSRE_36V_AM_FT_2008_day78.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2506, 'AMSRE_36V_AM_FT_2008_day79.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2507, 'AMSRE_36V_AM_FT_2008_day80.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2508, 'AMSRE_36V_AM_FT_2008_day81.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2509, 'AMSRE_36V_AM_FT_2008_day82.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2510, 'AMSRE_36V_AM_FT_2008_day83.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2511, 'AMSRE_36V_AM_FT_2008_day84.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2512, 'AMSRE_36V_AM_FT_2008_day85.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2513, 'AMSRE_36V_AM_FT_2008_day86.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2514, 'AMSRE_36V_AM_FT_2008_day87.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2515, 'AMSRE_36V_AM_FT_2008_day88.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2516, 'AMSRE_36V_AM_FT_2008_day89.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2517, 'AMSRE_36V_AM_FT_2008_day90.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2518, 'AMSRE_36V_AM_FT_2008_day91.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2519, 'AMSRE_36V_AM_FT_2008_day92.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2520, 'AMSRE_36V_AM_FT_2008_day93.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2521, 'AMSRE_36V_AM_FT_2008_day94.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2522, 'AMSRE_36V_AM_FT_2008_day95.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2523, 'AMSRE_36V_AM_FT_2008_day96.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2524, 'AMSRE_36V_AM_FT_2008_day97.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2525, 'AMSRE_36V_AM_FT_2008_day98.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2526, 'AMSRE_36V_AM_FT_2008_day99.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2527, 'AMSRE_36V_AM_FT_2008_day100.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2528, 'AMSRE_36V_AM_FT_2008_day101.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2529, 'AMSRE_36V_AM_FT_2008_day102.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2530, 'AMSRE_36V_AM_FT_2008_day103.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2531, 'AMSRE_36V_AM_FT_2008_day104.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2532, 'AMSRE_36V_AM_FT_2008_day105.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2533, 'AMSRE_36V_AM_FT_2008_day106.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2534, 'AMSRE_36V_AM_FT_2008_day107.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2535, 'AMSRE_36V_AM_FT_2008_day108.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2536, 'AMSRE_36V_AM_FT_2008_day109.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2537, 'AMSRE_36V_AM_FT_2008_day110.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2538, 'AMSRE_36V_AM_FT_2008_day111.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2539, 'AMSRE_36V_AM_FT_2008_day112.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2540, 'AMSRE_36V_AM_FT_2008_day113.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2541, 'AMSRE_36V_AM_FT_2008_day114.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2542, 'AMSRE_36V_AM_FT_2008_day115.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2543, 'AMSRE_36V_AM_FT_2008_day116.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2544, 'AMSRE_36V_AM_FT_2008_day117.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2545, 'AMSRE_36V_AM_FT_2008_day118.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2546, 'AMSRE_36V_AM_FT_2008_day119.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2547, 'AMSRE_36V_AM_FT_2008_day120.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2548, 'AMSRE_36V_AM_FT_2008_day121.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2549, 'AMSRE_36V_AM_FT_2008_day122.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2550, 'AMSRE_36V_AM_FT_2008_day123.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2551, 'AMSRE_36V_AM_FT_2008_day124.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2552, 'AMSRE_36V_AM_FT_2008_day125.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2553, 'AMSRE_36V_AM_FT_2008_day126.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2554, 'AMSRE_36V_AM_FT_2008_day127.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2555, 'AMSRE_36V_AM_FT_2008_day128.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2556, 'AMSRE_36V_AM_FT_2008_day129.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2557, 'AMSRE_36V_AM_FT_2008_day130.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2558, 'AMSRE_36V_AM_FT_2008_day131.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2559, 'AMSRE_36V_AM_FT_2008_day132.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2560, 'AMSRE_36V_AM_FT_2008_day133.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2561, 'AMSRE_36V_AM_FT_2008_day134.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2562, 'AMSRE_36V_AM_FT_2008_day135.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2563, 'AMSRE_36V_AM_FT_2008_day136.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2564, 'AMSRE_36V_AM_FT_2008_day137.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2565, 'AMSRE_36V_AM_FT_2008_day138.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2566, 'AMSRE_36V_AM_FT_2008_day139.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2567, 'AMSRE_36V_AM_FT_2008_day140.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2568, 'AMSRE_36V_AM_FT_2008_day141.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2569, 'AMSRE_36V_AM_FT_2008_day142.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2570, 'AMSRE_36V_AM_FT_2008_day143.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2571, 'AMSRE_36V_AM_FT_2008_day144.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2572, 'AMSRE_36V_AM_FT_2008_day145.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2573, 'AMSRE_36V_AM_FT_2008_day146.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2574, 'AMSRE_36V_AM_FT_2008_day147.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2575, 'AMSRE_36V_AM_FT_2008_day148.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2576, 'AMSRE_36V_AM_FT_2008_day149.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2577, 'AMSRE_36V_AM_FT_2008_day150.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2578, 'AMSRE_36V_AM_FT_2008_day151.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2579, 'AMSRE_36V_AM_FT_2008_day152.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2580, 'AMSRE_36V_AM_FT_2008_day153.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2581, 'AMSRE_36V_AM_FT_2008_day154.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2582, 'AMSRE_36V_AM_FT_2008_day155.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2583, 'AMSRE_36V_AM_FT_2008_day156.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2584, 'AMSRE_36V_AM_FT_2008_day157.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2585, 'AMSRE_36V_AM_FT_2008_day158.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2586, 'AMSRE_36V_AM_FT_2008_day159.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2587, 'AMSRE_36V_AM_FT_2008_day160.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2588, 'AMSRE_36V_AM_FT_2008_day161.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2589, 'AMSRE_36V_AM_FT_2008_day162.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2590, 'AMSRE_36V_AM_FT_2008_day163.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2591, 'AMSRE_36V_AM_FT_2008_day164.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2592, 'AMSRE_36V_AM_FT_2008_day165.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2593, 'AMSRE_36V_AM_FT_2008_day166.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2594, 'AMSRE_36V_AM_FT_2008_day167.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2595, 'AMSRE_36V_AM_FT_2008_day168.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2596, 'AMSRE_36V_AM_FT_2008_day169.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2597, 'AMSRE_36V_AM_FT_2008_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2598, 'AMSRE_36V_AM_FT_2008_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2599, 'AMSRE_36V_AM_FT_2008_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2600, 'AMSRE_36V_AM_FT_2008_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2601, 'AMSRE_36V_AM_FT_2008_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2602, 'AMSRE_36V_AM_FT_2008_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2603, 'AMSRE_36V_AM_FT_2008_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2604, 'AMSRE_36V_AM_FT_2008_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2605, 'AMSRE_36V_AM_FT_2008_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2606, 'AMSRE_36V_AM_FT_2008_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2607, 'AMSRE_36V_AM_FT_2008_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2608, 'AMSRE_36V_AM_FT_2008_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2609, 'AMSRE_36V_AM_FT_2008_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2610, 'AMSRE_36V_AM_FT_2008_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2611, 'AMSRE_36V_AM_FT_2008_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2612, 'AMSRE_36V_AM_FT_2008_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2613, 'AMSRE_36V_AM_FT_2008_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2614, 'AMSRE_36V_AM_FT_2008_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2615, 'AMSRE_36V_AM_FT_2008_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2616, 'AMSRE_36V_AM_FT_2008_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2617, 'AMSRE_36V_AM_FT_2008_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2618, 'AMSRE_36V_AM_FT_2008_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2619, 'AMSRE_36V_AM_FT_2008_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2620, 'AMSRE_36V_AM_FT_2008_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2621, 'AMSRE_36V_AM_FT_2008_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2622, 'AMSRE_36V_AM_FT_2008_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2623, 'AMSRE_36V_AM_FT_2008_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2624, 'AMSRE_36V_AM_FT_2008_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2625, 'AMSRE_36V_AM_FT_2008_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2626, 'AMSRE_36V_AM_FT_2008_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2627, 'AMSRE_36V_AM_FT_2008_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2628, 'AMSRE_36V_AM_FT_2008_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2629, 'AMSRE_36V_AM_FT_2008_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2630, 'AMSRE_36V_AM_FT_2008_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2631, 'AMSRE_36V_AM_FT_2008_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2632, 'AMSRE_36V_AM_FT_2008_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2633, 'AMSRE_36V_AM_FT_2008_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2634, 'AMSRE_36V_AM_FT_2008_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2635, 'AMSRE_36V_AM_FT_2008_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2636, 'AMSRE_36V_AM_FT_2008_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2637, 'AMSRE_36V_AM_FT_2008_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2638, 'AMSRE_36V_AM_FT_2008_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2639, 'AMSRE_36V_AM_FT_2008_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2640, 'AMSRE_36V_AM_FT_2008_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2641, 'AMSRE_36V_AM_FT_2008_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2642, 'AMSRE_36V_AM_FT_2008_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2643, 'AMSRE_36V_AM_FT_2008_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2644, 'AMSRE_36V_AM_FT_2008_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2645, 'AMSRE_36V_AM_FT_2008_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2646, 'AMSRE_36V_AM_FT_2008_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2647, 'AMSRE_36V_AM_FT_2008_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2648, 'AMSRE_36V_AM_FT_2008_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2649, 'AMSRE_36V_AM_FT_2008_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2650, 'AMSRE_36V_AM_FT_2008_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2651, 'AMSRE_36V_AM_FT_2008_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2652, 'AMSRE_36V_AM_FT_2008_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2653, 'AMSRE_36V_AM_FT_2008_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2654, 'AMSRE_36V_AM_FT_2008_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2655, 'AMSRE_36V_AM_FT_2008_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2656, 'AMSRE_36V_AM_FT_2008_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2657, 'AMSRE_36V_AM_FT_2008_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2658, 'AMSRE_36V_AM_FT_2008_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2659, 'AMSRE_36V_AM_FT_2008_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2660, 'AMSRE_36V_AM_FT_2008_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2661, 'AMSRE_36V_AM_FT_2008_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2662, 'AMSRE_36V_AM_FT_2008_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2663, 'AMSRE_36V_AM_FT_2008_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2664, 'AMSRE_36V_AM_FT_2008_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2665, 'AMSRE_36V_AM_FT_2008_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2666, 'AMSRE_36V_AM_FT_2008_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2667, 'AMSRE_36V_AM_FT_2008_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2668, 'AMSRE_36V_AM_FT_2008_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2669, 'AMSRE_36V_AM_FT_2008_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2670, 'AMSRE_36V_AM_FT_2008_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2671, 'AMSRE_36V_AM_FT_2008_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2672, 'AMSRE_36V_AM_FT_2008_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2673, 'AMSRE_36V_AM_FT_2008_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2674, 'AMSRE_36V_AM_FT_2008_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2675, 'AMSRE_36V_AM_FT_2008_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2676, 'AMSRE_36V_AM_FT_2008_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2677, 'AMSRE_36V_AM_FT_2008_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2678, 'AMSRE_36V_AM_FT_2008_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2679, 'AMSRE_36V_AM_FT_2008_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2680, 'AMSRE_36V_AM_FT_2008_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2681, 'AMSRE_36V_AM_FT_2008_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2682, 'AMSRE_36V_AM_FT_2008_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2683, 'AMSRE_36V_AM_FT_2008_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2684, 'AMSRE_36V_AM_FT_2008_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2685, 'AMSRE_36V_AM_FT_2008_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2686, 'AMSRE_36V_AM_FT_2008_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2687, 'AMSRE_36V_AM_FT_2008_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2688, 'AMSRE_36V_AM_FT_2008_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2689, 'AMSRE_36V_AM_FT_2008_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2690, 'AMSRE_36V_AM_FT_2008_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2691, 'AMSRE_36V_AM_FT_2008_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2692, 'AMSRE_36V_AM_FT_2008_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2693, 'AMSRE_36V_AM_FT_2008_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2694, 'AMSRE_36V_AM_FT_2008_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2695, 'AMSRE_36V_AM_FT_2008_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2696, 'AMSRE_36V_AM_FT_2008_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2697, 'AMSRE_36V_AM_FT_2008_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2698, 'AMSRE_36V_AM_FT_2008_day271.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2699, 'AMSRE_36V_AM_FT_2008_day272.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2700, 'AMSRE_36V_AM_FT_2008_day273.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2701, 'AMSRE_36V_AM_FT_2008_day274.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2702, 'AMSRE_36V_AM_FT_2008_day275.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2703, 'AMSRE_36V_AM_FT_2008_day276.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2704, 'AMSRE_36V_AM_FT_2008_day277.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2705, 'AMSRE_36V_AM_FT_2008_day278.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2706, 'AMSRE_36V_AM_FT_2008_day279.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2707, 'AMSRE_36V_AM_FT_2008_day280.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2708, 'AMSRE_36V_AM_FT_2008_day281.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2709, 'AMSRE_36V_AM_FT_2008_day282.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2710, 'AMSRE_36V_AM_FT_2008_day283.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2711, 'AMSRE_36V_AM_FT_2008_day284.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2712, 'AMSRE_36V_AM_FT_2008_day285.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2713, 'AMSRE_36V_AM_FT_2008_day286.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2714, 'AMSRE_36V_AM_FT_2008_day287.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2715, 'AMSRE_36V_AM_FT_2008_day288.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2716, 'AMSRE_36V_AM_FT_2008_day289.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2717, 'AMSRE_36V_AM_FT_2008_day290.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2718, 'AMSRE_36V_AM_FT_2008_day291.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2719, 'AMSRE_36V_AM_FT_2008_day292.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2720, 'AMSRE_36V_AM_FT_2008_day293.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2721, 'AMSRE_36V_AM_FT_2008_day294.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2722, 'AMSRE_36V_AM_FT_2008_day295.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2723, 'AMSRE_36V_AM_FT_2008_day296.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2724, 'AMSRE_36V_AM_FT_2008_day297.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2725, 'AMSRE_36V_AM_FT_2008_day298.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2726, 'AMSRE_36V_AM_FT_2008_day299.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2727, 'AMSRE_36V_AM_FT_2008_day300.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2728, 'AMSRE_36V_AM_FT_2008_day301.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2729, 'AMSRE_36V_AM_FT_2008_day302.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2730, 'AMSRE_36V_AM_FT_2008_day303.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2731, 'AMSRE_36V_AM_FT_2008_day304.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2732, 'AMSRE_36V_AM_FT_2008_day305.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2733, 'AMSRE_36V_AM_FT_2008_day306.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2734, 'AMSRE_36V_AM_FT_2008_day307.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2735, 'AMSRE_36V_AM_FT_2008_day308.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2736, 'AMSRE_36V_AM_FT_2008_day309.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2737, 'AMSRE_36V_AM_FT_2008_day310.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2738, 'AMSRE_36V_AM_FT_2008_day311.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2739, 'AMSRE_36V_AM_FT_2008_day312.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2740, 'AMSRE_36V_AM_FT_2008_day313.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2741, 'AMSRE_36V_AM_FT_2008_day314.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2742, 'AMSRE_36V_AM_FT_2008_day315.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2743, 'AMSRE_36V_AM_FT_2008_day316.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2744, 'AMSRE_36V_AM_FT_2008_day317.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2745, 'AMSRE_36V_AM_FT_2008_day318.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2746, 'AMSRE_36V_AM_FT_2008_day319.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2747, 'AMSRE_36V_AM_FT_2008_day320.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2748, 'AMSRE_36V_AM_FT_2008_day321.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2749, 'AMSRE_36V_AM_FT_2008_day322.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2750, 'AMSRE_36V_AM_FT_2008_day323.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2751, 'AMSRE_36V_AM_FT_2008_day324.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2752, 'AMSRE_36V_AM_FT_2008_day325.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2753, 'AMSRE_36V_AM_FT_2008_day326.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2754, 'AMSRE_36V_AM_FT_2008_day327.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2755, 'AMSRE_36V_AM_FT_2008_day328.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2756, 'AMSRE_36V_AM_FT_2008_day329.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2757, 'AMSRE_36V_AM_FT_2008_day330.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2758, 'AMSRE_36V_AM_FT_2008_day331.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2759, 'AMSRE_36V_AM_FT_2008_day332.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2760, 'AMSRE_36V_AM_FT_2008_day333.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2761, 'AMSRE_36V_AM_FT_2008_day334.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2762, 'AMSRE_36V_AM_FT_2008_day335.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2763, 'AMSRE_36V_AM_FT_2008_day336.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2764, 'AMSRE_36V_AM_FT_2008_day337.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2765, 'AMSRE_36V_AM_FT_2008_day338.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2766, 'AMSRE_36V_AM_FT_2008_day339.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2767, 'AMSRE_36V_AM_FT_2008_day340.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2768, 'AMSRE_36V_AM_FT_2008_day341.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2769, 'AMSRE_36V_AM_FT_2008_day342.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2770, 'AMSRE_36V_AM_FT_2008_day343.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2771, 'AMSRE_36V_AM_FT_2008_day344.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2772, 'AMSRE_36V_AM_FT_2008_day345.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2773, 'AMSRE_36V_AM_FT_2008_day346.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2774, 'AMSRE_36V_AM_FT_2008_day347.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2775, 'AMSRE_36V_AM_FT_2008_day348.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2776, 'AMSRE_36V_AM_FT_2008_day349.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2777, 'AMSRE_36V_AM_FT_2008_day350.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2778, 'AMSRE_36V_AM_FT_2008_day351.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2779, 'AMSRE_36V_AM_FT_2008_day352.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2780, 'AMSRE_36V_AM_FT_2008_day353.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2781, 'AMSRE_36V_AM_FT_2008_day354.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2782, 'AMSRE_36V_AM_FT_2008_day355.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2783, 'AMSRE_36V_AM_FT_2008_day356.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2784, 'AMSRE_36V_AM_FT_2008_day357.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2785, 'AMSRE_36V_AM_FT_2008_day358.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2786, 'AMSRE_36V_AM_FT_2008_day359.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2787, 'AMSRE_36V_AM_FT_2008_day360.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2788, 'AMSRE_36V_AM_FT_2008_day361.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2789, 'AMSRE_36V_AM_FT_2008_day362.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2790, 'AMSRE_36V_AM_FT_2008_day363.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2791, 'AMSRE_36V_AM_FT_2008_day364.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2792, 'AMSRE_36V_AM_FT_2008_day365.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2793, 'AMSRE_36V_AM_FT_2009_day1.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2794, 'AMSRE_36V_AM_FT_2009_day2.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2795, 'AMSRE_36V_AM_FT_2009_day3.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2796, 'AMSRE_36V_AM_FT_2009_day4.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2797, 'AMSRE_36V_AM_FT_2009_day5.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2798, 'AMSRE_36V_AM_FT_2009_day6.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2799, 'AMSRE_36V_AM_FT_2009_day7.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2800, 'AMSRE_36V_AM_FT_2009_day8.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2801, 'AMSRE_36V_AM_FT_2009_day9.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2802, 'AMSRE_36V_AM_FT_2009_day10.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2803, 'AMSRE_36V_AM_FT_2009_day11.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2804, 'AMSRE_36V_AM_FT_2009_day12.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2805, 'AMSRE_36V_AM_FT_2009_day13.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2806, 'AMSRE_36V_AM_FT_2009_day14.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2807, 'AMSRE_36V_AM_FT_2009_day15.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2808, 'AMSRE_36V_AM_FT_2009_day16.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2809, 'AMSRE_36V_AM_FT_2009_day17.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2810, 'AMSRE_36V_AM_FT_2009_day18.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2811, 'AMSRE_36V_AM_FT_2009_day19.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2812, 'AMSRE_36V_AM_FT_2009_day20.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2813, 'AMSRE_36V_AM_FT_2009_day21.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2814, 'AMSRE_36V_AM_FT_2009_day22.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2815, 'AMSRE_36V_AM_FT_2009_day23.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2816, 'AMSRE_36V_AM_FT_2009_day24.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2817, 'AMSRE_36V_AM_FT_2009_day25.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2818, 'AMSRE_36V_AM_FT_2009_day26.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2819, 'AMSRE_36V_AM_FT_2009_day27.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2820, 'AMSRE_36V_AM_FT_2009_day28.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2821, 'AMSRE_36V_AM_FT_2009_day29.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2822, 'AMSRE_36V_AM_FT_2009_day30.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2823, 'AMSRE_36V_AM_FT_2009_day31.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2824, 'AMSRE_36V_AM_FT_2009_day32.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2825, 'AMSRE_36V_AM_FT_2009_day33.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2826, 'AMSRE_36V_AM_FT_2009_day34.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2827, 'AMSRE_36V_AM_FT_2009_day35.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2828, 'AMSRE_36V_AM_FT_2009_day36.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2829, 'AMSRE_36V_AM_FT_2009_day37.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2830, 'AMSRE_36V_AM_FT_2009_day38.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2831, 'AMSRE_36V_AM_FT_2009_day39.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2832, 'AMSRE_36V_AM_FT_2009_day40.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2833, 'AMSRE_36V_AM_FT_2009_day41.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2834, 'AMSRE_36V_AM_FT_2009_day42.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2835, 'AMSRE_36V_AM_FT_2009_day43.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2836, 'AMSRE_36V_AM_FT_2009_day44.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2837, 'AMSRE_36V_AM_FT_2009_day45.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2838, 'AMSRE_36V_AM_FT_2009_day46.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2839, 'AMSRE_36V_AM_FT_2009_day47.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2840, 'AMSRE_36V_AM_FT_2009_day48.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2841, 'AMSRE_36V_AM_FT_2009_day49.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2842, 'AMSRE_36V_AM_FT_2009_day50.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2843, 'AMSRE_36V_AM_FT_2009_day51.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2844, 'AMSRE_36V_AM_FT_2009_day52.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2845, 'AMSRE_36V_AM_FT_2009_day53.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2846, 'AMSRE_36V_AM_FT_2009_day54.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2847, 'AMSRE_36V_AM_FT_2009_day55.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2848, 'AMSRE_36V_AM_FT_2009_day56.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2849, 'AMSRE_36V_AM_FT_2009_day57.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2850, 'AMSRE_36V_AM_FT_2009_day58.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2851, 'AMSRE_36V_AM_FT_2009_day59.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2852, 'AMSRE_36V_AM_FT_2009_day60.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2853, 'AMSRE_36V_AM_FT_2009_day61.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2854, 'AMSRE_36V_AM_FT_2009_day62.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2855, 'AMSRE_36V_AM_FT_2009_day63.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2856, 'AMSRE_36V_AM_FT_2009_day64.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2857, 'AMSRE_36V_AM_FT_2009_day65.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2858, 'AMSRE_36V_AM_FT_2009_day66.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2859, 'AMSRE_36V_AM_FT_2009_day67.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2860, 'AMSRE_36V_AM_FT_2009_day68.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2861, 'AMSRE_36V_AM_FT_2009_day69.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2862, 'AMSRE_36V_AM_FT_2009_day70.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2863, 'AMSRE_36V_AM_FT_2009_day71.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2864, 'AMSRE_36V_AM_FT_2009_day72.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2865, 'AMSRE_36V_AM_FT_2009_day73.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2866, 'AMSRE_36V_AM_FT_2009_day74.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2867, 'AMSRE_36V_AM_FT_2009_day75.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2868, 'AMSRE_36V_AM_FT_2009_day76.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2869, 'AMSRE_36V_AM_FT_2009_day77.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2870, 'AMSRE_36V_AM_FT_2009_day78.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2871, 'AMSRE_36V_AM_FT_2009_day79.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2872, 'AMSRE_36V_AM_FT_2009_day80.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2873, 'AMSRE_36V_AM_FT_2009_day81.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2874, 'AMSRE_36V_AM_FT_2009_day82.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2875, 'AMSRE_36V_AM_FT_2009_day83.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2876, 'AMSRE_36V_AM_FT_2009_day84.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2877, 'AMSRE_36V_AM_FT_2009_day85.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2878, 'AMSRE_36V_AM_FT_2009_day86.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2879, 'AMSRE_36V_AM_FT_2009_day87.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2880, 'AMSRE_36V_AM_FT_2009_day88.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2881, 'AMSRE_36V_AM_FT_2009_day89.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2882, 'AMSRE_36V_AM_FT_2009_day90.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2883, 'AMSRE_36V_AM_FT_2009_day91.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2884, 'AMSRE_36V_AM_FT_2009_day92.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2885, 'AMSRE_36V_AM_FT_2009_day93.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2886, 'AMSRE_36V_AM_FT_2009_day94.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2887, 'AMSRE_36V_AM_FT_2009_day95.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2888, 'AMSRE_36V_AM_FT_2009_day96.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2889, 'AMSRE_36V_AM_FT_2009_day97.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2890, 'AMSRE_36V_AM_FT_2009_day98.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2891, 'AMSRE_36V_AM_FT_2009_day99.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2892, 'AMSRE_36V_AM_FT_2009_day100.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2893, 'AMSRE_36V_AM_FT_2009_day101.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2894, 'AMSRE_36V_AM_FT_2009_day102.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2895, 'AMSRE_36V_AM_FT_2009_day103.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2896, 'AMSRE_36V_AM_FT_2009_day104.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2897, 'AMSRE_36V_AM_FT_2009_day105.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2898, 'AMSRE_36V_AM_FT_2009_day106.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2899, 'AMSRE_36V_AM_FT_2009_day107.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2900, 'AMSRE_36V_AM_FT_2009_day108.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2901, 'AMSRE_36V_AM_FT_2009_day109.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2902, 'AMSRE_36V_AM_FT_2009_day110.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2903, 'AMSRE_36V_AM_FT_2009_day111.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2904, 'AMSRE_36V_AM_FT_2009_day112.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2905, 'AMSRE_36V_AM_FT_2009_day113.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2906, 'AMSRE_36V_AM_FT_2009_day114.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2907, 'AMSRE_36V_AM_FT_2009_day115.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2908, 'AMSRE_36V_AM_FT_2009_day116.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2909, 'AMSRE_36V_AM_FT_2009_day117.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2910, 'AMSRE_36V_AM_FT_2009_day118.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2911, 'AMSRE_36V_AM_FT_2009_day119.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2912, 'AMSRE_36V_AM_FT_2009_day120.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2913, 'AMSRE_36V_AM_FT_2009_day121.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2914, 'AMSRE_36V_AM_FT_2009_day122.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2915, 'AMSRE_36V_AM_FT_2009_day123.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2916, 'AMSRE_36V_AM_FT_2009_day124.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2917, 'AMSRE_36V_AM_FT_2009_day125.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2918, 'AMSRE_36V_AM_FT_2009_day126.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2919, 'AMSRE_36V_AM_FT_2009_day127.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2920, 'AMSRE_36V_AM_FT_2009_day128.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2921, 'AMSRE_36V_AM_FT_2009_day129.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2922, 'AMSRE_36V_AM_FT_2009_day130.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2923, 'AMSRE_36V_AM_FT_2009_day131.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2924, 'AMSRE_36V_AM_FT_2009_day132.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2925, 'AMSRE_36V_AM_FT_2009_day133.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2926, 'AMSRE_36V_AM_FT_2009_day134.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2927, 'AMSRE_36V_AM_FT_2009_day135.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2928, 'AMSRE_36V_AM_FT_2009_day136.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2929, 'AMSRE_36V_AM_FT_2009_day137.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2930, 'AMSRE_36V_AM_FT_2009_day138.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2931, 'AMSRE_36V_AM_FT_2009_day139.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2932, 'AMSRE_36V_AM_FT_2009_day140.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2933, 'AMSRE_36V_AM_FT_2009_day141.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2934, 'AMSRE_36V_AM_FT_2009_day142.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2935, 'AMSRE_36V_AM_FT_2009_day143.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2936, 'AMSRE_36V_AM_FT_2009_day144.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2937, 'AMSRE_36V_AM_FT_2009_day145.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2938, 'AMSRE_36V_AM_FT_2009_day146.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2939, 'AMSRE_36V_AM_FT_2009_day147.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2940, 'AMSRE_36V_AM_FT_2009_day148.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2941, 'AMSRE_36V_AM_FT_2009_day149.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2942, 'AMSRE_36V_AM_FT_2009_day150.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2943, 'AMSRE_36V_AM_FT_2009_day151.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2944, 'AMSRE_36V_AM_FT_2009_day152.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2945, 'AMSRE_36V_AM_FT_2009_day153.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2946, 'AMSRE_36V_AM_FT_2009_day154.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2947, 'AMSRE_36V_AM_FT_2009_day155.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2948, 'AMSRE_36V_AM_FT_2009_day156.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2949, 'AMSRE_36V_AM_FT_2009_day157.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2950, 'AMSRE_36V_AM_FT_2009_day158.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2951, 'AMSRE_36V_AM_FT_2009_day159.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2952, 'AMSRE_36V_AM_FT_2009_day160.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2953, 'AMSRE_36V_AM_FT_2009_day161.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2954, 'AMSRE_36V_AM_FT_2009_day162.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2955, 'AMSRE_36V_AM_FT_2009_day163.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2956, 'AMSRE_36V_AM_FT_2009_day164.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2957, 'AMSRE_36V_AM_FT_2009_day165.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2958, 'AMSRE_36V_AM_FT_2009_day166.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2959, 'AMSRE_36V_AM_FT_2009_day167.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2960, 'AMSRE_36V_AM_FT_2009_day168.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2961, 'AMSRE_36V_AM_FT_2009_day169.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2962, 'AMSRE_36V_AM_FT_2009_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2963, 'AMSRE_36V_AM_FT_2009_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2964, 'AMSRE_36V_AM_FT_2009_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2965, 'AMSRE_36V_AM_FT_2009_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2966, 'AMSRE_36V_AM_FT_2009_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2967, 'AMSRE_36V_AM_FT_2009_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2968, 'AMSRE_36V_AM_FT_2009_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2969, 'AMSRE_36V_AM_FT_2009_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2970, 'AMSRE_36V_AM_FT_2009_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2971, 'AMSRE_36V_AM_FT_2009_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2972, 'AMSRE_36V_AM_FT_2009_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2973, 'AMSRE_36V_AM_FT_2009_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2974, 'AMSRE_36V_AM_FT_2009_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2975, 'AMSRE_36V_AM_FT_2009_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2976, 'AMSRE_36V_AM_FT_2009_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2977, 'AMSRE_36V_AM_FT_2009_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2978, 'AMSRE_36V_AM_FT_2009_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2979, 'AMSRE_36V_AM_FT_2009_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2980, 'AMSRE_36V_AM_FT_2009_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2981, 'AMSRE_36V_AM_FT_2009_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2982, 'AMSRE_36V_AM_FT_2009_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2983, 'AMSRE_36V_AM_FT_2009_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2984, 'AMSRE_36V_AM_FT_2009_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2985, 'AMSRE_36V_AM_FT_2009_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2986, 'AMSRE_36V_AM_FT_2009_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2987, 'AMSRE_36V_AM_FT_2009_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2988, 'AMSRE_36V_AM_FT_2009_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2989, 'AMSRE_36V_AM_FT_2009_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2990, 'AMSRE_36V_AM_FT_2009_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2991, 'AMSRE_36V_AM_FT_2009_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2992, 'AMSRE_36V_AM_FT_2009_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2993, 'AMSRE_36V_AM_FT_2009_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2994, 'AMSRE_36V_AM_FT_2009_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2995, 'AMSRE_36V_AM_FT_2009_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2996, 'AMSRE_36V_AM_FT_2009_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2997, 'AMSRE_36V_AM_FT_2009_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2998, 'AMSRE_36V_AM_FT_2009_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 2999, 'AMSRE_36V_AM_FT_2009_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3000, 'AMSRE_36V_AM_FT_2009_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3001, 'AMSRE_36V_AM_FT_2009_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3002, 'AMSRE_36V_AM_FT_2009_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3003, 'AMSRE_36V_AM_FT_2009_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3004, 'AMSRE_36V_AM_FT_2009_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3005, 'AMSRE_36V_AM_FT_2009_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3006, 'AMSRE_36V_AM_FT_2009_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3007, 'AMSRE_36V_AM_FT_2009_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3008, 'AMSRE_36V_AM_FT_2009_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3009, 'AMSRE_36V_AM_FT_2009_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3010, 'AMSRE_36V_AM_FT_2009_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3011, 'AMSRE_36V_AM_FT_2009_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3012, 'AMSRE_36V_AM_FT_2009_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3013, 'AMSRE_36V_AM_FT_2009_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3014, 'AMSRE_36V_AM_FT_2009_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3015, 'AMSRE_36V_AM_FT_2009_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3016, 'AMSRE_36V_AM_FT_2009_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3017, 'AMSRE_36V_AM_FT_2009_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3018, 'AMSRE_36V_AM_FT_2009_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3019, 'AMSRE_36V_AM_FT_2009_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3020, 'AMSRE_36V_AM_FT_2009_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3021, 'AMSRE_36V_AM_FT_2009_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3022, 'AMSRE_36V_AM_FT_2009_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3023, 'AMSRE_36V_AM_FT_2009_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3024, 'AMSRE_36V_AM_FT_2009_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3025, 'AMSRE_36V_AM_FT_2009_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3026, 'AMSRE_36V_AM_FT_2009_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3027, 'AMSRE_36V_AM_FT_2009_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3028, 'AMSRE_36V_AM_FT_2009_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3029, 'AMSRE_36V_AM_FT_2009_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3030, 'AMSRE_36V_AM_FT_2009_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3031, 'AMSRE_36V_AM_FT_2009_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3032, 'AMSRE_36V_AM_FT_2009_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3033, 'AMSRE_36V_AM_FT_2009_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3034, 'AMSRE_36V_AM_FT_2009_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3035, 'AMSRE_36V_AM_FT_2009_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3036, 'AMSRE_36V_AM_FT_2009_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3037, 'AMSRE_36V_AM_FT_2009_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3038, 'AMSRE_36V_AM_FT_2009_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3039, 'AMSRE_36V_AM_FT_2009_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3040, 'AMSRE_36V_AM_FT_2009_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3041, 'AMSRE_36V_AM_FT_2009_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3042, 'AMSRE_36V_AM_FT_2009_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3043, 'AMSRE_36V_AM_FT_2009_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3044, 'AMSRE_36V_AM_FT_2009_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3045, 'AMSRE_36V_AM_FT_2009_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3046, 'AMSRE_36V_AM_FT_2009_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3047, 'AMSRE_36V_AM_FT_2009_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3048, 'AMSRE_36V_AM_FT_2009_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3049, 'AMSRE_36V_AM_FT_2009_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3050, 'AMSRE_36V_AM_FT_2009_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3051, 'AMSRE_36V_AM_FT_2009_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3052, 'AMSRE_36V_AM_FT_2009_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3053, 'AMSRE_36V_AM_FT_2009_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3054, 'AMSRE_36V_AM_FT_2009_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3055, 'AMSRE_36V_AM_FT_2009_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3056, 'AMSRE_36V_AM_FT_2009_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3057, 'AMSRE_36V_AM_FT_2009_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3058, 'AMSRE_36V_AM_FT_2009_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3059, 'AMSRE_36V_AM_FT_2009_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3060, 'AMSRE_36V_AM_FT_2009_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3061, 'AMSRE_36V_AM_FT_2009_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3062, 'AMSRE_36V_AM_FT_2009_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3063, 'AMSRE_36V_AM_FT_2009_day271.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3064, 'AMSRE_36V_AM_FT_2009_day272.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3065, 'AMSRE_36V_AM_FT_2009_day273.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3066, 'AMSRE_36V_AM_FT_2009_day274.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3067, 'AMSRE_36V_AM_FT_2009_day275.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3068, 'AMSRE_36V_AM_FT_2009_day276.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3069, 'AMSRE_36V_AM_FT_2009_day277.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3070, 'AMSRE_36V_AM_FT_2009_day278.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3071, 'AMSRE_36V_AM_FT_2009_day279.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3072, 'AMSRE_36V_AM_FT_2009_day280.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3073, 'AMSRE_36V_AM_FT_2009_day281.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3074, 'AMSRE_36V_AM_FT_2009_day282.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3075, 'AMSRE_36V_AM_FT_2009_day283.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3076, 'AMSRE_36V_AM_FT_2009_day284.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3077, 'AMSRE_36V_AM_FT_2009_day285.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3078, 'AMSRE_36V_AM_FT_2009_day286.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3079, 'AMSRE_36V_AM_FT_2009_day287.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3080, 'AMSRE_36V_AM_FT_2009_day288.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3081, 'AMSRE_36V_AM_FT_2009_day289.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3082, 'AMSRE_36V_AM_FT_2009_day290.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3083, 'AMSRE_36V_AM_FT_2009_day291.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3084, 'AMSRE_36V_AM_FT_2009_day292.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3085, 'AMSRE_36V_AM_FT_2009_day293.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3086, 'AMSRE_36V_AM_FT_2009_day294.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3087, 'AMSRE_36V_AM_FT_2009_day295.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3088, 'AMSRE_36V_AM_FT_2009_day296.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3089, 'AMSRE_36V_AM_FT_2009_day297.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3090, 'AMSRE_36V_AM_FT_2009_day298.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3091, 'AMSRE_36V_AM_FT_2009_day299.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3092, 'AMSRE_36V_AM_FT_2009_day300.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3093, 'AMSRE_36V_AM_FT_2009_day301.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3094, 'AMSRE_36V_AM_FT_2009_day302.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3095, 'AMSRE_36V_AM_FT_2009_day303.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3096, 'AMSRE_36V_AM_FT_2009_day304.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3097, 'AMSRE_36V_AM_FT_2009_day305.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3098, 'AMSRE_36V_AM_FT_2009_day306.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3099, 'AMSRE_36V_AM_FT_2009_day307.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3100, 'AMSRE_36V_AM_FT_2009_day308.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3101, 'AMSRE_36V_AM_FT_2009_day309.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3102, 'AMSRE_36V_AM_FT_2009_day310.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3103, 'AMSRE_36V_AM_FT_2009_day311.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3104, 'AMSRE_36V_AM_FT_2009_day312.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3105, 'AMSRE_36V_AM_FT_2009_day313.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3106, 'AMSRE_36V_AM_FT_2009_day314.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3107, 'AMSRE_36V_AM_FT_2009_day315.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3108, 'AMSRE_36V_AM_FT_2009_day316.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3109, 'AMSRE_36V_AM_FT_2009_day317.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3110, 'AMSRE_36V_AM_FT_2009_day318.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3111, 'AMSRE_36V_AM_FT_2009_day319.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3112, 'AMSRE_36V_AM_FT_2009_day320.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3113, 'AMSRE_36V_AM_FT_2009_day321.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3114, 'AMSRE_36V_AM_FT_2009_day322.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3115, 'AMSRE_36V_AM_FT_2009_day323.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3116, 'AMSRE_36V_AM_FT_2009_day324.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3117, 'AMSRE_36V_AM_FT_2009_day325.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3118, 'AMSRE_36V_AM_FT_2009_day326.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3119, 'AMSRE_36V_AM_FT_2009_day327.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3120, 'AMSRE_36V_AM_FT_2009_day328.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3121, 'AMSRE_36V_AM_FT_2009_day329.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3122, 'AMSRE_36V_AM_FT_2009_day330.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3123, 'AMSRE_36V_AM_FT_2009_day331.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3124, 'AMSRE_36V_AM_FT_2009_day332.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3125, 'AMSRE_36V_AM_FT_2009_day333.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3126, 'AMSRE_36V_AM_FT_2009_day334.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3127, 'AMSRE_36V_AM_FT_2009_day335.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3128, 'AMSRE_36V_AM_FT_2009_day336.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3129, 'AMSRE_36V_AM_FT_2009_day337.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3130, 'AMSRE_36V_AM_FT_2009_day338.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3131, 'AMSRE_36V_AM_FT_2009_day339.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3132, 'AMSRE_36V_AM_FT_2009_day340.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3133, 'AMSRE_36V_AM_FT_2009_day341.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3134, 'AMSRE_36V_AM_FT_2009_day342.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3135, 'AMSRE_36V_AM_FT_2009_day343.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3136, 'AMSRE_36V_AM_FT_2009_day344.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3137, 'AMSRE_36V_AM_FT_2009_day345.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3138, 'AMSRE_36V_AM_FT_2009_day346.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3139, 'AMSRE_36V_AM_FT_2009_day347.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3140, 'AMSRE_36V_AM_FT_2009_day348.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3141, 'AMSRE_36V_AM_FT_2009_day349.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3142, 'AMSRE_36V_AM_FT_2009_day350.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3143, 'AMSRE_36V_AM_FT_2009_day351.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3144, 'AMSRE_36V_AM_FT_2009_day352.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3145, 'AMSRE_36V_AM_FT_2009_day353.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3146, 'AMSRE_36V_AM_FT_2009_day354.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3147, 'AMSRE_36V_AM_FT_2009_day355.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3148, 'AMSRE_36V_AM_FT_2009_day356.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3149, 'AMSRE_36V_AM_FT_2009_day357.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3150, 'AMSRE_36V_AM_FT_2009_day358.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3151, 'AMSRE_36V_AM_FT_2009_day359.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3152, 'AMSRE_36V_AM_FT_2009_day360.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3153, 'AMSRE_36V_AM_FT_2009_day361.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3154, 'AMSRE_36V_AM_FT_2009_day362.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3155, 'AMSRE_36V_AM_FT_2009_day363.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3156, 'AMSRE_36V_AM_FT_2009_day364.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3157, 'AMSRE_36V_AM_FT_2009_day365.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3158, 'AMSRE_36V_AM_FT_2010_day1.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3159, 'AMSRE_36V_AM_FT_2010_day2.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3160, 'AMSRE_36V_AM_FT_2010_day3.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3161, 'AMSRE_36V_AM_FT_2010_day4.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3162, 'AMSRE_36V_AM_FT_2010_day5.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3163, 'AMSRE_36V_AM_FT_2010_day6.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3164, 'AMSRE_36V_AM_FT_2010_day7.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3165, 'AMSRE_36V_AM_FT_2010_day8.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3166, 'AMSRE_36V_AM_FT_2010_day9.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3167, 'AMSRE_36V_AM_FT_2010_day10.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3168, 'AMSRE_36V_AM_FT_2010_day11.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3169, 'AMSRE_36V_AM_FT_2010_day12.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3170, 'AMSRE_36V_AM_FT_2010_day13.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3171, 'AMSRE_36V_AM_FT_2010_day14.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3172, 'AMSRE_36V_AM_FT_2010_day15.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3173, 'AMSRE_36V_AM_FT_2010_day16.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3174, 'AMSRE_36V_AM_FT_2010_day17.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3175, 'AMSRE_36V_AM_FT_2010_day18.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3176, 'AMSRE_36V_AM_FT_2010_day19.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3177, 'AMSRE_36V_AM_FT_2010_day20.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3178, 'AMSRE_36V_AM_FT_2010_day21.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3179, 'AMSRE_36V_AM_FT_2010_day22.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3180, 'AMSRE_36V_AM_FT_2010_day23.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3181, 'AMSRE_36V_AM_FT_2010_day24.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3182, 'AMSRE_36V_AM_FT_2010_day25.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3183, 'AMSRE_36V_AM_FT_2010_day26.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3184, 'AMSRE_36V_AM_FT_2010_day27.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3185, 'AMSRE_36V_AM_FT_2010_day28.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3186, 'AMSRE_36V_AM_FT_2010_day29.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3187, 'AMSRE_36V_AM_FT_2010_day30.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3188, 'AMSRE_36V_AM_FT_2010_day31.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3189, 'AMSRE_36V_AM_FT_2010_day32.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3190, 'AMSRE_36V_AM_FT_2010_day33.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3191, 'AMSRE_36V_AM_FT_2010_day34.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3192, 'AMSRE_36V_AM_FT_2010_day35.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3193, 'AMSRE_36V_AM_FT_2010_day36.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3194, 'AMSRE_36V_AM_FT_2010_day37.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3195, 'AMSRE_36V_AM_FT_2010_day38.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3196, 'AMSRE_36V_AM_FT_2010_day39.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3197, 'AMSRE_36V_AM_FT_2010_day40.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3198, 'AMSRE_36V_AM_FT_2010_day41.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3199, 'AMSRE_36V_AM_FT_2010_day42.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3200, 'AMSRE_36V_AM_FT_2010_day43.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3201, 'AMSRE_36V_AM_FT_2010_day44.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3202, 'AMSRE_36V_AM_FT_2010_day45.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3203, 'AMSRE_36V_AM_FT_2010_day46.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3204, 'AMSRE_36V_AM_FT_2010_day47.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3205, 'AMSRE_36V_AM_FT_2010_day48.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3206, 'AMSRE_36V_AM_FT_2010_day49.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3207, 'AMSRE_36V_AM_FT_2010_day50.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3208, 'AMSRE_36V_AM_FT_2010_day51.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3209, 'AMSRE_36V_AM_FT_2010_day52.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3210, 'AMSRE_36V_AM_FT_2010_day53.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3211, 'AMSRE_36V_AM_FT_2010_day54.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3212, 'AMSRE_36V_AM_FT_2010_day55.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3213, 'AMSRE_36V_AM_FT_2010_day56.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3214, 'AMSRE_36V_AM_FT_2010_day57.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3215, 'AMSRE_36V_AM_FT_2010_day58.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3216, 'AMSRE_36V_AM_FT_2010_day59.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3217, 'AMSRE_36V_AM_FT_2010_day60.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3218, 'AMSRE_36V_AM_FT_2010_day61.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3219, 'AMSRE_36V_AM_FT_2010_day62.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3220, 'AMSRE_36V_AM_FT_2010_day63.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3221, 'AMSRE_36V_AM_FT_2010_day64.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3222, 'AMSRE_36V_AM_FT_2010_day65.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3223, 'AMSRE_36V_AM_FT_2010_day66.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3224, 'AMSRE_36V_AM_FT_2010_day67.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3225, 'AMSRE_36V_AM_FT_2010_day68.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3226, 'AMSRE_36V_AM_FT_2010_day69.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3227, 'AMSRE_36V_AM_FT_2010_day70.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3228, 'AMSRE_36V_AM_FT_2010_day71.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3229, 'AMSRE_36V_AM_FT_2010_day72.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3230, 'AMSRE_36V_AM_FT_2010_day73.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3231, 'AMSRE_36V_AM_FT_2010_day74.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3232, 'AMSRE_36V_AM_FT_2010_day75.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3233, 'AMSRE_36V_AM_FT_2010_day76.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3234, 'AMSRE_36V_AM_FT_2010_day77.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3235, 'AMSRE_36V_AM_FT_2010_day78.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3236, 'AMSRE_36V_AM_FT_2010_day79.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3237, 'AMSRE_36V_AM_FT_2010_day80.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3238, 'AMSRE_36V_AM_FT_2010_day81.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3239, 'AMSRE_36V_AM_FT_2010_day82.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3240, 'AMSRE_36V_AM_FT_2010_day83.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3241, 'AMSRE_36V_AM_FT_2010_day84.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3242, 'AMSRE_36V_AM_FT_2010_day85.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3243, 'AMSRE_36V_AM_FT_2010_day86.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3244, 'AMSRE_36V_AM_FT_2010_day87.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3245, 'AMSRE_36V_AM_FT_2010_day88.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3246, 'AMSRE_36V_AM_FT_2010_day89.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3247, 'AMSRE_36V_AM_FT_2010_day90.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3248, 'AMSRE_36V_AM_FT_2010_day91.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3249, 'AMSRE_36V_AM_FT_2010_day92.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3250, 'AMSRE_36V_AM_FT_2010_day93.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3251, 'AMSRE_36V_AM_FT_2010_day94.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3252, 'AMSRE_36V_AM_FT_2010_day95.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3253, 'AMSRE_36V_AM_FT_2010_day96.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3254, 'AMSRE_36V_AM_FT_2010_day97.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3255, 'AMSRE_36V_AM_FT_2010_day98.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3256, 'AMSRE_36V_AM_FT_2010_day99.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3257, 'AMSRE_36V_AM_FT_2010_day100.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3258, 'AMSRE_36V_AM_FT_2010_day101.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3259, 'AMSRE_36V_AM_FT_2010_day102.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3260, 'AMSRE_36V_AM_FT_2010_day103.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3261, 'AMSRE_36V_AM_FT_2010_day104.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3262, 'AMSRE_36V_AM_FT_2010_day105.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3263, 'AMSRE_36V_AM_FT_2010_day106.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3264, 'AMSRE_36V_AM_FT_2010_day107.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3265, 'AMSRE_36V_AM_FT_2010_day108.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3266, 'AMSRE_36V_AM_FT_2010_day109.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3267, 'AMSRE_36V_AM_FT_2010_day110.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3268, 'AMSRE_36V_AM_FT_2010_day111.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3269, 'AMSRE_36V_AM_FT_2010_day112.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3270, 'AMSRE_36V_AM_FT_2010_day113.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3271, 'AMSRE_36V_AM_FT_2010_day114.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3272, 'AMSRE_36V_AM_FT_2010_day115.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3273, 'AMSRE_36V_AM_FT_2010_day116.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3274, 'AMSRE_36V_AM_FT_2010_day117.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3275, 'AMSRE_36V_AM_FT_2010_day118.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3276, 'AMSRE_36V_AM_FT_2010_day119.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3277, 'AMSRE_36V_AM_FT_2010_day120.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3278, 'AMSRE_36V_AM_FT_2010_day121.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3279, 'AMSRE_36V_AM_FT_2010_day122.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3280, 'AMSRE_36V_AM_FT_2010_day123.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3281, 'AMSRE_36V_AM_FT_2010_day124.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3282, 'AMSRE_36V_AM_FT_2010_day125.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3283, 'AMSRE_36V_AM_FT_2010_day126.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3284, 'AMSRE_36V_AM_FT_2010_day127.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3285, 'AMSRE_36V_AM_FT_2010_day128.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3286, 'AMSRE_36V_AM_FT_2010_day129.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3287, 'AMSRE_36V_AM_FT_2010_day130.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3288, 'AMSRE_36V_AM_FT_2010_day131.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3289, 'AMSRE_36V_AM_FT_2010_day132.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3290, 'AMSRE_36V_AM_FT_2010_day133.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3291, 'AMSRE_36V_AM_FT_2010_day134.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3292, 'AMSRE_36V_AM_FT_2010_day135.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3293, 'AMSRE_36V_AM_FT_2010_day136.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3294, 'AMSRE_36V_AM_FT_2010_day137.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3295, 'AMSRE_36V_AM_FT_2010_day138.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3296, 'AMSRE_36V_AM_FT_2010_day139.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3297, 'AMSRE_36V_AM_FT_2010_day140.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3298, 'AMSRE_36V_AM_FT_2010_day141.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3299, 'AMSRE_36V_AM_FT_2010_day142.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3300, 'AMSRE_36V_AM_FT_2010_day143.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3301, 'AMSRE_36V_AM_FT_2010_day144.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3302, 'AMSRE_36V_AM_FT_2010_day145.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3303, 'AMSRE_36V_AM_FT_2010_day146.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3304, 'AMSRE_36V_AM_FT_2010_day147.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3305, 'AMSRE_36V_AM_FT_2010_day148.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3306, 'AMSRE_36V_AM_FT_2010_day149.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3307, 'AMSRE_36V_AM_FT_2010_day150.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3308, 'AMSRE_36V_AM_FT_2010_day151.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3309, 'AMSRE_36V_AM_FT_2010_day152.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3310, 'AMSRE_36V_AM_FT_2010_day153.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3311, 'AMSRE_36V_AM_FT_2010_day154.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3312, 'AMSRE_36V_AM_FT_2010_day155.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3313, 'AMSRE_36V_AM_FT_2010_day156.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3314, 'AMSRE_36V_AM_FT_2010_day157.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3315, 'AMSRE_36V_AM_FT_2010_day158.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3316, 'AMSRE_36V_AM_FT_2010_day159.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3317, 'AMSRE_36V_AM_FT_2010_day160.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3318, 'AMSRE_36V_AM_FT_2010_day161.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3319, 'AMSRE_36V_AM_FT_2010_day162.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3320, 'AMSRE_36V_AM_FT_2010_day163.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3321, 'AMSRE_36V_AM_FT_2010_day164.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3322, 'AMSRE_36V_AM_FT_2010_day165.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3323, 'AMSRE_36V_AM_FT_2010_day166.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3324, 'AMSRE_36V_AM_FT_2010_day167.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3325, 'AMSRE_36V_AM_FT_2010_day168.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3326, 'AMSRE_36V_AM_FT_2010_day169.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3327, 'AMSRE_36V_AM_FT_2010_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3328, 'AMSRE_36V_AM_FT_2010_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3329, 'AMSRE_36V_AM_FT_2010_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3330, 'AMSRE_36V_AM_FT_2010_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3331, 'AMSRE_36V_AM_FT_2010_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3332, 'AMSRE_36V_AM_FT_2010_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3333, 'AMSRE_36V_AM_FT_2010_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3334, 'AMSRE_36V_AM_FT_2010_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3335, 'AMSRE_36V_AM_FT_2010_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3336, 'AMSRE_36V_AM_FT_2010_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3337, 'AMSRE_36V_AM_FT_2010_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3338, 'AMSRE_36V_AM_FT_2010_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3339, 'AMSRE_36V_AM_FT_2010_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3340, 'AMSRE_36V_AM_FT_2010_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3341, 'AMSRE_36V_AM_FT_2010_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3342, 'AMSRE_36V_AM_FT_2010_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3343, 'AMSRE_36V_AM_FT_2010_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3344, 'AMSRE_36V_AM_FT_2010_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3345, 'AMSRE_36V_AM_FT_2010_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3346, 'AMSRE_36V_AM_FT_2010_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3347, 'AMSRE_36V_AM_FT_2010_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3348, 'AMSRE_36V_AM_FT_2010_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3349, 'AMSRE_36V_AM_FT_2010_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3350, 'AMSRE_36V_AM_FT_2010_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3351, 'AMSRE_36V_AM_FT_2010_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3352, 'AMSRE_36V_AM_FT_2010_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3353, 'AMSRE_36V_AM_FT_2010_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3354, 'AMSRE_36V_AM_FT_2010_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3355, 'AMSRE_36V_AM_FT_2010_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3356, 'AMSRE_36V_AM_FT_2010_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3357, 'AMSRE_36V_AM_FT_2010_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3358, 'AMSRE_36V_AM_FT_2010_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3359, 'AMSRE_36V_AM_FT_2010_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3360, 'AMSRE_36V_AM_FT_2010_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3361, 'AMSRE_36V_AM_FT_2010_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3362, 'AMSRE_36V_AM_FT_2010_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3363, 'AMSRE_36V_AM_FT_2010_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3364, 'AMSRE_36V_AM_FT_2010_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3365, 'AMSRE_36V_AM_FT_2010_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3366, 'AMSRE_36V_AM_FT_2010_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3367, 'AMSRE_36V_AM_FT_2010_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3368, 'AMSRE_36V_AM_FT_2010_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3369, 'AMSRE_36V_AM_FT_2010_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3370, 'AMSRE_36V_AM_FT_2010_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3371, 'AMSRE_36V_AM_FT_2010_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3372, 'AMSRE_36V_AM_FT_2010_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3373, 'AMSRE_36V_AM_FT_2010_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3374, 'AMSRE_36V_AM_FT_2010_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3375, 'AMSRE_36V_AM_FT_2010_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3376, 'AMSRE_36V_AM_FT_2010_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3377, 'AMSRE_36V_AM_FT_2010_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3378, 'AMSRE_36V_AM_FT_2010_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3379, 'AMSRE_36V_AM_FT_2010_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3380, 'AMSRE_36V_AM_FT_2010_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3381, 'AMSRE_36V_AM_FT_2010_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3382, 'AMSRE_36V_AM_FT_2010_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3383, 'AMSRE_36V_AM_FT_2010_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3384, 'AMSRE_36V_AM_FT_2010_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3385, 'AMSRE_36V_AM_FT_2010_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3386, 'AMSRE_36V_AM_FT_2010_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3387, 'AMSRE_36V_AM_FT_2010_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3388, 'AMSRE_36V_AM_FT_2010_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3389, 'AMSRE_36V_AM_FT_2010_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3390, 'AMSRE_36V_AM_FT_2010_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3391, 'AMSRE_36V_AM_FT_2010_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3392, 'AMSRE_36V_AM_FT_2010_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3393, 'AMSRE_36V_AM_FT_2010_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3394, 'AMSRE_36V_AM_FT_2010_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3395, 'AMSRE_36V_AM_FT_2010_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3396, 'AMSRE_36V_AM_FT_2010_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3397, 'AMSRE_36V_AM_FT_2010_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3398, 'AMSRE_36V_AM_FT_2010_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3399, 'AMSRE_36V_AM_FT_2010_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3400, 'AMSRE_36V_AM_FT_2010_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3401, 'AMSRE_36V_AM_FT_2010_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3402, 'AMSRE_36V_AM_FT_2010_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3403, 'AMSRE_36V_AM_FT_2010_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3404, 'AMSRE_36V_AM_FT_2010_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3405, 'AMSRE_36V_AM_FT_2010_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3406, 'AMSRE_36V_AM_FT_2010_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3407, 'AMSRE_36V_AM_FT_2010_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3408, 'AMSRE_36V_AM_FT_2010_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3409, 'AMSRE_36V_AM_FT_2010_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3410, 'AMSRE_36V_AM_FT_2010_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3411, 'AMSRE_36V_AM_FT_2010_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3412, 'AMSRE_36V_AM_FT_2010_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3413, 'AMSRE_36V_AM_FT_2010_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3414, 'AMSRE_36V_AM_FT_2010_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3415, 'AMSRE_36V_AM_FT_2010_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3416, 'AMSRE_36V_AM_FT_2010_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3417, 'AMSRE_36V_AM_FT_2010_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3418, 'AMSRE_36V_AM_FT_2010_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3419, 'AMSRE_36V_AM_FT_2010_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3420, 'AMSRE_36V_AM_FT_2010_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3421, 'AMSRE_36V_AM_FT_2010_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3422, 'AMSRE_36V_AM_FT_2010_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3423, 'AMSRE_36V_AM_FT_2010_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3424, 'AMSRE_36V_AM_FT_2010_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3425, 'AMSRE_36V_AM_FT_2010_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3426, 'AMSRE_36V_AM_FT_2010_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3427, 'AMSRE_36V_AM_FT_2010_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3428, 'AMSRE_36V_AM_FT_2010_day271.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3429, 'AMSRE_36V_AM_FT_2010_day272.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3430, 'AMSRE_36V_AM_FT_2010_day273.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3431, 'AMSRE_36V_AM_FT_2010_day274.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3432, 'AMSRE_36V_AM_FT_2010_day275.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3433, 'AMSRE_36V_AM_FT_2010_day276.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3434, 'AMSRE_36V_AM_FT_2010_day277.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3435, 'AMSRE_36V_AM_FT_2010_day278.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3436, 'AMSRE_36V_AM_FT_2010_day279.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3437, 'AMSRE_36V_AM_FT_2010_day280.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3438, 'AMSRE_36V_AM_FT_2010_day281.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3439, 'AMSRE_36V_AM_FT_2010_day282.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3440, 'AMSRE_36V_AM_FT_2010_day283.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3441, 'AMSRE_36V_AM_FT_2010_day284.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3442, 'AMSRE_36V_AM_FT_2010_day285.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3443, 'AMSRE_36V_AM_FT_2010_day286.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3444, 'AMSRE_36V_AM_FT_2010_day287.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3445, 'AMSRE_36V_AM_FT_2010_day288.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3446, 'AMSRE_36V_AM_FT_2010_day289.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3447, 'AMSRE_36V_AM_FT_2010_day290.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3448, 'AMSRE_36V_AM_FT_2010_day291.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3449, 'AMSRE_36V_AM_FT_2010_day292.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3450, 'AMSRE_36V_AM_FT_2010_day293.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3451, 'AMSRE_36V_AM_FT_2010_day294.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3452, 'AMSRE_36V_AM_FT_2010_day295.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3453, 'AMSRE_36V_AM_FT_2010_day296.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3454, 'AMSRE_36V_AM_FT_2010_day297.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3455, 'AMSRE_36V_AM_FT_2010_day298.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3456, 'AMSRE_36V_AM_FT_2010_day299.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3457, 'AMSRE_36V_AM_FT_2010_day300.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3458, 'AMSRE_36V_AM_FT_2010_day301.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3459, 'AMSRE_36V_AM_FT_2010_day302.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3460, 'AMSRE_36V_AM_FT_2010_day303.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3461, 'AMSRE_36V_AM_FT_2010_day304.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3462, 'AMSRE_36V_AM_FT_2010_day305.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3463, 'AMSRE_36V_AM_FT_2010_day306.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3464, 'AMSRE_36V_AM_FT_2010_day307.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3465, 'AMSRE_36V_AM_FT_2010_day308.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3466, 'AMSRE_36V_AM_FT_2010_day309.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3467, 'AMSRE_36V_AM_FT_2010_day310.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3468, 'AMSRE_36V_AM_FT_2010_day311.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3469, 'AMSRE_36V_AM_FT_2010_day312.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3470, 'AMSRE_36V_AM_FT_2010_day313.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3471, 'AMSRE_36V_AM_FT_2010_day314.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3472, 'AMSRE_36V_AM_FT_2010_day315.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3473, 'AMSRE_36V_AM_FT_2010_day316.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3474, 'AMSRE_36V_AM_FT_2010_day317.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3475, 'AMSRE_36V_AM_FT_2010_day318.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3476, 'AMSRE_36V_AM_FT_2010_day319.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3477, 'AMSRE_36V_AM_FT_2010_day320.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3478, 'AMSRE_36V_AM_FT_2010_day321.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3479, 'AMSRE_36V_AM_FT_2010_day322.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3480, 'AMSRE_36V_AM_FT_2010_day323.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3481, 'AMSRE_36V_AM_FT_2010_day324.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3482, 'AMSRE_36V_AM_FT_2010_day325.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3483, 'AMSRE_36V_AM_FT_2010_day326.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3484, 'AMSRE_36V_AM_FT_2010_day327.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3485, 'AMSRE_36V_AM_FT_2010_day328.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3486, 'AMSRE_36V_AM_FT_2010_day329.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3487, 'AMSRE_36V_AM_FT_2010_day330.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3488, 'AMSRE_36V_AM_FT_2010_day331.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3489, 'AMSRE_36V_AM_FT_2010_day332.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3490, 'AMSRE_36V_AM_FT_2010_day333.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3491, 'AMSRE_36V_AM_FT_2010_day334.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3492, 'AMSRE_36V_AM_FT_2010_day335.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3493, 'AMSRE_36V_AM_FT_2010_day336.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3494, 'AMSRE_36V_AM_FT_2010_day337.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3495, 'AMSRE_36V_AM_FT_2010_day338.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3496, 'AMSRE_36V_AM_FT_2010_day339.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3497, 'AMSRE_36V_AM_FT_2010_day340.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3498, 'AMSRE_36V_AM_FT_2010_day341.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3499, 'AMSRE_36V_AM_FT_2010_day342.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3500, 'AMSRE_36V_AM_FT_2010_day343.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3501, 'AMSRE_36V_AM_FT_2010_day344.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3502, 'AMSRE_36V_AM_FT_2010_day345.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3503, 'AMSRE_36V_AM_FT_2010_day346.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3504, 'AMSRE_36V_AM_FT_2010_day347.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3505, 'AMSRE_36V_AM_FT_2010_day348.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3506, 'AMSRE_36V_AM_FT_2010_day349.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3507, 'AMSRE_36V_AM_FT_2010_day350.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3508, 'AMSRE_36V_AM_FT_2010_day351.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3509, 'AMSRE_36V_AM_FT_2010_day352.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3510, 'AMSRE_36V_AM_FT_2010_day353.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3511, 'AMSRE_36V_AM_FT_2010_day354.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3512, 'AMSRE_36V_AM_FT_2010_day355.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3513, 'AMSRE_36V_AM_FT_2010_day356.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3514, 'AMSRE_36V_AM_FT_2010_day357.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3515, 'AMSRE_36V_AM_FT_2010_day358.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3516, 'AMSRE_36V_AM_FT_2010_day359.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3517, 'AMSRE_36V_AM_FT_2010_day360.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3518, 'AMSRE_36V_AM_FT_2010_day361.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3519, 'AMSRE_36V_AM_FT_2010_day362.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3520, 'AMSRE_36V_AM_FT_2010_day363.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3521, 'AMSRE_36V_AM_FT_2010_day364.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3522, 'AMSRE_36V_AM_FT_2010_day365.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3523, 'AMSRE_36V_AM_FT_2011_day1.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3524, 'AMSRE_36V_AM_FT_2011_day2.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3525, 'AMSRE_36V_AM_FT_2011_day3.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3526, 'AMSRE_36V_AM_FT_2011_day4.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3527, 'AMSRE_36V_AM_FT_2011_day5.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3528, 'AMSRE_36V_AM_FT_2011_day6.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3529, 'AMSRE_36V_AM_FT_2011_day7.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3530, 'AMSRE_36V_AM_FT_2011_day8.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3531, 'AMSRE_36V_AM_FT_2011_day9.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3532, 'AMSRE_36V_AM_FT_2011_day10.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3533, 'AMSRE_36V_AM_FT_2011_day11.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3534, 'AMSRE_36V_AM_FT_2011_day12.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3535, 'AMSRE_36V_AM_FT_2011_day13.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3536, 'AMSRE_36V_AM_FT_2011_day14.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3537, 'AMSRE_36V_AM_FT_2011_day15.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3538, 'AMSRE_36V_AM_FT_2011_day16.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3539, 'AMSRE_36V_AM_FT_2011_day17.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3540, 'AMSRE_36V_AM_FT_2011_day18.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3541, 'AMSRE_36V_AM_FT_2011_day19.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3542, 'AMSRE_36V_AM_FT_2011_day20.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3543, 'AMSRE_36V_AM_FT_2011_day21.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3544, 'AMSRE_36V_AM_FT_2011_day22.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3545, 'AMSRE_36V_AM_FT_2011_day23.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3546, 'AMSRE_36V_AM_FT_2011_day24.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3547, 'AMSRE_36V_AM_FT_2011_day25.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3548, 'AMSRE_36V_AM_FT_2011_day26.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3549, 'AMSRE_36V_AM_FT_2011_day27.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3550, 'AMSRE_36V_AM_FT_2011_day28.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3551, 'AMSRE_36V_AM_FT_2011_day29.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3552, 'AMSRE_36V_AM_FT_2011_day30.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3553, 'AMSRE_36V_AM_FT_2011_day31.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3554, 'AMSRE_36V_AM_FT_2011_day32.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3555, 'AMSRE_36V_AM_FT_2011_day33.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3556, 'AMSRE_36V_AM_FT_2011_day34.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3557, 'AMSRE_36V_AM_FT_2011_day35.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3558, 'AMSRE_36V_AM_FT_2011_day36.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3559, 'AMSRE_36V_AM_FT_2011_day37.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3560, 'AMSRE_36V_AM_FT_2011_day38.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3561, 'AMSRE_36V_AM_FT_2011_day39.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3562, 'AMSRE_36V_AM_FT_2011_day40.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3563, 'AMSRE_36V_AM_FT_2011_day41.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3564, 'AMSRE_36V_AM_FT_2011_day42.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3565, 'AMSRE_36V_AM_FT_2011_day43.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3566, 'AMSRE_36V_AM_FT_2011_day44.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3567, 'AMSRE_36V_AM_FT_2011_day45.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3568, 'AMSRE_36V_AM_FT_2011_day46.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3569, 'AMSRE_36V_AM_FT_2011_day47.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3570, 'AMSRE_36V_AM_FT_2011_day48.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3571, 'AMSRE_36V_AM_FT_2011_day49.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3572, 'AMSRE_36V_AM_FT_2011_day50.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3573, 'AMSRE_36V_AM_FT_2011_day51.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3574, 'AMSRE_36V_AM_FT_2011_day52.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3575, 'AMSRE_36V_AM_FT_2011_day53.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3576, 'AMSRE_36V_AM_FT_2011_day54.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3577, 'AMSRE_36V_AM_FT_2011_day55.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3578, 'AMSRE_36V_AM_FT_2011_day56.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3579, 'AMSRE_36V_AM_FT_2011_day57.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3580, 'AMSRE_36V_AM_FT_2011_day58.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3581, 'AMSRE_36V_AM_FT_2011_day59.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3582, 'AMSRE_36V_AM_FT_2011_day60.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3583, 'AMSRE_36V_AM_FT_2011_day61.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3584, 'AMSRE_36V_AM_FT_2011_day62.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3585, 'AMSRE_36V_AM_FT_2011_day63.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3586, 'AMSRE_36V_AM_FT_2011_day64.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3587, 'AMSRE_36V_AM_FT_2011_day65.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3588, 'AMSRE_36V_AM_FT_2011_day66.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3589, 'AMSRE_36V_AM_FT_2011_day67.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3590, 'AMSRE_36V_AM_FT_2011_day68.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3591, 'AMSRE_36V_AM_FT_2011_day69.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3592, 'AMSRE_36V_AM_FT_2011_day70.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3593, 'AMSRE_36V_AM_FT_2011_day71.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3594, 'AMSRE_36V_AM_FT_2011_day72.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3595, 'AMSRE_36V_AM_FT_2011_day73.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3596, 'AMSRE_36V_AM_FT_2011_day74.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3597, 'AMSRE_36V_AM_FT_2011_day75.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3598, 'AMSRE_36V_AM_FT_2011_day76.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3599, 'AMSRE_36V_AM_FT_2011_day77.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3600, 'AMSRE_36V_AM_FT_2011_day78.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3601, 'AMSRE_36V_AM_FT_2011_day79.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3602, 'AMSRE_36V_AM_FT_2011_day80.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3603, 'AMSRE_36V_AM_FT_2011_day81.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3604, 'AMSRE_36V_AM_FT_2011_day82.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3605, 'AMSRE_36V_AM_FT_2011_day83.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3606, 'AMSRE_36V_AM_FT_2011_day84.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3607, 'AMSRE_36V_AM_FT_2011_day85.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3608, 'AMSRE_36V_AM_FT_2011_day86.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3609, 'AMSRE_36V_AM_FT_2011_day87.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3610, 'AMSRE_36V_AM_FT_2011_day88.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3611, 'AMSRE_36V_AM_FT_2011_day89.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3612, 'AMSRE_36V_AM_FT_2011_day90.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3613, 'AMSRE_36V_AM_FT_2011_day91.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3614, 'AMSRE_36V_AM_FT_2011_day92.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3615, 'AMSRE_36V_AM_FT_2011_day93.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3616, 'AMSRE_36V_AM_FT_2011_day94.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3617, 'AMSRE_36V_AM_FT_2011_day95.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3618, 'AMSRE_36V_AM_FT_2011_day96.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3619, 'AMSRE_36V_AM_FT_2011_day97.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3620, 'AMSRE_36V_AM_FT_2011_day98.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3621, 'AMSRE_36V_AM_FT_2011_day99.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3622, 'AMSRE_36V_AM_FT_2011_day100.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3623, 'AMSRE_36V_AM_FT_2011_day101.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3624, 'AMSRE_36V_AM_FT_2011_day102.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3625, 'AMSRE_36V_AM_FT_2011_day103.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3626, 'AMSRE_36V_AM_FT_2011_day104.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3627, 'AMSRE_36V_AM_FT_2011_day105.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3628, 'AMSRE_36V_AM_FT_2011_day106.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3629, 'AMSRE_36V_AM_FT_2011_day107.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3630, 'AMSRE_36V_AM_FT_2011_day108.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3631, 'AMSRE_36V_AM_FT_2011_day109.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3632, 'AMSRE_36V_AM_FT_2011_day110.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3633, 'AMSRE_36V_AM_FT_2011_day111.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3634, 'AMSRE_36V_AM_FT_2011_day112.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3635, 'AMSRE_36V_AM_FT_2011_day113.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3636, 'AMSRE_36V_AM_FT_2011_day114.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3637, 'AMSRE_36V_AM_FT_2011_day115.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3638, 'AMSRE_36V_AM_FT_2011_day116.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3639, 'AMSRE_36V_AM_FT_2011_day117.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3640, 'AMSRE_36V_AM_FT_2011_day118.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3641, 'AMSRE_36V_AM_FT_2011_day119.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3642, 'AMSRE_36V_AM_FT_2011_day120.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3643, 'AMSRE_36V_AM_FT_2011_day121.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3644, 'AMSRE_36V_AM_FT_2011_day122.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3645, 'AMSRE_36V_AM_FT_2011_day123.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3646, 'AMSRE_36V_AM_FT_2011_day124.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3647, 'AMSRE_36V_AM_FT_2011_day125.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3648, 'AMSRE_36V_AM_FT_2011_day126.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3649, 'AMSRE_36V_AM_FT_2011_day127.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3650, 'AMSRE_36V_AM_FT_2011_day128.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3651, 'AMSRE_36V_AM_FT_2011_day129.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3652, 'AMSRE_36V_AM_FT_2011_day130.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3653, 'AMSRE_36V_AM_FT_2011_day131.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3654, 'AMSRE_36V_AM_FT_2011_day132.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3655, 'AMSRE_36V_AM_FT_2011_day133.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3656, 'AMSRE_36V_AM_FT_2011_day134.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3657, 'AMSRE_36V_AM_FT_2011_day135.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3658, 'AMSRE_36V_AM_FT_2011_day136.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3659, 'AMSRE_36V_AM_FT_2011_day137.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3660, 'AMSRE_36V_AM_FT_2011_day138.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3661, 'AMSRE_36V_AM_FT_2011_day139.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3662, 'AMSRE_36V_AM_FT_2011_day140.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3663, 'AMSRE_36V_AM_FT_2011_day141.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3664, 'AMSRE_36V_AM_FT_2011_day142.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3665, 'AMSRE_36V_AM_FT_2011_day143.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3666, 'AMSRE_36V_AM_FT_2011_day144.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3667, 'AMSRE_36V_AM_FT_2011_day145.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3668, 'AMSRE_36V_AM_FT_2011_day146.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3669, 'AMSRE_36V_AM_FT_2011_day147.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3670, 'AMSRE_36V_AM_FT_2011_day148.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3671, 'AMSRE_36V_AM_FT_2011_day149.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3672, 'AMSRE_36V_AM_FT_2011_day150.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3673, 'AMSRE_36V_AM_FT_2011_day151.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3674, 'AMSRE_36V_AM_FT_2011_day152.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3675, 'AMSRE_36V_AM_FT_2011_day153.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3676, 'AMSRE_36V_AM_FT_2011_day154.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3677, 'AMSRE_36V_AM_FT_2011_day155.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3678, 'AMSRE_36V_AM_FT_2011_day156.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3679, 'AMSRE_36V_AM_FT_2011_day157.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3680, 'AMSRE_36V_AM_FT_2011_day158.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3681, 'AMSRE_36V_AM_FT_2011_day159.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3682, 'AMSRE_36V_AM_FT_2011_day160.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3683, 'AMSRE_36V_AM_FT_2011_day161.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3684, 'AMSRE_36V_AM_FT_2011_day162.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3685, 'AMSRE_36V_AM_FT_2011_day163.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3686, 'AMSRE_36V_AM_FT_2011_day164.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3687, 'AMSRE_36V_AM_FT_2011_day165.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3688, 'AMSRE_36V_AM_FT_2011_day166.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3689, 'AMSRE_36V_AM_FT_2011_day167.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3690, 'AMSRE_36V_AM_FT_2011_day168.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3691, 'AMSRE_36V_AM_FT_2011_day169.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3692, 'AMSRE_36V_AM_FT_2011_day170.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3693, 'AMSRE_36V_AM_FT_2011_day171.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3694, 'AMSRE_36V_AM_FT_2011_day172.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3695, 'AMSRE_36V_AM_FT_2011_day173.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3696, 'AMSRE_36V_AM_FT_2011_day174.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3697, 'AMSRE_36V_AM_FT_2011_day175.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3698, 'AMSRE_36V_AM_FT_2011_day176.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3699, 'AMSRE_36V_AM_FT_2011_day177.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3700, 'AMSRE_36V_AM_FT_2011_day178.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3701, 'AMSRE_36V_AM_FT_2011_day179.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3702, 'AMSRE_36V_AM_FT_2011_day180.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3703, 'AMSRE_36V_AM_FT_2011_day181.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3704, 'AMSRE_36V_AM_FT_2011_day182.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3705, 'AMSRE_36V_AM_FT_2011_day183.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3706, 'AMSRE_36V_AM_FT_2011_day184.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3707, 'AMSRE_36V_AM_FT_2011_day185.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3708, 'AMSRE_36V_AM_FT_2011_day186.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3709, 'AMSRE_36V_AM_FT_2011_day187.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3710, 'AMSRE_36V_AM_FT_2011_day188.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3711, 'AMSRE_36V_AM_FT_2011_day189.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3712, 'AMSRE_36V_AM_FT_2011_day190.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3713, 'AMSRE_36V_AM_FT_2011_day191.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3714, 'AMSRE_36V_AM_FT_2011_day192.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3715, 'AMSRE_36V_AM_FT_2011_day193.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3716, 'AMSRE_36V_AM_FT_2011_day194.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3717, 'AMSRE_36V_AM_FT_2011_day195.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3718, 'AMSRE_36V_AM_FT_2011_day196.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3719, 'AMSRE_36V_AM_FT_2011_day197.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3720, 'AMSRE_36V_AM_FT_2011_day198.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3721, 'AMSRE_36V_AM_FT_2011_day199.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3722, 'AMSRE_36V_AM_FT_2011_day200.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3723, 'AMSRE_36V_AM_FT_2011_day201.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3724, 'AMSRE_36V_AM_FT_2011_day202.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3725, 'AMSRE_36V_AM_FT_2011_day203.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3726, 'AMSRE_36V_AM_FT_2011_day204.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3727, 'AMSRE_36V_AM_FT_2011_day205.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3728, 'AMSRE_36V_AM_FT_2011_day206.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3729, 'AMSRE_36V_AM_FT_2011_day207.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3730, 'AMSRE_36V_AM_FT_2011_day208.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3731, 'AMSRE_36V_AM_FT_2011_day209.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3732, 'AMSRE_36V_AM_FT_2011_day210.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3733, 'AMSRE_36V_AM_FT_2011_day211.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3734, 'AMSRE_36V_AM_FT_2011_day212.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3735, 'AMSRE_36V_AM_FT_2011_day213.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3736, 'AMSRE_36V_AM_FT_2011_day214.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3737, 'AMSRE_36V_AM_FT_2011_day215.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3738, 'AMSRE_36V_AM_FT_2011_day216.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3739, 'AMSRE_36V_AM_FT_2011_day217.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3740, 'AMSRE_36V_AM_FT_2011_day218.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3741, 'AMSRE_36V_AM_FT_2011_day219.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3742, 'AMSRE_36V_AM_FT_2011_day220.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3743, 'AMSRE_36V_AM_FT_2011_day221.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3744, 'AMSRE_36V_AM_FT_2011_day222.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3745, 'AMSRE_36V_AM_FT_2011_day223.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3746, 'AMSRE_36V_AM_FT_2011_day224.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3747, 'AMSRE_36V_AM_FT_2011_day225.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3748, 'AMSRE_36V_AM_FT_2011_day226.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3749, 'AMSRE_36V_AM_FT_2011_day227.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3750, 'AMSRE_36V_AM_FT_2011_day228.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3751, 'AMSRE_36V_AM_FT_2011_day229.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3752, 'AMSRE_36V_AM_FT_2011_day230.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3753, 'AMSRE_36V_AM_FT_2011_day231.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3754, 'AMSRE_36V_AM_FT_2011_day232.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3755, 'AMSRE_36V_AM_FT_2011_day233.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3756, 'AMSRE_36V_AM_FT_2011_day234.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3757, 'AMSRE_36V_AM_FT_2011_day235.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3758, 'AMSRE_36V_AM_FT_2011_day236.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3759, 'AMSRE_36V_AM_FT_2011_day237.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3760, 'AMSRE_36V_AM_FT_2011_day238.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3761, 'AMSRE_36V_AM_FT_2011_day239.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3762, 'AMSRE_36V_AM_FT_2011_day240.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3763, 'AMSRE_36V_AM_FT_2011_day241.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3764, 'AMSRE_36V_AM_FT_2011_day242.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3765, 'AMSRE_36V_AM_FT_2011_day243.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3766, 'AMSRE_36V_AM_FT_2011_day244.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3767, 'AMSRE_36V_AM_FT_2011_day245.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3768, 'AMSRE_36V_AM_FT_2011_day246.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3769, 'AMSRE_36V_AM_FT_2011_day247.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3770, 'AMSRE_36V_AM_FT_2011_day248.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3771, 'AMSRE_36V_AM_FT_2011_day249.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3772, 'AMSRE_36V_AM_FT_2011_day250.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3773, 'AMSRE_36V_AM_FT_2011_day251.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3774, 'AMSRE_36V_AM_FT_2011_day252.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3775, 'AMSRE_36V_AM_FT_2011_day253.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3776, 'AMSRE_36V_AM_FT_2011_day254.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3777, 'AMSRE_36V_AM_FT_2011_day255.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3778, 'AMSRE_36V_AM_FT_2011_day256.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3779, 'AMSRE_36V_AM_FT_2011_day257.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3780, 'AMSRE_36V_AM_FT_2011_day258.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3781, 'AMSRE_36V_AM_FT_2011_day259.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3782, 'AMSRE_36V_AM_FT_2011_day260.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3783, 'AMSRE_36V_AM_FT_2011_day261.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3784, 'AMSRE_36V_AM_FT_2011_day262.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3785, 'AMSRE_36V_AM_FT_2011_day263.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3786, 'AMSRE_36V_AM_FT_2011_day264.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3787, 'AMSRE_36V_AM_FT_2011_day265.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3788, 'AMSRE_36V_AM_FT_2011_day266.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3789, 'AMSRE_36V_AM_FT_2011_day267.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3790, 'AMSRE_36V_AM_FT_2011_day268.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3791, 'AMSRE_36V_AM_FT_2011_day269.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3792, 'AMSRE_36V_AM_FT_2011_day270.h5');
INSERT INTO cs_stringrepcache VALUES (13, 3793, 'amsr-e-l3-dailyland-v06-20020619');
INSERT INTO cs_stringrepcache VALUES (13, 3794, 'amsr-e-l3-dailyland-v06-20020620');
INSERT INTO cs_stringrepcache VALUES (13, 3795, 'amsr-e-l3-dailyland-v06-20020621');
INSERT INTO cs_stringrepcache VALUES (13, 3796, 'amsr-e-l3-dailyland-v06-20020622');
INSERT INTO cs_stringrepcache VALUES (13, 3797, 'amsr-e-l3-dailyland-v06-20020623');
INSERT INTO cs_stringrepcache VALUES (13, 3798, 'amsr-e-l3-dailyland-v06-20020624');
INSERT INTO cs_stringrepcache VALUES (13, 3799, 'amsr-e-l3-dailyland-v06-20020625');
INSERT INTO cs_stringrepcache VALUES (13, 3800, 'amsr-e-l3-dailyland-v06-20020626');
INSERT INTO cs_stringrepcache VALUES (13, 3801, 'amsr-e-l3-dailyland-v06-20020627');
INSERT INTO cs_stringrepcache VALUES (13, 3802, 'amsr-e-l3-dailyland-v06-20020628');
INSERT INTO cs_stringrepcache VALUES (13, 3803, 'amsr-e-l3-dailyland-v06-20020629');
INSERT INTO cs_stringrepcache VALUES (13, 7210, 'Areas harvested, yields, production by NUTS 2 regions');
INSERT INTO cs_stringrepcache VALUES (13, 3804, 'amsr-e-l3-dailyland-v06-20020630');
INSERT INTO cs_stringrepcache VALUES (13, 3805, 'amsr-e-l3-dailyland-v06-20020701');
INSERT INTO cs_stringrepcache VALUES (13, 3806, 'amsr-e-l3-dailyland-v06-20020702');
INSERT INTO cs_stringrepcache VALUES (13, 3807, 'amsr-e-l3-dailyland-v06-20020703');
INSERT INTO cs_stringrepcache VALUES (13, 7211, 'CSI20_Fig01_September2012');
INSERT INTO cs_stringrepcache VALUES (13, 3808, 'amsr-e-l3-dailyland-v06-20020704');
INSERT INTO cs_stringrepcache VALUES (13, 3809, 'amsr-e-l3-dailyland-v06-20020705');
INSERT INTO cs_stringrepcache VALUES (13, 3810, 'amsr-e-l3-dailyland-v06-20020706');
INSERT INTO cs_stringrepcache VALUES (13, 3811, 'amsr-e-l3-dailyland-v06-20020707');
INSERT INTO cs_stringrepcache VALUES (13, 7212, 'CSI20_Fig02_September2012');
INSERT INTO cs_stringrepcache VALUES (13, 3812, 'amsr-e-l3-dailyland-v06-20020708');
INSERT INTO cs_stringrepcache VALUES (13, 3813, 'amsr-e-l3-dailyland-v06-20020709');
INSERT INTO cs_stringrepcache VALUES (13, 3814, 'amsr-e-l3-dailyland-v06-20020710');
INSERT INTO cs_stringrepcache VALUES (13, 3815, 'amsr-e-l3-dailyland-v06-20020711');
INSERT INTO cs_stringrepcache VALUES (13, 7213, 'CSI20_Fig03_September2012');
INSERT INTO cs_stringrepcache VALUES (13, 3816, 'amsr-e-l3-dailyland-v06-20020712');
INSERT INTO cs_stringrepcache VALUES (13, 3817, 'amsr-e-l3-dailyland-v06-20020713');
INSERT INTO cs_stringrepcache VALUES (13, 3818, 'amsr-e-l3-dailyland-v06-20020714');
INSERT INTO cs_stringrepcache VALUES (13, 3819, 'amsr-e-l3-dailyland-v06-20020715');
INSERT INTO cs_stringrepcache VALUES (13, 7214, 'CSI20_Fig04_September2012');
INSERT INTO cs_stringrepcache VALUES (13, 3820, 'amsr-e-l3-dailyland-v06-20020716');
INSERT INTO cs_stringrepcache VALUES (13, 3821, 'amsr-e-l3-dailyland-v06-20020717');
INSERT INTO cs_stringrepcache VALUES (13, 3822, 'amsr-e-l3-dailyland-v06-20020718');
INSERT INTO cs_stringrepcache VALUES (13, 3823, 'amsr-e-l3-dailyland-v06-20020719');
INSERT INTO cs_stringrepcache VALUES (13, 7215, 'CSI20_Fig05_September2012');
INSERT INTO cs_stringrepcache VALUES (13, 3824, 'amsr-e-l3-dailyland-v06-20020720');
INSERT INTO cs_stringrepcache VALUES (13, 3825, 'amsr-e-l3-dailyland-v06-20020721');
INSERT INTO cs_stringrepcache VALUES (13, 3826, 'amsr-e-l3-dailyland-v06-20020722');
INSERT INTO cs_stringrepcache VALUES (13, 3827, 'amsr-e-l3-dailyland-v06-20020723');
INSERT INTO cs_stringrepcache VALUES (13, 7216, 'CSI20_Fig06_September2012');
INSERT INTO cs_stringrepcache VALUES (13, 3828, 'amsr-e-l3-dailyland-v06-20020724');
INSERT INTO cs_stringrepcache VALUES (13, 3829, 'amsr-e-l3-dailyland-v06-20020725');
INSERT INTO cs_stringrepcache VALUES (13, 3830, 'amsr-e-l3-dailyland-v06-20020726');
INSERT INTO cs_stringrepcache VALUES (13, 3831, 'amsr-e-l3-dailyland-v06-20020727');
INSERT INTO cs_stringrepcache VALUES (13, 7217, 'CSI20_Fig07_September2012');
INSERT INTO cs_stringrepcache VALUES (13, 3832, 'amsr-e-l3-dailyland-v06-20020728');
INSERT INTO cs_stringrepcache VALUES (13, 3833, 'amsr-e-l3-dailyland-v06-20020729');
INSERT INTO cs_stringrepcache VALUES (13, 3834, 'amsr-e-l3-dailyland-v06-20020730');
INSERT INTO cs_stringrepcache VALUES (13, 3835, 'amsr-e-l3-dailyland-v06-20020731');
INSERT INTO cs_stringrepcache VALUES (13, 7218, 'CSI021_PO4_2010_msfd_regions');
INSERT INTO cs_stringrepcache VALUES (13, 3836, 'amsr-e-l3-dailyland-v06-20020801');
INSERT INTO cs_stringrepcache VALUES (13, 3837, 'amsr-e-l3-dailyland-v06-20020802');
INSERT INTO cs_stringrepcache VALUES (13, 3838, 'amsr-e-l3-dailyland-v06-20020803');
INSERT INTO cs_stringrepcache VALUES (13, 3839, 'amsr-e-l3-dailyland-v06-20020804');
INSERT INTO cs_stringrepcache VALUES (13, 7219, 'CSI021_Figure03_July2012');
INSERT INTO cs_stringrepcache VALUES (13, 3840, 'amsr-e-l3-dailyland-v06-20020805');
INSERT INTO cs_stringrepcache VALUES (13, 3841, 'amsr-e-l3-dailyland-v06-20020806');
INSERT INTO cs_stringrepcache VALUES (13, 3842, 'amsr-e-l3-dailyland-v06-20020807');
INSERT INTO cs_stringrepcache VALUES (13, 3843, 'amsr-e-l3-dailyland-v06-20020808');
INSERT INTO cs_stringrepcache VALUES (13, 7220, 'EEA-CSI-21 PO4 Assessment 2012 rev_new regions');
INSERT INTO cs_stringrepcache VALUES (13, 3844, 'amsr-e-l3-dailyland-v06-20020809');
INSERT INTO cs_stringrepcache VALUES (13, 3845, 'amsr-e-l3-dailyland-v06-20020810');
INSERT INTO cs_stringrepcache VALUES (13, 3846, 'amsr-e-l3-dailyland-v06-20020811');
INSERT INTO cs_stringrepcache VALUES (13, 3847, 'amsr-e-l3-dailyland-v06-20020812');
INSERT INTO cs_stringrepcache VALUES (13, 7203, 'Land-use on subbasins');
INSERT INTO cs_stringrepcache VALUES (13, 3848, 'amsr-e-l3-dailyland-v06-20020813');
INSERT INTO cs_stringrepcache VALUES (13, 3849, 'amsr-e-l3-dailyland-v06-20020814');
INSERT INTO cs_stringrepcache VALUES (13, 3850, 'amsr-e-l3-dailyland-v06-20020815');
INSERT INTO cs_stringrepcache VALUES (13, 3851, 'amsr-e-l3-dailyland-v06-20020816');
INSERT INTO cs_stringrepcache VALUES (13, 7205, 'Observed discharge');
INSERT INTO cs_stringrepcache VALUES (13, 3852, 'amsr-e-l3-dailyland-v06-20020817');
INSERT INTO cs_stringrepcache VALUES (13, 3853, 'amsr-e-l3-dailyland-v06-20020818');
INSERT INTO cs_stringrepcache VALUES (13, 3854, 'amsr-e-l3-dailyland-v06-20020819');
INSERT INTO cs_stringrepcache VALUES (13, 3855, 'amsr-e-l3-dailyland-v06-20020820');
INSERT INTO cs_stringrepcache VALUES (13, 7202, 'River discharge');
INSERT INTO cs_stringrepcache VALUES (13, 7207, 'Subbasin division');
INSERT INTO cs_stringrepcache VALUES (13, 3856, 'amsr-e-l3-dailyland-v06-20020821');
INSERT INTO cs_stringrepcache VALUES (13, 3857, 'amsr-e-l3-dailyland-v06-20020822');
INSERT INTO cs_stringrepcache VALUES (13, 3858, 'amsr-e-l3-dailyland-v06-20020823');
INSERT INTO cs_stringrepcache VALUES (13, 3859, 'amsr-e-l3-dailyland-v06-20020824');
INSERT INTO cs_stringrepcache VALUES (13, 3860, 'amsr-e-l3-dailyland-v06-20020825');
INSERT INTO cs_stringrepcache VALUES (13, 3861, 'amsr-e-l3-dailyland-v06-20020826');
INSERT INTO cs_stringrepcache VALUES (13, 3862, 'amsr-e-l3-dailyland-v06-20020827');
INSERT INTO cs_stringrepcache VALUES (13, 3863, 'amsr-e-l3-dailyland-v06-20020828');
INSERT INTO cs_stringrepcache VALUES (13, 3864, 'amsr-e-l3-dailyland-v06-20020829');
INSERT INTO cs_stringrepcache VALUES (13, 3865, 'amsr-e-l3-dailyland-v06-20020830');
INSERT INTO cs_stringrepcache VALUES (13, 3866, 'amsr-e-l3-dailyland-v06-20020831');
INSERT INTO cs_stringrepcache VALUES (13, 3867, 'amsr-e-l3-dailyland-v06-20020901');
INSERT INTO cs_stringrepcache VALUES (13, 3868, 'amsr-e-l3-dailyland-v06-20020902');
INSERT INTO cs_stringrepcache VALUES (13, 3869, 'amsr-e-l3-dailyland-v06-20020903');
INSERT INTO cs_stringrepcache VALUES (13, 3870, 'amsr-e-l3-dailyland-v06-20020904');
INSERT INTO cs_stringrepcache VALUES (13, 3871, 'amsr-e-l3-dailyland-v06-20020905');
INSERT INTO cs_stringrepcache VALUES (13, 3872, 'amsr-e-l3-dailyland-v06-20020906');
INSERT INTO cs_stringrepcache VALUES (13, 3873, 'amsr-e-l3-dailyland-v06-20020907');
INSERT INTO cs_stringrepcache VALUES (13, 3874, 'amsr-e-l3-dailyland-v06-20020908');
INSERT INTO cs_stringrepcache VALUES (13, 3875, 'amsr-e-l3-dailyland-v06-20020909');
INSERT INTO cs_stringrepcache VALUES (13, 3876, 'amsr-e-l3-dailyland-v06-20020910');
INSERT INTO cs_stringrepcache VALUES (13, 3877, 'amsr-e-l3-dailyland-v06-20020911');
INSERT INTO cs_stringrepcache VALUES (13, 3878, 'amsr-e-l3-dailyland-v06-20020912');
INSERT INTO cs_stringrepcache VALUES (13, 3879, 'amsr-e-l3-dailyland-v06-20020913');
INSERT INTO cs_stringrepcache VALUES (13, 3880, 'amsr-e-l3-dailyland-v06-20020914');
INSERT INTO cs_stringrepcache VALUES (13, 3881, 'amsr-e-l3-dailyland-v06-20020915');
INSERT INTO cs_stringrepcache VALUES (13, 3882, 'amsr-e-l3-dailyland-v06-20020916');
INSERT INTO cs_stringrepcache VALUES (13, 3883, 'amsr-e-l3-dailyland-v06-20020917');
INSERT INTO cs_stringrepcache VALUES (13, 3884, 'amsr-e-l3-dailyland-v06-20020918');
INSERT INTO cs_stringrepcache VALUES (13, 3885, 'amsr-e-l3-dailyland-v06-20020919');
INSERT INTO cs_stringrepcache VALUES (13, 3886, 'amsr-e-l3-dailyland-v06-20020920');
INSERT INTO cs_stringrepcache VALUES (13, 3887, 'amsr-e-l3-dailyland-v06-20020921');
INSERT INTO cs_stringrepcache VALUES (13, 3888, 'amsr-e-l3-dailyland-v06-20020922');
INSERT INTO cs_stringrepcache VALUES (13, 3889, 'amsr-e-l3-dailyland-v06-20020923');
INSERT INTO cs_stringrepcache VALUES (13, 3890, 'amsr-e-l3-dailyland-v06-20020924');
INSERT INTO cs_stringrepcache VALUES (13, 3891, 'amsr-e-l3-dailyland-v06-20020925');
INSERT INTO cs_stringrepcache VALUES (13, 3892, 'amsr-e-l3-dailyland-v06-20020926');
INSERT INTO cs_stringrepcache VALUES (13, 3893, 'amsr-e-l3-dailyland-v06-20020927');
INSERT INTO cs_stringrepcache VALUES (13, 3894, 'amsr-e-l3-dailyland-v06-20020928');
INSERT INTO cs_stringrepcache VALUES (13, 3895, 'amsr-e-l3-dailyland-v06-20020929');
INSERT INTO cs_stringrepcache VALUES (13, 3896, 'amsr-e-l3-dailyland-v06-20020930');
INSERT INTO cs_stringrepcache VALUES (13, 3897, 'amsr-e-l3-dailyland-v06-20021001');
INSERT INTO cs_stringrepcache VALUES (13, 3898, 'amsr-e-l3-dailyland-v06-20021002');
INSERT INTO cs_stringrepcache VALUES (13, 3899, 'amsr-e-l3-dailyland-v06-20021003');
INSERT INTO cs_stringrepcache VALUES (13, 3900, 'amsr-e-l3-dailyland-v06-20021004');
INSERT INTO cs_stringrepcache VALUES (13, 3901, 'amsr-e-l3-dailyland-v06-20021005');
INSERT INTO cs_stringrepcache VALUES (13, 3902, 'amsr-e-l3-dailyland-v06-20021006');
INSERT INTO cs_stringrepcache VALUES (13, 3903, 'amsr-e-l3-dailyland-v06-20021007');
INSERT INTO cs_stringrepcache VALUES (13, 3904, 'amsr-e-l3-dailyland-v06-20021008');
INSERT INTO cs_stringrepcache VALUES (13, 3905, 'amsr-e-l3-dailyland-v06-20021009');
INSERT INTO cs_stringrepcache VALUES (13, 3906, 'amsr-e-l3-dailyland-v06-20021010');
INSERT INTO cs_stringrepcache VALUES (13, 3907, 'amsr-e-l3-dailyland-v06-20021011');
INSERT INTO cs_stringrepcache VALUES (13, 3908, 'amsr-e-l3-dailyland-v06-20021012');
INSERT INTO cs_stringrepcache VALUES (13, 3909, 'amsr-e-l3-dailyland-v06-20021013');
INSERT INTO cs_stringrepcache VALUES (13, 3910, 'amsr-e-l3-dailyland-v06-20021014');
INSERT INTO cs_stringrepcache VALUES (13, 3911, 'amsr-e-l3-dailyland-v06-20021015');
INSERT INTO cs_stringrepcache VALUES (13, 3912, 'amsr-e-l3-dailyland-v06-20021016');
INSERT INTO cs_stringrepcache VALUES (13, 3913, 'amsr-e-l3-dailyland-v06-20021017');
INSERT INTO cs_stringrepcache VALUES (13, 3914, 'amsr-e-l3-dailyland-v06-20021018');
INSERT INTO cs_stringrepcache VALUES (13, 3915, 'amsr-e-l3-dailyland-v06-20021019');
INSERT INTO cs_stringrepcache VALUES (13, 3916, 'amsr-e-l3-dailyland-v06-20021020');
INSERT INTO cs_stringrepcache VALUES (13, 3917, 'amsr-e-l3-dailyland-v06-20021021');
INSERT INTO cs_stringrepcache VALUES (13, 3918, 'amsr-e-l3-dailyland-v06-20021022');
INSERT INTO cs_stringrepcache VALUES (13, 3919, 'amsr-e-l3-dailyland-v06-20021023');
INSERT INTO cs_stringrepcache VALUES (13, 3920, 'amsr-e-l3-dailyland-v06-20021024');
INSERT INTO cs_stringrepcache VALUES (13, 3921, 'amsr-e-l3-dailyland-v06-20021025');
INSERT INTO cs_stringrepcache VALUES (13, 3922, 'amsr-e-l3-dailyland-v06-20021026');
INSERT INTO cs_stringrepcache VALUES (13, 3923, 'amsr-e-l3-dailyland-v06-20021027');
INSERT INTO cs_stringrepcache VALUES (13, 3924, 'amsr-e-l3-dailyland-v06-20021028');
INSERT INTO cs_stringrepcache VALUES (13, 3925, 'amsr-e-l3-dailyland-v06-20021029');
INSERT INTO cs_stringrepcache VALUES (13, 3926, 'amsr-e-l3-dailyland-v06-20021030');
INSERT INTO cs_stringrepcache VALUES (13, 3927, 'amsr-e-l3-dailyland-v06-20021031');
INSERT INTO cs_stringrepcache VALUES (13, 3928, 'amsr-e-l3-dailyland-v06-20021101');
INSERT INTO cs_stringrepcache VALUES (13, 3929, 'amsr-e-l3-dailyland-v06-20021102');
INSERT INTO cs_stringrepcache VALUES (13, 3930, 'amsr-e-l3-dailyland-v06-20021103');
INSERT INTO cs_stringrepcache VALUES (13, 3931, 'amsr-e-l3-dailyland-v06-20021104');
INSERT INTO cs_stringrepcache VALUES (13, 3932, 'amsr-e-l3-dailyland-v06-20021105');
INSERT INTO cs_stringrepcache VALUES (13, 3933, 'amsr-e-l3-dailyland-v06-20021106');
INSERT INTO cs_stringrepcache VALUES (13, 3934, 'amsr-e-l3-dailyland-v06-20021107');
INSERT INTO cs_stringrepcache VALUES (13, 3935, 'amsr-e-l3-dailyland-v06-20021108');
INSERT INTO cs_stringrepcache VALUES (13, 3936, 'amsr-e-l3-dailyland-v06-20021109');
INSERT INTO cs_stringrepcache VALUES (13, 3937, 'amsr-e-l3-dailyland-v06-20021110');
INSERT INTO cs_stringrepcache VALUES (13, 3938, 'amsr-e-l3-dailyland-v06-20021111');
INSERT INTO cs_stringrepcache VALUES (13, 3939, 'amsr-e-l3-dailyland-v06-20021112');
INSERT INTO cs_stringrepcache VALUES (13, 3940, 'amsr-e-l3-dailyland-v06-20021113');
INSERT INTO cs_stringrepcache VALUES (13, 3941, 'amsr-e-l3-dailyland-v06-20021114');
INSERT INTO cs_stringrepcache VALUES (13, 3942, 'amsr-e-l3-dailyland-v06-20021115');
INSERT INTO cs_stringrepcache VALUES (13, 3943, 'amsr-e-l3-dailyland-v06-20021116');
INSERT INTO cs_stringrepcache VALUES (13, 3944, 'amsr-e-l3-dailyland-v06-20021117');
INSERT INTO cs_stringrepcache VALUES (13, 3945, 'amsr-e-l3-dailyland-v06-20021118');
INSERT INTO cs_stringrepcache VALUES (13, 3946, 'amsr-e-l3-dailyland-v06-20021119');
INSERT INTO cs_stringrepcache VALUES (13, 3947, 'amsr-e-l3-dailyland-v06-20021120');
INSERT INTO cs_stringrepcache VALUES (13, 3948, 'amsr-e-l3-dailyland-v06-20021121');
INSERT INTO cs_stringrepcache VALUES (13, 3949, 'amsr-e-l3-dailyland-v06-20021122');
INSERT INTO cs_stringrepcache VALUES (13, 3950, 'amsr-e-l3-dailyland-v06-20021123');
INSERT INTO cs_stringrepcache VALUES (13, 3951, 'amsr-e-l3-dailyland-v06-20021124');
INSERT INTO cs_stringrepcache VALUES (13, 3952, 'amsr-e-l3-dailyland-v06-20021125');
INSERT INTO cs_stringrepcache VALUES (13, 3953, 'amsr-e-l3-dailyland-v06-20021126');
INSERT INTO cs_stringrepcache VALUES (13, 3954, 'amsr-e-l3-dailyland-v06-20021127');
INSERT INTO cs_stringrepcache VALUES (13, 3955, 'amsr-e-l3-dailyland-v06-20021128');
INSERT INTO cs_stringrepcache VALUES (13, 3956, 'amsr-e-l3-dailyland-v06-20021129');
INSERT INTO cs_stringrepcache VALUES (13, 3957, 'amsr-e-l3-dailyland-v06-20021130');
INSERT INTO cs_stringrepcache VALUES (13, 3958, 'amsr-e-l3-dailyland-v06-20021201');
INSERT INTO cs_stringrepcache VALUES (13, 3959, 'amsr-e-l3-dailyland-v06-20021202');
INSERT INTO cs_stringrepcache VALUES (13, 3960, 'amsr-e-l3-dailyland-v06-20021203');
INSERT INTO cs_stringrepcache VALUES (13, 3961, 'amsr-e-l3-dailyland-v06-20021204');
INSERT INTO cs_stringrepcache VALUES (13, 3962, 'amsr-e-l3-dailyland-v06-20021205');
INSERT INTO cs_stringrepcache VALUES (13, 3963, 'amsr-e-l3-dailyland-v06-20021206');
INSERT INTO cs_stringrepcache VALUES (13, 3964, 'amsr-e-l3-dailyland-v06-20021207');
INSERT INTO cs_stringrepcache VALUES (13, 3965, 'amsr-e-l3-dailyland-v06-20021208');
INSERT INTO cs_stringrepcache VALUES (13, 3966, 'amsr-e-l3-dailyland-v06-20021209');
INSERT INTO cs_stringrepcache VALUES (13, 3967, 'amsr-e-l3-dailyland-v06-20021210');
INSERT INTO cs_stringrepcache VALUES (13, 3968, 'amsr-e-l3-dailyland-v06-20021211');
INSERT INTO cs_stringrepcache VALUES (13, 3969, 'amsr-e-l3-dailyland-v06-20021212');
INSERT INTO cs_stringrepcache VALUES (13, 3970, 'amsr-e-l3-dailyland-v06-20021213');
INSERT INTO cs_stringrepcache VALUES (13, 3971, 'amsr-e-l3-dailyland-v06-20021214');
INSERT INTO cs_stringrepcache VALUES (13, 3972, 'amsr-e-l3-dailyland-v06-20021215');
INSERT INTO cs_stringrepcache VALUES (13, 3973, 'amsr-e-l3-dailyland-v06-20021216');
INSERT INTO cs_stringrepcache VALUES (13, 3974, 'amsr-e-l3-dailyland-v06-20021217');
INSERT INTO cs_stringrepcache VALUES (13, 3975, 'amsr-e-l3-dailyland-v06-20021218');
INSERT INTO cs_stringrepcache VALUES (13, 3976, 'amsr-e-l3-dailyland-v06-20021219');
INSERT INTO cs_stringrepcache VALUES (13, 3977, 'amsr-e-l3-dailyland-v06-20021220');
INSERT INTO cs_stringrepcache VALUES (13, 3978, 'amsr-e-l3-dailyland-v06-20021221');
INSERT INTO cs_stringrepcache VALUES (13, 3979, 'amsr-e-l3-dailyland-v06-20021222');
INSERT INTO cs_stringrepcache VALUES (13, 3980, 'amsr-e-l3-dailyland-v06-20021223');
INSERT INTO cs_stringrepcache VALUES (13, 3981, 'amsr-e-l3-dailyland-v06-20021224');
INSERT INTO cs_stringrepcache VALUES (13, 3982, 'amsr-e-l3-dailyland-v06-20021225');
INSERT INTO cs_stringrepcache VALUES (13, 3983, 'amsr-e-l3-dailyland-v06-20021226');
INSERT INTO cs_stringrepcache VALUES (13, 3984, 'amsr-e-l3-dailyland-v06-20021227');
INSERT INTO cs_stringrepcache VALUES (13, 3985, 'amsr-e-l3-dailyland-v06-20021228');
INSERT INTO cs_stringrepcache VALUES (13, 3986, 'amsr-e-l3-dailyland-v06-20021229');
INSERT INTO cs_stringrepcache VALUES (13, 3987, 'amsr-e-l3-dailyland-v06-20021230');
INSERT INTO cs_stringrepcache VALUES (13, 3988, 'amsr-e-l3-dailyland-v06-20021231');
INSERT INTO cs_stringrepcache VALUES (13, 3989, 'amsr-e-l3-dailyland-v06-20030101');
INSERT INTO cs_stringrepcache VALUES (13, 3990, 'amsr-e-l3-dailyland-v06-20030102');
INSERT INTO cs_stringrepcache VALUES (13, 3991, 'amsr-e-l3-dailyland-v06-20030103');
INSERT INTO cs_stringrepcache VALUES (13, 3992, 'amsr-e-l3-dailyland-v06-20030104');
INSERT INTO cs_stringrepcache VALUES (13, 3993, 'amsr-e-l3-dailyland-v06-20030105');
INSERT INTO cs_stringrepcache VALUES (13, 3994, 'amsr-e-l3-dailyland-v06-20030106');
INSERT INTO cs_stringrepcache VALUES (13, 3995, 'amsr-e-l3-dailyland-v06-20030107');
INSERT INTO cs_stringrepcache VALUES (13, 3996, 'amsr-e-l3-dailyland-v06-20030108');
INSERT INTO cs_stringrepcache VALUES (13, 3997, 'amsr-e-l3-dailyland-v06-20030109');
INSERT INTO cs_stringrepcache VALUES (13, 3998, 'amsr-e-l3-dailyland-v06-20030110');
INSERT INTO cs_stringrepcache VALUES (13, 3999, 'amsr-e-l3-dailyland-v06-20030111');
INSERT INTO cs_stringrepcache VALUES (13, 4000, 'amsr-e-l3-dailyland-v06-20030112');
INSERT INTO cs_stringrepcache VALUES (13, 4001, 'amsr-e-l3-dailyland-v06-20030113');
INSERT INTO cs_stringrepcache VALUES (13, 4002, 'amsr-e-l3-dailyland-v06-20030114');
INSERT INTO cs_stringrepcache VALUES (13, 4003, 'amsr-e-l3-dailyland-v06-20030115');
INSERT INTO cs_stringrepcache VALUES (13, 4004, 'amsr-e-l3-dailyland-v06-20030116');
INSERT INTO cs_stringrepcache VALUES (13, 4005, 'amsr-e-l3-dailyland-v06-20030117');
INSERT INTO cs_stringrepcache VALUES (13, 4006, 'amsr-e-l3-dailyland-v06-20030118');
INSERT INTO cs_stringrepcache VALUES (13, 4007, 'amsr-e-l3-dailyland-v06-20030119');
INSERT INTO cs_stringrepcache VALUES (13, 4008, 'amsr-e-l3-dailyland-v06-20030120');
INSERT INTO cs_stringrepcache VALUES (13, 4009, 'amsr-e-l3-dailyland-v06-20030121');
INSERT INTO cs_stringrepcache VALUES (13, 4010, 'amsr-e-l3-dailyland-v06-20030122');
INSERT INTO cs_stringrepcache VALUES (13, 4011, 'amsr-e-l3-dailyland-v06-20030123');
INSERT INTO cs_stringrepcache VALUES (13, 4012, 'amsr-e-l3-dailyland-v06-20030124');
INSERT INTO cs_stringrepcache VALUES (13, 4013, 'amsr-e-l3-dailyland-v06-20030125');
INSERT INTO cs_stringrepcache VALUES (13, 4014, 'amsr-e-l3-dailyland-v06-20030126');
INSERT INTO cs_stringrepcache VALUES (13, 4015, 'amsr-e-l3-dailyland-v06-20030127');
INSERT INTO cs_stringrepcache VALUES (13, 4016, 'amsr-e-l3-dailyland-v06-20030128');
INSERT INTO cs_stringrepcache VALUES (13, 4017, 'amsr-e-l3-dailyland-v06-20030129');
INSERT INTO cs_stringrepcache VALUES (13, 4018, 'amsr-e-l3-dailyland-v06-20030130');
INSERT INTO cs_stringrepcache VALUES (13, 4019, 'amsr-e-l3-dailyland-v06-20030131');
INSERT INTO cs_stringrepcache VALUES (13, 4020, 'amsr-e-l3-dailyland-v06-20030201');
INSERT INTO cs_stringrepcache VALUES (13, 4021, 'amsr-e-l3-dailyland-v06-20030202');
INSERT INTO cs_stringrepcache VALUES (13, 4022, 'amsr-e-l3-dailyland-v06-20030203');
INSERT INTO cs_stringrepcache VALUES (13, 4023, 'amsr-e-l3-dailyland-v06-20030204');
INSERT INTO cs_stringrepcache VALUES (13, 4024, 'amsr-e-l3-dailyland-v06-20030205');
INSERT INTO cs_stringrepcache VALUES (13, 4025, 'amsr-e-l3-dailyland-v06-20030206');
INSERT INTO cs_stringrepcache VALUES (13, 4026, 'amsr-e-l3-dailyland-v06-20030207');
INSERT INTO cs_stringrepcache VALUES (13, 4027, 'amsr-e-l3-dailyland-v06-20030208');
INSERT INTO cs_stringrepcache VALUES (13, 4028, 'amsr-e-l3-dailyland-v06-20030209');
INSERT INTO cs_stringrepcache VALUES (13, 4029, 'amsr-e-l3-dailyland-v06-20030210');
INSERT INTO cs_stringrepcache VALUES (13, 4030, 'amsr-e-l3-dailyland-v06-20030211');
INSERT INTO cs_stringrepcache VALUES (13, 4031, 'amsr-e-l3-dailyland-v06-20030212');
INSERT INTO cs_stringrepcache VALUES (13, 4032, 'amsr-e-l3-dailyland-v06-20030213');
INSERT INTO cs_stringrepcache VALUES (13, 4033, 'amsr-e-l3-dailyland-v06-20030214');
INSERT INTO cs_stringrepcache VALUES (13, 4034, 'amsr-e-l3-dailyland-v06-20030215');
INSERT INTO cs_stringrepcache VALUES (13, 4035, 'amsr-e-l3-dailyland-v06-20030216');
INSERT INTO cs_stringrepcache VALUES (13, 4036, 'amsr-e-l3-dailyland-v06-20030217');
INSERT INTO cs_stringrepcache VALUES (13, 4037, 'amsr-e-l3-dailyland-v06-20030218');
INSERT INTO cs_stringrepcache VALUES (13, 4038, 'amsr-e-l3-dailyland-v06-20030219');
INSERT INTO cs_stringrepcache VALUES (13, 4039, 'amsr-e-l3-dailyland-v06-20030220');
INSERT INTO cs_stringrepcache VALUES (13, 4040, 'amsr-e-l3-dailyland-v06-20030221');
INSERT INTO cs_stringrepcache VALUES (13, 4041, 'amsr-e-l3-dailyland-v06-20030222');
INSERT INTO cs_stringrepcache VALUES (13, 4042, 'amsr-e-l3-dailyland-v06-20030223');
INSERT INTO cs_stringrepcache VALUES (13, 4043, 'amsr-e-l3-dailyland-v06-20030224');
INSERT INTO cs_stringrepcache VALUES (13, 4044, 'amsr-e-l3-dailyland-v06-20030225');
INSERT INTO cs_stringrepcache VALUES (13, 4045, 'amsr-e-l3-dailyland-v06-20030226');
INSERT INTO cs_stringrepcache VALUES (13, 4046, 'amsr-e-l3-dailyland-v06-20030227');
INSERT INTO cs_stringrepcache VALUES (13, 4047, 'amsr-e-l3-dailyland-v06-20030228');
INSERT INTO cs_stringrepcache VALUES (13, 4048, 'amsr-e-l3-dailyland-v06-20030301');
INSERT INTO cs_stringrepcache VALUES (13, 4049, 'amsr-e-l3-dailyland-v06-20030302');
INSERT INTO cs_stringrepcache VALUES (13, 4050, 'amsr-e-l3-dailyland-v06-20030303');
INSERT INTO cs_stringrepcache VALUES (13, 4051, 'amsr-e-l3-dailyland-v06-20030304');
INSERT INTO cs_stringrepcache VALUES (13, 4052, 'amsr-e-l3-dailyland-v06-20030305');
INSERT INTO cs_stringrepcache VALUES (13, 4053, 'amsr-e-l3-dailyland-v06-20030306');
INSERT INTO cs_stringrepcache VALUES (13, 4054, 'amsr-e-l3-dailyland-v06-20030307');
INSERT INTO cs_stringrepcache VALUES (13, 4055, 'amsr-e-l3-dailyland-v06-20030308');
INSERT INTO cs_stringrepcache VALUES (13, 4056, 'amsr-e-l3-dailyland-v06-20030309');
INSERT INTO cs_stringrepcache VALUES (13, 4057, 'amsr-e-l3-dailyland-v06-20030310');
INSERT INTO cs_stringrepcache VALUES (13, 4058, 'amsr-e-l3-dailyland-v06-20030311');
INSERT INTO cs_stringrepcache VALUES (13, 4059, 'amsr-e-l3-dailyland-v06-20030312');
INSERT INTO cs_stringrepcache VALUES (13, 4060, 'amsr-e-l3-dailyland-v06-20030313');
INSERT INTO cs_stringrepcache VALUES (13, 4061, 'amsr-e-l3-dailyland-v06-20030314');
INSERT INTO cs_stringrepcache VALUES (13, 4062, 'amsr-e-l3-dailyland-v06-20030315');
INSERT INTO cs_stringrepcache VALUES (13, 4063, 'amsr-e-l3-dailyland-v06-20030316');
INSERT INTO cs_stringrepcache VALUES (13, 4064, 'amsr-e-l3-dailyland-v06-20030317');
INSERT INTO cs_stringrepcache VALUES (13, 4065, 'amsr-e-l3-dailyland-v06-20030318');
INSERT INTO cs_stringrepcache VALUES (13, 4066, 'amsr-e-l3-dailyland-v06-20030319');
INSERT INTO cs_stringrepcache VALUES (13, 4067, 'amsr-e-l3-dailyland-v06-20030320');
INSERT INTO cs_stringrepcache VALUES (13, 4068, 'amsr-e-l3-dailyland-v06-20030321');
INSERT INTO cs_stringrepcache VALUES (13, 4069, 'amsr-e-l3-dailyland-v06-20030322');
INSERT INTO cs_stringrepcache VALUES (13, 4070, 'amsr-e-l3-dailyland-v06-20030323');
INSERT INTO cs_stringrepcache VALUES (13, 4071, 'amsr-e-l3-dailyland-v06-20030324');
INSERT INTO cs_stringrepcache VALUES (13, 4072, 'amsr-e-l3-dailyland-v06-20030325');
INSERT INTO cs_stringrepcache VALUES (13, 4073, 'amsr-e-l3-dailyland-v06-20030326');
INSERT INTO cs_stringrepcache VALUES (13, 4074, 'amsr-e-l3-dailyland-v06-20030327');
INSERT INTO cs_stringrepcache VALUES (13, 4075, 'amsr-e-l3-dailyland-v06-20030328');
INSERT INTO cs_stringrepcache VALUES (13, 4076, 'amsr-e-l3-dailyland-v06-20030329');
INSERT INTO cs_stringrepcache VALUES (13, 4077, 'amsr-e-l3-dailyland-v06-20030330');
INSERT INTO cs_stringrepcache VALUES (13, 4078, 'amsr-e-l3-dailyland-v06-20030331');
INSERT INTO cs_stringrepcache VALUES (13, 4079, 'amsr-e-l3-dailyland-v06-20030401');
INSERT INTO cs_stringrepcache VALUES (13, 4080, 'amsr-e-l3-dailyland-v06-20030402');
INSERT INTO cs_stringrepcache VALUES (13, 4081, 'amsr-e-l3-dailyland-v06-20030403');
INSERT INTO cs_stringrepcache VALUES (13, 4082, 'amsr-e-l3-dailyland-v06-20030404');
INSERT INTO cs_stringrepcache VALUES (13, 4083, 'amsr-e-l3-dailyland-v06-20030405');
INSERT INTO cs_stringrepcache VALUES (13, 4084, 'amsr-e-l3-dailyland-v06-20030406');
INSERT INTO cs_stringrepcache VALUES (13, 4085, 'amsr-e-l3-dailyland-v06-20030407');
INSERT INTO cs_stringrepcache VALUES (13, 4086, 'amsr-e-l3-dailyland-v06-20030408');
INSERT INTO cs_stringrepcache VALUES (13, 4087, 'amsr-e-l3-dailyland-v06-20030409');
INSERT INTO cs_stringrepcache VALUES (13, 4088, 'amsr-e-l3-dailyland-v06-20030410');
INSERT INTO cs_stringrepcache VALUES (13, 4089, 'amsr-e-l3-dailyland-v06-20030411');
INSERT INTO cs_stringrepcache VALUES (13, 4090, 'amsr-e-l3-dailyland-v06-20030412');
INSERT INTO cs_stringrepcache VALUES (13, 4091, 'amsr-e-l3-dailyland-v06-20030413');
INSERT INTO cs_stringrepcache VALUES (13, 4092, 'amsr-e-l3-dailyland-v06-20030414');
INSERT INTO cs_stringrepcache VALUES (13, 4093, 'amsr-e-l3-dailyland-v06-20030415');
INSERT INTO cs_stringrepcache VALUES (13, 4094, 'amsr-e-l3-dailyland-v06-20030416');
INSERT INTO cs_stringrepcache VALUES (13, 4095, 'amsr-e-l3-dailyland-v06-20030417');
INSERT INTO cs_stringrepcache VALUES (13, 4096, 'amsr-e-l3-dailyland-v06-20030418');
INSERT INTO cs_stringrepcache VALUES (13, 4097, 'amsr-e-l3-dailyland-v06-20030419');
INSERT INTO cs_stringrepcache VALUES (13, 4098, 'amsr-e-l3-dailyland-v06-20030420');
INSERT INTO cs_stringrepcache VALUES (13, 4099, 'amsr-e-l3-dailyland-v06-20030421');
INSERT INTO cs_stringrepcache VALUES (13, 4100, 'amsr-e-l3-dailyland-v06-20030422');
INSERT INTO cs_stringrepcache VALUES (13, 4101, 'amsr-e-l3-dailyland-v06-20030423');
INSERT INTO cs_stringrepcache VALUES (13, 4102, 'amsr-e-l3-dailyland-v06-20030424');
INSERT INTO cs_stringrepcache VALUES (13, 4103, 'amsr-e-l3-dailyland-v06-20030425');
INSERT INTO cs_stringrepcache VALUES (13, 4104, 'amsr-e-l3-dailyland-v06-20030426');
INSERT INTO cs_stringrepcache VALUES (13, 4105, 'amsr-e-l3-dailyland-v06-20030427');
INSERT INTO cs_stringrepcache VALUES (13, 4106, 'amsr-e-l3-dailyland-v06-20030428');
INSERT INTO cs_stringrepcache VALUES (13, 4107, 'amsr-e-l3-dailyland-v06-20030429');
INSERT INTO cs_stringrepcache VALUES (13, 4108, 'amsr-e-l3-dailyland-v06-20030430');
INSERT INTO cs_stringrepcache VALUES (13, 4109, 'amsr-e-l3-dailyland-v06-20030501');
INSERT INTO cs_stringrepcache VALUES (13, 4110, 'amsr-e-l3-dailyland-v06-20030502');
INSERT INTO cs_stringrepcache VALUES (13, 4111, 'amsr-e-l3-dailyland-v06-20030503');
INSERT INTO cs_stringrepcache VALUES (13, 4112, 'amsr-e-l3-dailyland-v06-20030504');
INSERT INTO cs_stringrepcache VALUES (13, 4113, 'amsr-e-l3-dailyland-v06-20030505');
INSERT INTO cs_stringrepcache VALUES (13, 4114, 'amsr-e-l3-dailyland-v06-20030506');
INSERT INTO cs_stringrepcache VALUES (13, 4115, 'amsr-e-l3-dailyland-v06-20030507');
INSERT INTO cs_stringrepcache VALUES (13, 4116, 'amsr-e-l3-dailyland-v06-20030508');
INSERT INTO cs_stringrepcache VALUES (13, 4117, 'amsr-e-l3-dailyland-v06-20030509');
INSERT INTO cs_stringrepcache VALUES (13, 4118, 'amsr-e-l3-dailyland-v06-20030510');
INSERT INTO cs_stringrepcache VALUES (13, 4119, 'amsr-e-l3-dailyland-v06-20030511');
INSERT INTO cs_stringrepcache VALUES (13, 4120, 'amsr-e-l3-dailyland-v06-20030512');
INSERT INTO cs_stringrepcache VALUES (13, 4121, 'amsr-e-l3-dailyland-v06-20030513');
INSERT INTO cs_stringrepcache VALUES (13, 4122, 'amsr-e-l3-dailyland-v06-20030514');
INSERT INTO cs_stringrepcache VALUES (13, 4123, 'amsr-e-l3-dailyland-v06-20030515');
INSERT INTO cs_stringrepcache VALUES (13, 4124, 'amsr-e-l3-dailyland-v06-20030516');
INSERT INTO cs_stringrepcache VALUES (13, 4125, 'amsr-e-l3-dailyland-v06-20030517');
INSERT INTO cs_stringrepcache VALUES (13, 4126, 'amsr-e-l3-dailyland-v06-20030518');
INSERT INTO cs_stringrepcache VALUES (13, 4127, 'amsr-e-l3-dailyland-v06-20030519');
INSERT INTO cs_stringrepcache VALUES (13, 4128, 'amsr-e-l3-dailyland-v06-20030520');
INSERT INTO cs_stringrepcache VALUES (13, 4129, 'amsr-e-l3-dailyland-v06-20030521');
INSERT INTO cs_stringrepcache VALUES (13, 4130, 'amsr-e-l3-dailyland-v06-20030522');
INSERT INTO cs_stringrepcache VALUES (13, 4131, 'amsr-e-l3-dailyland-v06-20030523');
INSERT INTO cs_stringrepcache VALUES (13, 4132, 'amsr-e-l3-dailyland-v06-20030524');
INSERT INTO cs_stringrepcache VALUES (13, 4133, 'amsr-e-l3-dailyland-v06-20030525');
INSERT INTO cs_stringrepcache VALUES (13, 4134, 'amsr-e-l3-dailyland-v06-20030526');
INSERT INTO cs_stringrepcache VALUES (13, 4135, 'amsr-e-l3-dailyland-v06-20030527');
INSERT INTO cs_stringrepcache VALUES (13, 4136, 'amsr-e-l3-dailyland-v06-20030528');
INSERT INTO cs_stringrepcache VALUES (13, 4137, 'amsr-e-l3-dailyland-v06-20030529');
INSERT INTO cs_stringrepcache VALUES (13, 4138, 'amsr-e-l3-dailyland-v06-20030530');
INSERT INTO cs_stringrepcache VALUES (13, 4139, 'amsr-e-l3-dailyland-v06-20030531');
INSERT INTO cs_stringrepcache VALUES (13, 4140, 'amsr-e-l3-dailyland-v06-20030601');
INSERT INTO cs_stringrepcache VALUES (13, 4141, 'amsr-e-l3-dailyland-v06-20030602');
INSERT INTO cs_stringrepcache VALUES (13, 4142, 'amsr-e-l3-dailyland-v06-20030603');
INSERT INTO cs_stringrepcache VALUES (13, 4143, 'amsr-e-l3-dailyland-v06-20030604');
INSERT INTO cs_stringrepcache VALUES (13, 4144, 'amsr-e-l3-dailyland-v06-20030605');
INSERT INTO cs_stringrepcache VALUES (13, 4145, 'amsr-e-l3-dailyland-v06-20030606');
INSERT INTO cs_stringrepcache VALUES (13, 4146, 'amsr-e-l3-dailyland-v06-20030607');
INSERT INTO cs_stringrepcache VALUES (13, 4147, 'amsr-e-l3-dailyland-v06-20030608');
INSERT INTO cs_stringrepcache VALUES (13, 4148, 'amsr-e-l3-dailyland-v06-20030609');
INSERT INTO cs_stringrepcache VALUES (13, 4149, 'amsr-e-l3-dailyland-v06-20030610');
INSERT INTO cs_stringrepcache VALUES (13, 4150, 'amsr-e-l3-dailyland-v06-20030611');
INSERT INTO cs_stringrepcache VALUES (13, 4151, 'amsr-e-l3-dailyland-v06-20030612');
INSERT INTO cs_stringrepcache VALUES (13, 4152, 'amsr-e-l3-dailyland-v06-20030613');
INSERT INTO cs_stringrepcache VALUES (13, 4153, 'amsr-e-l3-dailyland-v06-20030614');
INSERT INTO cs_stringrepcache VALUES (13, 4154, 'amsr-e-l3-dailyland-v06-20030615');
INSERT INTO cs_stringrepcache VALUES (13, 4155, 'amsr-e-l3-dailyland-v06-20030616');
INSERT INTO cs_stringrepcache VALUES (13, 4156, 'amsr-e-l3-dailyland-v06-20030617');
INSERT INTO cs_stringrepcache VALUES (13, 4157, 'amsr-e-l3-dailyland-v06-20030618');
INSERT INTO cs_stringrepcache VALUES (13, 4158, 'amsr-e-l3-dailyland-v06-20030619');
INSERT INTO cs_stringrepcache VALUES (13, 4159, 'amsr-e-l3-dailyland-v06-20030620');
INSERT INTO cs_stringrepcache VALUES (13, 4160, 'amsr-e-l3-dailyland-v06-20030621');
INSERT INTO cs_stringrepcache VALUES (13, 4161, 'amsr-e-l3-dailyland-v06-20030622');
INSERT INTO cs_stringrepcache VALUES (13, 4162, 'amsr-e-l3-dailyland-v06-20030623');
INSERT INTO cs_stringrepcache VALUES (13, 4163, 'amsr-e-l3-dailyland-v06-20030624');
INSERT INTO cs_stringrepcache VALUES (13, 4164, 'amsr-e-l3-dailyland-v06-20030625');
INSERT INTO cs_stringrepcache VALUES (13, 4165, 'amsr-e-l3-dailyland-v06-20030626');
INSERT INTO cs_stringrepcache VALUES (13, 4166, 'amsr-e-l3-dailyland-v06-20030627');
INSERT INTO cs_stringrepcache VALUES (13, 4167, 'amsr-e-l3-dailyland-v06-20030628');
INSERT INTO cs_stringrepcache VALUES (13, 4168, 'amsr-e-l3-dailyland-v06-20030629');
INSERT INTO cs_stringrepcache VALUES (13, 4169, 'amsr-e-l3-dailyland-v06-20030630');
INSERT INTO cs_stringrepcache VALUES (13, 4170, 'amsr-e-l3-dailyland-v06-20030701');
INSERT INTO cs_stringrepcache VALUES (13, 4171, 'amsr-e-l3-dailyland-v06-20030702');
INSERT INTO cs_stringrepcache VALUES (13, 4172, 'amsr-e-l3-dailyland-v06-20030703');
INSERT INTO cs_stringrepcache VALUES (13, 4173, 'amsr-e-l3-dailyland-v06-20030704');
INSERT INTO cs_stringrepcache VALUES (13, 4174, 'amsr-e-l3-dailyland-v06-20030705');
INSERT INTO cs_stringrepcache VALUES (13, 4175, 'amsr-e-l3-dailyland-v06-20030706');
INSERT INTO cs_stringrepcache VALUES (13, 4176, 'amsr-e-l3-dailyland-v06-20030707');
INSERT INTO cs_stringrepcache VALUES (13, 4177, 'amsr-e-l3-dailyland-v06-20030708');
INSERT INTO cs_stringrepcache VALUES (13, 4178, 'amsr-e-l3-dailyland-v06-20030709');
INSERT INTO cs_stringrepcache VALUES (13, 4179, 'amsr-e-l3-dailyland-v06-20030710');
INSERT INTO cs_stringrepcache VALUES (13, 4180, 'amsr-e-l3-dailyland-v06-20030711');
INSERT INTO cs_stringrepcache VALUES (13, 4181, 'amsr-e-l3-dailyland-v06-20030712');
INSERT INTO cs_stringrepcache VALUES (13, 4182, 'amsr-e-l3-dailyland-v06-20030713');
INSERT INTO cs_stringrepcache VALUES (13, 4183, 'amsr-e-l3-dailyland-v06-20030714');
INSERT INTO cs_stringrepcache VALUES (13, 4184, 'amsr-e-l3-dailyland-v06-20030715');
INSERT INTO cs_stringrepcache VALUES (13, 4185, 'amsr-e-l3-dailyland-v06-20030716');
INSERT INTO cs_stringrepcache VALUES (13, 4186, 'amsr-e-l3-dailyland-v06-20030717');
INSERT INTO cs_stringrepcache VALUES (13, 4187, 'amsr-e-l3-dailyland-v06-20030718');
INSERT INTO cs_stringrepcache VALUES (13, 4188, 'amsr-e-l3-dailyland-v06-20030719');
INSERT INTO cs_stringrepcache VALUES (13, 4189, 'amsr-e-l3-dailyland-v06-20030720');
INSERT INTO cs_stringrepcache VALUES (13, 4190, 'amsr-e-l3-dailyland-v06-20030721');
INSERT INTO cs_stringrepcache VALUES (13, 4191, 'amsr-e-l3-dailyland-v06-20030722');
INSERT INTO cs_stringrepcache VALUES (13, 4192, 'amsr-e-l3-dailyland-v06-20030723');
INSERT INTO cs_stringrepcache VALUES (13, 4193, 'amsr-e-l3-dailyland-v06-20030724');
INSERT INTO cs_stringrepcache VALUES (13, 4194, 'amsr-e-l3-dailyland-v06-20030725');
INSERT INTO cs_stringrepcache VALUES (13, 4195, 'amsr-e-l3-dailyland-v06-20030726');
INSERT INTO cs_stringrepcache VALUES (13, 4196, 'amsr-e-l3-dailyland-v06-20030727');
INSERT INTO cs_stringrepcache VALUES (13, 4197, 'amsr-e-l3-dailyland-v06-20030728');
INSERT INTO cs_stringrepcache VALUES (13, 4198, 'amsr-e-l3-dailyland-v06-20030729');
INSERT INTO cs_stringrepcache VALUES (13, 4199, 'amsr-e-l3-dailyland-v06-20030730');
INSERT INTO cs_stringrepcache VALUES (13, 4200, 'amsr-e-l3-dailyland-v06-20030731');
INSERT INTO cs_stringrepcache VALUES (13, 4201, 'amsr-e-l3-dailyland-v06-20030801');
INSERT INTO cs_stringrepcache VALUES (13, 4202, 'amsr-e-l3-dailyland-v06-20030802');
INSERT INTO cs_stringrepcache VALUES (13, 4203, 'amsr-e-l3-dailyland-v06-20030803');
INSERT INTO cs_stringrepcache VALUES (13, 4204, 'amsr-e-l3-dailyland-v06-20030804');
INSERT INTO cs_stringrepcache VALUES (13, 4205, 'amsr-e-l3-dailyland-v06-20030805');
INSERT INTO cs_stringrepcache VALUES (13, 4206, 'amsr-e-l3-dailyland-v06-20030806');
INSERT INTO cs_stringrepcache VALUES (13, 4207, 'amsr-e-l3-dailyland-v06-20030807');
INSERT INTO cs_stringrepcache VALUES (13, 4208, 'amsr-e-l3-dailyland-v06-20030808');
INSERT INTO cs_stringrepcache VALUES (13, 4209, 'amsr-e-l3-dailyland-v06-20030809');
INSERT INTO cs_stringrepcache VALUES (13, 4210, 'amsr-e-l3-dailyland-v06-20030810');
INSERT INTO cs_stringrepcache VALUES (13, 4211, 'amsr-e-l3-dailyland-v06-20030811');
INSERT INTO cs_stringrepcache VALUES (13, 4212, 'amsr-e-l3-dailyland-v06-20030812');
INSERT INTO cs_stringrepcache VALUES (13, 4213, 'amsr-e-l3-dailyland-v06-20030813');
INSERT INTO cs_stringrepcache VALUES (13, 4214, 'amsr-e-l3-dailyland-v06-20030814');
INSERT INTO cs_stringrepcache VALUES (13, 4215, 'amsr-e-l3-dailyland-v06-20030815');
INSERT INTO cs_stringrepcache VALUES (13, 4216, 'amsr-e-l3-dailyland-v06-20030816');
INSERT INTO cs_stringrepcache VALUES (13, 4217, 'amsr-e-l3-dailyland-v06-20030817');
INSERT INTO cs_stringrepcache VALUES (13, 4218, 'amsr-e-l3-dailyland-v06-20030818');
INSERT INTO cs_stringrepcache VALUES (13, 4219, 'amsr-e-l3-dailyland-v06-20030819');
INSERT INTO cs_stringrepcache VALUES (13, 4220, 'amsr-e-l3-dailyland-v06-20030820');
INSERT INTO cs_stringrepcache VALUES (13, 4221, 'amsr-e-l3-dailyland-v06-20030821');
INSERT INTO cs_stringrepcache VALUES (13, 4222, 'amsr-e-l3-dailyland-v06-20030822');
INSERT INTO cs_stringrepcache VALUES (13, 4223, 'amsr-e-l3-dailyland-v06-20030823');
INSERT INTO cs_stringrepcache VALUES (13, 4224, 'amsr-e-l3-dailyland-v06-20030824');
INSERT INTO cs_stringrepcache VALUES (13, 4225, 'amsr-e-l3-dailyland-v06-20030825');
INSERT INTO cs_stringrepcache VALUES (13, 4226, 'amsr-e-l3-dailyland-v06-20030826');
INSERT INTO cs_stringrepcache VALUES (13, 4227, 'amsr-e-l3-dailyland-v06-20030827');
INSERT INTO cs_stringrepcache VALUES (13, 4228, 'amsr-e-l3-dailyland-v06-20030828');
INSERT INTO cs_stringrepcache VALUES (13, 4229, 'amsr-e-l3-dailyland-v06-20030829');
INSERT INTO cs_stringrepcache VALUES (13, 4230, 'amsr-e-l3-dailyland-v06-20030830');
INSERT INTO cs_stringrepcache VALUES (13, 4231, 'amsr-e-l3-dailyland-v06-20030831');
INSERT INTO cs_stringrepcache VALUES (13, 4232, 'amsr-e-l3-dailyland-v06-20030901');
INSERT INTO cs_stringrepcache VALUES (13, 4233, 'amsr-e-l3-dailyland-v06-20030902');
INSERT INTO cs_stringrepcache VALUES (13, 4234, 'amsr-e-l3-dailyland-v06-20030903');
INSERT INTO cs_stringrepcache VALUES (13, 4235, 'amsr-e-l3-dailyland-v06-20030904');
INSERT INTO cs_stringrepcache VALUES (13, 4236, 'amsr-e-l3-dailyland-v06-20030905');
INSERT INTO cs_stringrepcache VALUES (13, 4237, 'amsr-e-l3-dailyland-v06-20030906');
INSERT INTO cs_stringrepcache VALUES (13, 4238, 'amsr-e-l3-dailyland-v06-20030907');
INSERT INTO cs_stringrepcache VALUES (13, 4239, 'amsr-e-l3-dailyland-v06-20030908');
INSERT INTO cs_stringrepcache VALUES (13, 4240, 'amsr-e-l3-dailyland-v06-20030909');
INSERT INTO cs_stringrepcache VALUES (13, 4241, 'amsr-e-l3-dailyland-v06-20030910');
INSERT INTO cs_stringrepcache VALUES (13, 4242, 'amsr-e-l3-dailyland-v06-20030911');
INSERT INTO cs_stringrepcache VALUES (13, 4243, 'amsr-e-l3-dailyland-v06-20030912');
INSERT INTO cs_stringrepcache VALUES (13, 4244, 'amsr-e-l3-dailyland-v06-20030913');
INSERT INTO cs_stringrepcache VALUES (13, 4245, 'amsr-e-l3-dailyland-v06-20030914');
INSERT INTO cs_stringrepcache VALUES (13, 4246, 'amsr-e-l3-dailyland-v06-20030915');
INSERT INTO cs_stringrepcache VALUES (13, 4247, 'amsr-e-l3-dailyland-v06-20030916');
INSERT INTO cs_stringrepcache VALUES (13, 4248, 'amsr-e-l3-dailyland-v06-20030917');
INSERT INTO cs_stringrepcache VALUES (13, 4249, 'amsr-e-l3-dailyland-v06-20030918');
INSERT INTO cs_stringrepcache VALUES (13, 4250, 'amsr-e-l3-dailyland-v06-20030919');
INSERT INTO cs_stringrepcache VALUES (13, 4251, 'amsr-e-l3-dailyland-v06-20030920');
INSERT INTO cs_stringrepcache VALUES (13, 4252, 'amsr-e-l3-dailyland-v06-20030921');
INSERT INTO cs_stringrepcache VALUES (13, 4253, 'amsr-e-l3-dailyland-v06-20030922');
INSERT INTO cs_stringrepcache VALUES (13, 4254, 'amsr-e-l3-dailyland-v06-20030923');
INSERT INTO cs_stringrepcache VALUES (13, 4255, 'amsr-e-l3-dailyland-v06-20030924');
INSERT INTO cs_stringrepcache VALUES (13, 4256, 'amsr-e-l3-dailyland-v06-20030925');
INSERT INTO cs_stringrepcache VALUES (13, 4257, 'amsr-e-l3-dailyland-v06-20030926');
INSERT INTO cs_stringrepcache VALUES (13, 4258, 'amsr-e-l3-dailyland-v06-20030927');
INSERT INTO cs_stringrepcache VALUES (13, 4259, 'amsr-e-l3-dailyland-v06-20030928');
INSERT INTO cs_stringrepcache VALUES (13, 4260, 'amsr-e-l3-dailyland-v06-20030929');
INSERT INTO cs_stringrepcache VALUES (13, 4261, 'amsr-e-l3-dailyland-v06-20030930');
INSERT INTO cs_stringrepcache VALUES (13, 4262, 'amsr-e-l3-dailyland-v06-20031001');
INSERT INTO cs_stringrepcache VALUES (13, 4263, 'amsr-e-l3-dailyland-v06-20031002');
INSERT INTO cs_stringrepcache VALUES (13, 4264, 'amsr-e-l3-dailyland-v06-20031003');
INSERT INTO cs_stringrepcache VALUES (13, 4265, 'amsr-e-l3-dailyland-v06-20031004');
INSERT INTO cs_stringrepcache VALUES (13, 4266, 'amsr-e-l3-dailyland-v06-20031005');
INSERT INTO cs_stringrepcache VALUES (13, 4267, 'amsr-e-l3-dailyland-v06-20031006');
INSERT INTO cs_stringrepcache VALUES (13, 4268, 'amsr-e-l3-dailyland-v06-20031007');
INSERT INTO cs_stringrepcache VALUES (13, 4269, 'amsr-e-l3-dailyland-v06-20031008');
INSERT INTO cs_stringrepcache VALUES (13, 4270, 'amsr-e-l3-dailyland-v06-20031009');
INSERT INTO cs_stringrepcache VALUES (13, 4271, 'amsr-e-l3-dailyland-v06-20031010');
INSERT INTO cs_stringrepcache VALUES (13, 4272, 'amsr-e-l3-dailyland-v06-20031011');
INSERT INTO cs_stringrepcache VALUES (13, 4273, 'amsr-e-l3-dailyland-v06-20031012');
INSERT INTO cs_stringrepcache VALUES (13, 4274, 'amsr-e-l3-dailyland-v06-20031013');
INSERT INTO cs_stringrepcache VALUES (13, 4275, 'amsr-e-l3-dailyland-v06-20031014');
INSERT INTO cs_stringrepcache VALUES (13, 4276, 'amsr-e-l3-dailyland-v06-20031015');
INSERT INTO cs_stringrepcache VALUES (13, 4277, 'amsr-e-l3-dailyland-v06-20031016');
INSERT INTO cs_stringrepcache VALUES (13, 4278, 'amsr-e-l3-dailyland-v06-20031017');
INSERT INTO cs_stringrepcache VALUES (13, 4279, 'amsr-e-l3-dailyland-v06-20031018');
INSERT INTO cs_stringrepcache VALUES (13, 4280, 'amsr-e-l3-dailyland-v06-20031019');
INSERT INTO cs_stringrepcache VALUES (13, 4281, 'amsr-e-l3-dailyland-v06-20031020');
INSERT INTO cs_stringrepcache VALUES (13, 4282, 'amsr-e-l3-dailyland-v06-20031021');
INSERT INTO cs_stringrepcache VALUES (13, 4283, 'amsr-e-l3-dailyland-v06-20031022');
INSERT INTO cs_stringrepcache VALUES (13, 4284, 'amsr-e-l3-dailyland-v06-20031023');
INSERT INTO cs_stringrepcache VALUES (13, 4285, 'amsr-e-l3-dailyland-v06-20031024');
INSERT INTO cs_stringrepcache VALUES (13, 4286, 'amsr-e-l3-dailyland-v06-20031025');
INSERT INTO cs_stringrepcache VALUES (13, 4287, 'amsr-e-l3-dailyland-v06-20031026');
INSERT INTO cs_stringrepcache VALUES (13, 4288, 'amsr-e-l3-dailyland-v06-20031027');
INSERT INTO cs_stringrepcache VALUES (13, 4289, 'amsr-e-l3-dailyland-v06-20031028');
INSERT INTO cs_stringrepcache VALUES (13, 4290, 'amsr-e-l3-dailyland-v06-20031029');
INSERT INTO cs_stringrepcache VALUES (13, 4291, 'amsr-e-l3-dailyland-v06-20031030');
INSERT INTO cs_stringrepcache VALUES (13, 4292, 'amsr-e-l3-dailyland-v06-20031031');
INSERT INTO cs_stringrepcache VALUES (13, 4293, 'amsr-e-l3-dailyland-v06-20031101');
INSERT INTO cs_stringrepcache VALUES (13, 4294, 'amsr-e-l3-dailyland-v06-20031102');
INSERT INTO cs_stringrepcache VALUES (13, 4295, 'amsr-e-l3-dailyland-v06-20031103');
INSERT INTO cs_stringrepcache VALUES (13, 4296, 'amsr-e-l3-dailyland-v06-20031104');
INSERT INTO cs_stringrepcache VALUES (13, 4297, 'amsr-e-l3-dailyland-v06-20031105');
INSERT INTO cs_stringrepcache VALUES (13, 4298, 'amsr-e-l3-dailyland-v06-20031106');
INSERT INTO cs_stringrepcache VALUES (13, 4299, 'amsr-e-l3-dailyland-v06-20031107');
INSERT INTO cs_stringrepcache VALUES (13, 4300, 'amsr-e-l3-dailyland-v06-20031108');
INSERT INTO cs_stringrepcache VALUES (13, 4301, 'amsr-e-l3-dailyland-v06-20031109');
INSERT INTO cs_stringrepcache VALUES (13, 4302, 'amsr-e-l3-dailyland-v06-20031110');
INSERT INTO cs_stringrepcache VALUES (13, 4303, 'amsr-e-l3-dailyland-v06-20031111');
INSERT INTO cs_stringrepcache VALUES (13, 4304, 'amsr-e-l3-dailyland-v06-20031112');
INSERT INTO cs_stringrepcache VALUES (13, 4305, 'amsr-e-l3-dailyland-v06-20031113');
INSERT INTO cs_stringrepcache VALUES (13, 4306, 'amsr-e-l3-dailyland-v06-20031114');
INSERT INTO cs_stringrepcache VALUES (13, 4307, 'amsr-e-l3-dailyland-v06-20031115');
INSERT INTO cs_stringrepcache VALUES (13, 4308, 'amsr-e-l3-dailyland-v06-20031116');
INSERT INTO cs_stringrepcache VALUES (13, 4309, 'amsr-e-l3-dailyland-v06-20031117');
INSERT INTO cs_stringrepcache VALUES (13, 4310, 'amsr-e-l3-dailyland-v06-20031118');
INSERT INTO cs_stringrepcache VALUES (13, 4311, 'amsr-e-l3-dailyland-v06-20031119');
INSERT INTO cs_stringrepcache VALUES (13, 4312, 'amsr-e-l3-dailyland-v06-20031120');
INSERT INTO cs_stringrepcache VALUES (13, 4313, 'amsr-e-l3-dailyland-v06-20031121');
INSERT INTO cs_stringrepcache VALUES (13, 4314, 'amsr-e-l3-dailyland-v06-20031122');
INSERT INTO cs_stringrepcache VALUES (13, 4315, 'amsr-e-l3-dailyland-v06-20031123');
INSERT INTO cs_stringrepcache VALUES (13, 4316, 'amsr-e-l3-dailyland-v06-20031124');
INSERT INTO cs_stringrepcache VALUES (13, 4317, 'amsr-e-l3-dailyland-v06-20031125');
INSERT INTO cs_stringrepcache VALUES (13, 4318, 'amsr-e-l3-dailyland-v06-20031126');
INSERT INTO cs_stringrepcache VALUES (13, 4319, 'amsr-e-l3-dailyland-v06-20031127');
INSERT INTO cs_stringrepcache VALUES (13, 4320, 'amsr-e-l3-dailyland-v06-20031128');
INSERT INTO cs_stringrepcache VALUES (13, 4321, 'amsr-e-l3-dailyland-v06-20031129');
INSERT INTO cs_stringrepcache VALUES (13, 4322, 'amsr-e-l3-dailyland-v06-20031130');
INSERT INTO cs_stringrepcache VALUES (13, 4323, 'amsr-e-l3-dailyland-v06-20031201');
INSERT INTO cs_stringrepcache VALUES (13, 4324, 'amsr-e-l3-dailyland-v06-20031202');
INSERT INTO cs_stringrepcache VALUES (13, 4325, 'amsr-e-l3-dailyland-v06-20031203');
INSERT INTO cs_stringrepcache VALUES (13, 4326, 'amsr-e-l3-dailyland-v06-20031204');
INSERT INTO cs_stringrepcache VALUES (13, 4327, 'amsr-e-l3-dailyland-v06-20031205');
INSERT INTO cs_stringrepcache VALUES (13, 4328, 'amsr-e-l3-dailyland-v06-20031206');
INSERT INTO cs_stringrepcache VALUES (13, 4329, 'amsr-e-l3-dailyland-v06-20031207');
INSERT INTO cs_stringrepcache VALUES (13, 4330, 'amsr-e-l3-dailyland-v06-20031208');
INSERT INTO cs_stringrepcache VALUES (13, 4331, 'amsr-e-l3-dailyland-v06-20031209');
INSERT INTO cs_stringrepcache VALUES (13, 4332, 'amsr-e-l3-dailyland-v06-20031210');
INSERT INTO cs_stringrepcache VALUES (13, 4333, 'amsr-e-l3-dailyland-v06-20031211');
INSERT INTO cs_stringrepcache VALUES (13, 4334, 'amsr-e-l3-dailyland-v06-20031212');
INSERT INTO cs_stringrepcache VALUES (13, 4335, 'amsr-e-l3-dailyland-v06-20031213');
INSERT INTO cs_stringrepcache VALUES (13, 4336, 'amsr-e-l3-dailyland-v06-20031214');
INSERT INTO cs_stringrepcache VALUES (13, 4337, 'amsr-e-l3-dailyland-v06-20031215');
INSERT INTO cs_stringrepcache VALUES (13, 4338, 'amsr-e-l3-dailyland-v06-20031216');
INSERT INTO cs_stringrepcache VALUES (13, 4339, 'amsr-e-l3-dailyland-v06-20031217');
INSERT INTO cs_stringrepcache VALUES (13, 4340, 'amsr-e-l3-dailyland-v06-20031218');
INSERT INTO cs_stringrepcache VALUES (13, 4341, 'amsr-e-l3-dailyland-v06-20031219');
INSERT INTO cs_stringrepcache VALUES (13, 4342, 'amsr-e-l3-dailyland-v06-20031220');
INSERT INTO cs_stringrepcache VALUES (13, 4343, 'amsr-e-l3-dailyland-v06-20031221');
INSERT INTO cs_stringrepcache VALUES (13, 4344, 'amsr-e-l3-dailyland-v06-20031222');
INSERT INTO cs_stringrepcache VALUES (13, 4345, 'amsr-e-l3-dailyland-v06-20031223');
INSERT INTO cs_stringrepcache VALUES (13, 4346, 'amsr-e-l3-dailyland-v06-20031224');
INSERT INTO cs_stringrepcache VALUES (13, 4347, 'amsr-e-l3-dailyland-v06-20031225');
INSERT INTO cs_stringrepcache VALUES (13, 4348, 'amsr-e-l3-dailyland-v06-20031226');
INSERT INTO cs_stringrepcache VALUES (13, 4349, 'amsr-e-l3-dailyland-v06-20031227');
INSERT INTO cs_stringrepcache VALUES (13, 4350, 'amsr-e-l3-dailyland-v06-20031228');
INSERT INTO cs_stringrepcache VALUES (13, 4351, 'amsr-e-l3-dailyland-v06-20031229');
INSERT INTO cs_stringrepcache VALUES (13, 4352, 'amsr-e-l3-dailyland-v06-20031230');
INSERT INTO cs_stringrepcache VALUES (13, 4353, 'amsr-e-l3-dailyland-v06-20031231');
INSERT INTO cs_stringrepcache VALUES (13, 4354, 'amsr-e-l3-dailyland-v06-20040101');
INSERT INTO cs_stringrepcache VALUES (13, 4355, 'amsr-e-l3-dailyland-v06-20040102');
INSERT INTO cs_stringrepcache VALUES (13, 4356, 'amsr-e-l3-dailyland-v06-20040103');
INSERT INTO cs_stringrepcache VALUES (13, 4357, 'amsr-e-l3-dailyland-v06-20040104');
INSERT INTO cs_stringrepcache VALUES (13, 4358, 'amsr-e-l3-dailyland-v06-20040105');
INSERT INTO cs_stringrepcache VALUES (13, 4359, 'amsr-e-l3-dailyland-v06-20040106');
INSERT INTO cs_stringrepcache VALUES (13, 4360, 'amsr-e-l3-dailyland-v06-20040107');
INSERT INTO cs_stringrepcache VALUES (13, 4361, 'amsr-e-l3-dailyland-v06-20040108');
INSERT INTO cs_stringrepcache VALUES (13, 4362, 'amsr-e-l3-dailyland-v06-20040109');
INSERT INTO cs_stringrepcache VALUES (13, 4363, 'amsr-e-l3-dailyland-v06-20040110');
INSERT INTO cs_stringrepcache VALUES (13, 4364, 'amsr-e-l3-dailyland-v06-20040111');
INSERT INTO cs_stringrepcache VALUES (13, 4365, 'amsr-e-l3-dailyland-v06-20040112');
INSERT INTO cs_stringrepcache VALUES (13, 4366, 'amsr-e-l3-dailyland-v06-20040113');
INSERT INTO cs_stringrepcache VALUES (13, 4367, 'amsr-e-l3-dailyland-v06-20040114');
INSERT INTO cs_stringrepcache VALUES (13, 4368, 'amsr-e-l3-dailyland-v06-20040115');
INSERT INTO cs_stringrepcache VALUES (13, 4369, 'amsr-e-l3-dailyland-v06-20040116');
INSERT INTO cs_stringrepcache VALUES (13, 4370, 'amsr-e-l3-dailyland-v06-20040117');
INSERT INTO cs_stringrepcache VALUES (13, 4371, 'amsr-e-l3-dailyland-v06-20040118');
INSERT INTO cs_stringrepcache VALUES (13, 4372, 'amsr-e-l3-dailyland-v06-20040119');
INSERT INTO cs_stringrepcache VALUES (13, 4373, 'amsr-e-l3-dailyland-v06-20040120');
INSERT INTO cs_stringrepcache VALUES (13, 4374, 'amsr-e-l3-dailyland-v06-20040121');
INSERT INTO cs_stringrepcache VALUES (13, 4375, 'amsr-e-l3-dailyland-v06-20040122');
INSERT INTO cs_stringrepcache VALUES (13, 4376, 'amsr-e-l3-dailyland-v06-20040123');
INSERT INTO cs_stringrepcache VALUES (13, 4377, 'amsr-e-l3-dailyland-v06-20040124');
INSERT INTO cs_stringrepcache VALUES (13, 4378, 'amsr-e-l3-dailyland-v06-20040125');
INSERT INTO cs_stringrepcache VALUES (13, 4379, 'amsr-e-l3-dailyland-v06-20040126');
INSERT INTO cs_stringrepcache VALUES (13, 4380, 'amsr-e-l3-dailyland-v06-20040127');
INSERT INTO cs_stringrepcache VALUES (13, 4381, 'amsr-e-l3-dailyland-v06-20040128');
INSERT INTO cs_stringrepcache VALUES (13, 4382, 'amsr-e-l3-dailyland-v06-20040129');
INSERT INTO cs_stringrepcache VALUES (13, 4383, 'amsr-e-l3-dailyland-v06-20040130');
INSERT INTO cs_stringrepcache VALUES (13, 4384, 'amsr-e-l3-dailyland-v06-20040131');
INSERT INTO cs_stringrepcache VALUES (13, 4385, 'amsr-e-l3-dailyland-v06-20040201');
INSERT INTO cs_stringrepcache VALUES (13, 4386, 'amsr-e-l3-dailyland-v06-20040202');
INSERT INTO cs_stringrepcache VALUES (13, 4387, 'amsr-e-l3-dailyland-v06-20040203');
INSERT INTO cs_stringrepcache VALUES (13, 4388, 'amsr-e-l3-dailyland-v06-20040204');
INSERT INTO cs_stringrepcache VALUES (13, 4389, 'amsr-e-l3-dailyland-v06-20040205');
INSERT INTO cs_stringrepcache VALUES (13, 4390, 'amsr-e-l3-dailyland-v06-20040206');
INSERT INTO cs_stringrepcache VALUES (13, 4391, 'amsr-e-l3-dailyland-v06-20040207');
INSERT INTO cs_stringrepcache VALUES (13, 4392, 'amsr-e-l3-dailyland-v06-20040208');
INSERT INTO cs_stringrepcache VALUES (13, 4393, 'amsr-e-l3-dailyland-v06-20040209');
INSERT INTO cs_stringrepcache VALUES (13, 4394, 'amsr-e-l3-dailyland-v06-20040210');
INSERT INTO cs_stringrepcache VALUES (13, 4395, 'amsr-e-l3-dailyland-v06-20040211');
INSERT INTO cs_stringrepcache VALUES (13, 4396, 'amsr-e-l3-dailyland-v06-20040212');
INSERT INTO cs_stringrepcache VALUES (13, 4397, 'amsr-e-l3-dailyland-v06-20040213');
INSERT INTO cs_stringrepcache VALUES (13, 4398, 'amsr-e-l3-dailyland-v06-20040214');
INSERT INTO cs_stringrepcache VALUES (13, 4399, 'amsr-e-l3-dailyland-v06-20040215');
INSERT INTO cs_stringrepcache VALUES (13, 4400, 'amsr-e-l3-dailyland-v06-20040216');
INSERT INTO cs_stringrepcache VALUES (13, 4401, 'amsr-e-l3-dailyland-v06-20040217');
INSERT INTO cs_stringrepcache VALUES (13, 4402, 'amsr-e-l3-dailyland-v06-20040218');
INSERT INTO cs_stringrepcache VALUES (13, 4403, 'amsr-e-l3-dailyland-v06-20040219');
INSERT INTO cs_stringrepcache VALUES (13, 4404, 'amsr-e-l3-dailyland-v06-20040220');
INSERT INTO cs_stringrepcache VALUES (13, 4405, 'amsr-e-l3-dailyland-v06-20040221');
INSERT INTO cs_stringrepcache VALUES (13, 4406, 'amsr-e-l3-dailyland-v06-20040222');
INSERT INTO cs_stringrepcache VALUES (13, 4407, 'amsr-e-l3-dailyland-v06-20040223');
INSERT INTO cs_stringrepcache VALUES (13, 4408, 'amsr-e-l3-dailyland-v06-20040224');
INSERT INTO cs_stringrepcache VALUES (13, 4409, 'amsr-e-l3-dailyland-v06-20040225');
INSERT INTO cs_stringrepcache VALUES (13, 4410, 'amsr-e-l3-dailyland-v06-20040226');
INSERT INTO cs_stringrepcache VALUES (13, 4411, 'amsr-e-l3-dailyland-v06-20040227');
INSERT INTO cs_stringrepcache VALUES (13, 4412, 'amsr-e-l3-dailyland-v06-20040228');
INSERT INTO cs_stringrepcache VALUES (13, 4413, 'amsr-e-l3-dailyland-v06-20040229');
INSERT INTO cs_stringrepcache VALUES (13, 4414, 'amsr-e-l3-dailyland-v06-20040301');
INSERT INTO cs_stringrepcache VALUES (13, 4415, 'amsr-e-l3-dailyland-v06-20040302');
INSERT INTO cs_stringrepcache VALUES (13, 4416, 'amsr-e-l3-dailyland-v06-20040303');
INSERT INTO cs_stringrepcache VALUES (13, 4417, 'amsr-e-l3-dailyland-v06-20040304');
INSERT INTO cs_stringrepcache VALUES (13, 4418, 'amsr-e-l3-dailyland-v06-20040305');
INSERT INTO cs_stringrepcache VALUES (13, 4419, 'amsr-e-l3-dailyland-v06-20040306');
INSERT INTO cs_stringrepcache VALUES (13, 4420, 'amsr-e-l3-dailyland-v06-20040307');
INSERT INTO cs_stringrepcache VALUES (13, 4421, 'amsr-e-l3-dailyland-v06-20040308');
INSERT INTO cs_stringrepcache VALUES (13, 4422, 'amsr-e-l3-dailyland-v06-20040309');
INSERT INTO cs_stringrepcache VALUES (13, 4423, 'amsr-e-l3-dailyland-v06-20040310');
INSERT INTO cs_stringrepcache VALUES (13, 4424, 'amsr-e-l3-dailyland-v06-20040311');
INSERT INTO cs_stringrepcache VALUES (13, 4425, 'amsr-e-l3-dailyland-v06-20040312');
INSERT INTO cs_stringrepcache VALUES (13, 4426, 'amsr-e-l3-dailyland-v06-20040313');
INSERT INTO cs_stringrepcache VALUES (13, 4427, 'amsr-e-l3-dailyland-v06-20040314');
INSERT INTO cs_stringrepcache VALUES (13, 4428, 'amsr-e-l3-dailyland-v06-20040315');
INSERT INTO cs_stringrepcache VALUES (13, 4429, 'amsr-e-l3-dailyland-v06-20040316');
INSERT INTO cs_stringrepcache VALUES (13, 4430, 'amsr-e-l3-dailyland-v06-20040317');
INSERT INTO cs_stringrepcache VALUES (13, 4431, 'amsr-e-l3-dailyland-v06-20040318');
INSERT INTO cs_stringrepcache VALUES (13, 4432, 'amsr-e-l3-dailyland-v06-20040319');
INSERT INTO cs_stringrepcache VALUES (13, 4433, 'amsr-e-l3-dailyland-v06-20040320');
INSERT INTO cs_stringrepcache VALUES (13, 4434, 'amsr-e-l3-dailyland-v06-20040321');
INSERT INTO cs_stringrepcache VALUES (13, 4435, 'amsr-e-l3-dailyland-v06-20040322');
INSERT INTO cs_stringrepcache VALUES (13, 4436, 'amsr-e-l3-dailyland-v06-20040323');
INSERT INTO cs_stringrepcache VALUES (13, 4437, 'amsr-e-l3-dailyland-v06-20040324');
INSERT INTO cs_stringrepcache VALUES (13, 4438, 'amsr-e-l3-dailyland-v06-20040325');
INSERT INTO cs_stringrepcache VALUES (13, 4439, 'amsr-e-l3-dailyland-v06-20040326');
INSERT INTO cs_stringrepcache VALUES (13, 4440, 'amsr-e-l3-dailyland-v06-20040327');
INSERT INTO cs_stringrepcache VALUES (13, 4441, 'amsr-e-l3-dailyland-v06-20040328');
INSERT INTO cs_stringrepcache VALUES (13, 4442, 'amsr-e-l3-dailyland-v06-20040329');
INSERT INTO cs_stringrepcache VALUES (13, 4443, 'amsr-e-l3-dailyland-v06-20040330');
INSERT INTO cs_stringrepcache VALUES (13, 4444, 'amsr-e-l3-dailyland-v06-20040331');
INSERT INTO cs_stringrepcache VALUES (13, 4445, 'amsr-e-l3-dailyland-v06-20040401');
INSERT INTO cs_stringrepcache VALUES (13, 4446, 'amsr-e-l3-dailyland-v06-20040402');
INSERT INTO cs_stringrepcache VALUES (13, 4447, 'amsr-e-l3-dailyland-v06-20040403');
INSERT INTO cs_stringrepcache VALUES (13, 4448, 'amsr-e-l3-dailyland-v06-20040404');
INSERT INTO cs_stringrepcache VALUES (13, 4449, 'amsr-e-l3-dailyland-v06-20040405');
INSERT INTO cs_stringrepcache VALUES (13, 4450, 'amsr-e-l3-dailyland-v06-20040406');
INSERT INTO cs_stringrepcache VALUES (13, 4451, 'amsr-e-l3-dailyland-v06-20040407');
INSERT INTO cs_stringrepcache VALUES (13, 4452, 'amsr-e-l3-dailyland-v06-20040408');
INSERT INTO cs_stringrepcache VALUES (13, 4453, 'amsr-e-l3-dailyland-v06-20040409');
INSERT INTO cs_stringrepcache VALUES (13, 4454, 'amsr-e-l3-dailyland-v06-20040410');
INSERT INTO cs_stringrepcache VALUES (13, 4455, 'amsr-e-l3-dailyland-v06-20040411');
INSERT INTO cs_stringrepcache VALUES (13, 4456, 'amsr-e-l3-dailyland-v06-20040412');
INSERT INTO cs_stringrepcache VALUES (13, 4457, 'amsr-e-l3-dailyland-v06-20040413');
INSERT INTO cs_stringrepcache VALUES (13, 4458, 'amsr-e-l3-dailyland-v06-20040414');
INSERT INTO cs_stringrepcache VALUES (13, 4459, 'amsr-e-l3-dailyland-v06-20040415');
INSERT INTO cs_stringrepcache VALUES (13, 4460, 'amsr-e-l3-dailyland-v06-20040416');
INSERT INTO cs_stringrepcache VALUES (13, 4461, 'amsr-e-l3-dailyland-v06-20040417');
INSERT INTO cs_stringrepcache VALUES (13, 4462, 'amsr-e-l3-dailyland-v06-20040418');
INSERT INTO cs_stringrepcache VALUES (13, 4463, 'amsr-e-l3-dailyland-v06-20040419');
INSERT INTO cs_stringrepcache VALUES (13, 4464, 'amsr-e-l3-dailyland-v06-20040420');
INSERT INTO cs_stringrepcache VALUES (13, 4465, 'amsr-e-l3-dailyland-v06-20040421');
INSERT INTO cs_stringrepcache VALUES (13, 4466, 'amsr-e-l3-dailyland-v06-20040422');
INSERT INTO cs_stringrepcache VALUES (13, 4467, 'amsr-e-l3-dailyland-v06-20040423');
INSERT INTO cs_stringrepcache VALUES (13, 4468, 'amsr-e-l3-dailyland-v06-20040424');
INSERT INTO cs_stringrepcache VALUES (13, 4469, 'amsr-e-l3-dailyland-v06-20040425');
INSERT INTO cs_stringrepcache VALUES (13, 4470, 'amsr-e-l3-dailyland-v06-20040426');
INSERT INTO cs_stringrepcache VALUES (13, 4471, 'amsr-e-l3-dailyland-v06-20040427');
INSERT INTO cs_stringrepcache VALUES (13, 4472, 'amsr-e-l3-dailyland-v06-20040428');
INSERT INTO cs_stringrepcache VALUES (13, 4473, 'amsr-e-l3-dailyland-v06-20040429');
INSERT INTO cs_stringrepcache VALUES (13, 4474, 'amsr-e-l3-dailyland-v06-20040430');
INSERT INTO cs_stringrepcache VALUES (13, 4475, 'amsr-e-l3-dailyland-v06-20040501');
INSERT INTO cs_stringrepcache VALUES (13, 4476, 'amsr-e-l3-dailyland-v06-20040502');
INSERT INTO cs_stringrepcache VALUES (13, 4477, 'amsr-e-l3-dailyland-v06-20040503');
INSERT INTO cs_stringrepcache VALUES (13, 4478, 'amsr-e-l3-dailyland-v06-20040504');
INSERT INTO cs_stringrepcache VALUES (13, 4479, 'amsr-e-l3-dailyland-v06-20040505');
INSERT INTO cs_stringrepcache VALUES (13, 4480, 'amsr-e-l3-dailyland-v06-20040506');
INSERT INTO cs_stringrepcache VALUES (13, 4481, 'amsr-e-l3-dailyland-v06-20040507');
INSERT INTO cs_stringrepcache VALUES (13, 4482, 'amsr-e-l3-dailyland-v06-20040508');
INSERT INTO cs_stringrepcache VALUES (13, 4483, 'amsr-e-l3-dailyland-v06-20040509');
INSERT INTO cs_stringrepcache VALUES (13, 4484, 'amsr-e-l3-dailyland-v06-20040510');
INSERT INTO cs_stringrepcache VALUES (13, 4485, 'amsr-e-l3-dailyland-v06-20040511');
INSERT INTO cs_stringrepcache VALUES (13, 4486, 'amsr-e-l3-dailyland-v06-20040512');
INSERT INTO cs_stringrepcache VALUES (13, 4487, 'amsr-e-l3-dailyland-v06-20040513');
INSERT INTO cs_stringrepcache VALUES (13, 4488, 'amsr-e-l3-dailyland-v06-20040514');
INSERT INTO cs_stringrepcache VALUES (13, 4489, 'amsr-e-l3-dailyland-v06-20040515');
INSERT INTO cs_stringrepcache VALUES (13, 4490, 'amsr-e-l3-dailyland-v06-20040516');
INSERT INTO cs_stringrepcache VALUES (13, 4491, 'amsr-e-l3-dailyland-v06-20040517');
INSERT INTO cs_stringrepcache VALUES (13, 4492, 'amsr-e-l3-dailyland-v06-20040518');
INSERT INTO cs_stringrepcache VALUES (13, 4493, 'amsr-e-l3-dailyland-v06-20040519');
INSERT INTO cs_stringrepcache VALUES (13, 4494, 'amsr-e-l3-dailyland-v06-20040520');
INSERT INTO cs_stringrepcache VALUES (13, 4495, 'amsr-e-l3-dailyland-v06-20040521');
INSERT INTO cs_stringrepcache VALUES (13, 4496, 'amsr-e-l3-dailyland-v06-20040522');
INSERT INTO cs_stringrepcache VALUES (13, 4497, 'amsr-e-l3-dailyland-v06-20040523');
INSERT INTO cs_stringrepcache VALUES (13, 4498, 'amsr-e-l3-dailyland-v06-20040524');
INSERT INTO cs_stringrepcache VALUES (13, 4499, 'amsr-e-l3-dailyland-v06-20040525');
INSERT INTO cs_stringrepcache VALUES (13, 4500, 'amsr-e-l3-dailyland-v06-20040526');
INSERT INTO cs_stringrepcache VALUES (13, 4501, 'amsr-e-l3-dailyland-v06-20040527');
INSERT INTO cs_stringrepcache VALUES (13, 4502, 'amsr-e-l3-dailyland-v06-20040528');
INSERT INTO cs_stringrepcache VALUES (13, 4503, 'amsr-e-l3-dailyland-v06-20040529');
INSERT INTO cs_stringrepcache VALUES (13, 4504, 'amsr-e-l3-dailyland-v06-20040530');
INSERT INTO cs_stringrepcache VALUES (13, 4505, 'amsr-e-l3-dailyland-v06-20040531');
INSERT INTO cs_stringrepcache VALUES (13, 4506, 'amsr-e-l3-dailyland-v06-20040601');
INSERT INTO cs_stringrepcache VALUES (13, 4507, 'amsr-e-l3-dailyland-v06-20040602');
INSERT INTO cs_stringrepcache VALUES (13, 4508, 'amsr-e-l3-dailyland-v06-20040603');
INSERT INTO cs_stringrepcache VALUES (13, 4509, 'amsr-e-l3-dailyland-v06-20040604');
INSERT INTO cs_stringrepcache VALUES (13, 4510, 'amsr-e-l3-dailyland-v06-20040605');
INSERT INTO cs_stringrepcache VALUES (13, 4511, 'amsr-e-l3-dailyland-v06-20040606');
INSERT INTO cs_stringrepcache VALUES (13, 4512, 'amsr-e-l3-dailyland-v06-20040607');
INSERT INTO cs_stringrepcache VALUES (13, 4513, 'amsr-e-l3-dailyland-v06-20040608');
INSERT INTO cs_stringrepcache VALUES (13, 4514, 'amsr-e-l3-dailyland-v06-20040609');
INSERT INTO cs_stringrepcache VALUES (13, 4515, 'amsr-e-l3-dailyland-v06-20040610');
INSERT INTO cs_stringrepcache VALUES (13, 4516, 'amsr-e-l3-dailyland-v06-20040611');
INSERT INTO cs_stringrepcache VALUES (13, 4517, 'amsr-e-l3-dailyland-v06-20040612');
INSERT INTO cs_stringrepcache VALUES (13, 4518, 'amsr-e-l3-dailyland-v06-20040613');
INSERT INTO cs_stringrepcache VALUES (13, 4519, 'amsr-e-l3-dailyland-v06-20040614');
INSERT INTO cs_stringrepcache VALUES (13, 4520, 'amsr-e-l3-dailyland-v06-20040615');
INSERT INTO cs_stringrepcache VALUES (13, 4521, 'amsr-e-l3-dailyland-v06-20040616');
INSERT INTO cs_stringrepcache VALUES (13, 4522, 'amsr-e-l3-dailyland-v06-20040617');
INSERT INTO cs_stringrepcache VALUES (13, 4523, 'amsr-e-l3-dailyland-v06-20040618');
INSERT INTO cs_stringrepcache VALUES (13, 4524, 'amsr-e-l3-dailyland-v06-20040619');
INSERT INTO cs_stringrepcache VALUES (13, 4525, 'amsr-e-l3-dailyland-v06-20040620');
INSERT INTO cs_stringrepcache VALUES (13, 4526, 'amsr-e-l3-dailyland-v06-20040621');
INSERT INTO cs_stringrepcache VALUES (13, 4527, 'amsr-e-l3-dailyland-v06-20040622');
INSERT INTO cs_stringrepcache VALUES (13, 4528, 'amsr-e-l3-dailyland-v06-20040623');
INSERT INTO cs_stringrepcache VALUES (13, 4529, 'amsr-e-l3-dailyland-v06-20040624');
INSERT INTO cs_stringrepcache VALUES (13, 4530, 'amsr-e-l3-dailyland-v06-20040625');
INSERT INTO cs_stringrepcache VALUES (13, 4531, 'amsr-e-l3-dailyland-v06-20040626');
INSERT INTO cs_stringrepcache VALUES (13, 4532, 'amsr-e-l3-dailyland-v06-20040627');
INSERT INTO cs_stringrepcache VALUES (13, 4533, 'amsr-e-l3-dailyland-v06-20040628');
INSERT INTO cs_stringrepcache VALUES (13, 4534, 'amsr-e-l3-dailyland-v06-20040629');
INSERT INTO cs_stringrepcache VALUES (13, 4535, 'amsr-e-l3-dailyland-v06-20040630');
INSERT INTO cs_stringrepcache VALUES (13, 4536, 'amsr-e-l3-dailyland-v06-20040701');
INSERT INTO cs_stringrepcache VALUES (13, 4537, 'amsr-e-l3-dailyland-v06-20040702');
INSERT INTO cs_stringrepcache VALUES (13, 4538, 'amsr-e-l3-dailyland-v06-20040703');
INSERT INTO cs_stringrepcache VALUES (13, 4539, 'amsr-e-l3-dailyland-v06-20040704');
INSERT INTO cs_stringrepcache VALUES (13, 4540, 'amsr-e-l3-dailyland-v06-20040705');
INSERT INTO cs_stringrepcache VALUES (13, 4541, 'amsr-e-l3-dailyland-v06-20040706');
INSERT INTO cs_stringrepcache VALUES (13, 4542, 'amsr-e-l3-dailyland-v06-20040707');
INSERT INTO cs_stringrepcache VALUES (13, 4543, 'amsr-e-l3-dailyland-v06-20040708');
INSERT INTO cs_stringrepcache VALUES (13, 4544, 'amsr-e-l3-dailyland-v06-20040709');
INSERT INTO cs_stringrepcache VALUES (13, 4545, 'amsr-e-l3-dailyland-v06-20040710');
INSERT INTO cs_stringrepcache VALUES (13, 4546, 'amsr-e-l3-dailyland-v06-20040711');
INSERT INTO cs_stringrepcache VALUES (13, 4547, 'amsr-e-l3-dailyland-v06-20040712');
INSERT INTO cs_stringrepcache VALUES (13, 4548, 'amsr-e-l3-dailyland-v06-20040713');
INSERT INTO cs_stringrepcache VALUES (13, 4549, 'amsr-e-l3-dailyland-v06-20040714');
INSERT INTO cs_stringrepcache VALUES (13, 4550, 'amsr-e-l3-dailyland-v06-20040715');
INSERT INTO cs_stringrepcache VALUES (13, 4551, 'amsr-e-l3-dailyland-v06-20040716');
INSERT INTO cs_stringrepcache VALUES (13, 4552, 'amsr-e-l3-dailyland-v06-20040717');
INSERT INTO cs_stringrepcache VALUES (13, 4553, 'amsr-e-l3-dailyland-v06-20040718');
INSERT INTO cs_stringrepcache VALUES (13, 4554, 'amsr-e-l3-dailyland-v06-20040719');
INSERT INTO cs_stringrepcache VALUES (13, 4555, 'amsr-e-l3-dailyland-v06-20040720');
INSERT INTO cs_stringrepcache VALUES (13, 4556, 'amsr-e-l3-dailyland-v06-20040721');
INSERT INTO cs_stringrepcache VALUES (13, 4557, 'amsr-e-l3-dailyland-v06-20040722');
INSERT INTO cs_stringrepcache VALUES (13, 4558, 'amsr-e-l3-dailyland-v06-20040723');
INSERT INTO cs_stringrepcache VALUES (13, 4559, 'amsr-e-l3-dailyland-v06-20040724');
INSERT INTO cs_stringrepcache VALUES (13, 4560, 'amsr-e-l3-dailyland-v06-20040725');
INSERT INTO cs_stringrepcache VALUES (13, 4561, 'amsr-e-l3-dailyland-v06-20040726');
INSERT INTO cs_stringrepcache VALUES (13, 4562, 'amsr-e-l3-dailyland-v06-20040727');
INSERT INTO cs_stringrepcache VALUES (13, 4563, 'amsr-e-l3-dailyland-v06-20040728');
INSERT INTO cs_stringrepcache VALUES (13, 4564, 'amsr-e-l3-dailyland-v06-20040729');
INSERT INTO cs_stringrepcache VALUES (13, 4565, 'amsr-e-l3-dailyland-v06-20040730');
INSERT INTO cs_stringrepcache VALUES (13, 4566, 'amsr-e-l3-dailyland-v06-20040731');
INSERT INTO cs_stringrepcache VALUES (13, 4567, 'amsr-e-l3-dailyland-v06-20040801');
INSERT INTO cs_stringrepcache VALUES (13, 4568, 'amsr-e-l3-dailyland-v06-20040802');
INSERT INTO cs_stringrepcache VALUES (13, 4569, 'amsr-e-l3-dailyland-v06-20040803');
INSERT INTO cs_stringrepcache VALUES (13, 4570, 'amsr-e-l3-dailyland-v06-20040804');
INSERT INTO cs_stringrepcache VALUES (13, 4571, 'amsr-e-l3-dailyland-v06-20040805');
INSERT INTO cs_stringrepcache VALUES (13, 4572, 'amsr-e-l3-dailyland-v06-20040806');
INSERT INTO cs_stringrepcache VALUES (13, 4573, 'amsr-e-l3-dailyland-v06-20040807');
INSERT INTO cs_stringrepcache VALUES (13, 4574, 'amsr-e-l3-dailyland-v06-20040808');
INSERT INTO cs_stringrepcache VALUES (13, 4575, 'amsr-e-l3-dailyland-v06-20040809');
INSERT INTO cs_stringrepcache VALUES (13, 4576, 'amsr-e-l3-dailyland-v06-20040810');
INSERT INTO cs_stringrepcache VALUES (13, 4577, 'amsr-e-l3-dailyland-v06-20040811');
INSERT INTO cs_stringrepcache VALUES (13, 4578, 'amsr-e-l3-dailyland-v06-20040812');
INSERT INTO cs_stringrepcache VALUES (13, 4579, 'amsr-e-l3-dailyland-v06-20040813');
INSERT INTO cs_stringrepcache VALUES (13, 4580, 'amsr-e-l3-dailyland-v06-20040814');
INSERT INTO cs_stringrepcache VALUES (13, 4581, 'amsr-e-l3-dailyland-v06-20040815');
INSERT INTO cs_stringrepcache VALUES (13, 4582, 'amsr-e-l3-dailyland-v06-20040816');
INSERT INTO cs_stringrepcache VALUES (13, 4583, 'amsr-e-l3-dailyland-v06-20040817');
INSERT INTO cs_stringrepcache VALUES (13, 4584, 'amsr-e-l3-dailyland-v06-20040818');
INSERT INTO cs_stringrepcache VALUES (13, 4585, 'amsr-e-l3-dailyland-v06-20040819');
INSERT INTO cs_stringrepcache VALUES (13, 4586, 'amsr-e-l3-dailyland-v06-20040820');
INSERT INTO cs_stringrepcache VALUES (13, 4587, 'amsr-e-l3-dailyland-v06-20040821');
INSERT INTO cs_stringrepcache VALUES (13, 4588, 'amsr-e-l3-dailyland-v06-20040822');
INSERT INTO cs_stringrepcache VALUES (13, 4589, 'amsr-e-l3-dailyland-v06-20040823');
INSERT INTO cs_stringrepcache VALUES (13, 4590, 'amsr-e-l3-dailyland-v06-20040824');
INSERT INTO cs_stringrepcache VALUES (13, 4591, 'amsr-e-l3-dailyland-v06-20040825');
INSERT INTO cs_stringrepcache VALUES (13, 4592, 'amsr-e-l3-dailyland-v06-20040826');
INSERT INTO cs_stringrepcache VALUES (13, 4593, 'amsr-e-l3-dailyland-v06-20040827');
INSERT INTO cs_stringrepcache VALUES (13, 4594, 'amsr-e-l3-dailyland-v06-20040828');
INSERT INTO cs_stringrepcache VALUES (13, 4595, 'amsr-e-l3-dailyland-v06-20040829');
INSERT INTO cs_stringrepcache VALUES (13, 4596, 'amsr-e-l3-dailyland-v06-20040830');
INSERT INTO cs_stringrepcache VALUES (13, 4597, 'amsr-e-l3-dailyland-v06-20040831');
INSERT INTO cs_stringrepcache VALUES (13, 4598, 'amsr-e-l3-dailyland-v06-20040901');
INSERT INTO cs_stringrepcache VALUES (13, 4599, 'amsr-e-l3-dailyland-v06-20040902');
INSERT INTO cs_stringrepcache VALUES (13, 4600, 'amsr-e-l3-dailyland-v06-20040903');
INSERT INTO cs_stringrepcache VALUES (13, 4601, 'amsr-e-l3-dailyland-v06-20040904');
INSERT INTO cs_stringrepcache VALUES (13, 4602, 'amsr-e-l3-dailyland-v06-20040905');
INSERT INTO cs_stringrepcache VALUES (13, 4603, 'amsr-e-l3-dailyland-v06-20040906');
INSERT INTO cs_stringrepcache VALUES (13, 4604, 'amsr-e-l3-dailyland-v06-20040907');
INSERT INTO cs_stringrepcache VALUES (13, 4605, 'amsr-e-l3-dailyland-v06-20040908');
INSERT INTO cs_stringrepcache VALUES (13, 4606, 'amsr-e-l3-dailyland-v06-20040909');
INSERT INTO cs_stringrepcache VALUES (13, 4607, 'amsr-e-l3-dailyland-v06-20040910');
INSERT INTO cs_stringrepcache VALUES (13, 4608, 'amsr-e-l3-dailyland-v06-20040911');
INSERT INTO cs_stringrepcache VALUES (13, 4609, 'amsr-e-l3-dailyland-v06-20040912');
INSERT INTO cs_stringrepcache VALUES (13, 4610, 'amsr-e-l3-dailyland-v06-20040913');
INSERT INTO cs_stringrepcache VALUES (13, 4611, 'amsr-e-l3-dailyland-v06-20040914');
INSERT INTO cs_stringrepcache VALUES (13, 4612, 'amsr-e-l3-dailyland-v06-20040915');
INSERT INTO cs_stringrepcache VALUES (13, 4613, 'amsr-e-l3-dailyland-v06-20040916');
INSERT INTO cs_stringrepcache VALUES (13, 4614, 'amsr-e-l3-dailyland-v06-20040917');
INSERT INTO cs_stringrepcache VALUES (13, 4615, 'amsr-e-l3-dailyland-v06-20040918');
INSERT INTO cs_stringrepcache VALUES (13, 4616, 'amsr-e-l3-dailyland-v06-20040919');
INSERT INTO cs_stringrepcache VALUES (13, 4617, 'amsr-e-l3-dailyland-v06-20040920');
INSERT INTO cs_stringrepcache VALUES (13, 4618, 'amsr-e-l3-dailyland-v06-20040921');
INSERT INTO cs_stringrepcache VALUES (13, 4619, 'amsr-e-l3-dailyland-v06-20040922');
INSERT INTO cs_stringrepcache VALUES (13, 4620, 'amsr-e-l3-dailyland-v06-20040923');
INSERT INTO cs_stringrepcache VALUES (13, 4621, 'amsr-e-l3-dailyland-v06-20040924');
INSERT INTO cs_stringrepcache VALUES (13, 4622, 'amsr-e-l3-dailyland-v06-20040925');
INSERT INTO cs_stringrepcache VALUES (13, 4623, 'amsr-e-l3-dailyland-v06-20040926');
INSERT INTO cs_stringrepcache VALUES (13, 4624, 'amsr-e-l3-dailyland-v06-20040927');
INSERT INTO cs_stringrepcache VALUES (13, 4625, 'amsr-e-l3-dailyland-v06-20040928');
INSERT INTO cs_stringrepcache VALUES (13, 4626, 'amsr-e-l3-dailyland-v06-20040929');
INSERT INTO cs_stringrepcache VALUES (13, 4627, 'amsr-e-l3-dailyland-v06-20040930');
INSERT INTO cs_stringrepcache VALUES (13, 4628, 'amsr-e-l3-dailyland-v06-20041001');
INSERT INTO cs_stringrepcache VALUES (13, 4629, 'amsr-e-l3-dailyland-v06-20041002');
INSERT INTO cs_stringrepcache VALUES (13, 4630, 'amsr-e-l3-dailyland-v06-20041003');
INSERT INTO cs_stringrepcache VALUES (13, 4631, 'amsr-e-l3-dailyland-v06-20041004');
INSERT INTO cs_stringrepcache VALUES (13, 4632, 'amsr-e-l3-dailyland-v06-20041005');
INSERT INTO cs_stringrepcache VALUES (13, 4633, 'amsr-e-l3-dailyland-v06-20041006');
INSERT INTO cs_stringrepcache VALUES (13, 4634, 'amsr-e-l3-dailyland-v06-20041007');
INSERT INTO cs_stringrepcache VALUES (13, 4635, 'amsr-e-l3-dailyland-v06-20041008');
INSERT INTO cs_stringrepcache VALUES (13, 4636, 'amsr-e-l3-dailyland-v06-20041009');
INSERT INTO cs_stringrepcache VALUES (13, 4637, 'amsr-e-l3-dailyland-v06-20041010');
INSERT INTO cs_stringrepcache VALUES (13, 4638, 'amsr-e-l3-dailyland-v06-20041011');
INSERT INTO cs_stringrepcache VALUES (13, 4639, 'amsr-e-l3-dailyland-v06-20041012');
INSERT INTO cs_stringrepcache VALUES (13, 4640, 'amsr-e-l3-dailyland-v06-20041013');
INSERT INTO cs_stringrepcache VALUES (13, 4641, 'amsr-e-l3-dailyland-v06-20041014');
INSERT INTO cs_stringrepcache VALUES (13, 4642, 'amsr-e-l3-dailyland-v06-20041015');
INSERT INTO cs_stringrepcache VALUES (13, 4643, 'amsr-e-l3-dailyland-v06-20041016');
INSERT INTO cs_stringrepcache VALUES (13, 4644, 'amsr-e-l3-dailyland-v06-20041017');
INSERT INTO cs_stringrepcache VALUES (13, 4645, 'amsr-e-l3-dailyland-v06-20041018');
INSERT INTO cs_stringrepcache VALUES (13, 4646, 'amsr-e-l3-dailyland-v06-20041019');
INSERT INTO cs_stringrepcache VALUES (13, 4647, 'amsr-e-l3-dailyland-v06-20041020');
INSERT INTO cs_stringrepcache VALUES (13, 4648, 'amsr-e-l3-dailyland-v06-20041021');
INSERT INTO cs_stringrepcache VALUES (13, 4649, 'amsr-e-l3-dailyland-v06-20041022');
INSERT INTO cs_stringrepcache VALUES (13, 4650, 'amsr-e-l3-dailyland-v06-20041023');
INSERT INTO cs_stringrepcache VALUES (13, 4651, 'amsr-e-l3-dailyland-v06-20041024');
INSERT INTO cs_stringrepcache VALUES (13, 4652, 'amsr-e-l3-dailyland-v06-20041025');
INSERT INTO cs_stringrepcache VALUES (13, 4653, 'amsr-e-l3-dailyland-v06-20041026');
INSERT INTO cs_stringrepcache VALUES (13, 4654, 'amsr-e-l3-dailyland-v06-20041027');
INSERT INTO cs_stringrepcache VALUES (13, 4655, 'amsr-e-l3-dailyland-v06-20041028');
INSERT INTO cs_stringrepcache VALUES (13, 4656, 'amsr-e-l3-dailyland-v06-20041029');
INSERT INTO cs_stringrepcache VALUES (13, 4657, 'amsr-e-l3-dailyland-v06-20041030');
INSERT INTO cs_stringrepcache VALUES (13, 4658, 'amsr-e-l3-dailyland-v06-20041031');
INSERT INTO cs_stringrepcache VALUES (13, 4659, 'amsr-e-l3-dailyland-v06-20041101');
INSERT INTO cs_stringrepcache VALUES (13, 4660, 'amsr-e-l3-dailyland-v06-20041102');
INSERT INTO cs_stringrepcache VALUES (13, 4661, 'amsr-e-l3-dailyland-v06-20041103');
INSERT INTO cs_stringrepcache VALUES (13, 4662, 'amsr-e-l3-dailyland-v06-20041104');
INSERT INTO cs_stringrepcache VALUES (13, 4663, 'amsr-e-l3-dailyland-v06-20041105');
INSERT INTO cs_stringrepcache VALUES (13, 4664, 'amsr-e-l3-dailyland-v06-20041106');
INSERT INTO cs_stringrepcache VALUES (13, 4665, 'amsr-e-l3-dailyland-v06-20041107');
INSERT INTO cs_stringrepcache VALUES (13, 4666, 'amsr-e-l3-dailyland-v06-20041108');
INSERT INTO cs_stringrepcache VALUES (13, 4667, 'amsr-e-l3-dailyland-v06-20041109');
INSERT INTO cs_stringrepcache VALUES (13, 4668, 'amsr-e-l3-dailyland-v06-20041110');
INSERT INTO cs_stringrepcache VALUES (13, 4669, 'amsr-e-l3-dailyland-v06-20041111');
INSERT INTO cs_stringrepcache VALUES (13, 4670, 'amsr-e-l3-dailyland-v06-20041112');
INSERT INTO cs_stringrepcache VALUES (13, 4671, 'amsr-e-l3-dailyland-v06-20041113');
INSERT INTO cs_stringrepcache VALUES (13, 4672, 'amsr-e-l3-dailyland-v06-20041114');
INSERT INTO cs_stringrepcache VALUES (13, 4673, 'amsr-e-l3-dailyland-v06-20041115');
INSERT INTO cs_stringrepcache VALUES (13, 4674, 'amsr-e-l3-dailyland-v06-20041116');
INSERT INTO cs_stringrepcache VALUES (13, 4675, 'amsr-e-l3-dailyland-v06-20041117');
INSERT INTO cs_stringrepcache VALUES (13, 4676, 'amsr-e-l3-dailyland-v06-20041118');
INSERT INTO cs_stringrepcache VALUES (13, 4677, 'amsr-e-l3-dailyland-v06-20041119');
INSERT INTO cs_stringrepcache VALUES (13, 4678, 'amsr-e-l3-dailyland-v06-20041120');
INSERT INTO cs_stringrepcache VALUES (13, 4679, 'amsr-e-l3-dailyland-v06-20041121');
INSERT INTO cs_stringrepcache VALUES (13, 4680, 'amsr-e-l3-dailyland-v06-20041122');
INSERT INTO cs_stringrepcache VALUES (13, 4681, 'amsr-e-l3-dailyland-v06-20041123');
INSERT INTO cs_stringrepcache VALUES (13, 4682, 'amsr-e-l3-dailyland-v06-20041124');
INSERT INTO cs_stringrepcache VALUES (13, 4683, 'amsr-e-l3-dailyland-v06-20041125');
INSERT INTO cs_stringrepcache VALUES (13, 4684, 'amsr-e-l3-dailyland-v06-20041126');
INSERT INTO cs_stringrepcache VALUES (13, 4685, 'amsr-e-l3-dailyland-v06-20041127');
INSERT INTO cs_stringrepcache VALUES (13, 4686, 'amsr-e-l3-dailyland-v06-20041128');
INSERT INTO cs_stringrepcache VALUES (13, 4687, 'amsr-e-l3-dailyland-v06-20041129');
INSERT INTO cs_stringrepcache VALUES (13, 4688, 'amsr-e-l3-dailyland-v06-20041130');
INSERT INTO cs_stringrepcache VALUES (13, 4689, 'amsr-e-l3-dailyland-v06-20041201');
INSERT INTO cs_stringrepcache VALUES (13, 4690, 'amsr-e-l3-dailyland-v06-20041202');
INSERT INTO cs_stringrepcache VALUES (13, 4691, 'amsr-e-l3-dailyland-v06-20041203');
INSERT INTO cs_stringrepcache VALUES (13, 4692, 'amsr-e-l3-dailyland-v06-20041204');
INSERT INTO cs_stringrepcache VALUES (13, 4693, 'amsr-e-l3-dailyland-v06-20041205');
INSERT INTO cs_stringrepcache VALUES (13, 4694, 'amsr-e-l3-dailyland-v06-20041206');
INSERT INTO cs_stringrepcache VALUES (13, 4695, 'amsr-e-l3-dailyland-v06-20041207');
INSERT INTO cs_stringrepcache VALUES (13, 4696, 'amsr-e-l3-dailyland-v06-20041208');
INSERT INTO cs_stringrepcache VALUES (13, 4697, 'amsr-e-l3-dailyland-v06-20041209');
INSERT INTO cs_stringrepcache VALUES (13, 4698, 'amsr-e-l3-dailyland-v06-20041210');
INSERT INTO cs_stringrepcache VALUES (13, 4699, 'amsr-e-l3-dailyland-v06-20041211');
INSERT INTO cs_stringrepcache VALUES (13, 4700, 'amsr-e-l3-dailyland-v06-20041212');
INSERT INTO cs_stringrepcache VALUES (13, 4701, 'amsr-e-l3-dailyland-v06-20041213');
INSERT INTO cs_stringrepcache VALUES (13, 4702, 'amsr-e-l3-dailyland-v06-20041214');
INSERT INTO cs_stringrepcache VALUES (13, 4703, 'amsr-e-l3-dailyland-v06-20041215');
INSERT INTO cs_stringrepcache VALUES (13, 4704, 'amsr-e-l3-dailyland-v06-20041216');
INSERT INTO cs_stringrepcache VALUES (13, 4705, 'amsr-e-l3-dailyland-v06-20041217');
INSERT INTO cs_stringrepcache VALUES (13, 4706, 'amsr-e-l3-dailyland-v06-20041218');
INSERT INTO cs_stringrepcache VALUES (13, 4707, 'amsr-e-l3-dailyland-v06-20041219');
INSERT INTO cs_stringrepcache VALUES (13, 4708, 'amsr-e-l3-dailyland-v06-20041220');
INSERT INTO cs_stringrepcache VALUES (13, 4709, 'amsr-e-l3-dailyland-v06-20041221');
INSERT INTO cs_stringrepcache VALUES (13, 4710, 'amsr-e-l3-dailyland-v06-20041222');
INSERT INTO cs_stringrepcache VALUES (13, 4711, 'amsr-e-l3-dailyland-v06-20041223');
INSERT INTO cs_stringrepcache VALUES (13, 4712, 'amsr-e-l3-dailyland-v06-20041224');
INSERT INTO cs_stringrepcache VALUES (13, 4713, 'amsr-e-l3-dailyland-v06-20041225');
INSERT INTO cs_stringrepcache VALUES (13, 4714, 'amsr-e-l3-dailyland-v06-20041226');
INSERT INTO cs_stringrepcache VALUES (13, 4715, 'amsr-e-l3-dailyland-v06-20041227');
INSERT INTO cs_stringrepcache VALUES (13, 4716, 'amsr-e-l3-dailyland-v06-20041228');
INSERT INTO cs_stringrepcache VALUES (13, 4717, 'amsr-e-l3-dailyland-v06-20041229');
INSERT INTO cs_stringrepcache VALUES (13, 4718, 'amsr-e-l3-dailyland-v06-20041230');
INSERT INTO cs_stringrepcache VALUES (13, 4719, 'amsr-e-l3-dailyland-v06-20041231');
INSERT INTO cs_stringrepcache VALUES (13, 4720, 'amsr-e-l3-dailyland-v06-20050101');
INSERT INTO cs_stringrepcache VALUES (13, 4721, 'amsr-e-l3-dailyland-v06-20050102');
INSERT INTO cs_stringrepcache VALUES (13, 4722, 'amsr-e-l3-dailyland-v06-20050103');
INSERT INTO cs_stringrepcache VALUES (13, 4723, 'amsr-e-l3-dailyland-v06-20050104');
INSERT INTO cs_stringrepcache VALUES (13, 4724, 'amsr-e-l3-dailyland-v06-20050105');
INSERT INTO cs_stringrepcache VALUES (13, 4725, 'amsr-e-l3-dailyland-v06-20050106');
INSERT INTO cs_stringrepcache VALUES (13, 4726, 'amsr-e-l3-dailyland-v06-20050107');
INSERT INTO cs_stringrepcache VALUES (13, 4727, 'amsr-e-l3-dailyland-v06-20050108');
INSERT INTO cs_stringrepcache VALUES (13, 4728, 'amsr-e-l3-dailyland-v06-20050109');
INSERT INTO cs_stringrepcache VALUES (13, 4729, 'amsr-e-l3-dailyland-v06-20050110');
INSERT INTO cs_stringrepcache VALUES (13, 4730, 'amsr-e-l3-dailyland-v06-20050111');
INSERT INTO cs_stringrepcache VALUES (13, 4731, 'amsr-e-l3-dailyland-v06-20050112');
INSERT INTO cs_stringrepcache VALUES (13, 4732, 'amsr-e-l3-dailyland-v06-20050113');
INSERT INTO cs_stringrepcache VALUES (13, 4733, 'amsr-e-l3-dailyland-v06-20050114');
INSERT INTO cs_stringrepcache VALUES (13, 4734, 'amsr-e-l3-dailyland-v06-20050115');
INSERT INTO cs_stringrepcache VALUES (13, 4735, 'amsr-e-l3-dailyland-v06-20050116');
INSERT INTO cs_stringrepcache VALUES (13, 4736, 'amsr-e-l3-dailyland-v06-20050117');
INSERT INTO cs_stringrepcache VALUES (13, 4737, 'amsr-e-l3-dailyland-v06-20050118');
INSERT INTO cs_stringrepcache VALUES (13, 4738, 'amsr-e-l3-dailyland-v06-20050119');
INSERT INTO cs_stringrepcache VALUES (13, 4739, 'amsr-e-l3-dailyland-v06-20050120');
INSERT INTO cs_stringrepcache VALUES (13, 4740, 'amsr-e-l3-dailyland-v06-20050121');
INSERT INTO cs_stringrepcache VALUES (13, 4741, 'amsr-e-l3-dailyland-v06-20050122');
INSERT INTO cs_stringrepcache VALUES (13, 4742, 'amsr-e-l3-dailyland-v06-20050123');
INSERT INTO cs_stringrepcache VALUES (13, 4743, 'amsr-e-l3-dailyland-v06-20050124');
INSERT INTO cs_stringrepcache VALUES (13, 4744, 'amsr-e-l3-dailyland-v06-20050125');
INSERT INTO cs_stringrepcache VALUES (13, 4745, 'amsr-e-l3-dailyland-v06-20050126');
INSERT INTO cs_stringrepcache VALUES (13, 4746, 'amsr-e-l3-dailyland-v06-20050127');
INSERT INTO cs_stringrepcache VALUES (13, 4747, 'amsr-e-l3-dailyland-v06-20050128');
INSERT INTO cs_stringrepcache VALUES (13, 4748, 'amsr-e-l3-dailyland-v06-20050129');
INSERT INTO cs_stringrepcache VALUES (13, 4749, 'amsr-e-l3-dailyland-v06-20050130');
INSERT INTO cs_stringrepcache VALUES (13, 4750, 'amsr-e-l3-dailyland-v06-20050131');
INSERT INTO cs_stringrepcache VALUES (13, 4751, 'amsr-e-l3-dailyland-v06-20050201');
INSERT INTO cs_stringrepcache VALUES (13, 4752, 'amsr-e-l3-dailyland-v06-20050202');
INSERT INTO cs_stringrepcache VALUES (13, 4753, 'amsr-e-l3-dailyland-v06-20050203');
INSERT INTO cs_stringrepcache VALUES (13, 4754, 'amsr-e-l3-dailyland-v06-20050204');
INSERT INTO cs_stringrepcache VALUES (13, 4755, 'amsr-e-l3-dailyland-v06-20050205');
INSERT INTO cs_stringrepcache VALUES (13, 4756, 'amsr-e-l3-dailyland-v06-20050206');
INSERT INTO cs_stringrepcache VALUES (13, 4757, 'amsr-e-l3-dailyland-v06-20050207');
INSERT INTO cs_stringrepcache VALUES (13, 4758, 'amsr-e-l3-dailyland-v06-20050208');
INSERT INTO cs_stringrepcache VALUES (13, 4759, 'amsr-e-l3-dailyland-v06-20050209');
INSERT INTO cs_stringrepcache VALUES (13, 4760, 'amsr-e-l3-dailyland-v06-20050210');
INSERT INTO cs_stringrepcache VALUES (13, 4761, 'amsr-e-l3-dailyland-v06-20050211');
INSERT INTO cs_stringrepcache VALUES (13, 4762, 'amsr-e-l3-dailyland-v06-20050212');
INSERT INTO cs_stringrepcache VALUES (13, 4763, 'amsr-e-l3-dailyland-v06-20050213');
INSERT INTO cs_stringrepcache VALUES (13, 4764, 'amsr-e-l3-dailyland-v06-20050214');
INSERT INTO cs_stringrepcache VALUES (13, 4765, 'amsr-e-l3-dailyland-v06-20050215');
INSERT INTO cs_stringrepcache VALUES (13, 4766, 'amsr-e-l3-dailyland-v06-20050216');
INSERT INTO cs_stringrepcache VALUES (13, 4767, 'amsr-e-l3-dailyland-v06-20050217');
INSERT INTO cs_stringrepcache VALUES (13, 4768, 'amsr-e-l3-dailyland-v06-20050218');
INSERT INTO cs_stringrepcache VALUES (13, 4769, 'amsr-e-l3-dailyland-v06-20050219');
INSERT INTO cs_stringrepcache VALUES (13, 4770, 'amsr-e-l3-dailyland-v06-20050220');
INSERT INTO cs_stringrepcache VALUES (13, 4771, 'amsr-e-l3-dailyland-v06-20050221');
INSERT INTO cs_stringrepcache VALUES (13, 4772, 'amsr-e-l3-dailyland-v06-20050222');
INSERT INTO cs_stringrepcache VALUES (13, 4773, 'amsr-e-l3-dailyland-v06-20050223');
INSERT INTO cs_stringrepcache VALUES (13, 4774, 'amsr-e-l3-dailyland-v06-20050224');
INSERT INTO cs_stringrepcache VALUES (13, 4775, 'amsr-e-l3-dailyland-v06-20050225');
INSERT INTO cs_stringrepcache VALUES (13, 4776, 'amsr-e-l3-dailyland-v06-20050226');
INSERT INTO cs_stringrepcache VALUES (13, 4777, 'amsr-e-l3-dailyland-v06-20050227');
INSERT INTO cs_stringrepcache VALUES (13, 4778, 'amsr-e-l3-dailyland-v06-20050228');
INSERT INTO cs_stringrepcache VALUES (13, 4779, 'amsr-e-l3-dailyland-v06-20050301');
INSERT INTO cs_stringrepcache VALUES (13, 4780, 'amsr-e-l3-dailyland-v06-20050302');
INSERT INTO cs_stringrepcache VALUES (13, 4781, 'amsr-e-l3-dailyland-v06-20050303');
INSERT INTO cs_stringrepcache VALUES (13, 4782, 'amsr-e-l3-dailyland-v06-20050304');
INSERT INTO cs_stringrepcache VALUES (13, 4783, 'amsr-e-l3-dailyland-v06-20050305');
INSERT INTO cs_stringrepcache VALUES (13, 4784, 'amsr-e-l3-dailyland-v06-20050306');
INSERT INTO cs_stringrepcache VALUES (13, 4785, 'amsr-e-l3-dailyland-v06-20050307');
INSERT INTO cs_stringrepcache VALUES (13, 4786, 'amsr-e-l3-dailyland-v06-20050308');
INSERT INTO cs_stringrepcache VALUES (13, 4787, 'amsr-e-l3-dailyland-v06-20050309');
INSERT INTO cs_stringrepcache VALUES (13, 4788, 'amsr-e-l3-dailyland-v06-20050310');
INSERT INTO cs_stringrepcache VALUES (13, 4789, 'amsr-e-l3-dailyland-v06-20050311');
INSERT INTO cs_stringrepcache VALUES (13, 4790, 'amsr-e-l3-dailyland-v06-20050312');
INSERT INTO cs_stringrepcache VALUES (13, 4791, 'amsr-e-l3-dailyland-v06-20050313');
INSERT INTO cs_stringrepcache VALUES (13, 4792, 'amsr-e-l3-dailyland-v06-20050314');
INSERT INTO cs_stringrepcache VALUES (13, 4793, 'amsr-e-l3-dailyland-v06-20050315');
INSERT INTO cs_stringrepcache VALUES (13, 4794, 'amsr-e-l3-dailyland-v06-20050316');
INSERT INTO cs_stringrepcache VALUES (13, 4795, 'amsr-e-l3-dailyland-v06-20050317');
INSERT INTO cs_stringrepcache VALUES (13, 4796, 'amsr-e-l3-dailyland-v06-20050318');
INSERT INTO cs_stringrepcache VALUES (13, 4797, 'amsr-e-l3-dailyland-v06-20050319');
INSERT INTO cs_stringrepcache VALUES (13, 4798, 'amsr-e-l3-dailyland-v06-20050320');
INSERT INTO cs_stringrepcache VALUES (13, 4799, 'amsr-e-l3-dailyland-v06-20050321');
INSERT INTO cs_stringrepcache VALUES (13, 4800, 'amsr-e-l3-dailyland-v06-20050322');
INSERT INTO cs_stringrepcache VALUES (13, 4801, 'amsr-e-l3-dailyland-v06-20050323');
INSERT INTO cs_stringrepcache VALUES (13, 4802, 'amsr-e-l3-dailyland-v06-20050324');
INSERT INTO cs_stringrepcache VALUES (13, 4803, 'amsr-e-l3-dailyland-v06-20050325');
INSERT INTO cs_stringrepcache VALUES (13, 4804, 'amsr-e-l3-dailyland-v06-20050326');
INSERT INTO cs_stringrepcache VALUES (13, 4805, 'amsr-e-l3-dailyland-v06-20050327');
INSERT INTO cs_stringrepcache VALUES (13, 4806, 'amsr-e-l3-dailyland-v06-20050328');
INSERT INTO cs_stringrepcache VALUES (13, 4807, 'amsr-e-l3-dailyland-v06-20050329');
INSERT INTO cs_stringrepcache VALUES (13, 4808, 'amsr-e-l3-dailyland-v06-20050330');
INSERT INTO cs_stringrepcache VALUES (13, 4809, 'amsr-e-l3-dailyland-v06-20050331');
INSERT INTO cs_stringrepcache VALUES (13, 4810, 'amsr-e-l3-dailyland-v06-20050401');
INSERT INTO cs_stringrepcache VALUES (13, 4811, 'amsr-e-l3-dailyland-v06-20050402');
INSERT INTO cs_stringrepcache VALUES (13, 4812, 'amsr-e-l3-dailyland-v06-20050403');
INSERT INTO cs_stringrepcache VALUES (13, 4813, 'amsr-e-l3-dailyland-v06-20050404');
INSERT INTO cs_stringrepcache VALUES (13, 4814, 'amsr-e-l3-dailyland-v06-20050405');
INSERT INTO cs_stringrepcache VALUES (13, 4815, 'amsr-e-l3-dailyland-v06-20050406');
INSERT INTO cs_stringrepcache VALUES (13, 4816, 'amsr-e-l3-dailyland-v06-20050407');
INSERT INTO cs_stringrepcache VALUES (13, 4817, 'amsr-e-l3-dailyland-v06-20050408');
INSERT INTO cs_stringrepcache VALUES (13, 4818, 'amsr-e-l3-dailyland-v06-20050409');
INSERT INTO cs_stringrepcache VALUES (13, 4819, 'amsr-e-l3-dailyland-v06-20050410');
INSERT INTO cs_stringrepcache VALUES (13, 4820, 'amsr-e-l3-dailyland-v06-20050411');
INSERT INTO cs_stringrepcache VALUES (13, 4821, 'amsr-e-l3-dailyland-v06-20050412');
INSERT INTO cs_stringrepcache VALUES (13, 4822, 'amsr-e-l3-dailyland-v06-20050413');
INSERT INTO cs_stringrepcache VALUES (13, 4823, 'amsr-e-l3-dailyland-v06-20050414');
INSERT INTO cs_stringrepcache VALUES (13, 4824, 'amsr-e-l3-dailyland-v06-20050415');
INSERT INTO cs_stringrepcache VALUES (13, 4825, 'amsr-e-l3-dailyland-v06-20050416');
INSERT INTO cs_stringrepcache VALUES (13, 4826, 'amsr-e-l3-dailyland-v06-20050417');
INSERT INTO cs_stringrepcache VALUES (13, 4827, 'amsr-e-l3-dailyland-v06-20050418');
INSERT INTO cs_stringrepcache VALUES (13, 4828, 'amsr-e-l3-dailyland-v06-20050419');
INSERT INTO cs_stringrepcache VALUES (13, 4829, 'amsr-e-l3-dailyland-v06-20050420');
INSERT INTO cs_stringrepcache VALUES (13, 4830, 'amsr-e-l3-dailyland-v06-20050421');
INSERT INTO cs_stringrepcache VALUES (13, 4831, 'amsr-e-l3-dailyland-v06-20050422');
INSERT INTO cs_stringrepcache VALUES (13, 4832, 'amsr-e-l3-dailyland-v06-20050423');
INSERT INTO cs_stringrepcache VALUES (13, 4833, 'amsr-e-l3-dailyland-v06-20050424');
INSERT INTO cs_stringrepcache VALUES (13, 4834, 'amsr-e-l3-dailyland-v06-20050425');
INSERT INTO cs_stringrepcache VALUES (13, 4835, 'amsr-e-l3-dailyland-v06-20050426');
INSERT INTO cs_stringrepcache VALUES (13, 4836, 'amsr-e-l3-dailyland-v06-20050427');
INSERT INTO cs_stringrepcache VALUES (13, 4837, 'amsr-e-l3-dailyland-v06-20050428');
INSERT INTO cs_stringrepcache VALUES (13, 4838, 'amsr-e-l3-dailyland-v06-20050429');
INSERT INTO cs_stringrepcache VALUES (13, 4839, 'amsr-e-l3-dailyland-v06-20050430');
INSERT INTO cs_stringrepcache VALUES (13, 4840, 'amsr-e-l3-dailyland-v06-20050501');
INSERT INTO cs_stringrepcache VALUES (13, 4841, 'amsr-e-l3-dailyland-v06-20050502');
INSERT INTO cs_stringrepcache VALUES (13, 4842, 'amsr-e-l3-dailyland-v06-20050503');
INSERT INTO cs_stringrepcache VALUES (13, 4843, 'amsr-e-l3-dailyland-v06-20050504');
INSERT INTO cs_stringrepcache VALUES (13, 4844, 'amsr-e-l3-dailyland-v06-20050505');
INSERT INTO cs_stringrepcache VALUES (13, 4845, 'amsr-e-l3-dailyland-v06-20050506');
INSERT INTO cs_stringrepcache VALUES (13, 4846, 'amsr-e-l3-dailyland-v06-20050507');
INSERT INTO cs_stringrepcache VALUES (13, 4847, 'amsr-e-l3-dailyland-v06-20050508');
INSERT INTO cs_stringrepcache VALUES (13, 4848, 'amsr-e-l3-dailyland-v06-20050509');
INSERT INTO cs_stringrepcache VALUES (13, 4849, 'amsr-e-l3-dailyland-v06-20050510');
INSERT INTO cs_stringrepcache VALUES (13, 4850, 'amsr-e-l3-dailyland-v06-20050511');
INSERT INTO cs_stringrepcache VALUES (13, 4851, 'amsr-e-l3-dailyland-v06-20050512');
INSERT INTO cs_stringrepcache VALUES (13, 4852, 'amsr-e-l3-dailyland-v06-20050513');
INSERT INTO cs_stringrepcache VALUES (13, 4853, 'amsr-e-l3-dailyland-v06-20050514');
INSERT INTO cs_stringrepcache VALUES (13, 4854, 'amsr-e-l3-dailyland-v06-20050515');
INSERT INTO cs_stringrepcache VALUES (13, 4855, 'amsr-e-l3-dailyland-v06-20050516');
INSERT INTO cs_stringrepcache VALUES (13, 4856, 'amsr-e-l3-dailyland-v06-20050517');
INSERT INTO cs_stringrepcache VALUES (13, 4857, 'amsr-e-l3-dailyland-v06-20050518');
INSERT INTO cs_stringrepcache VALUES (13, 4858, 'amsr-e-l3-dailyland-v06-20050519');
INSERT INTO cs_stringrepcache VALUES (13, 4859, 'amsr-e-l3-dailyland-v06-20050520');
INSERT INTO cs_stringrepcache VALUES (13, 4860, 'amsr-e-l3-dailyland-v06-20050521');
INSERT INTO cs_stringrepcache VALUES (13, 4861, 'amsr-e-l3-dailyland-v06-20050522');
INSERT INTO cs_stringrepcache VALUES (13, 4862, 'amsr-e-l3-dailyland-v06-20050523');
INSERT INTO cs_stringrepcache VALUES (13, 4863, 'amsr-e-l3-dailyland-v06-20050524');
INSERT INTO cs_stringrepcache VALUES (13, 4864, 'amsr-e-l3-dailyland-v06-20050525');
INSERT INTO cs_stringrepcache VALUES (13, 4865, 'amsr-e-l3-dailyland-v06-20050526');
INSERT INTO cs_stringrepcache VALUES (13, 4866, 'amsr-e-l3-dailyland-v06-20050527');
INSERT INTO cs_stringrepcache VALUES (13, 4867, 'amsr-e-l3-dailyland-v06-20050528');
INSERT INTO cs_stringrepcache VALUES (13, 4868, 'amsr-e-l3-dailyland-v06-20050529');
INSERT INTO cs_stringrepcache VALUES (13, 4869, 'amsr-e-l3-dailyland-v06-20050530');
INSERT INTO cs_stringrepcache VALUES (13, 4870, 'amsr-e-l3-dailyland-v06-20050531');
INSERT INTO cs_stringrepcache VALUES (13, 4871, 'amsr-e-l3-dailyland-v06-20050601');
INSERT INTO cs_stringrepcache VALUES (13, 4872, 'amsr-e-l3-dailyland-v06-20050602');
INSERT INTO cs_stringrepcache VALUES (13, 4873, 'amsr-e-l3-dailyland-v06-20050603');
INSERT INTO cs_stringrepcache VALUES (13, 4874, 'amsr-e-l3-dailyland-v06-20050604');
INSERT INTO cs_stringrepcache VALUES (13, 4875, 'amsr-e-l3-dailyland-v06-20050605');
INSERT INTO cs_stringrepcache VALUES (13, 4876, 'amsr-e-l3-dailyland-v06-20050606');
INSERT INTO cs_stringrepcache VALUES (13, 4877, 'amsr-e-l3-dailyland-v06-20050607');
INSERT INTO cs_stringrepcache VALUES (13, 4878, 'amsr-e-l3-dailyland-v06-20050608');
INSERT INTO cs_stringrepcache VALUES (13, 4879, 'amsr-e-l3-dailyland-v06-20050609');
INSERT INTO cs_stringrepcache VALUES (13, 4880, 'amsr-e-l3-dailyland-v06-20050610');
INSERT INTO cs_stringrepcache VALUES (13, 4881, 'amsr-e-l3-dailyland-v06-20050611');
INSERT INTO cs_stringrepcache VALUES (13, 4882, 'amsr-e-l3-dailyland-v06-20050612');
INSERT INTO cs_stringrepcache VALUES (13, 4883, 'amsr-e-l3-dailyland-v06-20050613');
INSERT INTO cs_stringrepcache VALUES (13, 4884, 'amsr-e-l3-dailyland-v06-20050614');
INSERT INTO cs_stringrepcache VALUES (13, 4885, 'amsr-e-l3-dailyland-v06-20050615');
INSERT INTO cs_stringrepcache VALUES (13, 4886, 'amsr-e-l3-dailyland-v06-20050616');
INSERT INTO cs_stringrepcache VALUES (13, 4887, 'amsr-e-l3-dailyland-v06-20050617');
INSERT INTO cs_stringrepcache VALUES (13, 4888, 'amsr-e-l3-dailyland-v06-20050618');
INSERT INTO cs_stringrepcache VALUES (13, 4889, 'amsr-e-l3-dailyland-v06-20050619');
INSERT INTO cs_stringrepcache VALUES (13, 4890, 'amsr-e-l3-dailyland-v06-20050620');
INSERT INTO cs_stringrepcache VALUES (13, 4891, 'amsr-e-l3-dailyland-v06-20050621');
INSERT INTO cs_stringrepcache VALUES (13, 4892, 'amsr-e-l3-dailyland-v06-20050622');
INSERT INTO cs_stringrepcache VALUES (13, 4893, 'amsr-e-l3-dailyland-v06-20050623');
INSERT INTO cs_stringrepcache VALUES (13, 4894, 'amsr-e-l3-dailyland-v06-20050624');
INSERT INTO cs_stringrepcache VALUES (13, 4895, 'amsr-e-l3-dailyland-v06-20050625');
INSERT INTO cs_stringrepcache VALUES (13, 4896, 'amsr-e-l3-dailyland-v06-20050626');
INSERT INTO cs_stringrepcache VALUES (13, 4897, 'amsr-e-l3-dailyland-v06-20050627');
INSERT INTO cs_stringrepcache VALUES (13, 4898, 'amsr-e-l3-dailyland-v06-20050628');
INSERT INTO cs_stringrepcache VALUES (13, 4899, 'amsr-e-l3-dailyland-v06-20050629');
INSERT INTO cs_stringrepcache VALUES (13, 4900, 'amsr-e-l3-dailyland-v06-20050630');
INSERT INTO cs_stringrepcache VALUES (13, 4901, 'amsr-e-l3-dailyland-v06-20050701');
INSERT INTO cs_stringrepcache VALUES (13, 4902, 'amsr-e-l3-dailyland-v06-20050702');
INSERT INTO cs_stringrepcache VALUES (13, 4903, 'amsr-e-l3-dailyland-v06-20050703');
INSERT INTO cs_stringrepcache VALUES (13, 4904, 'amsr-e-l3-dailyland-v06-20050704');
INSERT INTO cs_stringrepcache VALUES (13, 4905, 'amsr-e-l3-dailyland-v06-20050705');
INSERT INTO cs_stringrepcache VALUES (13, 4906, 'amsr-e-l3-dailyland-v06-20050706');
INSERT INTO cs_stringrepcache VALUES (13, 4907, 'amsr-e-l3-dailyland-v06-20050707');
INSERT INTO cs_stringrepcache VALUES (13, 4908, 'amsr-e-l3-dailyland-v06-20050708');
INSERT INTO cs_stringrepcache VALUES (13, 4909, 'amsr-e-l3-dailyland-v06-20050709');
INSERT INTO cs_stringrepcache VALUES (13, 4910, 'amsr-e-l3-dailyland-v06-20050710');
INSERT INTO cs_stringrepcache VALUES (13, 4911, 'amsr-e-l3-dailyland-v06-20050711');
INSERT INTO cs_stringrepcache VALUES (13, 4912, 'amsr-e-l3-dailyland-v06-20050712');
INSERT INTO cs_stringrepcache VALUES (13, 4913, 'amsr-e-l3-dailyland-v06-20050713');
INSERT INTO cs_stringrepcache VALUES (13, 4914, 'amsr-e-l3-dailyland-v06-20050714');
INSERT INTO cs_stringrepcache VALUES (13, 4915, 'amsr-e-l3-dailyland-v06-20050715');
INSERT INTO cs_stringrepcache VALUES (13, 4916, 'amsr-e-l3-dailyland-v06-20050716');
INSERT INTO cs_stringrepcache VALUES (13, 4917, 'amsr-e-l3-dailyland-v06-20050717');
INSERT INTO cs_stringrepcache VALUES (13, 4918, 'amsr-e-l3-dailyland-v06-20050718');
INSERT INTO cs_stringrepcache VALUES (13, 4919, 'amsr-e-l3-dailyland-v06-20050719');
INSERT INTO cs_stringrepcache VALUES (13, 4920, 'amsr-e-l3-dailyland-v06-20050720');
INSERT INTO cs_stringrepcache VALUES (13, 4921, 'amsr-e-l3-dailyland-v06-20050721');
INSERT INTO cs_stringrepcache VALUES (13, 4922, 'amsr-e-l3-dailyland-v06-20050722');
INSERT INTO cs_stringrepcache VALUES (13, 4923, 'amsr-e-l3-dailyland-v06-20050723');
INSERT INTO cs_stringrepcache VALUES (13, 4924, 'amsr-e-l3-dailyland-v06-20050724');
INSERT INTO cs_stringrepcache VALUES (13, 4925, 'amsr-e-l3-dailyland-v06-20050725');
INSERT INTO cs_stringrepcache VALUES (13, 4926, 'amsr-e-l3-dailyland-v06-20050726');
INSERT INTO cs_stringrepcache VALUES (13, 4927, 'amsr-e-l3-dailyland-v06-20050727');
INSERT INTO cs_stringrepcache VALUES (13, 4928, 'amsr-e-l3-dailyland-v06-20050728');
INSERT INTO cs_stringrepcache VALUES (13, 4929, 'amsr-e-l3-dailyland-v06-20050729');
INSERT INTO cs_stringrepcache VALUES (13, 4930, 'amsr-e-l3-dailyland-v06-20050730');
INSERT INTO cs_stringrepcache VALUES (13, 4931, 'amsr-e-l3-dailyland-v06-20050731');
INSERT INTO cs_stringrepcache VALUES (13, 4932, 'amsr-e-l3-dailyland-v06-20050801');
INSERT INTO cs_stringrepcache VALUES (13, 4933, 'amsr-e-l3-dailyland-v06-20050802');
INSERT INTO cs_stringrepcache VALUES (13, 4934, 'amsr-e-l3-dailyland-v06-20050803');
INSERT INTO cs_stringrepcache VALUES (13, 4935, 'amsr-e-l3-dailyland-v06-20050804');
INSERT INTO cs_stringrepcache VALUES (13, 4936, 'amsr-e-l3-dailyland-v06-20050805');
INSERT INTO cs_stringrepcache VALUES (13, 4937, 'amsr-e-l3-dailyland-v06-20050806');
INSERT INTO cs_stringrepcache VALUES (13, 4938, 'amsr-e-l3-dailyland-v06-20050807');
INSERT INTO cs_stringrepcache VALUES (13, 4939, 'amsr-e-l3-dailyland-v06-20050808');
INSERT INTO cs_stringrepcache VALUES (13, 4940, 'amsr-e-l3-dailyland-v06-20050809');
INSERT INTO cs_stringrepcache VALUES (13, 4941, 'amsr-e-l3-dailyland-v06-20050810');
INSERT INTO cs_stringrepcache VALUES (13, 4942, 'amsr-e-l3-dailyland-v06-20050811');
INSERT INTO cs_stringrepcache VALUES (13, 4943, 'amsr-e-l3-dailyland-v06-20050812');
INSERT INTO cs_stringrepcache VALUES (13, 4944, 'amsr-e-l3-dailyland-v06-20050813');
INSERT INTO cs_stringrepcache VALUES (13, 4945, 'amsr-e-l3-dailyland-v06-20050814');
INSERT INTO cs_stringrepcache VALUES (13, 4946, 'amsr-e-l3-dailyland-v06-20050815');
INSERT INTO cs_stringrepcache VALUES (13, 4947, 'amsr-e-l3-dailyland-v06-20050816');
INSERT INTO cs_stringrepcache VALUES (13, 4948, 'amsr-e-l3-dailyland-v06-20050817');
INSERT INTO cs_stringrepcache VALUES (13, 4949, 'amsr-e-l3-dailyland-v06-20050818');
INSERT INTO cs_stringrepcache VALUES (13, 4950, 'amsr-e-l3-dailyland-v06-20050819');
INSERT INTO cs_stringrepcache VALUES (13, 4951, 'amsr-e-l3-dailyland-v06-20050820');
INSERT INTO cs_stringrepcache VALUES (13, 4952, 'amsr-e-l3-dailyland-v06-20050821');
INSERT INTO cs_stringrepcache VALUES (13, 4953, 'amsr-e-l3-dailyland-v06-20050822');
INSERT INTO cs_stringrepcache VALUES (13, 4954, 'amsr-e-l3-dailyland-v06-20050823');
INSERT INTO cs_stringrepcache VALUES (13, 4955, 'amsr-e-l3-dailyland-v06-20050824');
INSERT INTO cs_stringrepcache VALUES (13, 4956, 'amsr-e-l3-dailyland-v06-20050825');
INSERT INTO cs_stringrepcache VALUES (13, 4957, 'amsr-e-l3-dailyland-v06-20050826');
INSERT INTO cs_stringrepcache VALUES (13, 4958, 'amsr-e-l3-dailyland-v06-20050827');
INSERT INTO cs_stringrepcache VALUES (13, 4959, 'amsr-e-l3-dailyland-v06-20050828');
INSERT INTO cs_stringrepcache VALUES (13, 4960, 'amsr-e-l3-dailyland-v06-20050829');
INSERT INTO cs_stringrepcache VALUES (13, 4961, 'amsr-e-l3-dailyland-v06-20050830');
INSERT INTO cs_stringrepcache VALUES (13, 4962, 'amsr-e-l3-dailyland-v06-20050831');
INSERT INTO cs_stringrepcache VALUES (13, 4963, 'amsr-e-l3-dailyland-v06-20050901');
INSERT INTO cs_stringrepcache VALUES (13, 4964, 'amsr-e-l3-dailyland-v06-20050902');
INSERT INTO cs_stringrepcache VALUES (13, 4965, 'amsr-e-l3-dailyland-v06-20050903');
INSERT INTO cs_stringrepcache VALUES (13, 4966, 'amsr-e-l3-dailyland-v06-20050904');
INSERT INTO cs_stringrepcache VALUES (13, 4967, 'amsr-e-l3-dailyland-v06-20050905');
INSERT INTO cs_stringrepcache VALUES (13, 4968, 'amsr-e-l3-dailyland-v06-20050906');
INSERT INTO cs_stringrepcache VALUES (13, 4969, 'amsr-e-l3-dailyland-v06-20050907');
INSERT INTO cs_stringrepcache VALUES (13, 4970, 'amsr-e-l3-dailyland-v06-20050908');
INSERT INTO cs_stringrepcache VALUES (13, 4971, 'amsr-e-l3-dailyland-v06-20050909');
INSERT INTO cs_stringrepcache VALUES (13, 4972, 'amsr-e-l3-dailyland-v06-20050910');
INSERT INTO cs_stringrepcache VALUES (13, 4973, 'amsr-e-l3-dailyland-v06-20050911');
INSERT INTO cs_stringrepcache VALUES (13, 4974, 'amsr-e-l3-dailyland-v06-20050912');
INSERT INTO cs_stringrepcache VALUES (13, 4975, 'amsr-e-l3-dailyland-v06-20050913');
INSERT INTO cs_stringrepcache VALUES (13, 4976, 'amsr-e-l3-dailyland-v06-20050914');
INSERT INTO cs_stringrepcache VALUES (13, 4977, 'amsr-e-l3-dailyland-v06-20050915');
INSERT INTO cs_stringrepcache VALUES (13, 4978, 'amsr-e-l3-dailyland-v06-20050916');
INSERT INTO cs_stringrepcache VALUES (13, 4979, 'amsr-e-l3-dailyland-v06-20050917');
INSERT INTO cs_stringrepcache VALUES (13, 4980, 'amsr-e-l3-dailyland-v06-20050918');
INSERT INTO cs_stringrepcache VALUES (13, 4981, 'amsr-e-l3-dailyland-v06-20050919');
INSERT INTO cs_stringrepcache VALUES (13, 4982, 'amsr-e-l3-dailyland-v06-20050920');
INSERT INTO cs_stringrepcache VALUES (13, 4983, 'amsr-e-l3-dailyland-v06-20050921');
INSERT INTO cs_stringrepcache VALUES (13, 4984, 'amsr-e-l3-dailyland-v06-20050922');
INSERT INTO cs_stringrepcache VALUES (13, 4985, 'amsr-e-l3-dailyland-v06-20050923');
INSERT INTO cs_stringrepcache VALUES (13, 4986, 'amsr-e-l3-dailyland-v06-20050924');
INSERT INTO cs_stringrepcache VALUES (13, 4987, 'amsr-e-l3-dailyland-v06-20050925');
INSERT INTO cs_stringrepcache VALUES (13, 4988, 'amsr-e-l3-dailyland-v06-20050926');
INSERT INTO cs_stringrepcache VALUES (13, 4989, 'amsr-e-l3-dailyland-v06-20050927');
INSERT INTO cs_stringrepcache VALUES (13, 4990, 'amsr-e-l3-dailyland-v06-20050928');
INSERT INTO cs_stringrepcache VALUES (13, 4991, 'amsr-e-l3-dailyland-v06-20050929');
INSERT INTO cs_stringrepcache VALUES (13, 4992, 'amsr-e-l3-dailyland-v06-20050930');
INSERT INTO cs_stringrepcache VALUES (13, 4993, 'amsr-e-l3-dailyland-v06-20051001');
INSERT INTO cs_stringrepcache VALUES (13, 4994, 'amsr-e-l3-dailyland-v06-20051002');
INSERT INTO cs_stringrepcache VALUES (13, 4995, 'amsr-e-l3-dailyland-v06-20051003');
INSERT INTO cs_stringrepcache VALUES (13, 4996, 'amsr-e-l3-dailyland-v06-20051004');
INSERT INTO cs_stringrepcache VALUES (13, 4997, 'amsr-e-l3-dailyland-v06-20051005');
INSERT INTO cs_stringrepcache VALUES (13, 4998, 'amsr-e-l3-dailyland-v06-20051006');
INSERT INTO cs_stringrepcache VALUES (13, 4999, 'amsr-e-l3-dailyland-v06-20051007');
INSERT INTO cs_stringrepcache VALUES (13, 5000, 'amsr-e-l3-dailyland-v06-20051008');
INSERT INTO cs_stringrepcache VALUES (13, 5001, 'amsr-e-l3-dailyland-v06-20051009');
INSERT INTO cs_stringrepcache VALUES (13, 5002, 'amsr-e-l3-dailyland-v06-20051010');
INSERT INTO cs_stringrepcache VALUES (13, 5003, 'amsr-e-l3-dailyland-v06-20051011');
INSERT INTO cs_stringrepcache VALUES (13, 5004, 'amsr-e-l3-dailyland-v06-20051012');
INSERT INTO cs_stringrepcache VALUES (13, 5005, 'amsr-e-l3-dailyland-v06-20051013');
INSERT INTO cs_stringrepcache VALUES (13, 5006, 'amsr-e-l3-dailyland-v06-20051014');
INSERT INTO cs_stringrepcache VALUES (13, 5007, 'amsr-e-l3-dailyland-v06-20051015');
INSERT INTO cs_stringrepcache VALUES (13, 5008, 'amsr-e-l3-dailyland-v06-20051016');
INSERT INTO cs_stringrepcache VALUES (13, 5009, 'amsr-e-l3-dailyland-v06-20051017');
INSERT INTO cs_stringrepcache VALUES (13, 5010, 'amsr-e-l3-dailyland-v06-20051018');
INSERT INTO cs_stringrepcache VALUES (13, 5011, 'amsr-e-l3-dailyland-v06-20051019');
INSERT INTO cs_stringrepcache VALUES (13, 5012, 'amsr-e-l3-dailyland-v06-20051020');
INSERT INTO cs_stringrepcache VALUES (13, 5013, 'amsr-e-l3-dailyland-v06-20051021');
INSERT INTO cs_stringrepcache VALUES (13, 5014, 'amsr-e-l3-dailyland-v06-20051022');
INSERT INTO cs_stringrepcache VALUES (13, 5015, 'amsr-e-l3-dailyland-v06-20051023');
INSERT INTO cs_stringrepcache VALUES (13, 5016, 'amsr-e-l3-dailyland-v06-20051024');
INSERT INTO cs_stringrepcache VALUES (13, 5017, 'amsr-e-l3-dailyland-v06-20051025');
INSERT INTO cs_stringrepcache VALUES (13, 5018, 'amsr-e-l3-dailyland-v06-20051026');
INSERT INTO cs_stringrepcache VALUES (13, 5019, 'amsr-e-l3-dailyland-v06-20051027');
INSERT INTO cs_stringrepcache VALUES (13, 5020, 'amsr-e-l3-dailyland-v06-20051028');
INSERT INTO cs_stringrepcache VALUES (13, 5021, 'amsr-e-l3-dailyland-v06-20051029');
INSERT INTO cs_stringrepcache VALUES (13, 5022, 'amsr-e-l3-dailyland-v06-20051030');
INSERT INTO cs_stringrepcache VALUES (13, 5023, 'amsr-e-l3-dailyland-v06-20051031');
INSERT INTO cs_stringrepcache VALUES (13, 5024, 'amsr-e-l3-dailyland-v06-20051101');
INSERT INTO cs_stringrepcache VALUES (13, 5025, 'amsr-e-l3-dailyland-v06-20051102');
INSERT INTO cs_stringrepcache VALUES (13, 5026, 'amsr-e-l3-dailyland-v06-20051103');
INSERT INTO cs_stringrepcache VALUES (13, 5027, 'amsr-e-l3-dailyland-v06-20051104');
INSERT INTO cs_stringrepcache VALUES (13, 5028, 'amsr-e-l3-dailyland-v06-20051105');
INSERT INTO cs_stringrepcache VALUES (13, 5029, 'amsr-e-l3-dailyland-v06-20051106');
INSERT INTO cs_stringrepcache VALUES (13, 5030, 'amsr-e-l3-dailyland-v06-20051107');
INSERT INTO cs_stringrepcache VALUES (13, 5031, 'amsr-e-l3-dailyland-v06-20051108');
INSERT INTO cs_stringrepcache VALUES (13, 5032, 'amsr-e-l3-dailyland-v06-20051109');
INSERT INTO cs_stringrepcache VALUES (13, 5033, 'amsr-e-l3-dailyland-v06-20051110');
INSERT INTO cs_stringrepcache VALUES (13, 5034, 'amsr-e-l3-dailyland-v06-20051111');
INSERT INTO cs_stringrepcache VALUES (13, 5035, 'amsr-e-l3-dailyland-v06-20051112');
INSERT INTO cs_stringrepcache VALUES (13, 5036, 'amsr-e-l3-dailyland-v06-20051113');
INSERT INTO cs_stringrepcache VALUES (13, 5037, 'amsr-e-l3-dailyland-v06-20051114');
INSERT INTO cs_stringrepcache VALUES (13, 5038, 'amsr-e-l3-dailyland-v06-20051115');
INSERT INTO cs_stringrepcache VALUES (13, 5039, 'amsr-e-l3-dailyland-v06-20051116');
INSERT INTO cs_stringrepcache VALUES (13, 5040, 'amsr-e-l3-dailyland-v06-20051117');
INSERT INTO cs_stringrepcache VALUES (13, 5041, 'amsr-e-l3-dailyland-v06-20051118');
INSERT INTO cs_stringrepcache VALUES (13, 5042, 'amsr-e-l3-dailyland-v06-20051119');
INSERT INTO cs_stringrepcache VALUES (13, 5043, 'amsr-e-l3-dailyland-v06-20051120');
INSERT INTO cs_stringrepcache VALUES (13, 5044, 'amsr-e-l3-dailyland-v06-20051121');
INSERT INTO cs_stringrepcache VALUES (13, 5045, 'amsr-e-l3-dailyland-v06-20051122');
INSERT INTO cs_stringrepcache VALUES (13, 5046, 'amsr-e-l3-dailyland-v06-20051123');
INSERT INTO cs_stringrepcache VALUES (13, 5047, 'amsr-e-l3-dailyland-v06-20051124');
INSERT INTO cs_stringrepcache VALUES (13, 5048, 'amsr-e-l3-dailyland-v06-20051125');
INSERT INTO cs_stringrepcache VALUES (13, 5049, 'amsr-e-l3-dailyland-v06-20051126');
INSERT INTO cs_stringrepcache VALUES (13, 5050, 'amsr-e-l3-dailyland-v06-20051127');
INSERT INTO cs_stringrepcache VALUES (13, 5051, 'amsr-e-l3-dailyland-v06-20051128');
INSERT INTO cs_stringrepcache VALUES (13, 5052, 'amsr-e-l3-dailyland-v06-20051129');
INSERT INTO cs_stringrepcache VALUES (13, 5053, 'amsr-e-l3-dailyland-v06-20051130');
INSERT INTO cs_stringrepcache VALUES (13, 5054, 'amsr-e-l3-dailyland-v06-20051201');
INSERT INTO cs_stringrepcache VALUES (13, 5055, 'amsr-e-l3-dailyland-v06-20051202');
INSERT INTO cs_stringrepcache VALUES (13, 5056, 'amsr-e-l3-dailyland-v06-20051203');
INSERT INTO cs_stringrepcache VALUES (13, 5057, 'amsr-e-l3-dailyland-v06-20051204');
INSERT INTO cs_stringrepcache VALUES (13, 5058, 'amsr-e-l3-dailyland-v06-20051205');
INSERT INTO cs_stringrepcache VALUES (13, 5059, 'amsr-e-l3-dailyland-v06-20051206');
INSERT INTO cs_stringrepcache VALUES (13, 5060, 'amsr-e-l3-dailyland-v06-20051207');
INSERT INTO cs_stringrepcache VALUES (13, 5061, 'amsr-e-l3-dailyland-v06-20051208');
INSERT INTO cs_stringrepcache VALUES (13, 5062, 'amsr-e-l3-dailyland-v06-20051209');
INSERT INTO cs_stringrepcache VALUES (13, 5063, 'amsr-e-l3-dailyland-v06-20051210');
INSERT INTO cs_stringrepcache VALUES (13, 5064, 'amsr-e-l3-dailyland-v06-20051211');
INSERT INTO cs_stringrepcache VALUES (13, 5065, 'amsr-e-l3-dailyland-v06-20051212');
INSERT INTO cs_stringrepcache VALUES (13, 5066, 'amsr-e-l3-dailyland-v06-20051213');
INSERT INTO cs_stringrepcache VALUES (13, 5067, 'amsr-e-l3-dailyland-v06-20051214');
INSERT INTO cs_stringrepcache VALUES (13, 5068, 'amsr-e-l3-dailyland-v06-20051215');
INSERT INTO cs_stringrepcache VALUES (13, 5069, 'amsr-e-l3-dailyland-v06-20051216');
INSERT INTO cs_stringrepcache VALUES (13, 5070, 'amsr-e-l3-dailyland-v06-20051217');
INSERT INTO cs_stringrepcache VALUES (13, 5071, 'amsr-e-l3-dailyland-v06-20051218');
INSERT INTO cs_stringrepcache VALUES (13, 5072, 'amsr-e-l3-dailyland-v06-20051219');
INSERT INTO cs_stringrepcache VALUES (13, 5073, 'amsr-e-l3-dailyland-v06-20051220');
INSERT INTO cs_stringrepcache VALUES (13, 5074, 'amsr-e-l3-dailyland-v06-20051221');
INSERT INTO cs_stringrepcache VALUES (13, 5075, 'amsr-e-l3-dailyland-v06-20051222');
INSERT INTO cs_stringrepcache VALUES (13, 5076, 'amsr-e-l3-dailyland-v06-20051223');
INSERT INTO cs_stringrepcache VALUES (13, 5077, 'amsr-e-l3-dailyland-v06-20051224');
INSERT INTO cs_stringrepcache VALUES (13, 5078, 'amsr-e-l3-dailyland-v06-20051225');
INSERT INTO cs_stringrepcache VALUES (13, 5079, 'amsr-e-l3-dailyland-v06-20051226');
INSERT INTO cs_stringrepcache VALUES (13, 5080, 'amsr-e-l3-dailyland-v06-20051227');
INSERT INTO cs_stringrepcache VALUES (13, 5081, 'amsr-e-l3-dailyland-v06-20051228');
INSERT INTO cs_stringrepcache VALUES (13, 5082, 'amsr-e-l3-dailyland-v06-20051229');
INSERT INTO cs_stringrepcache VALUES (13, 5083, 'amsr-e-l3-dailyland-v06-20051230');
INSERT INTO cs_stringrepcache VALUES (13, 5084, 'amsr-e-l3-dailyland-v06-20051231');
INSERT INTO cs_stringrepcache VALUES (13, 5085, 'amsr-e-l3-dailyland-v06-20060101');
INSERT INTO cs_stringrepcache VALUES (13, 5086, 'amsr-e-l3-dailyland-v06-20060102');
INSERT INTO cs_stringrepcache VALUES (13, 5087, 'amsr-e-l3-dailyland-v06-20060103');
INSERT INTO cs_stringrepcache VALUES (13, 5088, 'amsr-e-l3-dailyland-v06-20060104');
INSERT INTO cs_stringrepcache VALUES (13, 5089, 'amsr-e-l3-dailyland-v06-20060105');
INSERT INTO cs_stringrepcache VALUES (13, 5090, 'amsr-e-l3-dailyland-v06-20060106');
INSERT INTO cs_stringrepcache VALUES (13, 5091, 'amsr-e-l3-dailyland-v06-20060107');
INSERT INTO cs_stringrepcache VALUES (13, 5092, 'amsr-e-l3-dailyland-v06-20060108');
INSERT INTO cs_stringrepcache VALUES (13, 5093, 'amsr-e-l3-dailyland-v06-20060109');
INSERT INTO cs_stringrepcache VALUES (13, 5094, 'amsr-e-l3-dailyland-v06-20060110');
INSERT INTO cs_stringrepcache VALUES (13, 5095, 'amsr-e-l3-dailyland-v06-20060111');
INSERT INTO cs_stringrepcache VALUES (13, 5096, 'amsr-e-l3-dailyland-v06-20060112');
INSERT INTO cs_stringrepcache VALUES (13, 5097, 'amsr-e-l3-dailyland-v06-20060113');
INSERT INTO cs_stringrepcache VALUES (13, 5098, 'amsr-e-l3-dailyland-v06-20060114');
INSERT INTO cs_stringrepcache VALUES (13, 5099, 'amsr-e-l3-dailyland-v06-20060115');
INSERT INTO cs_stringrepcache VALUES (13, 5100, 'amsr-e-l3-dailyland-v06-20060116');
INSERT INTO cs_stringrepcache VALUES (13, 5101, 'amsr-e-l3-dailyland-v06-20060117');
INSERT INTO cs_stringrepcache VALUES (13, 5102, 'amsr-e-l3-dailyland-v06-20060118');
INSERT INTO cs_stringrepcache VALUES (13, 5103, 'amsr-e-l3-dailyland-v06-20060119');
INSERT INTO cs_stringrepcache VALUES (13, 5104, 'amsr-e-l3-dailyland-v06-20060120');
INSERT INTO cs_stringrepcache VALUES (13, 5105, 'amsr-e-l3-dailyland-v06-20060121');
INSERT INTO cs_stringrepcache VALUES (13, 5106, 'amsr-e-l3-dailyland-v06-20060122');
INSERT INTO cs_stringrepcache VALUES (13, 5107, 'amsr-e-l3-dailyland-v06-20060123');
INSERT INTO cs_stringrepcache VALUES (13, 5108, 'amsr-e-l3-dailyland-v06-20060124');
INSERT INTO cs_stringrepcache VALUES (13, 5109, 'amsr-e-l3-dailyland-v06-20060125');
INSERT INTO cs_stringrepcache VALUES (13, 5110, 'amsr-e-l3-dailyland-v06-20060126');
INSERT INTO cs_stringrepcache VALUES (13, 5111, 'amsr-e-l3-dailyland-v06-20060127');
INSERT INTO cs_stringrepcache VALUES (13, 5112, 'amsr-e-l3-dailyland-v06-20060128');
INSERT INTO cs_stringrepcache VALUES (13, 5113, 'amsr-e-l3-dailyland-v06-20060129');
INSERT INTO cs_stringrepcache VALUES (13, 5114, 'amsr-e-l3-dailyland-v06-20060130');
INSERT INTO cs_stringrepcache VALUES (13, 5115, 'amsr-e-l3-dailyland-v06-20060131');
INSERT INTO cs_stringrepcache VALUES (13, 5116, 'amsr-e-l3-dailyland-v06-20060201');
INSERT INTO cs_stringrepcache VALUES (13, 5117, 'amsr-e-l3-dailyland-v06-20060202');
INSERT INTO cs_stringrepcache VALUES (13, 5118, 'amsr-e-l3-dailyland-v06-20060203');
INSERT INTO cs_stringrepcache VALUES (13, 5119, 'amsr-e-l3-dailyland-v06-20060204');
INSERT INTO cs_stringrepcache VALUES (13, 5120, 'amsr-e-l3-dailyland-v06-20060205');
INSERT INTO cs_stringrepcache VALUES (13, 5121, 'amsr-e-l3-dailyland-v06-20060206');
INSERT INTO cs_stringrepcache VALUES (13, 5122, 'amsr-e-l3-dailyland-v06-20060207');
INSERT INTO cs_stringrepcache VALUES (13, 5123, 'amsr-e-l3-dailyland-v06-20060208');
INSERT INTO cs_stringrepcache VALUES (13, 5124, 'amsr-e-l3-dailyland-v06-20060209');
INSERT INTO cs_stringrepcache VALUES (13, 5125, 'amsr-e-l3-dailyland-v06-20060210');
INSERT INTO cs_stringrepcache VALUES (13, 5126, 'amsr-e-l3-dailyland-v06-20060211');
INSERT INTO cs_stringrepcache VALUES (13, 5127, 'amsr-e-l3-dailyland-v06-20060212');
INSERT INTO cs_stringrepcache VALUES (13, 5128, 'amsr-e-l3-dailyland-v06-20060213');
INSERT INTO cs_stringrepcache VALUES (13, 5129, 'amsr-e-l3-dailyland-v06-20060214');
INSERT INTO cs_stringrepcache VALUES (13, 5130, 'amsr-e-l3-dailyland-v06-20060215');
INSERT INTO cs_stringrepcache VALUES (13, 5131, 'amsr-e-l3-dailyland-v06-20060216');
INSERT INTO cs_stringrepcache VALUES (13, 5132, 'amsr-e-l3-dailyland-v06-20060217');
INSERT INTO cs_stringrepcache VALUES (13, 5133, 'amsr-e-l3-dailyland-v06-20060218');
INSERT INTO cs_stringrepcache VALUES (13, 5134, 'amsr-e-l3-dailyland-v06-20060219');
INSERT INTO cs_stringrepcache VALUES (13, 5135, 'amsr-e-l3-dailyland-v06-20060220');
INSERT INTO cs_stringrepcache VALUES (13, 5136, 'amsr-e-l3-dailyland-v06-20060221');
INSERT INTO cs_stringrepcache VALUES (13, 5137, 'amsr-e-l3-dailyland-v06-20060222');
INSERT INTO cs_stringrepcache VALUES (13, 5138, 'amsr-e-l3-dailyland-v06-20060223');
INSERT INTO cs_stringrepcache VALUES (13, 5139, 'amsr-e-l3-dailyland-v06-20060224');
INSERT INTO cs_stringrepcache VALUES (13, 5140, 'amsr-e-l3-dailyland-v06-20060225');
INSERT INTO cs_stringrepcache VALUES (13, 5141, 'amsr-e-l3-dailyland-v06-20060226');
INSERT INTO cs_stringrepcache VALUES (13, 5142, 'amsr-e-l3-dailyland-v06-20060227');
INSERT INTO cs_stringrepcache VALUES (13, 5143, 'amsr-e-l3-dailyland-v06-20060228');
INSERT INTO cs_stringrepcache VALUES (13, 5144, 'amsr-e-l3-dailyland-v06-20060301');
INSERT INTO cs_stringrepcache VALUES (13, 5145, 'amsr-e-l3-dailyland-v06-20060302');
INSERT INTO cs_stringrepcache VALUES (13, 5146, 'amsr-e-l3-dailyland-v06-20060303');
INSERT INTO cs_stringrepcache VALUES (13, 5147, 'amsr-e-l3-dailyland-v06-20060304');
INSERT INTO cs_stringrepcache VALUES (13, 5148, 'amsr-e-l3-dailyland-v06-20060305');
INSERT INTO cs_stringrepcache VALUES (13, 5149, 'amsr-e-l3-dailyland-v06-20060306');
INSERT INTO cs_stringrepcache VALUES (13, 5150, 'amsr-e-l3-dailyland-v06-20060307');
INSERT INTO cs_stringrepcache VALUES (13, 5151, 'amsr-e-l3-dailyland-v06-20060308');
INSERT INTO cs_stringrepcache VALUES (13, 5152, 'amsr-e-l3-dailyland-v06-20060309');
INSERT INTO cs_stringrepcache VALUES (13, 5153, 'amsr-e-l3-dailyland-v06-20060310');
INSERT INTO cs_stringrepcache VALUES (13, 5154, 'amsr-e-l3-dailyland-v06-20060311');
INSERT INTO cs_stringrepcache VALUES (13, 5155, 'amsr-e-l3-dailyland-v06-20060312');
INSERT INTO cs_stringrepcache VALUES (13, 5156, 'amsr-e-l3-dailyland-v06-20060313');
INSERT INTO cs_stringrepcache VALUES (13, 5157, 'amsr-e-l3-dailyland-v06-20060314');
INSERT INTO cs_stringrepcache VALUES (13, 5158, 'amsr-e-l3-dailyland-v06-20060315');
INSERT INTO cs_stringrepcache VALUES (13, 5159, 'amsr-e-l3-dailyland-v06-20060316');
INSERT INTO cs_stringrepcache VALUES (13, 5160, 'amsr-e-l3-dailyland-v06-20060317');
INSERT INTO cs_stringrepcache VALUES (13, 5161, 'amsr-e-l3-dailyland-v06-20060318');
INSERT INTO cs_stringrepcache VALUES (13, 5162, 'amsr-e-l3-dailyland-v06-20060319');
INSERT INTO cs_stringrepcache VALUES (13, 5163, 'amsr-e-l3-dailyland-v06-20060320');
INSERT INTO cs_stringrepcache VALUES (13, 5164, 'amsr-e-l3-dailyland-v06-20060321');
INSERT INTO cs_stringrepcache VALUES (13, 5165, 'amsr-e-l3-dailyland-v06-20060322');
INSERT INTO cs_stringrepcache VALUES (13, 5166, 'amsr-e-l3-dailyland-v06-20060323');
INSERT INTO cs_stringrepcache VALUES (13, 5167, 'amsr-e-l3-dailyland-v06-20060324');
INSERT INTO cs_stringrepcache VALUES (13, 5168, 'amsr-e-l3-dailyland-v06-20060325');
INSERT INTO cs_stringrepcache VALUES (13, 5169, 'amsr-e-l3-dailyland-v06-20060326');
INSERT INTO cs_stringrepcache VALUES (13, 5170, 'amsr-e-l3-dailyland-v06-20060327');
INSERT INTO cs_stringrepcache VALUES (13, 5171, 'amsr-e-l3-dailyland-v06-20060328');
INSERT INTO cs_stringrepcache VALUES (13, 5172, 'amsr-e-l3-dailyland-v06-20060329');
INSERT INTO cs_stringrepcache VALUES (13, 5173, 'amsr-e-l3-dailyland-v06-20060330');
INSERT INTO cs_stringrepcache VALUES (13, 5174, 'amsr-e-l3-dailyland-v06-20060331');
INSERT INTO cs_stringrepcache VALUES (13, 5175, 'amsr-e-l3-dailyland-v06-20060401');
INSERT INTO cs_stringrepcache VALUES (13, 5176, 'amsr-e-l3-dailyland-v06-20060402');
INSERT INTO cs_stringrepcache VALUES (13, 5177, 'amsr-e-l3-dailyland-v06-20060403');
INSERT INTO cs_stringrepcache VALUES (13, 5178, 'amsr-e-l3-dailyland-v06-20060404');
INSERT INTO cs_stringrepcache VALUES (13, 5179, 'amsr-e-l3-dailyland-v06-20060405');
INSERT INTO cs_stringrepcache VALUES (13, 5180, 'amsr-e-l3-dailyland-v06-20060406');
INSERT INTO cs_stringrepcache VALUES (13, 5181, 'amsr-e-l3-dailyland-v06-20060407');
INSERT INTO cs_stringrepcache VALUES (13, 5182, 'amsr-e-l3-dailyland-v06-20060408');
INSERT INTO cs_stringrepcache VALUES (13, 5183, 'amsr-e-l3-dailyland-v06-20060409');
INSERT INTO cs_stringrepcache VALUES (13, 5184, 'amsr-e-l3-dailyland-v06-20060410');
INSERT INTO cs_stringrepcache VALUES (13, 5185, 'amsr-e-l3-dailyland-v06-20060411');
INSERT INTO cs_stringrepcache VALUES (13, 5186, 'amsr-e-l3-dailyland-v06-20060412');
INSERT INTO cs_stringrepcache VALUES (13, 5187, 'amsr-e-l3-dailyland-v06-20060413');
INSERT INTO cs_stringrepcache VALUES (13, 5188, 'amsr-e-l3-dailyland-v06-20060414');
INSERT INTO cs_stringrepcache VALUES (13, 5189, 'amsr-e-l3-dailyland-v06-20060415');
INSERT INTO cs_stringrepcache VALUES (13, 5190, 'amsr-e-l3-dailyland-v06-20060416');
INSERT INTO cs_stringrepcache VALUES (13, 5191, 'amsr-e-l3-dailyland-v06-20060417');
INSERT INTO cs_stringrepcache VALUES (13, 5192, 'amsr-e-l3-dailyland-v06-20060418');
INSERT INTO cs_stringrepcache VALUES (13, 5193, 'amsr-e-l3-dailyland-v06-20060419');
INSERT INTO cs_stringrepcache VALUES (13, 5194, 'amsr-e-l3-dailyland-v06-20060420');
INSERT INTO cs_stringrepcache VALUES (13, 5195, 'amsr-e-l3-dailyland-v06-20060421');
INSERT INTO cs_stringrepcache VALUES (13, 5196, 'amsr-e-l3-dailyland-v06-20060422');
INSERT INTO cs_stringrepcache VALUES (13, 5197, 'amsr-e-l3-dailyland-v06-20060423');
INSERT INTO cs_stringrepcache VALUES (13, 5198, 'amsr-e-l3-dailyland-v06-20060424');
INSERT INTO cs_stringrepcache VALUES (13, 5199, 'amsr-e-l3-dailyland-v06-20060425');
INSERT INTO cs_stringrepcache VALUES (13, 5200, 'amsr-e-l3-dailyland-v06-20060426');
INSERT INTO cs_stringrepcache VALUES (13, 5201, 'amsr-e-l3-dailyland-v06-20060427');
INSERT INTO cs_stringrepcache VALUES (13, 5202, 'amsr-e-l3-dailyland-v06-20060428');
INSERT INTO cs_stringrepcache VALUES (13, 5203, 'amsr-e-l3-dailyland-v06-20060429');
INSERT INTO cs_stringrepcache VALUES (13, 5204, 'amsr-e-l3-dailyland-v06-20060430');
INSERT INTO cs_stringrepcache VALUES (13, 5205, 'amsr-e-l3-dailyland-v06-20060501');
INSERT INTO cs_stringrepcache VALUES (13, 5206, 'amsr-e-l3-dailyland-v06-20060502');
INSERT INTO cs_stringrepcache VALUES (13, 5207, 'amsr-e-l3-dailyland-v06-20060503');
INSERT INTO cs_stringrepcache VALUES (13, 5208, 'amsr-e-l3-dailyland-v06-20060504');
INSERT INTO cs_stringrepcache VALUES (13, 5209, 'amsr-e-l3-dailyland-v06-20060505');
INSERT INTO cs_stringrepcache VALUES (13, 5210, 'amsr-e-l3-dailyland-v06-20060506');
INSERT INTO cs_stringrepcache VALUES (13, 5211, 'amsr-e-l3-dailyland-v06-20060507');
INSERT INTO cs_stringrepcache VALUES (13, 5212, 'amsr-e-l3-dailyland-v06-20060508');
INSERT INTO cs_stringrepcache VALUES (13, 5213, 'amsr-e-l3-dailyland-v06-20060509');
INSERT INTO cs_stringrepcache VALUES (13, 5214, 'amsr-e-l3-dailyland-v06-20060510');
INSERT INTO cs_stringrepcache VALUES (13, 5215, 'amsr-e-l3-dailyland-v06-20060511');
INSERT INTO cs_stringrepcache VALUES (13, 5216, 'amsr-e-l3-dailyland-v06-20060512');
INSERT INTO cs_stringrepcache VALUES (13, 5217, 'amsr-e-l3-dailyland-v06-20060513');
INSERT INTO cs_stringrepcache VALUES (13, 5218, 'amsr-e-l3-dailyland-v06-20060514');
INSERT INTO cs_stringrepcache VALUES (13, 5219, 'amsr-e-l3-dailyland-v06-20060515');
INSERT INTO cs_stringrepcache VALUES (13, 5220, 'amsr-e-l3-dailyland-v06-20060516');
INSERT INTO cs_stringrepcache VALUES (13, 5221, 'amsr-e-l3-dailyland-v06-20060517');
INSERT INTO cs_stringrepcache VALUES (13, 5222, 'amsr-e-l3-dailyland-v06-20060518');
INSERT INTO cs_stringrepcache VALUES (13, 5223, 'amsr-e-l3-dailyland-v06-20060519');
INSERT INTO cs_stringrepcache VALUES (13, 5224, 'amsr-e-l3-dailyland-v06-20060520');
INSERT INTO cs_stringrepcache VALUES (13, 5225, 'amsr-e-l3-dailyland-v06-20060521');
INSERT INTO cs_stringrepcache VALUES (13, 5226, 'amsr-e-l3-dailyland-v06-20060522');
INSERT INTO cs_stringrepcache VALUES (13, 5227, 'amsr-e-l3-dailyland-v06-20060523');
INSERT INTO cs_stringrepcache VALUES (13, 5228, 'amsr-e-l3-dailyland-v06-20060524');
INSERT INTO cs_stringrepcache VALUES (13, 5229, 'amsr-e-l3-dailyland-v06-20060525');
INSERT INTO cs_stringrepcache VALUES (13, 5230, 'amsr-e-l3-dailyland-v06-20060526');
INSERT INTO cs_stringrepcache VALUES (13, 5231, 'amsr-e-l3-dailyland-v06-20060527');
INSERT INTO cs_stringrepcache VALUES (13, 5232, 'amsr-e-l3-dailyland-v06-20060528');
INSERT INTO cs_stringrepcache VALUES (13, 5233, 'amsr-e-l3-dailyland-v06-20060529');
INSERT INTO cs_stringrepcache VALUES (13, 5234, 'amsr-e-l3-dailyland-v06-20060530');
INSERT INTO cs_stringrepcache VALUES (13, 5235, 'amsr-e-l3-dailyland-v06-20060531');
INSERT INTO cs_stringrepcache VALUES (13, 5236, 'amsr-e-l3-dailyland-v06-20060601');
INSERT INTO cs_stringrepcache VALUES (13, 5237, 'amsr-e-l3-dailyland-v06-20060602');
INSERT INTO cs_stringrepcache VALUES (13, 5238, 'amsr-e-l3-dailyland-v06-20060603');
INSERT INTO cs_stringrepcache VALUES (13, 5239, 'amsr-e-l3-dailyland-v06-20060604');
INSERT INTO cs_stringrepcache VALUES (13, 5240, 'amsr-e-l3-dailyland-v06-20060605');
INSERT INTO cs_stringrepcache VALUES (13, 5241, 'amsr-e-l3-dailyland-v06-20060606');
INSERT INTO cs_stringrepcache VALUES (13, 5242, 'amsr-e-l3-dailyland-v06-20060607');
INSERT INTO cs_stringrepcache VALUES (13, 5243, 'amsr-e-l3-dailyland-v06-20060608');
INSERT INTO cs_stringrepcache VALUES (13, 5244, 'amsr-e-l3-dailyland-v06-20060609');
INSERT INTO cs_stringrepcache VALUES (13, 5245, 'amsr-e-l3-dailyland-v06-20060610');
INSERT INTO cs_stringrepcache VALUES (13, 5246, 'amsr-e-l3-dailyland-v06-20060611');
INSERT INTO cs_stringrepcache VALUES (13, 5247, 'amsr-e-l3-dailyland-v06-20060612');
INSERT INTO cs_stringrepcache VALUES (13, 5248, 'amsr-e-l3-dailyland-v06-20060613');
INSERT INTO cs_stringrepcache VALUES (13, 5249, 'amsr-e-l3-dailyland-v06-20060614');
INSERT INTO cs_stringrepcache VALUES (13, 5250, 'amsr-e-l3-dailyland-v06-20060615');
INSERT INTO cs_stringrepcache VALUES (13, 5251, 'amsr-e-l3-dailyland-v06-20060616');
INSERT INTO cs_stringrepcache VALUES (13, 5252, 'amsr-e-l3-dailyland-v06-20060617');
INSERT INTO cs_stringrepcache VALUES (13, 5253, 'amsr-e-l3-dailyland-v06-20060618');
INSERT INTO cs_stringrepcache VALUES (13, 5254, 'amsr-e-l3-dailyland-v06-20060619');
INSERT INTO cs_stringrepcache VALUES (13, 5255, 'amsr-e-l3-dailyland-v06-20060620');
INSERT INTO cs_stringrepcache VALUES (13, 5256, 'amsr-e-l3-dailyland-v06-20060621');
INSERT INTO cs_stringrepcache VALUES (13, 5257, 'amsr-e-l3-dailyland-v06-20060622');
INSERT INTO cs_stringrepcache VALUES (13, 5258, 'amsr-e-l3-dailyland-v06-20060623');
INSERT INTO cs_stringrepcache VALUES (13, 5259, 'amsr-e-l3-dailyland-v06-20060624');
INSERT INTO cs_stringrepcache VALUES (13, 5260, 'amsr-e-l3-dailyland-v06-20060625');
INSERT INTO cs_stringrepcache VALUES (13, 5261, 'amsr-e-l3-dailyland-v06-20060626');
INSERT INTO cs_stringrepcache VALUES (13, 5262, 'amsr-e-l3-dailyland-v06-20060627');
INSERT INTO cs_stringrepcache VALUES (13, 5263, 'amsr-e-l3-dailyland-v06-20060628');
INSERT INTO cs_stringrepcache VALUES (13, 5264, 'amsr-e-l3-dailyland-v06-20060629');
INSERT INTO cs_stringrepcache VALUES (13, 5265, 'amsr-e-l3-dailyland-v06-20060630');
INSERT INTO cs_stringrepcache VALUES (13, 5266, 'amsr-e-l3-dailyland-v06-20060701');
INSERT INTO cs_stringrepcache VALUES (13, 5267, 'amsr-e-l3-dailyland-v06-20060702');
INSERT INTO cs_stringrepcache VALUES (13, 5268, 'amsr-e-l3-dailyland-v06-20060703');
INSERT INTO cs_stringrepcache VALUES (13, 5269, 'amsr-e-l3-dailyland-v06-20060704');
INSERT INTO cs_stringrepcache VALUES (13, 5270, 'amsr-e-l3-dailyland-v06-20060705');
INSERT INTO cs_stringrepcache VALUES (13, 5271, 'amsr-e-l3-dailyland-v06-20060706');
INSERT INTO cs_stringrepcache VALUES (13, 5272, 'amsr-e-l3-dailyland-v06-20060707');
INSERT INTO cs_stringrepcache VALUES (13, 5273, 'amsr-e-l3-dailyland-v06-20060708');
INSERT INTO cs_stringrepcache VALUES (13, 5274, 'amsr-e-l3-dailyland-v06-20060709');
INSERT INTO cs_stringrepcache VALUES (13, 5275, 'amsr-e-l3-dailyland-v06-20060710');
INSERT INTO cs_stringrepcache VALUES (13, 5276, 'amsr-e-l3-dailyland-v06-20060711');
INSERT INTO cs_stringrepcache VALUES (13, 5277, 'amsr-e-l3-dailyland-v06-20060712');
INSERT INTO cs_stringrepcache VALUES (13, 5278, 'amsr-e-l3-dailyland-v06-20060713');
INSERT INTO cs_stringrepcache VALUES (13, 5279, 'amsr-e-l3-dailyland-v06-20060714');
INSERT INTO cs_stringrepcache VALUES (13, 5280, 'amsr-e-l3-dailyland-v06-20060715');
INSERT INTO cs_stringrepcache VALUES (13, 5281, 'amsr-e-l3-dailyland-v06-20060716');
INSERT INTO cs_stringrepcache VALUES (13, 5282, 'amsr-e-l3-dailyland-v06-20060717');
INSERT INTO cs_stringrepcache VALUES (13, 5283, 'amsr-e-l3-dailyland-v06-20060718');
INSERT INTO cs_stringrepcache VALUES (13, 5284, 'amsr-e-l3-dailyland-v06-20060719');
INSERT INTO cs_stringrepcache VALUES (13, 5285, 'amsr-e-l3-dailyland-v06-20060720');
INSERT INTO cs_stringrepcache VALUES (13, 5286, 'amsr-e-l3-dailyland-v06-20060721');
INSERT INTO cs_stringrepcache VALUES (13, 5287, 'amsr-e-l3-dailyland-v06-20060722');
INSERT INTO cs_stringrepcache VALUES (13, 5288, 'amsr-e-l3-dailyland-v06-20060723');
INSERT INTO cs_stringrepcache VALUES (13, 5289, 'amsr-e-l3-dailyland-v06-20060724');
INSERT INTO cs_stringrepcache VALUES (13, 5290, 'amsr-e-l3-dailyland-v06-20060725');
INSERT INTO cs_stringrepcache VALUES (13, 5291, 'amsr-e-l3-dailyland-v06-20060726');
INSERT INTO cs_stringrepcache VALUES (13, 5292, 'amsr-e-l3-dailyland-v06-20060727');
INSERT INTO cs_stringrepcache VALUES (13, 5293, 'amsr-e-l3-dailyland-v06-20060728');
INSERT INTO cs_stringrepcache VALUES (13, 5294, 'amsr-e-l3-dailyland-v06-20060729');
INSERT INTO cs_stringrepcache VALUES (13, 5295, 'amsr-e-l3-dailyland-v06-20060730');
INSERT INTO cs_stringrepcache VALUES (13, 5296, 'amsr-e-l3-dailyland-v06-20060731');
INSERT INTO cs_stringrepcache VALUES (13, 5297, 'amsr-e-l3-dailyland-v06-20060801');
INSERT INTO cs_stringrepcache VALUES (13, 5298, 'amsr-e-l3-dailyland-v06-20060802');
INSERT INTO cs_stringrepcache VALUES (13, 5299, 'amsr-e-l3-dailyland-v06-20060803');
INSERT INTO cs_stringrepcache VALUES (13, 5300, 'amsr-e-l3-dailyland-v06-20060804');
INSERT INTO cs_stringrepcache VALUES (13, 5301, 'amsr-e-l3-dailyland-v06-20060805');
INSERT INTO cs_stringrepcache VALUES (13, 5302, 'amsr-e-l3-dailyland-v06-20060806');
INSERT INTO cs_stringrepcache VALUES (13, 5303, 'amsr-e-l3-dailyland-v06-20060807');
INSERT INTO cs_stringrepcache VALUES (13, 5304, 'amsr-e-l3-dailyland-v06-20060808');
INSERT INTO cs_stringrepcache VALUES (13, 5305, 'amsr-e-l3-dailyland-v06-20060809');
INSERT INTO cs_stringrepcache VALUES (13, 5306, 'amsr-e-l3-dailyland-v06-20060810');
INSERT INTO cs_stringrepcache VALUES (13, 5307, 'amsr-e-l3-dailyland-v06-20060811');
INSERT INTO cs_stringrepcache VALUES (13, 5308, 'amsr-e-l3-dailyland-v06-20060812');
INSERT INTO cs_stringrepcache VALUES (13, 5309, 'amsr-e-l3-dailyland-v06-20060813');
INSERT INTO cs_stringrepcache VALUES (13, 5310, 'amsr-e-l3-dailyland-v06-20060814');
INSERT INTO cs_stringrepcache VALUES (13, 5311, 'amsr-e-l3-dailyland-v06-20060815');
INSERT INTO cs_stringrepcache VALUES (13, 5312, 'amsr-e-l3-dailyland-v06-20060816');
INSERT INTO cs_stringrepcache VALUES (13, 5313, 'amsr-e-l3-dailyland-v06-20060817');
INSERT INTO cs_stringrepcache VALUES (13, 5314, 'amsr-e-l3-dailyland-v06-20060818');
INSERT INTO cs_stringrepcache VALUES (13, 5315, 'amsr-e-l3-dailyland-v06-20060819');
INSERT INTO cs_stringrepcache VALUES (13, 5316, 'amsr-e-l3-dailyland-v06-20060820');
INSERT INTO cs_stringrepcache VALUES (13, 5317, 'amsr-e-l3-dailyland-v06-20060821');
INSERT INTO cs_stringrepcache VALUES (13, 5318, 'amsr-e-l3-dailyland-v06-20060822');
INSERT INTO cs_stringrepcache VALUES (13, 5319, 'amsr-e-l3-dailyland-v06-20060823');
INSERT INTO cs_stringrepcache VALUES (13, 5320, 'amsr-e-l3-dailyland-v06-20060824');
INSERT INTO cs_stringrepcache VALUES (13, 5321, 'amsr-e-l3-dailyland-v06-20060825');
INSERT INTO cs_stringrepcache VALUES (13, 5322, 'amsr-e-l3-dailyland-v06-20060826');
INSERT INTO cs_stringrepcache VALUES (13, 5323, 'amsr-e-l3-dailyland-v06-20060827');
INSERT INTO cs_stringrepcache VALUES (13, 5324, 'amsr-e-l3-dailyland-v06-20060828');
INSERT INTO cs_stringrepcache VALUES (13, 5325, 'amsr-e-l3-dailyland-v06-20060829');
INSERT INTO cs_stringrepcache VALUES (13, 5326, 'amsr-e-l3-dailyland-v06-20060830');
INSERT INTO cs_stringrepcache VALUES (13, 5327, 'amsr-e-l3-dailyland-v06-20060831');
INSERT INTO cs_stringrepcache VALUES (13, 5328, 'amsr-e-l3-dailyland-v06-20060901');
INSERT INTO cs_stringrepcache VALUES (13, 5329, 'amsr-e-l3-dailyland-v06-20060902');
INSERT INTO cs_stringrepcache VALUES (13, 5330, 'amsr-e-l3-dailyland-v06-20060903');
INSERT INTO cs_stringrepcache VALUES (13, 5331, 'amsr-e-l3-dailyland-v06-20060904');
INSERT INTO cs_stringrepcache VALUES (13, 5332, 'amsr-e-l3-dailyland-v06-20060905');
INSERT INTO cs_stringrepcache VALUES (13, 5333, 'amsr-e-l3-dailyland-v06-20060906');
INSERT INTO cs_stringrepcache VALUES (13, 5334, 'amsr-e-l3-dailyland-v06-20060907');
INSERT INTO cs_stringrepcache VALUES (13, 5335, 'amsr-e-l3-dailyland-v06-20060908');
INSERT INTO cs_stringrepcache VALUES (13, 5336, 'amsr-e-l3-dailyland-v06-20060909');
INSERT INTO cs_stringrepcache VALUES (13, 5337, 'amsr-e-l3-dailyland-v06-20060910');
INSERT INTO cs_stringrepcache VALUES (13, 5338, 'amsr-e-l3-dailyland-v06-20060911');
INSERT INTO cs_stringrepcache VALUES (13, 5339, 'amsr-e-l3-dailyland-v06-20060912');
INSERT INTO cs_stringrepcache VALUES (13, 5340, 'amsr-e-l3-dailyland-v06-20060913');
INSERT INTO cs_stringrepcache VALUES (13, 5341, 'amsr-e-l3-dailyland-v06-20060914');
INSERT INTO cs_stringrepcache VALUES (13, 5342, 'amsr-e-l3-dailyland-v06-20060915');
INSERT INTO cs_stringrepcache VALUES (13, 5343, 'amsr-e-l3-dailyland-v06-20060916');
INSERT INTO cs_stringrepcache VALUES (13, 5344, 'amsr-e-l3-dailyland-v06-20060917');
INSERT INTO cs_stringrepcache VALUES (13, 5345, 'amsr-e-l3-dailyland-v06-20060918');
INSERT INTO cs_stringrepcache VALUES (13, 5346, 'amsr-e-l3-dailyland-v06-20060919');
INSERT INTO cs_stringrepcache VALUES (13, 5347, 'amsr-e-l3-dailyland-v06-20060920');
INSERT INTO cs_stringrepcache VALUES (13, 5348, 'amsr-e-l3-dailyland-v06-20060921');
INSERT INTO cs_stringrepcache VALUES (13, 5349, 'amsr-e-l3-dailyland-v06-20060922');
INSERT INTO cs_stringrepcache VALUES (13, 5350, 'amsr-e-l3-dailyland-v06-20060923');
INSERT INTO cs_stringrepcache VALUES (13, 5351, 'amsr-e-l3-dailyland-v06-20060924');
INSERT INTO cs_stringrepcache VALUES (13, 5352, 'amsr-e-l3-dailyland-v06-20060925');
INSERT INTO cs_stringrepcache VALUES (13, 5353, 'amsr-e-l3-dailyland-v06-20060926');
INSERT INTO cs_stringrepcache VALUES (13, 5354, 'amsr-e-l3-dailyland-v06-20060927');
INSERT INTO cs_stringrepcache VALUES (13, 5355, 'amsr-e-l3-dailyland-v06-20060928');
INSERT INTO cs_stringrepcache VALUES (13, 5356, 'amsr-e-l3-dailyland-v06-20060929');
INSERT INTO cs_stringrepcache VALUES (13, 5357, 'amsr-e-l3-dailyland-v06-20060930');
INSERT INTO cs_stringrepcache VALUES (13, 5358, 'amsr-e-l3-dailyland-v06-20061001');
INSERT INTO cs_stringrepcache VALUES (13, 5359, 'amsr-e-l3-dailyland-v06-20061002');
INSERT INTO cs_stringrepcache VALUES (13, 5360, 'amsr-e-l3-dailyland-v06-20061003');
INSERT INTO cs_stringrepcache VALUES (13, 5361, 'amsr-e-l3-dailyland-v06-20061004');
INSERT INTO cs_stringrepcache VALUES (13, 5362, 'amsr-e-l3-dailyland-v06-20061005');
INSERT INTO cs_stringrepcache VALUES (13, 5363, 'amsr-e-l3-dailyland-v06-20061006');
INSERT INTO cs_stringrepcache VALUES (13, 5364, 'amsr-e-l3-dailyland-v06-20061007');
INSERT INTO cs_stringrepcache VALUES (13, 5365, 'amsr-e-l3-dailyland-v06-20061008');
INSERT INTO cs_stringrepcache VALUES (13, 5366, 'amsr-e-l3-dailyland-v06-20061009');
INSERT INTO cs_stringrepcache VALUES (13, 5367, 'amsr-e-l3-dailyland-v06-20061010');
INSERT INTO cs_stringrepcache VALUES (13, 5368, 'amsr-e-l3-dailyland-v06-20061011');
INSERT INTO cs_stringrepcache VALUES (13, 5369, 'amsr-e-l3-dailyland-v06-20061012');
INSERT INTO cs_stringrepcache VALUES (13, 5370, 'amsr-e-l3-dailyland-v06-20061013');
INSERT INTO cs_stringrepcache VALUES (13, 5371, 'amsr-e-l3-dailyland-v06-20061014');
INSERT INTO cs_stringrepcache VALUES (13, 5372, 'amsr-e-l3-dailyland-v06-20061015');
INSERT INTO cs_stringrepcache VALUES (13, 5373, 'amsr-e-l3-dailyland-v06-20061016');
INSERT INTO cs_stringrepcache VALUES (13, 5374, 'amsr-e-l3-dailyland-v06-20061017');
INSERT INTO cs_stringrepcache VALUES (13, 5375, 'amsr-e-l3-dailyland-v06-20061018');
INSERT INTO cs_stringrepcache VALUES (13, 5376, 'amsr-e-l3-dailyland-v06-20061019');
INSERT INTO cs_stringrepcache VALUES (13, 5377, 'amsr-e-l3-dailyland-v06-20061020');
INSERT INTO cs_stringrepcache VALUES (13, 5378, 'amsr-e-l3-dailyland-v06-20061021');
INSERT INTO cs_stringrepcache VALUES (13, 5379, 'amsr-e-l3-dailyland-v06-20061022');
INSERT INTO cs_stringrepcache VALUES (13, 5380, 'amsr-e-l3-dailyland-v06-20061023');
INSERT INTO cs_stringrepcache VALUES (13, 5381, 'amsr-e-l3-dailyland-v06-20061024');
INSERT INTO cs_stringrepcache VALUES (13, 5382, 'amsr-e-l3-dailyland-v06-20061025');
INSERT INTO cs_stringrepcache VALUES (13, 5383, 'amsr-e-l3-dailyland-v06-20061026');
INSERT INTO cs_stringrepcache VALUES (13, 5384, 'amsr-e-l3-dailyland-v06-20061027');
INSERT INTO cs_stringrepcache VALUES (13, 5385, 'amsr-e-l3-dailyland-v06-20061028');
INSERT INTO cs_stringrepcache VALUES (13, 5386, 'amsr-e-l3-dailyland-v06-20061029');
INSERT INTO cs_stringrepcache VALUES (13, 5387, 'amsr-e-l3-dailyland-v06-20061030');
INSERT INTO cs_stringrepcache VALUES (13, 5388, 'amsr-e-l3-dailyland-v06-20061031');
INSERT INTO cs_stringrepcache VALUES (13, 5389, 'amsr-e-l3-dailyland-v06-20061101');
INSERT INTO cs_stringrepcache VALUES (13, 5390, 'amsr-e-l3-dailyland-v06-20061102');
INSERT INTO cs_stringrepcache VALUES (13, 5391, 'amsr-e-l3-dailyland-v06-20061103');
INSERT INTO cs_stringrepcache VALUES (13, 5392, 'amsr-e-l3-dailyland-v06-20061104');
INSERT INTO cs_stringrepcache VALUES (13, 5393, 'amsr-e-l3-dailyland-v06-20061105');
INSERT INTO cs_stringrepcache VALUES (13, 5394, 'amsr-e-l3-dailyland-v06-20061106');
INSERT INTO cs_stringrepcache VALUES (13, 5395, 'amsr-e-l3-dailyland-v06-20061107');
INSERT INTO cs_stringrepcache VALUES (13, 5396, 'amsr-e-l3-dailyland-v06-20061108');
INSERT INTO cs_stringrepcache VALUES (13, 5397, 'amsr-e-l3-dailyland-v06-20061109');
INSERT INTO cs_stringrepcache VALUES (13, 5398, 'amsr-e-l3-dailyland-v06-20061110');
INSERT INTO cs_stringrepcache VALUES (13, 5399, 'amsr-e-l3-dailyland-v06-20061111');
INSERT INTO cs_stringrepcache VALUES (13, 5400, 'amsr-e-l3-dailyland-v06-20061112');
INSERT INTO cs_stringrepcache VALUES (13, 5401, 'amsr-e-l3-dailyland-v06-20061113');
INSERT INTO cs_stringrepcache VALUES (13, 5402, 'amsr-e-l3-dailyland-v06-20061114');
INSERT INTO cs_stringrepcache VALUES (13, 5403, 'amsr-e-l3-dailyland-v06-20061115');
INSERT INTO cs_stringrepcache VALUES (13, 5404, 'amsr-e-l3-dailyland-v06-20061116');
INSERT INTO cs_stringrepcache VALUES (13, 5405, 'amsr-e-l3-dailyland-v06-20061117');
INSERT INTO cs_stringrepcache VALUES (13, 5406, 'amsr-e-l3-dailyland-v06-20061118');
INSERT INTO cs_stringrepcache VALUES (13, 5407, 'amsr-e-l3-dailyland-v06-20061119');
INSERT INTO cs_stringrepcache VALUES (13, 5408, 'amsr-e-l3-dailyland-v06-20061120');
INSERT INTO cs_stringrepcache VALUES (13, 5409, 'amsr-e-l3-dailyland-v06-20061121');
INSERT INTO cs_stringrepcache VALUES (13, 5410, 'amsr-e-l3-dailyland-v06-20061122');
INSERT INTO cs_stringrepcache VALUES (13, 5411, 'amsr-e-l3-dailyland-v06-20061123');
INSERT INTO cs_stringrepcache VALUES (13, 5412, 'amsr-e-l3-dailyland-v06-20061124');
INSERT INTO cs_stringrepcache VALUES (13, 5413, 'amsr-e-l3-dailyland-v06-20061125');
INSERT INTO cs_stringrepcache VALUES (13, 5414, 'amsr-e-l3-dailyland-v06-20061126');
INSERT INTO cs_stringrepcache VALUES (13, 5415, 'amsr-e-l3-dailyland-v06-20061127');
INSERT INTO cs_stringrepcache VALUES (13, 5416, 'amsr-e-l3-dailyland-v06-20061128');
INSERT INTO cs_stringrepcache VALUES (13, 5417, 'amsr-e-l3-dailyland-v06-20061129');
INSERT INTO cs_stringrepcache VALUES (13, 5418, 'amsr-e-l3-dailyland-v06-20061130');
INSERT INTO cs_stringrepcache VALUES (13, 5419, 'amsr-e-l3-dailyland-v06-20061201');
INSERT INTO cs_stringrepcache VALUES (13, 5420, 'amsr-e-l3-dailyland-v06-20061202');
INSERT INTO cs_stringrepcache VALUES (13, 5421, 'amsr-e-l3-dailyland-v06-20061203');
INSERT INTO cs_stringrepcache VALUES (13, 5422, 'amsr-e-l3-dailyland-v06-20061204');
INSERT INTO cs_stringrepcache VALUES (13, 5423, 'amsr-e-l3-dailyland-v06-20061205');
INSERT INTO cs_stringrepcache VALUES (13, 5424, 'amsr-e-l3-dailyland-v06-20061206');
INSERT INTO cs_stringrepcache VALUES (13, 5425, 'amsr-e-l3-dailyland-v06-20061207');
INSERT INTO cs_stringrepcache VALUES (13, 5426, 'amsr-e-l3-dailyland-v06-20061208');
INSERT INTO cs_stringrepcache VALUES (13, 5427, 'amsr-e-l3-dailyland-v06-20061209');
INSERT INTO cs_stringrepcache VALUES (13, 5428, 'amsr-e-l3-dailyland-v06-20061210');
INSERT INTO cs_stringrepcache VALUES (13, 5429, 'amsr-e-l3-dailyland-v06-20061211');
INSERT INTO cs_stringrepcache VALUES (13, 5430, 'amsr-e-l3-dailyland-v06-20061212');
INSERT INTO cs_stringrepcache VALUES (13, 5431, 'amsr-e-l3-dailyland-v06-20061213');
INSERT INTO cs_stringrepcache VALUES (13, 5432, 'amsr-e-l3-dailyland-v06-20061214');
INSERT INTO cs_stringrepcache VALUES (13, 5433, 'amsr-e-l3-dailyland-v06-20061215');
INSERT INTO cs_stringrepcache VALUES (13, 5434, 'amsr-e-l3-dailyland-v06-20061216');
INSERT INTO cs_stringrepcache VALUES (13, 5435, 'amsr-e-l3-dailyland-v06-20061217');
INSERT INTO cs_stringrepcache VALUES (13, 5436, 'amsr-e-l3-dailyland-v06-20061218');
INSERT INTO cs_stringrepcache VALUES (13, 5437, 'amsr-e-l3-dailyland-v06-20061219');
INSERT INTO cs_stringrepcache VALUES (13, 5438, 'amsr-e-l3-dailyland-v06-20061220');
INSERT INTO cs_stringrepcache VALUES (13, 5439, 'amsr-e-l3-dailyland-v06-20061221');
INSERT INTO cs_stringrepcache VALUES (13, 5440, 'amsr-e-l3-dailyland-v06-20061222');
INSERT INTO cs_stringrepcache VALUES (13, 5441, 'amsr-e-l3-dailyland-v06-20061223');
INSERT INTO cs_stringrepcache VALUES (13, 5442, 'amsr-e-l3-dailyland-v06-20061224');
INSERT INTO cs_stringrepcache VALUES (13, 5443, 'amsr-e-l3-dailyland-v06-20061225');
INSERT INTO cs_stringrepcache VALUES (13, 5444, 'amsr-e-l3-dailyland-v06-20061226');
INSERT INTO cs_stringrepcache VALUES (13, 5445, 'amsr-e-l3-dailyland-v06-20061227');
INSERT INTO cs_stringrepcache VALUES (13, 5446, 'amsr-e-l3-dailyland-v06-20061228');
INSERT INTO cs_stringrepcache VALUES (13, 5447, 'amsr-e-l3-dailyland-v06-20061229');
INSERT INTO cs_stringrepcache VALUES (13, 5448, 'amsr-e-l3-dailyland-v06-20061230');
INSERT INTO cs_stringrepcache VALUES (13, 5449, 'amsr-e-l3-dailyland-v06-20061231');
INSERT INTO cs_stringrepcache VALUES (13, 5450, 'amsr-e-l3-dailyland-v06-20070101');
INSERT INTO cs_stringrepcache VALUES (13, 5451, 'amsr-e-l3-dailyland-v06-20070102');
INSERT INTO cs_stringrepcache VALUES (13, 5452, 'amsr-e-l3-dailyland-v06-20070103');
INSERT INTO cs_stringrepcache VALUES (13, 5453, 'amsr-e-l3-dailyland-v06-20070104');
INSERT INTO cs_stringrepcache VALUES (13, 5454, 'amsr-e-l3-dailyland-v06-20070105');
INSERT INTO cs_stringrepcache VALUES (13, 5455, 'amsr-e-l3-dailyland-v06-20070106');
INSERT INTO cs_stringrepcache VALUES (13, 5456, 'amsr-e-l3-dailyland-v06-20070107');
INSERT INTO cs_stringrepcache VALUES (13, 5457, 'amsr-e-l3-dailyland-v06-20070108');
INSERT INTO cs_stringrepcache VALUES (13, 5458, 'amsr-e-l3-dailyland-v06-20070109');
INSERT INTO cs_stringrepcache VALUES (13, 5459, 'amsr-e-l3-dailyland-v06-20070110');
INSERT INTO cs_stringrepcache VALUES (13, 5460, 'amsr-e-l3-dailyland-v06-20070111');
INSERT INTO cs_stringrepcache VALUES (13, 5461, 'amsr-e-l3-dailyland-v06-20070112');
INSERT INTO cs_stringrepcache VALUES (13, 5462, 'amsr-e-l3-dailyland-v06-20070113');
INSERT INTO cs_stringrepcache VALUES (13, 5463, 'amsr-e-l3-dailyland-v06-20070114');
INSERT INTO cs_stringrepcache VALUES (13, 5464, 'amsr-e-l3-dailyland-v06-20070115');
INSERT INTO cs_stringrepcache VALUES (13, 5465, 'amsr-e-l3-dailyland-v06-20070116');
INSERT INTO cs_stringrepcache VALUES (13, 5466, 'amsr-e-l3-dailyland-v06-20070117');
INSERT INTO cs_stringrepcache VALUES (13, 5467, 'amsr-e-l3-dailyland-v06-20070118');
INSERT INTO cs_stringrepcache VALUES (13, 5468, 'amsr-e-l3-dailyland-v06-20070119');
INSERT INTO cs_stringrepcache VALUES (13, 5469, 'amsr-e-l3-dailyland-v06-20070120');
INSERT INTO cs_stringrepcache VALUES (13, 5470, 'amsr-e-l3-dailyland-v06-20070121');
INSERT INTO cs_stringrepcache VALUES (13, 5471, 'amsr-e-l3-dailyland-v06-20070122');
INSERT INTO cs_stringrepcache VALUES (13, 5472, 'amsr-e-l3-dailyland-v06-20070123');
INSERT INTO cs_stringrepcache VALUES (13, 5473, 'amsr-e-l3-dailyland-v06-20070124');
INSERT INTO cs_stringrepcache VALUES (13, 5474, 'amsr-e-l3-dailyland-v06-20070125');
INSERT INTO cs_stringrepcache VALUES (13, 5475, 'amsr-e-l3-dailyland-v06-20070126');
INSERT INTO cs_stringrepcache VALUES (13, 5476, 'amsr-e-l3-dailyland-v06-20070127');
INSERT INTO cs_stringrepcache VALUES (13, 5477, 'amsr-e-l3-dailyland-v06-20070128');
INSERT INTO cs_stringrepcache VALUES (13, 5478, 'amsr-e-l3-dailyland-v06-20070129');
INSERT INTO cs_stringrepcache VALUES (13, 5479, 'amsr-e-l3-dailyland-v06-20070130');
INSERT INTO cs_stringrepcache VALUES (13, 5480, 'amsr-e-l3-dailyland-v06-20070131');
INSERT INTO cs_stringrepcache VALUES (13, 5481, 'amsr-e-l3-dailyland-v06-20070201');
INSERT INTO cs_stringrepcache VALUES (13, 5482, 'amsr-e-l3-dailyland-v06-20070202');
INSERT INTO cs_stringrepcache VALUES (13, 5483, 'amsr-e-l3-dailyland-v06-20070203');
INSERT INTO cs_stringrepcache VALUES (13, 5484, 'amsr-e-l3-dailyland-v06-20070204');
INSERT INTO cs_stringrepcache VALUES (13, 5485, 'amsr-e-l3-dailyland-v06-20070205');
INSERT INTO cs_stringrepcache VALUES (13, 5486, 'amsr-e-l3-dailyland-v06-20070206');
INSERT INTO cs_stringrepcache VALUES (13, 5487, 'amsr-e-l3-dailyland-v06-20070207');
INSERT INTO cs_stringrepcache VALUES (13, 5488, 'amsr-e-l3-dailyland-v06-20070208');
INSERT INTO cs_stringrepcache VALUES (13, 5489, 'amsr-e-l3-dailyland-v06-20070209');
INSERT INTO cs_stringrepcache VALUES (13, 5490, 'amsr-e-l3-dailyland-v06-20070210');
INSERT INTO cs_stringrepcache VALUES (13, 5491, 'amsr-e-l3-dailyland-v06-20070211');
INSERT INTO cs_stringrepcache VALUES (13, 5492, 'amsr-e-l3-dailyland-v06-20070212');
INSERT INTO cs_stringrepcache VALUES (13, 5493, 'amsr-e-l3-dailyland-v06-20070213');
INSERT INTO cs_stringrepcache VALUES (13, 5494, 'amsr-e-l3-dailyland-v06-20070214');
INSERT INTO cs_stringrepcache VALUES (13, 5495, 'amsr-e-l3-dailyland-v06-20070215');
INSERT INTO cs_stringrepcache VALUES (13, 5496, 'amsr-e-l3-dailyland-v06-20070216');
INSERT INTO cs_stringrepcache VALUES (13, 5497, 'amsr-e-l3-dailyland-v06-20070217');
INSERT INTO cs_stringrepcache VALUES (13, 5498, 'amsr-e-l3-dailyland-v06-20070218');
INSERT INTO cs_stringrepcache VALUES (13, 5499, 'amsr-e-l3-dailyland-v06-20070219');
INSERT INTO cs_stringrepcache VALUES (13, 5500, 'amsr-e-l3-dailyland-v06-20070220');
INSERT INTO cs_stringrepcache VALUES (13, 5501, 'amsr-e-l3-dailyland-v06-20070221');
INSERT INTO cs_stringrepcache VALUES (13, 5502, 'amsr-e-l3-dailyland-v06-20070222');
INSERT INTO cs_stringrepcache VALUES (13, 5503, 'amsr-e-l3-dailyland-v06-20070223');
INSERT INTO cs_stringrepcache VALUES (13, 5504, 'amsr-e-l3-dailyland-v06-20070224');
INSERT INTO cs_stringrepcache VALUES (13, 5505, 'amsr-e-l3-dailyland-v06-20070225');
INSERT INTO cs_stringrepcache VALUES (13, 5506, 'amsr-e-l3-dailyland-v06-20070226');
INSERT INTO cs_stringrepcache VALUES (13, 5507, 'amsr-e-l3-dailyland-v06-20070227');
INSERT INTO cs_stringrepcache VALUES (13, 5508, 'amsr-e-l3-dailyland-v06-20070228');
INSERT INTO cs_stringrepcache VALUES (13, 5509, 'amsr-e-l3-dailyland-v06-20070301');
INSERT INTO cs_stringrepcache VALUES (13, 5510, 'amsr-e-l3-dailyland-v06-20070302');
INSERT INTO cs_stringrepcache VALUES (13, 5511, 'amsr-e-l3-dailyland-v06-20070303');
INSERT INTO cs_stringrepcache VALUES (13, 5512, 'amsr-e-l3-dailyland-v06-20070304');
INSERT INTO cs_stringrepcache VALUES (13, 5513, 'amsr-e-l3-dailyland-v06-20070305');
INSERT INTO cs_stringrepcache VALUES (13, 5514, 'amsr-e-l3-dailyland-v06-20070306');
INSERT INTO cs_stringrepcache VALUES (13, 5515, 'amsr-e-l3-dailyland-v06-20070307');
INSERT INTO cs_stringrepcache VALUES (13, 5516, 'amsr-e-l3-dailyland-v06-20070308');
INSERT INTO cs_stringrepcache VALUES (13, 5517, 'amsr-e-l3-dailyland-v06-20070309');
INSERT INTO cs_stringrepcache VALUES (13, 5518, 'amsr-e-l3-dailyland-v06-20070310');
INSERT INTO cs_stringrepcache VALUES (13, 5519, 'amsr-e-l3-dailyland-v06-20070311');
INSERT INTO cs_stringrepcache VALUES (13, 5520, 'amsr-e-l3-dailyland-v06-20070312');
INSERT INTO cs_stringrepcache VALUES (13, 5521, 'amsr-e-l3-dailyland-v06-20070313');
INSERT INTO cs_stringrepcache VALUES (13, 5522, 'amsr-e-l3-dailyland-v06-20070314');
INSERT INTO cs_stringrepcache VALUES (13, 5523, 'amsr-e-l3-dailyland-v06-20070315');
INSERT INTO cs_stringrepcache VALUES (13, 5524, 'amsr-e-l3-dailyland-v06-20070316');
INSERT INTO cs_stringrepcache VALUES (13, 5525, 'amsr-e-l3-dailyland-v06-20070317');
INSERT INTO cs_stringrepcache VALUES (13, 5526, 'amsr-e-l3-dailyland-v06-20070318');
INSERT INTO cs_stringrepcache VALUES (13, 5527, 'amsr-e-l3-dailyland-v06-20070319');
INSERT INTO cs_stringrepcache VALUES (13, 5528, 'amsr-e-l3-dailyland-v06-20070320');
INSERT INTO cs_stringrepcache VALUES (13, 5529, 'amsr-e-l3-dailyland-v06-20070321');
INSERT INTO cs_stringrepcache VALUES (13, 5530, 'amsr-e-l3-dailyland-v06-20070322');
INSERT INTO cs_stringrepcache VALUES (13, 5531, 'amsr-e-l3-dailyland-v06-20070323');
INSERT INTO cs_stringrepcache VALUES (13, 5532, 'amsr-e-l3-dailyland-v06-20070324');
INSERT INTO cs_stringrepcache VALUES (13, 5533, 'amsr-e-l3-dailyland-v06-20070325');
INSERT INTO cs_stringrepcache VALUES (13, 5534, 'amsr-e-l3-dailyland-v06-20070326');
INSERT INTO cs_stringrepcache VALUES (13, 5535, 'amsr-e-l3-dailyland-v06-20070327');
INSERT INTO cs_stringrepcache VALUES (13, 5536, 'amsr-e-l3-dailyland-v06-20070328');
INSERT INTO cs_stringrepcache VALUES (13, 5537, 'amsr-e-l3-dailyland-v06-20070329');
INSERT INTO cs_stringrepcache VALUES (13, 5538, 'amsr-e-l3-dailyland-v06-20070330');
INSERT INTO cs_stringrepcache VALUES (13, 5539, 'amsr-e-l3-dailyland-v06-20070331');
INSERT INTO cs_stringrepcache VALUES (13, 5540, 'amsr-e-l3-dailyland-v06-20070401');
INSERT INTO cs_stringrepcache VALUES (13, 5541, 'amsr-e-l3-dailyland-v06-20070402');
INSERT INTO cs_stringrepcache VALUES (13, 5542, 'amsr-e-l3-dailyland-v06-20070403');
INSERT INTO cs_stringrepcache VALUES (13, 5543, 'amsr-e-l3-dailyland-v06-20070404');
INSERT INTO cs_stringrepcache VALUES (13, 5544, 'amsr-e-l3-dailyland-v06-20070405');
INSERT INTO cs_stringrepcache VALUES (13, 5545, 'amsr-e-l3-dailyland-v06-20070406');
INSERT INTO cs_stringrepcache VALUES (13, 5546, 'amsr-e-l3-dailyland-v06-20070407');
INSERT INTO cs_stringrepcache VALUES (13, 5547, 'amsr-e-l3-dailyland-v06-20070408');
INSERT INTO cs_stringrepcache VALUES (13, 5548, 'amsr-e-l3-dailyland-v06-20070409');
INSERT INTO cs_stringrepcache VALUES (13, 5549, 'amsr-e-l3-dailyland-v06-20070410');
INSERT INTO cs_stringrepcache VALUES (13, 5550, 'amsr-e-l3-dailyland-v06-20070411');
INSERT INTO cs_stringrepcache VALUES (13, 5551, 'amsr-e-l3-dailyland-v06-20070412');
INSERT INTO cs_stringrepcache VALUES (13, 5552, 'amsr-e-l3-dailyland-v06-20070413');
INSERT INTO cs_stringrepcache VALUES (13, 5553, 'amsr-e-l3-dailyland-v06-20070414');
INSERT INTO cs_stringrepcache VALUES (13, 5554, 'amsr-e-l3-dailyland-v06-20070415');
INSERT INTO cs_stringrepcache VALUES (13, 5555, 'amsr-e-l3-dailyland-v06-20070416');
INSERT INTO cs_stringrepcache VALUES (13, 5556, 'amsr-e-l3-dailyland-v06-20070417');
INSERT INTO cs_stringrepcache VALUES (13, 5557, 'amsr-e-l3-dailyland-v06-20070418');
INSERT INTO cs_stringrepcache VALUES (13, 5558, 'amsr-e-l3-dailyland-v06-20070419');
INSERT INTO cs_stringrepcache VALUES (13, 5559, 'amsr-e-l3-dailyland-v06-20070420');
INSERT INTO cs_stringrepcache VALUES (13, 5560, 'amsr-e-l3-dailyland-v06-20070421');
INSERT INTO cs_stringrepcache VALUES (13, 5561, 'amsr-e-l3-dailyland-v06-20070422');
INSERT INTO cs_stringrepcache VALUES (13, 5562, 'amsr-e-l3-dailyland-v06-20070423');
INSERT INTO cs_stringrepcache VALUES (13, 5563, 'amsr-e-l3-dailyland-v06-20070424');
INSERT INTO cs_stringrepcache VALUES (13, 5564, 'amsr-e-l3-dailyland-v06-20070425');
INSERT INTO cs_stringrepcache VALUES (13, 5565, 'amsr-e-l3-dailyland-v06-20070426');
INSERT INTO cs_stringrepcache VALUES (13, 5566, 'amsr-e-l3-dailyland-v06-20070427');
INSERT INTO cs_stringrepcache VALUES (13, 5567, 'amsr-e-l3-dailyland-v06-20070428');
INSERT INTO cs_stringrepcache VALUES (13, 5568, 'amsr-e-l3-dailyland-v06-20070429');
INSERT INTO cs_stringrepcache VALUES (13, 5569, 'amsr-e-l3-dailyland-v06-20070430');
INSERT INTO cs_stringrepcache VALUES (13, 5570, 'amsr-e-l3-dailyland-v06-20070501');
INSERT INTO cs_stringrepcache VALUES (13, 5571, 'amsr-e-l3-dailyland-v06-20070502');
INSERT INTO cs_stringrepcache VALUES (13, 5572, 'amsr-e-l3-dailyland-v06-20070503');
INSERT INTO cs_stringrepcache VALUES (13, 5573, 'amsr-e-l3-dailyland-v06-20070504');
INSERT INTO cs_stringrepcache VALUES (13, 5574, 'amsr-e-l3-dailyland-v06-20070505');
INSERT INTO cs_stringrepcache VALUES (13, 5575, 'amsr-e-l3-dailyland-v06-20070506');
INSERT INTO cs_stringrepcache VALUES (13, 5576, 'amsr-e-l3-dailyland-v06-20070507');
INSERT INTO cs_stringrepcache VALUES (13, 5577, 'amsr-e-l3-dailyland-v06-20070508');
INSERT INTO cs_stringrepcache VALUES (13, 5578, 'amsr-e-l3-dailyland-v06-20070509');
INSERT INTO cs_stringrepcache VALUES (13, 5579, 'amsr-e-l3-dailyland-v06-20070510');
INSERT INTO cs_stringrepcache VALUES (13, 5580, 'amsr-e-l3-dailyland-v06-20070511');
INSERT INTO cs_stringrepcache VALUES (13, 5581, 'amsr-e-l3-dailyland-v06-20070512');
INSERT INTO cs_stringrepcache VALUES (13, 5582, 'amsr-e-l3-dailyland-v06-20070513');
INSERT INTO cs_stringrepcache VALUES (13, 5583, 'amsr-e-l3-dailyland-v06-20070514');
INSERT INTO cs_stringrepcache VALUES (13, 5584, 'amsr-e-l3-dailyland-v06-20070515');
INSERT INTO cs_stringrepcache VALUES (13, 5585, 'amsr-e-l3-dailyland-v06-20070516');
INSERT INTO cs_stringrepcache VALUES (13, 5586, 'amsr-e-l3-dailyland-v06-20070517');
INSERT INTO cs_stringrepcache VALUES (13, 5587, 'amsr-e-l3-dailyland-v06-20070518');
INSERT INTO cs_stringrepcache VALUES (13, 5588, 'amsr-e-l3-dailyland-v06-20070519');
INSERT INTO cs_stringrepcache VALUES (13, 5589, 'amsr-e-l3-dailyland-v06-20070520');
INSERT INTO cs_stringrepcache VALUES (13, 5590, 'amsr-e-l3-dailyland-v06-20070521');
INSERT INTO cs_stringrepcache VALUES (13, 5591, 'amsr-e-l3-dailyland-v06-20070522');
INSERT INTO cs_stringrepcache VALUES (13, 5592, 'amsr-e-l3-dailyland-v06-20070523');
INSERT INTO cs_stringrepcache VALUES (13, 5593, 'amsr-e-l3-dailyland-v06-20070524');
INSERT INTO cs_stringrepcache VALUES (13, 5594, 'amsr-e-l3-dailyland-v06-20070525');
INSERT INTO cs_stringrepcache VALUES (13, 5595, 'amsr-e-l3-dailyland-v06-20070526');
INSERT INTO cs_stringrepcache VALUES (13, 5596, 'amsr-e-l3-dailyland-v06-20070527');
INSERT INTO cs_stringrepcache VALUES (13, 5597, 'amsr-e-l3-dailyland-v06-20070528');
INSERT INTO cs_stringrepcache VALUES (13, 5598, 'amsr-e-l3-dailyland-v06-20070529');
INSERT INTO cs_stringrepcache VALUES (13, 5599, 'amsr-e-l3-dailyland-v06-20070530');
INSERT INTO cs_stringrepcache VALUES (13, 5600, 'amsr-e-l3-dailyland-v06-20070531');
INSERT INTO cs_stringrepcache VALUES (13, 5601, 'amsr-e-l3-dailyland-v06-20070601');
INSERT INTO cs_stringrepcache VALUES (13, 5602, 'amsr-e-l3-dailyland-v06-20070602');
INSERT INTO cs_stringrepcache VALUES (13, 5603, 'amsr-e-l3-dailyland-v06-20070603');
INSERT INTO cs_stringrepcache VALUES (13, 5604, 'amsr-e-l3-dailyland-v06-20070604');
INSERT INTO cs_stringrepcache VALUES (13, 5605, 'amsr-e-l3-dailyland-v06-20070605');
INSERT INTO cs_stringrepcache VALUES (13, 5606, 'amsr-e-l3-dailyland-v06-20070606');
INSERT INTO cs_stringrepcache VALUES (13, 5607, 'amsr-e-l3-dailyland-v06-20070607');
INSERT INTO cs_stringrepcache VALUES (13, 5608, 'amsr-e-l3-dailyland-v06-20070608');
INSERT INTO cs_stringrepcache VALUES (13, 5609, 'amsr-e-l3-dailyland-v06-20070609');
INSERT INTO cs_stringrepcache VALUES (13, 5610, 'amsr-e-l3-dailyland-v06-20070610');
INSERT INTO cs_stringrepcache VALUES (13, 5611, 'amsr-e-l3-dailyland-v06-20070611');
INSERT INTO cs_stringrepcache VALUES (13, 5612, 'amsr-e-l3-dailyland-v06-20070612');
INSERT INTO cs_stringrepcache VALUES (13, 5613, 'amsr-e-l3-dailyland-v06-20070613');
INSERT INTO cs_stringrepcache VALUES (13, 5614, 'amsr-e-l3-dailyland-v06-20070614');
INSERT INTO cs_stringrepcache VALUES (13, 5615, 'amsr-e-l3-dailyland-v06-20070615');
INSERT INTO cs_stringrepcache VALUES (13, 5616, 'amsr-e-l3-dailyland-v06-20070616');
INSERT INTO cs_stringrepcache VALUES (13, 5617, 'amsr-e-l3-dailyland-v06-20070617');
INSERT INTO cs_stringrepcache VALUES (13, 5618, 'amsr-e-l3-dailyland-v06-20070618');
INSERT INTO cs_stringrepcache VALUES (13, 5619, 'amsr-e-l3-dailyland-v06-20070619');
INSERT INTO cs_stringrepcache VALUES (13, 5620, 'amsr-e-l3-dailyland-v06-20070620');
INSERT INTO cs_stringrepcache VALUES (13, 5621, 'amsr-e-l3-dailyland-v06-20070621');
INSERT INTO cs_stringrepcache VALUES (13, 5622, 'amsr-e-l3-dailyland-v06-20070622');
INSERT INTO cs_stringrepcache VALUES (13, 5623, 'amsr-e-l3-dailyland-v06-20070623');
INSERT INTO cs_stringrepcache VALUES (13, 5624, 'amsr-e-l3-dailyland-v06-20070624');
INSERT INTO cs_stringrepcache VALUES (13, 5625, 'amsr-e-l3-dailyland-v06-20070625');
INSERT INTO cs_stringrepcache VALUES (13, 5626, 'amsr-e-l3-dailyland-v06-20070626');
INSERT INTO cs_stringrepcache VALUES (13, 5627, 'amsr-e-l3-dailyland-v06-20070627');
INSERT INTO cs_stringrepcache VALUES (13, 5628, 'amsr-e-l3-dailyland-v06-20070628');
INSERT INTO cs_stringrepcache VALUES (13, 5629, 'amsr-e-l3-dailyland-v06-20070629');
INSERT INTO cs_stringrepcache VALUES (13, 5630, 'amsr-e-l3-dailyland-v06-20070630');
INSERT INTO cs_stringrepcache VALUES (13, 5631, 'amsr-e-l3-dailyland-v06-20070701');
INSERT INTO cs_stringrepcache VALUES (13, 5632, 'amsr-e-l3-dailyland-v06-20070702');
INSERT INTO cs_stringrepcache VALUES (13, 5633, 'amsr-e-l3-dailyland-v06-20070703');
INSERT INTO cs_stringrepcache VALUES (13, 5634, 'amsr-e-l3-dailyland-v06-20070704');
INSERT INTO cs_stringrepcache VALUES (13, 5635, 'amsr-e-l3-dailyland-v06-20070705');
INSERT INTO cs_stringrepcache VALUES (13, 5636, 'amsr-e-l3-dailyland-v06-20070706');
INSERT INTO cs_stringrepcache VALUES (13, 5637, 'amsr-e-l3-dailyland-v06-20070707');
INSERT INTO cs_stringrepcache VALUES (13, 5638, 'amsr-e-l3-dailyland-v06-20070708');
INSERT INTO cs_stringrepcache VALUES (13, 5639, 'amsr-e-l3-dailyland-v06-20070709');
INSERT INTO cs_stringrepcache VALUES (13, 5640, 'amsr-e-l3-dailyland-v06-20070710');
INSERT INTO cs_stringrepcache VALUES (13, 5641, 'amsr-e-l3-dailyland-v06-20070711');
INSERT INTO cs_stringrepcache VALUES (13, 5642, 'amsr-e-l3-dailyland-v06-20070712');
INSERT INTO cs_stringrepcache VALUES (13, 5643, 'amsr-e-l3-dailyland-v06-20070713');
INSERT INTO cs_stringrepcache VALUES (13, 5644, 'amsr-e-l3-dailyland-v06-20070714');
INSERT INTO cs_stringrepcache VALUES (13, 5645, 'amsr-e-l3-dailyland-v06-20070715');
INSERT INTO cs_stringrepcache VALUES (13, 5646, 'amsr-e-l3-dailyland-v06-20070716');
INSERT INTO cs_stringrepcache VALUES (13, 5647, 'amsr-e-l3-dailyland-v06-20070717');
INSERT INTO cs_stringrepcache VALUES (13, 5648, 'amsr-e-l3-dailyland-v06-20070718');
INSERT INTO cs_stringrepcache VALUES (13, 5649, 'amsr-e-l3-dailyland-v06-20070719');
INSERT INTO cs_stringrepcache VALUES (13, 5650, 'amsr-e-l3-dailyland-v06-20070720');
INSERT INTO cs_stringrepcache VALUES (13, 5651, 'amsr-e-l3-dailyland-v06-20070721');
INSERT INTO cs_stringrepcache VALUES (13, 5652, 'amsr-e-l3-dailyland-v06-20070722');
INSERT INTO cs_stringrepcache VALUES (13, 5653, 'amsr-e-l3-dailyland-v06-20070723');
INSERT INTO cs_stringrepcache VALUES (13, 5654, 'amsr-e-l3-dailyland-v06-20070724');
INSERT INTO cs_stringrepcache VALUES (13, 5655, 'amsr-e-l3-dailyland-v06-20070725');
INSERT INTO cs_stringrepcache VALUES (13, 5656, 'amsr-e-l3-dailyland-v06-20070726');
INSERT INTO cs_stringrepcache VALUES (13, 5657, 'amsr-e-l3-dailyland-v06-20070727');
INSERT INTO cs_stringrepcache VALUES (13, 5658, 'amsr-e-l3-dailyland-v06-20070728');
INSERT INTO cs_stringrepcache VALUES (13, 5659, 'amsr-e-l3-dailyland-v06-20070729');
INSERT INTO cs_stringrepcache VALUES (13, 5660, 'amsr-e-l3-dailyland-v06-20070730');
INSERT INTO cs_stringrepcache VALUES (13, 5661, 'amsr-e-l3-dailyland-v06-20070731');
INSERT INTO cs_stringrepcache VALUES (13, 5662, 'amsr-e-l3-dailyland-v06-20070801');
INSERT INTO cs_stringrepcache VALUES (13, 5663, 'amsr-e-l3-dailyland-v06-20070802');
INSERT INTO cs_stringrepcache VALUES (13, 5664, 'amsr-e-l3-dailyland-v06-20070803');
INSERT INTO cs_stringrepcache VALUES (13, 5665, 'amsr-e-l3-dailyland-v06-20070804');
INSERT INTO cs_stringrepcache VALUES (13, 5666, 'amsr-e-l3-dailyland-v06-20070805');
INSERT INTO cs_stringrepcache VALUES (13, 5667, 'amsr-e-l3-dailyland-v06-20070806');
INSERT INTO cs_stringrepcache VALUES (13, 5668, 'amsr-e-l3-dailyland-v06-20070807');
INSERT INTO cs_stringrepcache VALUES (13, 5669, 'amsr-e-l3-dailyland-v06-20070808');
INSERT INTO cs_stringrepcache VALUES (13, 5670, 'amsr-e-l3-dailyland-v06-20070809');
INSERT INTO cs_stringrepcache VALUES (13, 5671, 'amsr-e-l3-dailyland-v06-20070810');
INSERT INTO cs_stringrepcache VALUES (13, 5672, 'amsr-e-l3-dailyland-v06-20070811');
INSERT INTO cs_stringrepcache VALUES (13, 5673, 'amsr-e-l3-dailyland-v06-20070812');
INSERT INTO cs_stringrepcache VALUES (13, 5674, 'amsr-e-l3-dailyland-v06-20070813');
INSERT INTO cs_stringrepcache VALUES (13, 5675, 'amsr-e-l3-dailyland-v06-20070814');
INSERT INTO cs_stringrepcache VALUES (13, 5676, 'amsr-e-l3-dailyland-v06-20070815');
INSERT INTO cs_stringrepcache VALUES (13, 5677, 'amsr-e-l3-dailyland-v06-20070816');
INSERT INTO cs_stringrepcache VALUES (13, 5678, 'amsr-e-l3-dailyland-v06-20070817');
INSERT INTO cs_stringrepcache VALUES (13, 5679, 'amsr-e-l3-dailyland-v06-20070818');
INSERT INTO cs_stringrepcache VALUES (13, 5680, 'amsr-e-l3-dailyland-v06-20070819');
INSERT INTO cs_stringrepcache VALUES (13, 5681, 'amsr-e-l3-dailyland-v06-20070820');
INSERT INTO cs_stringrepcache VALUES (13, 5682, 'amsr-e-l3-dailyland-v06-20070821');
INSERT INTO cs_stringrepcache VALUES (13, 5683, 'amsr-e-l3-dailyland-v06-20070822');
INSERT INTO cs_stringrepcache VALUES (13, 5684, 'amsr-e-l3-dailyland-v06-20070823');
INSERT INTO cs_stringrepcache VALUES (13, 5685, 'amsr-e-l3-dailyland-v06-20070824');
INSERT INTO cs_stringrepcache VALUES (13, 5686, 'amsr-e-l3-dailyland-v06-20070825');
INSERT INTO cs_stringrepcache VALUES (13, 5687, 'amsr-e-l3-dailyland-v06-20070826');
INSERT INTO cs_stringrepcache VALUES (13, 5688, 'amsr-e-l3-dailyland-v06-20070827');
INSERT INTO cs_stringrepcache VALUES (13, 5689, 'amsr-e-l3-dailyland-v06-20070828');
INSERT INTO cs_stringrepcache VALUES (13, 5690, 'amsr-e-l3-dailyland-v06-20070829');
INSERT INTO cs_stringrepcache VALUES (13, 5691, 'amsr-e-l3-dailyland-v06-20070830');
INSERT INTO cs_stringrepcache VALUES (13, 5692, 'amsr-e-l3-dailyland-v06-20070831');
INSERT INTO cs_stringrepcache VALUES (13, 5693, 'amsr-e-l3-dailyland-v06-20070901');
INSERT INTO cs_stringrepcache VALUES (13, 5694, 'amsr-e-l3-dailyland-v06-20070902');
INSERT INTO cs_stringrepcache VALUES (13, 5695, 'amsr-e-l3-dailyland-v06-20070903');
INSERT INTO cs_stringrepcache VALUES (13, 5696, 'amsr-e-l3-dailyland-v06-20070904');
INSERT INTO cs_stringrepcache VALUES (13, 5697, 'amsr-e-l3-dailyland-v06-20070905');
INSERT INTO cs_stringrepcache VALUES (13, 5698, 'amsr-e-l3-dailyland-v06-20070906');
INSERT INTO cs_stringrepcache VALUES (13, 5699, 'amsr-e-l3-dailyland-v06-20070907');
INSERT INTO cs_stringrepcache VALUES (13, 5700, 'amsr-e-l3-dailyland-v06-20070908');
INSERT INTO cs_stringrepcache VALUES (13, 5701, 'amsr-e-l3-dailyland-v06-20070909');
INSERT INTO cs_stringrepcache VALUES (13, 5702, 'amsr-e-l3-dailyland-v06-20070910');
INSERT INTO cs_stringrepcache VALUES (13, 5703, 'amsr-e-l3-dailyland-v06-20070911');
INSERT INTO cs_stringrepcache VALUES (13, 5704, 'amsr-e-l3-dailyland-v06-20070912');
INSERT INTO cs_stringrepcache VALUES (13, 5705, 'amsr-e-l3-dailyland-v06-20070913');
INSERT INTO cs_stringrepcache VALUES (13, 5706, 'amsr-e-l3-dailyland-v06-20070914');
INSERT INTO cs_stringrepcache VALUES (13, 5707, 'amsr-e-l3-dailyland-v06-20070915');
INSERT INTO cs_stringrepcache VALUES (13, 5708, 'amsr-e-l3-dailyland-v06-20070916');
INSERT INTO cs_stringrepcache VALUES (13, 5709, 'amsr-e-l3-dailyland-v06-20070917');
INSERT INTO cs_stringrepcache VALUES (13, 5710, 'amsr-e-l3-dailyland-v06-20070918');
INSERT INTO cs_stringrepcache VALUES (13, 5711, 'amsr-e-l3-dailyland-v06-20070919');
INSERT INTO cs_stringrepcache VALUES (13, 5712, 'amsr-e-l3-dailyland-v06-20070920');
INSERT INTO cs_stringrepcache VALUES (13, 5713, 'amsr-e-l3-dailyland-v06-20070921');
INSERT INTO cs_stringrepcache VALUES (13, 5714, 'amsr-e-l3-dailyland-v06-20070922');
INSERT INTO cs_stringrepcache VALUES (13, 5715, 'amsr-e-l3-dailyland-v06-20070923');
INSERT INTO cs_stringrepcache VALUES (13, 5716, 'amsr-e-l3-dailyland-v06-20070924');
INSERT INTO cs_stringrepcache VALUES (13, 5717, 'amsr-e-l3-dailyland-v06-20070925');
INSERT INTO cs_stringrepcache VALUES (13, 5718, 'amsr-e-l3-dailyland-v06-20070926');
INSERT INTO cs_stringrepcache VALUES (13, 5719, 'amsr-e-l3-dailyland-v06-20070927');
INSERT INTO cs_stringrepcache VALUES (13, 5720, 'amsr-e-l3-dailyland-v06-20070928');
INSERT INTO cs_stringrepcache VALUES (13, 5721, 'amsr-e-l3-dailyland-v06-20070929');
INSERT INTO cs_stringrepcache VALUES (13, 5722, 'amsr-e-l3-dailyland-v06-20070930');
INSERT INTO cs_stringrepcache VALUES (13, 5723, 'amsr-e-l3-dailyland-v06-20071001');
INSERT INTO cs_stringrepcache VALUES (13, 5724, 'amsr-e-l3-dailyland-v06-20071002');
INSERT INTO cs_stringrepcache VALUES (13, 5725, 'amsr-e-l3-dailyland-v06-20071003');
INSERT INTO cs_stringrepcache VALUES (13, 5726, 'amsr-e-l3-dailyland-v06-20071004');
INSERT INTO cs_stringrepcache VALUES (13, 5727, 'amsr-e-l3-dailyland-v06-20071005');
INSERT INTO cs_stringrepcache VALUES (13, 5728, 'amsr-e-l3-dailyland-v06-20071006');
INSERT INTO cs_stringrepcache VALUES (13, 5729, 'amsr-e-l3-dailyland-v06-20071007');
INSERT INTO cs_stringrepcache VALUES (13, 5730, 'amsr-e-l3-dailyland-v06-20071008');
INSERT INTO cs_stringrepcache VALUES (13, 5731, 'amsr-e-l3-dailyland-v06-20071009');
INSERT INTO cs_stringrepcache VALUES (13, 5732, 'amsr-e-l3-dailyland-v06-20071010');
INSERT INTO cs_stringrepcache VALUES (13, 5733, 'amsr-e-l3-dailyland-v06-20071011');
INSERT INTO cs_stringrepcache VALUES (13, 5734, 'amsr-e-l3-dailyland-v06-20071012');
INSERT INTO cs_stringrepcache VALUES (13, 5735, 'amsr-e-l3-dailyland-v06-20071013');
INSERT INTO cs_stringrepcache VALUES (13, 5736, 'amsr-e-l3-dailyland-v06-20071014');
INSERT INTO cs_stringrepcache VALUES (13, 5737, 'amsr-e-l3-dailyland-v06-20071015');
INSERT INTO cs_stringrepcache VALUES (13, 5738, 'amsr-e-l3-dailyland-v06-20071016');
INSERT INTO cs_stringrepcache VALUES (13, 5739, 'amsr-e-l3-dailyland-v06-20071017');
INSERT INTO cs_stringrepcache VALUES (13, 5740, 'amsr-e-l3-dailyland-v06-20071018');
INSERT INTO cs_stringrepcache VALUES (13, 5741, 'amsr-e-l3-dailyland-v06-20071019');
INSERT INTO cs_stringrepcache VALUES (13, 5742, 'amsr-e-l3-dailyland-v06-20071020');
INSERT INTO cs_stringrepcache VALUES (13, 5743, 'amsr-e-l3-dailyland-v06-20071021');
INSERT INTO cs_stringrepcache VALUES (13, 5744, 'amsr-e-l3-dailyland-v06-20071022');
INSERT INTO cs_stringrepcache VALUES (13, 5745, 'amsr-e-l3-dailyland-v06-20071023');
INSERT INTO cs_stringrepcache VALUES (13, 5746, 'amsr-e-l3-dailyland-v06-20071024');
INSERT INTO cs_stringrepcache VALUES (13, 5747, 'amsr-e-l3-dailyland-v06-20071025');
INSERT INTO cs_stringrepcache VALUES (13, 5748, 'amsr-e-l3-dailyland-v06-20071026');
INSERT INTO cs_stringrepcache VALUES (13, 5749, 'amsr-e-l3-dailyland-v06-20071027');
INSERT INTO cs_stringrepcache VALUES (13, 5750, 'amsr-e-l3-dailyland-v06-20071028');
INSERT INTO cs_stringrepcache VALUES (13, 5751, 'amsr-e-l3-dailyland-v06-20071029');
INSERT INTO cs_stringrepcache VALUES (13, 5752, 'amsr-e-l3-dailyland-v06-20071030');
INSERT INTO cs_stringrepcache VALUES (13, 5753, 'amsr-e-l3-dailyland-v06-20071031');
INSERT INTO cs_stringrepcache VALUES (13, 5754, 'amsr-e-l3-dailyland-v06-20071101');
INSERT INTO cs_stringrepcache VALUES (13, 5755, 'amsr-e-l3-dailyland-v06-20071102');
INSERT INTO cs_stringrepcache VALUES (13, 5756, 'amsr-e-l3-dailyland-v06-20071103');
INSERT INTO cs_stringrepcache VALUES (13, 5757, 'amsr-e-l3-dailyland-v06-20071104');
INSERT INTO cs_stringrepcache VALUES (13, 5758, 'amsr-e-l3-dailyland-v06-20071105');
INSERT INTO cs_stringrepcache VALUES (13, 5759, 'amsr-e-l3-dailyland-v06-20071106');
INSERT INTO cs_stringrepcache VALUES (13, 5760, 'amsr-e-l3-dailyland-v06-20071107');
INSERT INTO cs_stringrepcache VALUES (13, 5761, 'amsr-e-l3-dailyland-v06-20071108');
INSERT INTO cs_stringrepcache VALUES (13, 5762, 'amsr-e-l3-dailyland-v06-20071109');
INSERT INTO cs_stringrepcache VALUES (13, 5763, 'amsr-e-l3-dailyland-v06-20071110');
INSERT INTO cs_stringrepcache VALUES (13, 5764, 'amsr-e-l3-dailyland-v06-20071111');
INSERT INTO cs_stringrepcache VALUES (13, 5765, 'amsr-e-l3-dailyland-v06-20071112');
INSERT INTO cs_stringrepcache VALUES (13, 5766, 'amsr-e-l3-dailyland-v06-20071113');
INSERT INTO cs_stringrepcache VALUES (13, 5767, 'amsr-e-l3-dailyland-v06-20071114');
INSERT INTO cs_stringrepcache VALUES (13, 5768, 'amsr-e-l3-dailyland-v06-20071115');
INSERT INTO cs_stringrepcache VALUES (13, 5769, 'amsr-e-l3-dailyland-v06-20071116');
INSERT INTO cs_stringrepcache VALUES (13, 5770, 'amsr-e-l3-dailyland-v06-20071117');
INSERT INTO cs_stringrepcache VALUES (13, 5771, 'amsr-e-l3-dailyland-v06-20071118');
INSERT INTO cs_stringrepcache VALUES (13, 5772, 'amsr-e-l3-dailyland-v06-20071119');
INSERT INTO cs_stringrepcache VALUES (13, 5773, 'amsr-e-l3-dailyland-v06-20071120');
INSERT INTO cs_stringrepcache VALUES (13, 5774, 'amsr-e-l3-dailyland-v06-20071121');
INSERT INTO cs_stringrepcache VALUES (13, 5775, 'amsr-e-l3-dailyland-v06-20071122');
INSERT INTO cs_stringrepcache VALUES (13, 5776, 'amsr-e-l3-dailyland-v06-20071123');
INSERT INTO cs_stringrepcache VALUES (13, 5777, 'amsr-e-l3-dailyland-v06-20071124');
INSERT INTO cs_stringrepcache VALUES (13, 5778, 'amsr-e-l3-dailyland-v06-20071125');
INSERT INTO cs_stringrepcache VALUES (13, 5779, 'amsr-e-l3-dailyland-v06-20071126');
INSERT INTO cs_stringrepcache VALUES (13, 5780, 'amsr-e-l3-dailyland-v06-20071127');
INSERT INTO cs_stringrepcache VALUES (13, 5781, 'amsr-e-l3-dailyland-v06-20071128');
INSERT INTO cs_stringrepcache VALUES (13, 5782, 'amsr-e-l3-dailyland-v06-20071129');
INSERT INTO cs_stringrepcache VALUES (13, 5783, 'amsr-e-l3-dailyland-v06-20071130');
INSERT INTO cs_stringrepcache VALUES (13, 5784, 'amsr-e-l3-dailyland-v06-20071201');
INSERT INTO cs_stringrepcache VALUES (13, 5785, 'amsr-e-l3-dailyland-v06-20071202');
INSERT INTO cs_stringrepcache VALUES (13, 5786, 'amsr-e-l3-dailyland-v06-20071203');
INSERT INTO cs_stringrepcache VALUES (13, 5787, 'amsr-e-l3-dailyland-v06-20071204');
INSERT INTO cs_stringrepcache VALUES (13, 5788, 'amsr-e-l3-dailyland-v06-20071205');
INSERT INTO cs_stringrepcache VALUES (13, 5789, 'amsr-e-l3-dailyland-v06-20071206');
INSERT INTO cs_stringrepcache VALUES (13, 5790, 'amsr-e-l3-dailyland-v06-20071207');
INSERT INTO cs_stringrepcache VALUES (13, 5791, 'amsr-e-l3-dailyland-v06-20071208');
INSERT INTO cs_stringrepcache VALUES (13, 5792, 'amsr-e-l3-dailyland-v06-20071209');
INSERT INTO cs_stringrepcache VALUES (13, 5793, 'amsr-e-l3-dailyland-v06-20071210');
INSERT INTO cs_stringrepcache VALUES (13, 5794, 'amsr-e-l3-dailyland-v06-20071211');
INSERT INTO cs_stringrepcache VALUES (13, 5795, 'amsr-e-l3-dailyland-v06-20071212');
INSERT INTO cs_stringrepcache VALUES (13, 5796, 'amsr-e-l3-dailyland-v06-20071213');
INSERT INTO cs_stringrepcache VALUES (13, 5797, 'amsr-e-l3-dailyland-v06-20071214');
INSERT INTO cs_stringrepcache VALUES (13, 5798, 'amsr-e-l3-dailyland-v06-20071215');
INSERT INTO cs_stringrepcache VALUES (13, 5799, 'amsr-e-l3-dailyland-v06-20071216');
INSERT INTO cs_stringrepcache VALUES (13, 5800, 'amsr-e-l3-dailyland-v06-20071217');
INSERT INTO cs_stringrepcache VALUES (13, 5801, 'amsr-e-l3-dailyland-v06-20071218');
INSERT INTO cs_stringrepcache VALUES (13, 5802, 'amsr-e-l3-dailyland-v06-20071219');
INSERT INTO cs_stringrepcache VALUES (13, 5803, 'amsr-e-l3-dailyland-v06-20071220');
INSERT INTO cs_stringrepcache VALUES (13, 5804, 'amsr-e-l3-dailyland-v06-20071221');
INSERT INTO cs_stringrepcache VALUES (13, 5805, 'amsr-e-l3-dailyland-v06-20071222');
INSERT INTO cs_stringrepcache VALUES (13, 5806, 'amsr-e-l3-dailyland-v06-20071223');
INSERT INTO cs_stringrepcache VALUES (13, 5807, 'amsr-e-l3-dailyland-v06-20071224');
INSERT INTO cs_stringrepcache VALUES (13, 5808, 'amsr-e-l3-dailyland-v06-20071225');
INSERT INTO cs_stringrepcache VALUES (13, 5809, 'amsr-e-l3-dailyland-v06-20071226');
INSERT INTO cs_stringrepcache VALUES (13, 5810, 'amsr-e-l3-dailyland-v06-20071227');
INSERT INTO cs_stringrepcache VALUES (13, 5811, 'amsr-e-l3-dailyland-v06-20071228');
INSERT INTO cs_stringrepcache VALUES (13, 5812, 'amsr-e-l3-dailyland-v06-20071229');
INSERT INTO cs_stringrepcache VALUES (13, 5813, 'amsr-e-l3-dailyland-v06-20071230');
INSERT INTO cs_stringrepcache VALUES (13, 5814, 'amsr-e-l3-dailyland-v06-20071231');
INSERT INTO cs_stringrepcache VALUES (13, 5815, 'amsr-e-l3-dailyland-v06-20080101');
INSERT INTO cs_stringrepcache VALUES (13, 5816, 'amsr-e-l3-dailyland-v06-20080102');
INSERT INTO cs_stringrepcache VALUES (13, 5817, 'amsr-e-l3-dailyland-v06-20080103');
INSERT INTO cs_stringrepcache VALUES (13, 5818, 'amsr-e-l3-dailyland-v06-20080104');
INSERT INTO cs_stringrepcache VALUES (13, 5819, 'amsr-e-l3-dailyland-v06-20080105');
INSERT INTO cs_stringrepcache VALUES (13, 5820, 'amsr-e-l3-dailyland-v06-20080106');
INSERT INTO cs_stringrepcache VALUES (13, 5821, 'amsr-e-l3-dailyland-v06-20080107');
INSERT INTO cs_stringrepcache VALUES (13, 5822, 'amsr-e-l3-dailyland-v06-20080108');
INSERT INTO cs_stringrepcache VALUES (13, 5823, 'amsr-e-l3-dailyland-v06-20080109');
INSERT INTO cs_stringrepcache VALUES (13, 5824, 'amsr-e-l3-dailyland-v06-20080110');
INSERT INTO cs_stringrepcache VALUES (13, 5825, 'amsr-e-l3-dailyland-v06-20080111');
INSERT INTO cs_stringrepcache VALUES (13, 5826, 'amsr-e-l3-dailyland-v06-20080112');
INSERT INTO cs_stringrepcache VALUES (13, 5827, 'amsr-e-l3-dailyland-v06-20080113');
INSERT INTO cs_stringrepcache VALUES (13, 5828, 'amsr-e-l3-dailyland-v06-20080114');
INSERT INTO cs_stringrepcache VALUES (13, 5829, 'amsr-e-l3-dailyland-v06-20080115');
INSERT INTO cs_stringrepcache VALUES (13, 5830, 'amsr-e-l3-dailyland-v06-20080116');
INSERT INTO cs_stringrepcache VALUES (13, 5831, 'amsr-e-l3-dailyland-v06-20080117');
INSERT INTO cs_stringrepcache VALUES (13, 5832, 'amsr-e-l3-dailyland-v06-20080118');
INSERT INTO cs_stringrepcache VALUES (13, 5833, 'amsr-e-l3-dailyland-v06-20080119');
INSERT INTO cs_stringrepcache VALUES (13, 5834, 'amsr-e-l3-dailyland-v06-20080120');
INSERT INTO cs_stringrepcache VALUES (13, 5835, 'amsr-e-l3-dailyland-v06-20080121');
INSERT INTO cs_stringrepcache VALUES (13, 5836, 'amsr-e-l3-dailyland-v06-20080122');
INSERT INTO cs_stringrepcache VALUES (13, 5837, 'amsr-e-l3-dailyland-v06-20080123');
INSERT INTO cs_stringrepcache VALUES (13, 5838, 'amsr-e-l3-dailyland-v06-20080124');
INSERT INTO cs_stringrepcache VALUES (13, 5839, 'amsr-e-l3-dailyland-v06-20080125');
INSERT INTO cs_stringrepcache VALUES (13, 5840, 'amsr-e-l3-dailyland-v06-20080126');
INSERT INTO cs_stringrepcache VALUES (13, 5841, 'amsr-e-l3-dailyland-v06-20080127');
INSERT INTO cs_stringrepcache VALUES (13, 5842, 'amsr-e-l3-dailyland-v06-20080128');
INSERT INTO cs_stringrepcache VALUES (13, 5843, 'amsr-e-l3-dailyland-v06-20080129');
INSERT INTO cs_stringrepcache VALUES (13, 5844, 'amsr-e-l3-dailyland-v06-20080130');
INSERT INTO cs_stringrepcache VALUES (13, 5845, 'amsr-e-l3-dailyland-v06-20080131');
INSERT INTO cs_stringrepcache VALUES (13, 5846, 'amsr-e-l3-dailyland-v06-20080201');
INSERT INTO cs_stringrepcache VALUES (13, 5847, 'amsr-e-l3-dailyland-v06-20080202');
INSERT INTO cs_stringrepcache VALUES (13, 5848, 'amsr-e-l3-dailyland-v06-20080203');
INSERT INTO cs_stringrepcache VALUES (13, 5849, 'amsr-e-l3-dailyland-v06-20080204');
INSERT INTO cs_stringrepcache VALUES (13, 5850, 'amsr-e-l3-dailyland-v06-20080205');
INSERT INTO cs_stringrepcache VALUES (13, 5851, 'amsr-e-l3-dailyland-v06-20080206');
INSERT INTO cs_stringrepcache VALUES (13, 5852, 'amsr-e-l3-dailyland-v06-20080207');
INSERT INTO cs_stringrepcache VALUES (13, 5853, 'amsr-e-l3-dailyland-v06-20080208');
INSERT INTO cs_stringrepcache VALUES (13, 5854, 'amsr-e-l3-dailyland-v06-20080209');
INSERT INTO cs_stringrepcache VALUES (13, 5855, 'amsr-e-l3-dailyland-v06-20080210');
INSERT INTO cs_stringrepcache VALUES (13, 5856, 'amsr-e-l3-dailyland-v06-20080211');
INSERT INTO cs_stringrepcache VALUES (13, 5857, 'amsr-e-l3-dailyland-v06-20080212');
INSERT INTO cs_stringrepcache VALUES (13, 5858, 'amsr-e-l3-dailyland-v06-20080213');
INSERT INTO cs_stringrepcache VALUES (13, 5859, 'amsr-e-l3-dailyland-v06-20080214');
INSERT INTO cs_stringrepcache VALUES (13, 5860, 'amsr-e-l3-dailyland-v06-20080215');
INSERT INTO cs_stringrepcache VALUES (13, 5861, 'amsr-e-l3-dailyland-v06-20080216');
INSERT INTO cs_stringrepcache VALUES (13, 5862, 'amsr-e-l3-dailyland-v06-20080217');
INSERT INTO cs_stringrepcache VALUES (13, 5863, 'amsr-e-l3-dailyland-v06-20080218');
INSERT INTO cs_stringrepcache VALUES (13, 5864, 'amsr-e-l3-dailyland-v06-20080219');
INSERT INTO cs_stringrepcache VALUES (13, 5865, 'amsr-e-l3-dailyland-v06-20080220');
INSERT INTO cs_stringrepcache VALUES (13, 5866, 'amsr-e-l3-dailyland-v06-20080221');
INSERT INTO cs_stringrepcache VALUES (13, 5867, 'amsr-e-l3-dailyland-v06-20080222');
INSERT INTO cs_stringrepcache VALUES (13, 5868, 'amsr-e-l3-dailyland-v06-20080223');
INSERT INTO cs_stringrepcache VALUES (13, 5869, 'amsr-e-l3-dailyland-v06-20080224');
INSERT INTO cs_stringrepcache VALUES (13, 5870, 'amsr-e-l3-dailyland-v06-20080225');
INSERT INTO cs_stringrepcache VALUES (13, 5871, 'amsr-e-l3-dailyland-v06-20080226');
INSERT INTO cs_stringrepcache VALUES (13, 5872, 'amsr-e-l3-dailyland-v06-20080227');
INSERT INTO cs_stringrepcache VALUES (13, 5873, 'amsr-e-l3-dailyland-v06-20080228');
INSERT INTO cs_stringrepcache VALUES (13, 5874, 'amsr-e-l3-dailyland-v06-20080229');
INSERT INTO cs_stringrepcache VALUES (13, 5875, 'amsr-e-l3-dailyland-v06-20080301');
INSERT INTO cs_stringrepcache VALUES (13, 5876, 'amsr-e-l3-dailyland-v06-20080302');
INSERT INTO cs_stringrepcache VALUES (13, 5877, 'amsr-e-l3-dailyland-v06-20080303');
INSERT INTO cs_stringrepcache VALUES (13, 5878, 'amsr-e-l3-dailyland-v06-20080304');
INSERT INTO cs_stringrepcache VALUES (13, 5879, 'amsr-e-l3-dailyland-v06-20080305');
INSERT INTO cs_stringrepcache VALUES (13, 5880, 'amsr-e-l3-dailyland-v06-20080306');
INSERT INTO cs_stringrepcache VALUES (13, 5881, 'amsr-e-l3-dailyland-v06-20080307');
INSERT INTO cs_stringrepcache VALUES (13, 5882, 'amsr-e-l3-dailyland-v06-20080308');
INSERT INTO cs_stringrepcache VALUES (13, 5883, 'amsr-e-l3-dailyland-v06-20080309');
INSERT INTO cs_stringrepcache VALUES (13, 5884, 'amsr-e-l3-dailyland-v06-20080310');
INSERT INTO cs_stringrepcache VALUES (13, 5885, 'amsr-e-l3-dailyland-v06-20080311');
INSERT INTO cs_stringrepcache VALUES (13, 5886, 'amsr-e-l3-dailyland-v06-20080312');
INSERT INTO cs_stringrepcache VALUES (13, 5887, 'amsr-e-l3-dailyland-v06-20080313');
INSERT INTO cs_stringrepcache VALUES (13, 5888, 'amsr-e-l3-dailyland-v06-20080314');
INSERT INTO cs_stringrepcache VALUES (13, 5889, 'amsr-e-l3-dailyland-v06-20080315');
INSERT INTO cs_stringrepcache VALUES (13, 5890, 'amsr-e-l3-dailyland-v06-20080316');
INSERT INTO cs_stringrepcache VALUES (13, 5891, 'amsr-e-l3-dailyland-v06-20080317');
INSERT INTO cs_stringrepcache VALUES (13, 5892, 'amsr-e-l3-dailyland-v06-20080318');
INSERT INTO cs_stringrepcache VALUES (13, 5893, 'amsr-e-l3-dailyland-v06-20080319');
INSERT INTO cs_stringrepcache VALUES (13, 5894, 'amsr-e-l3-dailyland-v06-20080320');
INSERT INTO cs_stringrepcache VALUES (13, 5895, 'amsr-e-l3-dailyland-v06-20080321');
INSERT INTO cs_stringrepcache VALUES (13, 5896, 'amsr-e-l3-dailyland-v06-20080322');
INSERT INTO cs_stringrepcache VALUES (13, 5897, 'amsr-e-l3-dailyland-v06-20080323');
INSERT INTO cs_stringrepcache VALUES (13, 5898, 'amsr-e-l3-dailyland-v06-20080324');
INSERT INTO cs_stringrepcache VALUES (13, 5899, 'amsr-e-l3-dailyland-v06-20080325');
INSERT INTO cs_stringrepcache VALUES (13, 5900, 'amsr-e-l3-dailyland-v06-20080326');
INSERT INTO cs_stringrepcache VALUES (13, 5901, 'amsr-e-l3-dailyland-v06-20080327');
INSERT INTO cs_stringrepcache VALUES (13, 5902, 'amsr-e-l3-dailyland-v06-20080328');
INSERT INTO cs_stringrepcache VALUES (13, 5903, 'amsr-e-l3-dailyland-v06-20080329');
INSERT INTO cs_stringrepcache VALUES (13, 5904, 'amsr-e-l3-dailyland-v06-20080330');
INSERT INTO cs_stringrepcache VALUES (13, 5905, 'amsr-e-l3-dailyland-v06-20080331');
INSERT INTO cs_stringrepcache VALUES (13, 5906, 'amsr-e-l3-dailyland-v06-20080401');
INSERT INTO cs_stringrepcache VALUES (13, 5907, 'amsr-e-l3-dailyland-v06-20080402');
INSERT INTO cs_stringrepcache VALUES (13, 5908, 'amsr-e-l3-dailyland-v06-20080403');
INSERT INTO cs_stringrepcache VALUES (13, 5909, 'amsr-e-l3-dailyland-v06-20080404');
INSERT INTO cs_stringrepcache VALUES (13, 5910, 'amsr-e-l3-dailyland-v06-20080405');
INSERT INTO cs_stringrepcache VALUES (13, 5911, 'amsr-e-l3-dailyland-v06-20080406');
INSERT INTO cs_stringrepcache VALUES (13, 5912, 'amsr-e-l3-dailyland-v06-20080407');
INSERT INTO cs_stringrepcache VALUES (13, 5913, 'amsr-e-l3-dailyland-v06-20080408');
INSERT INTO cs_stringrepcache VALUES (13, 5914, 'amsr-e-l3-dailyland-v06-20080409');
INSERT INTO cs_stringrepcache VALUES (13, 5915, 'amsr-e-l3-dailyland-v06-20080410');
INSERT INTO cs_stringrepcache VALUES (13, 5916, 'amsr-e-l3-dailyland-v06-20080411');
INSERT INTO cs_stringrepcache VALUES (13, 5917, 'amsr-e-l3-dailyland-v06-20080412');
INSERT INTO cs_stringrepcache VALUES (13, 5918, 'amsr-e-l3-dailyland-v06-20080413');
INSERT INTO cs_stringrepcache VALUES (13, 5919, 'amsr-e-l3-dailyland-v06-20080414');
INSERT INTO cs_stringrepcache VALUES (13, 5920, 'amsr-e-l3-dailyland-v06-20080415');
INSERT INTO cs_stringrepcache VALUES (13, 5921, 'amsr-e-l3-dailyland-v06-20080416');
INSERT INTO cs_stringrepcache VALUES (13, 5922, 'amsr-e-l3-dailyland-v06-20080417');
INSERT INTO cs_stringrepcache VALUES (13, 5923, 'amsr-e-l3-dailyland-v06-20080418');
INSERT INTO cs_stringrepcache VALUES (13, 5924, 'amsr-e-l3-dailyland-v06-20080419');
INSERT INTO cs_stringrepcache VALUES (13, 5925, 'amsr-e-l3-dailyland-v06-20080420');
INSERT INTO cs_stringrepcache VALUES (13, 5926, 'amsr-e-l3-dailyland-v06-20080421');
INSERT INTO cs_stringrepcache VALUES (13, 5927, 'amsr-e-l3-dailyland-v06-20080422');
INSERT INTO cs_stringrepcache VALUES (13, 5928, 'amsr-e-l3-dailyland-v06-20080423');
INSERT INTO cs_stringrepcache VALUES (13, 5929, 'amsr-e-l3-dailyland-v06-20080424');
INSERT INTO cs_stringrepcache VALUES (13, 5930, 'amsr-e-l3-dailyland-v06-20080425');
INSERT INTO cs_stringrepcache VALUES (13, 5931, 'amsr-e-l3-dailyland-v06-20080426');
INSERT INTO cs_stringrepcache VALUES (13, 5932, 'amsr-e-l3-dailyland-v06-20080427');
INSERT INTO cs_stringrepcache VALUES (13, 5933, 'amsr-e-l3-dailyland-v06-20080428');
INSERT INTO cs_stringrepcache VALUES (13, 5934, 'amsr-e-l3-dailyland-v06-20080429');
INSERT INTO cs_stringrepcache VALUES (13, 5935, 'amsr-e-l3-dailyland-v06-20080430');
INSERT INTO cs_stringrepcache VALUES (13, 5936, 'amsr-e-l3-dailyland-v06-20080501');
INSERT INTO cs_stringrepcache VALUES (13, 5937, 'amsr-e-l3-dailyland-v06-20080502');
INSERT INTO cs_stringrepcache VALUES (13, 5938, 'amsr-e-l3-dailyland-v06-20080503');
INSERT INTO cs_stringrepcache VALUES (13, 5939, 'amsr-e-l3-dailyland-v06-20080504');
INSERT INTO cs_stringrepcache VALUES (13, 5940, 'amsr-e-l3-dailyland-v06-20080505');
INSERT INTO cs_stringrepcache VALUES (13, 5941, 'amsr-e-l3-dailyland-v06-20080506');
INSERT INTO cs_stringrepcache VALUES (13, 5942, 'amsr-e-l3-dailyland-v06-20080507');
INSERT INTO cs_stringrepcache VALUES (13, 5943, 'amsr-e-l3-dailyland-v06-20080508');
INSERT INTO cs_stringrepcache VALUES (13, 5944, 'amsr-e-l3-dailyland-v06-20080509');
INSERT INTO cs_stringrepcache VALUES (13, 5945, 'amsr-e-l3-dailyland-v06-20080510');
INSERT INTO cs_stringrepcache VALUES (13, 5946, 'amsr-e-l3-dailyland-v06-20080511');
INSERT INTO cs_stringrepcache VALUES (13, 5947, 'amsr-e-l3-dailyland-v06-20080512');
INSERT INTO cs_stringrepcache VALUES (13, 5948, 'amsr-e-l3-dailyland-v06-20080513');
INSERT INTO cs_stringrepcache VALUES (13, 5949, 'amsr-e-l3-dailyland-v06-20080514');
INSERT INTO cs_stringrepcache VALUES (13, 5950, 'amsr-e-l3-dailyland-v06-20080515');
INSERT INTO cs_stringrepcache VALUES (13, 5951, 'amsr-e-l3-dailyland-v06-20080516');
INSERT INTO cs_stringrepcache VALUES (13, 5952, 'amsr-e-l3-dailyland-v06-20080517');
INSERT INTO cs_stringrepcache VALUES (13, 5953, 'amsr-e-l3-dailyland-v06-20080518');
INSERT INTO cs_stringrepcache VALUES (13, 5954, 'amsr-e-l3-dailyland-v06-20080519');
INSERT INTO cs_stringrepcache VALUES (13, 5955, 'amsr-e-l3-dailyland-v06-20080520');
INSERT INTO cs_stringrepcache VALUES (13, 5956, 'amsr-e-l3-dailyland-v06-20080521');
INSERT INTO cs_stringrepcache VALUES (13, 5957, 'amsr-e-l3-dailyland-v06-20080522');
INSERT INTO cs_stringrepcache VALUES (13, 5958, 'amsr-e-l3-dailyland-v06-20080523');
INSERT INTO cs_stringrepcache VALUES (13, 5959, 'amsr-e-l3-dailyland-v06-20080524');
INSERT INTO cs_stringrepcache VALUES (13, 5960, 'amsr-e-l3-dailyland-v06-20080525');
INSERT INTO cs_stringrepcache VALUES (13, 5961, 'amsr-e-l3-dailyland-v06-20080526');
INSERT INTO cs_stringrepcache VALUES (13, 5962, 'amsr-e-l3-dailyland-v06-20080527');
INSERT INTO cs_stringrepcache VALUES (13, 5963, 'amsr-e-l3-dailyland-v06-20080528');
INSERT INTO cs_stringrepcache VALUES (13, 5964, 'amsr-e-l3-dailyland-v06-20080529');
INSERT INTO cs_stringrepcache VALUES (13, 5965, 'amsr-e-l3-dailyland-v06-20080530');
INSERT INTO cs_stringrepcache VALUES (13, 5966, 'amsr-e-l3-dailyland-v06-20080531');
INSERT INTO cs_stringrepcache VALUES (13, 5967, 'amsr-e-l3-dailyland-v06-20080601');
INSERT INTO cs_stringrepcache VALUES (13, 5968, 'amsr-e-l3-dailyland-v06-20080602');
INSERT INTO cs_stringrepcache VALUES (13, 5969, 'amsr-e-l3-dailyland-v06-20080603');
INSERT INTO cs_stringrepcache VALUES (13, 5970, 'amsr-e-l3-dailyland-v06-20080604');
INSERT INTO cs_stringrepcache VALUES (13, 5971, 'amsr-e-l3-dailyland-v06-20080605');
INSERT INTO cs_stringrepcache VALUES (13, 5972, 'amsr-e-l3-dailyland-v06-20080606');
INSERT INTO cs_stringrepcache VALUES (13, 5973, 'amsr-e-l3-dailyland-v06-20080607');
INSERT INTO cs_stringrepcache VALUES (13, 5974, 'amsr-e-l3-dailyland-v06-20080608');
INSERT INTO cs_stringrepcache VALUES (13, 5975, 'amsr-e-l3-dailyland-v06-20080609');
INSERT INTO cs_stringrepcache VALUES (13, 5976, 'amsr-e-l3-dailyland-v06-20080610');
INSERT INTO cs_stringrepcache VALUES (13, 5977, 'amsr-e-l3-dailyland-v06-20080611');
INSERT INTO cs_stringrepcache VALUES (13, 5978, 'amsr-e-l3-dailyland-v06-20080612');
INSERT INTO cs_stringrepcache VALUES (13, 5979, 'amsr-e-l3-dailyland-v06-20080613');
INSERT INTO cs_stringrepcache VALUES (13, 5980, 'amsr-e-l3-dailyland-v06-20080614');
INSERT INTO cs_stringrepcache VALUES (13, 5981, 'amsr-e-l3-dailyland-v06-20080615');
INSERT INTO cs_stringrepcache VALUES (13, 5982, 'amsr-e-l3-dailyland-v06-20080616');
INSERT INTO cs_stringrepcache VALUES (13, 5983, 'amsr-e-l3-dailyland-v06-20080617');
INSERT INTO cs_stringrepcache VALUES (13, 5984, 'amsr-e-l3-dailyland-v06-20080618');
INSERT INTO cs_stringrepcache VALUES (13, 5985, 'amsr-e-l3-dailyland-v06-20080619');
INSERT INTO cs_stringrepcache VALUES (13, 5986, 'amsr-e-l3-dailyland-v06-20080620');
INSERT INTO cs_stringrepcache VALUES (13, 5987, 'amsr-e-l3-dailyland-v06-20080621');
INSERT INTO cs_stringrepcache VALUES (13, 5988, 'amsr-e-l3-dailyland-v06-20080622');
INSERT INTO cs_stringrepcache VALUES (13, 5989, 'amsr-e-l3-dailyland-v06-20080623');
INSERT INTO cs_stringrepcache VALUES (13, 5990, 'amsr-e-l3-dailyland-v06-20080624');
INSERT INTO cs_stringrepcache VALUES (13, 5991, 'amsr-e-l3-dailyland-v06-20080625');
INSERT INTO cs_stringrepcache VALUES (13, 5992, 'amsr-e-l3-dailyland-v06-20080626');
INSERT INTO cs_stringrepcache VALUES (13, 5993, 'amsr-e-l3-dailyland-v06-20080627');
INSERT INTO cs_stringrepcache VALUES (13, 5994, 'amsr-e-l3-dailyland-v06-20080628');
INSERT INTO cs_stringrepcache VALUES (13, 5995, 'amsr-e-l3-dailyland-v06-20080629');
INSERT INTO cs_stringrepcache VALUES (13, 5996, 'amsr-e-l3-dailyland-v06-20080630');
INSERT INTO cs_stringrepcache VALUES (13, 5997, 'amsr-e-l3-dailyland-v06-20080701');
INSERT INTO cs_stringrepcache VALUES (13, 5998, 'amsr-e-l3-dailyland-v06-20080702');
INSERT INTO cs_stringrepcache VALUES (13, 5999, 'amsr-e-l3-dailyland-v06-20080703');
INSERT INTO cs_stringrepcache VALUES (13, 6000, 'amsr-e-l3-dailyland-v06-20080704');
INSERT INTO cs_stringrepcache VALUES (13, 6001, 'amsr-e-l3-dailyland-v06-20080705');
INSERT INTO cs_stringrepcache VALUES (13, 6002, 'amsr-e-l3-dailyland-v06-20080706');
INSERT INTO cs_stringrepcache VALUES (13, 6003, 'amsr-e-l3-dailyland-v06-20080707');
INSERT INTO cs_stringrepcache VALUES (13, 6004, 'amsr-e-l3-dailyland-v06-20080708');
INSERT INTO cs_stringrepcache VALUES (13, 6005, 'amsr-e-l3-dailyland-v06-20080709');
INSERT INTO cs_stringrepcache VALUES (13, 6006, 'amsr-e-l3-dailyland-v06-20080710');
INSERT INTO cs_stringrepcache VALUES (13, 6007, 'amsr-e-l3-dailyland-v06-20080711');
INSERT INTO cs_stringrepcache VALUES (13, 6008, 'amsr-e-l3-dailyland-v06-20080712');
INSERT INTO cs_stringrepcache VALUES (13, 6009, 'amsr-e-l3-dailyland-v06-20080713');
INSERT INTO cs_stringrepcache VALUES (13, 6010, 'amsr-e-l3-dailyland-v06-20080714');
INSERT INTO cs_stringrepcache VALUES (13, 6011, 'amsr-e-l3-dailyland-v06-20080715');
INSERT INTO cs_stringrepcache VALUES (13, 6012, 'amsr-e-l3-dailyland-v06-20080716');
INSERT INTO cs_stringrepcache VALUES (13, 6013, 'amsr-e-l3-dailyland-v06-20080717');
INSERT INTO cs_stringrepcache VALUES (13, 6014, 'amsr-e-l3-dailyland-v06-20080718');
INSERT INTO cs_stringrepcache VALUES (13, 6015, 'amsr-e-l3-dailyland-v06-20080719');
INSERT INTO cs_stringrepcache VALUES (13, 6016, 'amsr-e-l3-dailyland-v06-20080720');
INSERT INTO cs_stringrepcache VALUES (13, 6017, 'amsr-e-l3-dailyland-v06-20080721');
INSERT INTO cs_stringrepcache VALUES (13, 6018, 'amsr-e-l3-dailyland-v06-20080722');
INSERT INTO cs_stringrepcache VALUES (13, 6019, 'amsr-e-l3-dailyland-v06-20080723');
INSERT INTO cs_stringrepcache VALUES (13, 6020, 'amsr-e-l3-dailyland-v06-20080724');
INSERT INTO cs_stringrepcache VALUES (13, 6021, 'amsr-e-l3-dailyland-v06-20080725');
INSERT INTO cs_stringrepcache VALUES (13, 6022, 'amsr-e-l3-dailyland-v06-20080726');
INSERT INTO cs_stringrepcache VALUES (13, 6023, 'amsr-e-l3-dailyland-v06-20080727');
INSERT INTO cs_stringrepcache VALUES (13, 6024, 'amsr-e-l3-dailyland-v06-20080728');
INSERT INTO cs_stringrepcache VALUES (13, 6025, 'amsr-e-l3-dailyland-v06-20080729');
INSERT INTO cs_stringrepcache VALUES (13, 6026, 'amsr-e-l3-dailyland-v06-20080730');
INSERT INTO cs_stringrepcache VALUES (13, 6027, 'amsr-e-l3-dailyland-v06-20080731');
INSERT INTO cs_stringrepcache VALUES (13, 6028, 'amsr-e-l3-dailyland-v06-20080801');
INSERT INTO cs_stringrepcache VALUES (13, 6029, 'amsr-e-l3-dailyland-v06-20080802');
INSERT INTO cs_stringrepcache VALUES (13, 6030, 'amsr-e-l3-dailyland-v06-20080803');
INSERT INTO cs_stringrepcache VALUES (13, 6031, 'amsr-e-l3-dailyland-v06-20080804');
INSERT INTO cs_stringrepcache VALUES (13, 6032, 'amsr-e-l3-dailyland-v06-20080805');
INSERT INTO cs_stringrepcache VALUES (13, 6033, 'amsr-e-l3-dailyland-v06-20080806');
INSERT INTO cs_stringrepcache VALUES (13, 6034, 'amsr-e-l3-dailyland-v06-20080807');
INSERT INTO cs_stringrepcache VALUES (13, 6035, 'amsr-e-l3-dailyland-v06-20080808');
INSERT INTO cs_stringrepcache VALUES (13, 6036, 'amsr-e-l3-dailyland-v06-20080809');
INSERT INTO cs_stringrepcache VALUES (13, 6037, 'amsr-e-l3-dailyland-v06-20080810');
INSERT INTO cs_stringrepcache VALUES (13, 6038, 'amsr-e-l3-dailyland-v06-20080811');
INSERT INTO cs_stringrepcache VALUES (13, 6039, 'amsr-e-l3-dailyland-v06-20080812');
INSERT INTO cs_stringrepcache VALUES (13, 6040, 'amsr-e-l3-dailyland-v06-20080813');
INSERT INTO cs_stringrepcache VALUES (13, 6041, 'amsr-e-l3-dailyland-v06-20080814');
INSERT INTO cs_stringrepcache VALUES (13, 6042, 'amsr-e-l3-dailyland-v06-20080815');
INSERT INTO cs_stringrepcache VALUES (13, 6043, 'amsr-e-l3-dailyland-v06-20080816');
INSERT INTO cs_stringrepcache VALUES (13, 6044, 'amsr-e-l3-dailyland-v06-20080817');
INSERT INTO cs_stringrepcache VALUES (13, 6045, 'amsr-e-l3-dailyland-v06-20080818');
INSERT INTO cs_stringrepcache VALUES (13, 6046, 'amsr-e-l3-dailyland-v06-20080819');
INSERT INTO cs_stringrepcache VALUES (13, 6047, 'amsr-e-l3-dailyland-v06-20080820');
INSERT INTO cs_stringrepcache VALUES (13, 6048, 'amsr-e-l3-dailyland-v06-20080821');
INSERT INTO cs_stringrepcache VALUES (13, 6049, 'amsr-e-l3-dailyland-v06-20080822');
INSERT INTO cs_stringrepcache VALUES (13, 6050, 'amsr-e-l3-dailyland-v06-20080823');
INSERT INTO cs_stringrepcache VALUES (13, 6051, 'amsr-e-l3-dailyland-v06-20080824');
INSERT INTO cs_stringrepcache VALUES (13, 6052, 'amsr-e-l3-dailyland-v06-20080825');
INSERT INTO cs_stringrepcache VALUES (13, 6053, 'amsr-e-l3-dailyland-v06-20080826');
INSERT INTO cs_stringrepcache VALUES (13, 6054, 'amsr-e-l3-dailyland-v06-20080827');
INSERT INTO cs_stringrepcache VALUES (13, 6055, 'amsr-e-l3-dailyland-v06-20080828');
INSERT INTO cs_stringrepcache VALUES (13, 6056, 'amsr-e-l3-dailyland-v06-20080829');
INSERT INTO cs_stringrepcache VALUES (13, 6057, 'amsr-e-l3-dailyland-v06-20080830');
INSERT INTO cs_stringrepcache VALUES (13, 6058, 'amsr-e-l3-dailyland-v06-20080831');
INSERT INTO cs_stringrepcache VALUES (13, 6059, 'amsr-e-l3-dailyland-v06-20080901');
INSERT INTO cs_stringrepcache VALUES (13, 6060, 'amsr-e-l3-dailyland-v06-20080902');
INSERT INTO cs_stringrepcache VALUES (13, 6061, 'amsr-e-l3-dailyland-v06-20080903');
INSERT INTO cs_stringrepcache VALUES (13, 6062, 'amsr-e-l3-dailyland-v06-20080904');
INSERT INTO cs_stringrepcache VALUES (13, 6063, 'amsr-e-l3-dailyland-v06-20080905');
INSERT INTO cs_stringrepcache VALUES (13, 6064, 'amsr-e-l3-dailyland-v06-20080906');
INSERT INTO cs_stringrepcache VALUES (13, 6065, 'amsr-e-l3-dailyland-v06-20080907');
INSERT INTO cs_stringrepcache VALUES (13, 6066, 'amsr-e-l3-dailyland-v06-20080908');
INSERT INTO cs_stringrepcache VALUES (13, 6067, 'amsr-e-l3-dailyland-v06-20080909');
INSERT INTO cs_stringrepcache VALUES (13, 6068, 'amsr-e-l3-dailyland-v06-20080910');
INSERT INTO cs_stringrepcache VALUES (13, 6069, 'amsr-e-l3-dailyland-v06-20080911');
INSERT INTO cs_stringrepcache VALUES (13, 6070, 'amsr-e-l3-dailyland-v06-20080912');
INSERT INTO cs_stringrepcache VALUES (13, 6071, 'amsr-e-l3-dailyland-v06-20080913');
INSERT INTO cs_stringrepcache VALUES (13, 6072, 'amsr-e-l3-dailyland-v06-20080914');
INSERT INTO cs_stringrepcache VALUES (13, 6073, 'amsr-e-l3-dailyland-v06-20080915');
INSERT INTO cs_stringrepcache VALUES (13, 6074, 'amsr-e-l3-dailyland-v06-20080916');
INSERT INTO cs_stringrepcache VALUES (13, 6075, 'amsr-e-l3-dailyland-v06-20080917');
INSERT INTO cs_stringrepcache VALUES (13, 6076, 'amsr-e-l3-dailyland-v06-20080918');
INSERT INTO cs_stringrepcache VALUES (13, 6077, 'amsr-e-l3-dailyland-v06-20080919');
INSERT INTO cs_stringrepcache VALUES (13, 6078, 'amsr-e-l3-dailyland-v06-20080920');
INSERT INTO cs_stringrepcache VALUES (13, 6079, 'amsr-e-l3-dailyland-v06-20080921');
INSERT INTO cs_stringrepcache VALUES (13, 6080, 'amsr-e-l3-dailyland-v06-20080922');
INSERT INTO cs_stringrepcache VALUES (13, 6081, 'amsr-e-l3-dailyland-v06-20080923');
INSERT INTO cs_stringrepcache VALUES (13, 6082, 'amsr-e-l3-dailyland-v06-20080924');
INSERT INTO cs_stringrepcache VALUES (13, 6083, 'amsr-e-l3-dailyland-v06-20080925');
INSERT INTO cs_stringrepcache VALUES (13, 6084, 'amsr-e-l3-dailyland-v06-20080926');
INSERT INTO cs_stringrepcache VALUES (13, 6085, 'amsr-e-l3-dailyland-v06-20080927');
INSERT INTO cs_stringrepcache VALUES (13, 6086, 'amsr-e-l3-dailyland-v06-20080928');
INSERT INTO cs_stringrepcache VALUES (13, 6087, 'amsr-e-l3-dailyland-v06-20080929');
INSERT INTO cs_stringrepcache VALUES (13, 6088, 'amsr-e-l3-dailyland-v06-20080930');
INSERT INTO cs_stringrepcache VALUES (13, 6089, 'amsr-e-l3-dailyland-v06-20081001');
INSERT INTO cs_stringrepcache VALUES (13, 6090, 'amsr-e-l3-dailyland-v06-20081002');
INSERT INTO cs_stringrepcache VALUES (13, 6091, 'amsr-e-l3-dailyland-v06-20081003');
INSERT INTO cs_stringrepcache VALUES (13, 6092, 'amsr-e-l3-dailyland-v06-20081004');
INSERT INTO cs_stringrepcache VALUES (13, 6093, 'amsr-e-l3-dailyland-v06-20081005');
INSERT INTO cs_stringrepcache VALUES (13, 6094, 'amsr-e-l3-dailyland-v06-20081006');
INSERT INTO cs_stringrepcache VALUES (13, 6095, 'amsr-e-l3-dailyland-v06-20081007');
INSERT INTO cs_stringrepcache VALUES (13, 6096, 'amsr-e-l3-dailyland-v06-20081008');
INSERT INTO cs_stringrepcache VALUES (13, 6097, 'amsr-e-l3-dailyland-v06-20081009');
INSERT INTO cs_stringrepcache VALUES (13, 6098, 'amsr-e-l3-dailyland-v06-20081010');
INSERT INTO cs_stringrepcache VALUES (13, 6099, 'amsr-e-l3-dailyland-v06-20081011');
INSERT INTO cs_stringrepcache VALUES (13, 6100, 'amsr-e-l3-dailyland-v06-20081012');
INSERT INTO cs_stringrepcache VALUES (13, 6101, 'amsr-e-l3-dailyland-v06-20081013');
INSERT INTO cs_stringrepcache VALUES (13, 6102, 'amsr-e-l3-dailyland-v06-20081014');
INSERT INTO cs_stringrepcache VALUES (13, 6103, 'amsr-e-l3-dailyland-v06-20081015');
INSERT INTO cs_stringrepcache VALUES (13, 6104, 'amsr-e-l3-dailyland-v06-20081016');
INSERT INTO cs_stringrepcache VALUES (13, 6105, 'amsr-e-l3-dailyland-v06-20081017');
INSERT INTO cs_stringrepcache VALUES (13, 6106, 'amsr-e-l3-dailyland-v06-20081018');
INSERT INTO cs_stringrepcache VALUES (13, 6107, 'amsr-e-l3-dailyland-v06-20081019');
INSERT INTO cs_stringrepcache VALUES (13, 6108, 'amsr-e-l3-dailyland-v06-20081020');
INSERT INTO cs_stringrepcache VALUES (13, 6109, 'amsr-e-l3-dailyland-v06-20081021');
INSERT INTO cs_stringrepcache VALUES (13, 6110, 'amsr-e-l3-dailyland-v06-20081022');
INSERT INTO cs_stringrepcache VALUES (13, 6111, 'amsr-e-l3-dailyland-v06-20081023');
INSERT INTO cs_stringrepcache VALUES (13, 6112, 'amsr-e-l3-dailyland-v06-20081024');
INSERT INTO cs_stringrepcache VALUES (13, 6113, 'amsr-e-l3-dailyland-v06-20081025');
INSERT INTO cs_stringrepcache VALUES (13, 6114, 'amsr-e-l3-dailyland-v06-20081026');
INSERT INTO cs_stringrepcache VALUES (13, 6115, 'amsr-e-l3-dailyland-v06-20081027');
INSERT INTO cs_stringrepcache VALUES (13, 6116, 'amsr-e-l3-dailyland-v06-20081028');
INSERT INTO cs_stringrepcache VALUES (13, 6117, 'amsr-e-l3-dailyland-v06-20081029');
INSERT INTO cs_stringrepcache VALUES (13, 6118, 'amsr-e-l3-dailyland-v06-20081030');
INSERT INTO cs_stringrepcache VALUES (13, 6119, 'amsr-e-l3-dailyland-v06-20081031');
INSERT INTO cs_stringrepcache VALUES (13, 6120, 'amsr-e-l3-dailyland-v06-20081101');
INSERT INTO cs_stringrepcache VALUES (13, 6121, 'amsr-e-l3-dailyland-v06-20081102');
INSERT INTO cs_stringrepcache VALUES (13, 6122, 'amsr-e-l3-dailyland-v06-20081103');
INSERT INTO cs_stringrepcache VALUES (13, 6123, 'amsr-e-l3-dailyland-v06-20081104');
INSERT INTO cs_stringrepcache VALUES (13, 6124, 'amsr-e-l3-dailyland-v06-20081105');
INSERT INTO cs_stringrepcache VALUES (13, 6125, 'amsr-e-l3-dailyland-v06-20081106');
INSERT INTO cs_stringrepcache VALUES (13, 6126, 'amsr-e-l3-dailyland-v06-20081107');
INSERT INTO cs_stringrepcache VALUES (13, 6127, 'amsr-e-l3-dailyland-v06-20081108');
INSERT INTO cs_stringrepcache VALUES (13, 6128, 'amsr-e-l3-dailyland-v06-20081109');
INSERT INTO cs_stringrepcache VALUES (13, 6129, 'amsr-e-l3-dailyland-v06-20081110');
INSERT INTO cs_stringrepcache VALUES (13, 6130, 'amsr-e-l3-dailyland-v06-20081111');
INSERT INTO cs_stringrepcache VALUES (13, 6131, 'amsr-e-l3-dailyland-v06-20081112');
INSERT INTO cs_stringrepcache VALUES (13, 6132, 'amsr-e-l3-dailyland-v06-20081113');
INSERT INTO cs_stringrepcache VALUES (13, 6133, 'amsr-e-l3-dailyland-v06-20081114');
INSERT INTO cs_stringrepcache VALUES (13, 6134, 'amsr-e-l3-dailyland-v06-20081115');
INSERT INTO cs_stringrepcache VALUES (13, 6135, 'amsr-e-l3-dailyland-v06-20081116');
INSERT INTO cs_stringrepcache VALUES (13, 6136, 'amsr-e-l3-dailyland-v06-20081117');
INSERT INTO cs_stringrepcache VALUES (13, 6137, 'amsr-e-l3-dailyland-v06-20081118');
INSERT INTO cs_stringrepcache VALUES (13, 6138, 'amsr-e-l3-dailyland-v06-20081119');
INSERT INTO cs_stringrepcache VALUES (13, 6139, 'amsr-e-l3-dailyland-v06-20081120');
INSERT INTO cs_stringrepcache VALUES (13, 6140, 'amsr-e-l3-dailyland-v06-20081121');
INSERT INTO cs_stringrepcache VALUES (13, 6141, 'amsr-e-l3-dailyland-v06-20081122');
INSERT INTO cs_stringrepcache VALUES (13, 6142, 'amsr-e-l3-dailyland-v06-20081123');
INSERT INTO cs_stringrepcache VALUES (13, 6143, 'amsr-e-l3-dailyland-v06-20081124');
INSERT INTO cs_stringrepcache VALUES (13, 6144, 'amsr-e-l3-dailyland-v06-20081125');
INSERT INTO cs_stringrepcache VALUES (13, 6145, 'amsr-e-l3-dailyland-v06-20081126');
INSERT INTO cs_stringrepcache VALUES (13, 6146, 'amsr-e-l3-dailyland-v06-20081127');
INSERT INTO cs_stringrepcache VALUES (13, 6147, 'amsr-e-l3-dailyland-v06-20081128');
INSERT INTO cs_stringrepcache VALUES (13, 6148, 'amsr-e-l3-dailyland-v06-20081129');
INSERT INTO cs_stringrepcache VALUES (13, 6149, 'amsr-e-l3-dailyland-v06-20081130');
INSERT INTO cs_stringrepcache VALUES (13, 6150, 'amsr-e-l3-dailyland-v06-20081201');
INSERT INTO cs_stringrepcache VALUES (13, 6151, 'amsr-e-l3-dailyland-v06-20081202');
INSERT INTO cs_stringrepcache VALUES (13, 6152, 'amsr-e-l3-dailyland-v06-20081203');
INSERT INTO cs_stringrepcache VALUES (13, 6153, 'amsr-e-l3-dailyland-v06-20081204');
INSERT INTO cs_stringrepcache VALUES (13, 6154, 'amsr-e-l3-dailyland-v06-20081205');
INSERT INTO cs_stringrepcache VALUES (13, 6155, 'amsr-e-l3-dailyland-v06-20081206');
INSERT INTO cs_stringrepcache VALUES (13, 6156, 'amsr-e-l3-dailyland-v06-20081207');
INSERT INTO cs_stringrepcache VALUES (13, 6157, 'amsr-e-l3-dailyland-v06-20081208');
INSERT INTO cs_stringrepcache VALUES (13, 6158, 'amsr-e-l3-dailyland-v06-20081209');
INSERT INTO cs_stringrepcache VALUES (13, 6159, 'amsr-e-l3-dailyland-v06-20081210');
INSERT INTO cs_stringrepcache VALUES (13, 6160, 'amsr-e-l3-dailyland-v06-20081211');
INSERT INTO cs_stringrepcache VALUES (13, 6161, 'amsr-e-l3-dailyland-v06-20081212');
INSERT INTO cs_stringrepcache VALUES (13, 6162, 'amsr-e-l3-dailyland-v06-20081213');
INSERT INTO cs_stringrepcache VALUES (13, 6163, 'amsr-e-l3-dailyland-v06-20081214');
INSERT INTO cs_stringrepcache VALUES (13, 6164, 'amsr-e-l3-dailyland-v06-20081215');
INSERT INTO cs_stringrepcache VALUES (13, 6165, 'amsr-e-l3-dailyland-v06-20081216');
INSERT INTO cs_stringrepcache VALUES (13, 6166, 'amsr-e-l3-dailyland-v06-20081217');
INSERT INTO cs_stringrepcache VALUES (13, 6167, 'amsr-e-l3-dailyland-v06-20081218');
INSERT INTO cs_stringrepcache VALUES (13, 6168, 'amsr-e-l3-dailyland-v06-20081219');
INSERT INTO cs_stringrepcache VALUES (13, 6169, 'amsr-e-l3-dailyland-v06-20081220');
INSERT INTO cs_stringrepcache VALUES (13, 6170, 'amsr-e-l3-dailyland-v06-20081221');
INSERT INTO cs_stringrepcache VALUES (13, 6171, 'amsr-e-l3-dailyland-v06-20081222');
INSERT INTO cs_stringrepcache VALUES (13, 6172, 'amsr-e-l3-dailyland-v06-20081223');
INSERT INTO cs_stringrepcache VALUES (13, 6173, 'amsr-e-l3-dailyland-v06-20081224');
INSERT INTO cs_stringrepcache VALUES (13, 6174, 'amsr-e-l3-dailyland-v06-20081225');
INSERT INTO cs_stringrepcache VALUES (13, 6175, 'amsr-e-l3-dailyland-v06-20081226');
INSERT INTO cs_stringrepcache VALUES (13, 6176, 'amsr-e-l3-dailyland-v06-20081227');
INSERT INTO cs_stringrepcache VALUES (13, 6177, 'amsr-e-l3-dailyland-v06-20081228');
INSERT INTO cs_stringrepcache VALUES (13, 6178, 'amsr-e-l3-dailyland-v06-20081229');
INSERT INTO cs_stringrepcache VALUES (13, 6179, 'amsr-e-l3-dailyland-v06-20081230');
INSERT INTO cs_stringrepcache VALUES (13, 6180, 'amsr-e-l3-dailyland-v06-20081231');
INSERT INTO cs_stringrepcache VALUES (13, 6181, 'amsr-e-l3-dailyland-v06-20090101');
INSERT INTO cs_stringrepcache VALUES (13, 6182, 'amsr-e-l3-dailyland-v06-20090102');
INSERT INTO cs_stringrepcache VALUES (13, 6183, 'amsr-e-l3-dailyland-v06-20090103');
INSERT INTO cs_stringrepcache VALUES (13, 6184, 'amsr-e-l3-dailyland-v06-20090104');
INSERT INTO cs_stringrepcache VALUES (13, 6185, 'amsr-e-l3-dailyland-v06-20090105');
INSERT INTO cs_stringrepcache VALUES (13, 6186, 'amsr-e-l3-dailyland-v06-20090106');
INSERT INTO cs_stringrepcache VALUES (13, 6187, 'amsr-e-l3-dailyland-v06-20090107');
INSERT INTO cs_stringrepcache VALUES (13, 6188, 'amsr-e-l3-dailyland-v06-20090108');
INSERT INTO cs_stringrepcache VALUES (13, 6189, 'amsr-e-l3-dailyland-v06-20090109');
INSERT INTO cs_stringrepcache VALUES (13, 6190, 'amsr-e-l3-dailyland-v06-20090110');
INSERT INTO cs_stringrepcache VALUES (13, 6191, 'amsr-e-l3-dailyland-v06-20090111');
INSERT INTO cs_stringrepcache VALUES (13, 6192, 'amsr-e-l3-dailyland-v06-20090112');
INSERT INTO cs_stringrepcache VALUES (13, 6193, 'amsr-e-l3-dailyland-v06-20090113');
INSERT INTO cs_stringrepcache VALUES (13, 6194, 'amsr-e-l3-dailyland-v06-20090114');
INSERT INTO cs_stringrepcache VALUES (13, 6195, 'amsr-e-l3-dailyland-v06-20090115');
INSERT INTO cs_stringrepcache VALUES (13, 6196, 'amsr-e-l3-dailyland-v06-20090116');
INSERT INTO cs_stringrepcache VALUES (13, 6197, 'amsr-e-l3-dailyland-v06-20090117');
INSERT INTO cs_stringrepcache VALUES (13, 6198, 'amsr-e-l3-dailyland-v06-20090118');
INSERT INTO cs_stringrepcache VALUES (13, 6199, 'amsr-e-l3-dailyland-v06-20090119');
INSERT INTO cs_stringrepcache VALUES (13, 6200, 'amsr-e-l3-dailyland-v06-20090120');
INSERT INTO cs_stringrepcache VALUES (13, 6201, 'amsr-e-l3-dailyland-v06-20090121');
INSERT INTO cs_stringrepcache VALUES (13, 6202, 'amsr-e-l3-dailyland-v06-20090122');
INSERT INTO cs_stringrepcache VALUES (13, 6203, 'amsr-e-l3-dailyland-v06-20090123');
INSERT INTO cs_stringrepcache VALUES (13, 6204, 'amsr-e-l3-dailyland-v06-20090124');
INSERT INTO cs_stringrepcache VALUES (13, 6205, 'amsr-e-l3-dailyland-v06-20090125');
INSERT INTO cs_stringrepcache VALUES (13, 6206, 'amsr-e-l3-dailyland-v06-20090126');
INSERT INTO cs_stringrepcache VALUES (13, 6207, 'amsr-e-l3-dailyland-v06-20090127');
INSERT INTO cs_stringrepcache VALUES (13, 6208, 'amsr-e-l3-dailyland-v06-20090128');
INSERT INTO cs_stringrepcache VALUES (13, 6209, 'amsr-e-l3-dailyland-v06-20090129');
INSERT INTO cs_stringrepcache VALUES (13, 6210, 'amsr-e-l3-dailyland-v06-20090130');
INSERT INTO cs_stringrepcache VALUES (13, 6211, 'amsr-e-l3-dailyland-v06-20090131');
INSERT INTO cs_stringrepcache VALUES (13, 6212, 'amsr-e-l3-dailyland-v06-20090201');
INSERT INTO cs_stringrepcache VALUES (13, 6213, 'amsr-e-l3-dailyland-v06-20090202');
INSERT INTO cs_stringrepcache VALUES (13, 6214, 'amsr-e-l3-dailyland-v06-20090203');
INSERT INTO cs_stringrepcache VALUES (13, 6215, 'amsr-e-l3-dailyland-v06-20090204');
INSERT INTO cs_stringrepcache VALUES (13, 6216, 'amsr-e-l3-dailyland-v06-20090205');
INSERT INTO cs_stringrepcache VALUES (13, 6217, 'amsr-e-l3-dailyland-v06-20090206');
INSERT INTO cs_stringrepcache VALUES (13, 6218, 'amsr-e-l3-dailyland-v06-20090207');
INSERT INTO cs_stringrepcache VALUES (13, 6219, 'amsr-e-l3-dailyland-v06-20090208');
INSERT INTO cs_stringrepcache VALUES (13, 6220, 'amsr-e-l3-dailyland-v06-20090209');
INSERT INTO cs_stringrepcache VALUES (13, 6221, 'amsr-e-l3-dailyland-v06-20090210');
INSERT INTO cs_stringrepcache VALUES (13, 6222, 'amsr-e-l3-dailyland-v06-20090211');
INSERT INTO cs_stringrepcache VALUES (13, 6223, 'amsr-e-l3-dailyland-v06-20090212');
INSERT INTO cs_stringrepcache VALUES (13, 6224, 'amsr-e-l3-dailyland-v06-20090213');
INSERT INTO cs_stringrepcache VALUES (13, 6225, 'amsr-e-l3-dailyland-v06-20090214');
INSERT INTO cs_stringrepcache VALUES (13, 6226, 'amsr-e-l3-dailyland-v06-20090215');
INSERT INTO cs_stringrepcache VALUES (13, 6227, 'amsr-e-l3-dailyland-v06-20090216');
INSERT INTO cs_stringrepcache VALUES (13, 6228, 'amsr-e-l3-dailyland-v06-20090217');
INSERT INTO cs_stringrepcache VALUES (13, 6229, 'amsr-e-l3-dailyland-v06-20090218');
INSERT INTO cs_stringrepcache VALUES (13, 6230, 'amsr-e-l3-dailyland-v06-20090219');
INSERT INTO cs_stringrepcache VALUES (13, 6231, 'amsr-e-l3-dailyland-v06-20090220');
INSERT INTO cs_stringrepcache VALUES (13, 6232, 'amsr-e-l3-dailyland-v06-20090221');
INSERT INTO cs_stringrepcache VALUES (13, 6233, 'amsr-e-l3-dailyland-v06-20090222');
INSERT INTO cs_stringrepcache VALUES (13, 6234, 'amsr-e-l3-dailyland-v06-20090223');
INSERT INTO cs_stringrepcache VALUES (13, 6235, 'amsr-e-l3-dailyland-v06-20090224');
INSERT INTO cs_stringrepcache VALUES (13, 6236, 'amsr-e-l3-dailyland-v06-20090225');
INSERT INTO cs_stringrepcache VALUES (13, 6237, 'amsr-e-l3-dailyland-v06-20090226');
INSERT INTO cs_stringrepcache VALUES (13, 6238, 'amsr-e-l3-dailyland-v06-20090227');
INSERT INTO cs_stringrepcache VALUES (13, 6239, 'amsr-e-l3-dailyland-v06-20090228');
INSERT INTO cs_stringrepcache VALUES (13, 6240, 'amsr-e-l3-dailyland-v06-20090301');
INSERT INTO cs_stringrepcache VALUES (13, 6241, 'amsr-e-l3-dailyland-v06-20090302');
INSERT INTO cs_stringrepcache VALUES (13, 6242, 'amsr-e-l3-dailyland-v06-20090303');
INSERT INTO cs_stringrepcache VALUES (13, 6243, 'amsr-e-l3-dailyland-v06-20090304');
INSERT INTO cs_stringrepcache VALUES (13, 6244, 'amsr-e-l3-dailyland-v06-20090305');
INSERT INTO cs_stringrepcache VALUES (13, 6245, 'amsr-e-l3-dailyland-v06-20090306');
INSERT INTO cs_stringrepcache VALUES (13, 6246, 'amsr-e-l3-dailyland-v06-20090307');
INSERT INTO cs_stringrepcache VALUES (13, 6247, 'amsr-e-l3-dailyland-v06-20090308');
INSERT INTO cs_stringrepcache VALUES (13, 6248, 'amsr-e-l3-dailyland-v06-20090309');
INSERT INTO cs_stringrepcache VALUES (13, 6249, 'amsr-e-l3-dailyland-v06-20090310');
INSERT INTO cs_stringrepcache VALUES (13, 6250, 'amsr-e-l3-dailyland-v06-20090311');
INSERT INTO cs_stringrepcache VALUES (13, 6251, 'amsr-e-l3-dailyland-v06-20090312');
INSERT INTO cs_stringrepcache VALUES (13, 6252, 'amsr-e-l3-dailyland-v06-20090313');
INSERT INTO cs_stringrepcache VALUES (13, 6253, 'amsr-e-l3-dailyland-v06-20090314');
INSERT INTO cs_stringrepcache VALUES (13, 6254, 'amsr-e-l3-dailyland-v06-20090315');
INSERT INTO cs_stringrepcache VALUES (13, 6255, 'amsr-e-l3-dailyland-v06-20090316');
INSERT INTO cs_stringrepcache VALUES (13, 6256, 'amsr-e-l3-dailyland-v06-20090317');
INSERT INTO cs_stringrepcache VALUES (13, 6257, 'amsr-e-l3-dailyland-v06-20090318');
INSERT INTO cs_stringrepcache VALUES (13, 6258, 'amsr-e-l3-dailyland-v06-20090319');
INSERT INTO cs_stringrepcache VALUES (13, 6259, 'amsr-e-l3-dailyland-v06-20090320');
INSERT INTO cs_stringrepcache VALUES (13, 6260, 'amsr-e-l3-dailyland-v06-20090321');
INSERT INTO cs_stringrepcache VALUES (13, 6261, 'amsr-e-l3-dailyland-v06-20090322');
INSERT INTO cs_stringrepcache VALUES (13, 6262, 'amsr-e-l3-dailyland-v06-20090323');
INSERT INTO cs_stringrepcache VALUES (13, 6263, 'amsr-e-l3-dailyland-v06-20090324');
INSERT INTO cs_stringrepcache VALUES (13, 6264, 'amsr-e-l3-dailyland-v06-20090325');
INSERT INTO cs_stringrepcache VALUES (13, 6265, 'amsr-e-l3-dailyland-v06-20090326');
INSERT INTO cs_stringrepcache VALUES (13, 6266, 'amsr-e-l3-dailyland-v06-20090327');
INSERT INTO cs_stringrepcache VALUES (13, 6267, 'amsr-e-l3-dailyland-v06-20090328');
INSERT INTO cs_stringrepcache VALUES (13, 6268, 'amsr-e-l3-dailyland-v06-20090329');
INSERT INTO cs_stringrepcache VALUES (13, 6269, 'amsr-e-l3-dailyland-v06-20090330');
INSERT INTO cs_stringrepcache VALUES (13, 6270, 'amsr-e-l3-dailyland-v06-20090331');
INSERT INTO cs_stringrepcache VALUES (13, 6271, 'amsr-e-l3-dailyland-v06-20090401');
INSERT INTO cs_stringrepcache VALUES (13, 6272, 'amsr-e-l3-dailyland-v06-20090402');
INSERT INTO cs_stringrepcache VALUES (13, 6273, 'amsr-e-l3-dailyland-v06-20090403');
INSERT INTO cs_stringrepcache VALUES (13, 6274, 'amsr-e-l3-dailyland-v06-20090404');
INSERT INTO cs_stringrepcache VALUES (13, 6275, 'amsr-e-l3-dailyland-v06-20090405');
INSERT INTO cs_stringrepcache VALUES (13, 6276, 'amsr-e-l3-dailyland-v06-20090406');
INSERT INTO cs_stringrepcache VALUES (13, 6277, 'amsr-e-l3-dailyland-v06-20090407');
INSERT INTO cs_stringrepcache VALUES (13, 6278, 'amsr-e-l3-dailyland-v06-20090408');
INSERT INTO cs_stringrepcache VALUES (13, 6279, 'amsr-e-l3-dailyland-v06-20090409');
INSERT INTO cs_stringrepcache VALUES (13, 6280, 'amsr-e-l3-dailyland-v06-20090410');
INSERT INTO cs_stringrepcache VALUES (13, 6281, 'amsr-e-l3-dailyland-v06-20090411');
INSERT INTO cs_stringrepcache VALUES (13, 6282, 'amsr-e-l3-dailyland-v06-20090412');
INSERT INTO cs_stringrepcache VALUES (13, 6283, 'amsr-e-l3-dailyland-v06-20090413');
INSERT INTO cs_stringrepcache VALUES (13, 6284, 'amsr-e-l3-dailyland-v06-20090414');
INSERT INTO cs_stringrepcache VALUES (13, 6285, 'amsr-e-l3-dailyland-v06-20090415');
INSERT INTO cs_stringrepcache VALUES (13, 6286, 'amsr-e-l3-dailyland-v06-20090416');
INSERT INTO cs_stringrepcache VALUES (13, 6287, 'amsr-e-l3-dailyland-v06-20090417');
INSERT INTO cs_stringrepcache VALUES (13, 6288, 'amsr-e-l3-dailyland-v06-20090418');
INSERT INTO cs_stringrepcache VALUES (13, 6289, 'amsr-e-l3-dailyland-v06-20090419');
INSERT INTO cs_stringrepcache VALUES (13, 6290, 'amsr-e-l3-dailyland-v06-20090420');
INSERT INTO cs_stringrepcache VALUES (13, 6291, 'amsr-e-l3-dailyland-v06-20090421');
INSERT INTO cs_stringrepcache VALUES (13, 6292, 'amsr-e-l3-dailyland-v06-20090422');
INSERT INTO cs_stringrepcache VALUES (13, 6293, 'amsr-e-l3-dailyland-v06-20090423');
INSERT INTO cs_stringrepcache VALUES (13, 6294, 'amsr-e-l3-dailyland-v06-20090424');
INSERT INTO cs_stringrepcache VALUES (13, 6295, 'amsr-e-l3-dailyland-v06-20090425');
INSERT INTO cs_stringrepcache VALUES (13, 6296, 'amsr-e-l3-dailyland-v06-20090426');
INSERT INTO cs_stringrepcache VALUES (13, 6297, 'amsr-e-l3-dailyland-v06-20090427');
INSERT INTO cs_stringrepcache VALUES (13, 6298, 'amsr-e-l3-dailyland-v06-20090428');
INSERT INTO cs_stringrepcache VALUES (13, 6299, 'amsr-e-l3-dailyland-v06-20090429');
INSERT INTO cs_stringrepcache VALUES (13, 6300, 'amsr-e-l3-dailyland-v06-20090430');
INSERT INTO cs_stringrepcache VALUES (13, 6301, 'amsr-e-l3-dailyland-v06-20090501');
INSERT INTO cs_stringrepcache VALUES (13, 6302, 'amsr-e-l3-dailyland-v06-20090502');
INSERT INTO cs_stringrepcache VALUES (13, 6303, 'amsr-e-l3-dailyland-v06-20090503');
INSERT INTO cs_stringrepcache VALUES (13, 6304, 'amsr-e-l3-dailyland-v06-20090504');
INSERT INTO cs_stringrepcache VALUES (13, 6305, 'amsr-e-l3-dailyland-v06-20090505');
INSERT INTO cs_stringrepcache VALUES (13, 6306, 'amsr-e-l3-dailyland-v06-20090506');
INSERT INTO cs_stringrepcache VALUES (13, 6307, 'amsr-e-l3-dailyland-v06-20090507');
INSERT INTO cs_stringrepcache VALUES (13, 6308, 'amsr-e-l3-dailyland-v06-20090508');
INSERT INTO cs_stringrepcache VALUES (13, 6309, 'amsr-e-l3-dailyland-v06-20090509');
INSERT INTO cs_stringrepcache VALUES (13, 6310, 'amsr-e-l3-dailyland-v06-20090510');
INSERT INTO cs_stringrepcache VALUES (13, 6311, 'amsr-e-l3-dailyland-v06-20090511');
INSERT INTO cs_stringrepcache VALUES (13, 6312, 'amsr-e-l3-dailyland-v06-20090512');
INSERT INTO cs_stringrepcache VALUES (13, 6313, 'amsr-e-l3-dailyland-v06-20090513');
INSERT INTO cs_stringrepcache VALUES (13, 6314, 'amsr-e-l3-dailyland-v06-20090514');
INSERT INTO cs_stringrepcache VALUES (13, 6315, 'amsr-e-l3-dailyland-v06-20090515');
INSERT INTO cs_stringrepcache VALUES (13, 6316, 'amsr-e-l3-dailyland-v06-20090516');
INSERT INTO cs_stringrepcache VALUES (13, 6317, 'amsr-e-l3-dailyland-v06-20090517');
INSERT INTO cs_stringrepcache VALUES (13, 6318, 'amsr-e-l3-dailyland-v06-20090518');
INSERT INTO cs_stringrepcache VALUES (13, 6319, 'amsr-e-l3-dailyland-v06-20090519');
INSERT INTO cs_stringrepcache VALUES (13, 6320, 'amsr-e-l3-dailyland-v06-20090520');
INSERT INTO cs_stringrepcache VALUES (13, 6321, 'amsr-e-l3-dailyland-v06-20090521');
INSERT INTO cs_stringrepcache VALUES (13, 6322, 'amsr-e-l3-dailyland-v06-20090522');
INSERT INTO cs_stringrepcache VALUES (13, 6323, 'amsr-e-l3-dailyland-v06-20090523');
INSERT INTO cs_stringrepcache VALUES (13, 6324, 'amsr-e-l3-dailyland-v06-20090524');
INSERT INTO cs_stringrepcache VALUES (13, 6325, 'amsr-e-l3-dailyland-v06-20090525');
INSERT INTO cs_stringrepcache VALUES (13, 6326, 'amsr-e-l3-dailyland-v06-20090526');
INSERT INTO cs_stringrepcache VALUES (13, 6327, 'amsr-e-l3-dailyland-v06-20090527');
INSERT INTO cs_stringrepcache VALUES (13, 6328, 'amsr-e-l3-dailyland-v06-20090528');
INSERT INTO cs_stringrepcache VALUES (13, 6329, 'amsr-e-l3-dailyland-v06-20090529');
INSERT INTO cs_stringrepcache VALUES (13, 6330, 'amsr-e-l3-dailyland-v06-20090530');
INSERT INTO cs_stringrepcache VALUES (13, 6331, 'amsr-e-l3-dailyland-v06-20090531');
INSERT INTO cs_stringrepcache VALUES (13, 6332, 'amsr-e-l3-dailyland-v06-20090601');
INSERT INTO cs_stringrepcache VALUES (13, 6333, 'amsr-e-l3-dailyland-v06-20090602');
INSERT INTO cs_stringrepcache VALUES (13, 6334, 'amsr-e-l3-dailyland-v06-20090603');
INSERT INTO cs_stringrepcache VALUES (13, 6335, 'amsr-e-l3-dailyland-v06-20090604');
INSERT INTO cs_stringrepcache VALUES (13, 6336, 'amsr-e-l3-dailyland-v06-20090605');
INSERT INTO cs_stringrepcache VALUES (13, 6337, 'amsr-e-l3-dailyland-v06-20090606');
INSERT INTO cs_stringrepcache VALUES (13, 6338, 'amsr-e-l3-dailyland-v06-20090607');
INSERT INTO cs_stringrepcache VALUES (13, 6339, 'amsr-e-l3-dailyland-v06-20090608');
INSERT INTO cs_stringrepcache VALUES (13, 6340, 'amsr-e-l3-dailyland-v06-20090609');
INSERT INTO cs_stringrepcache VALUES (13, 6341, 'amsr-e-l3-dailyland-v06-20090610');
INSERT INTO cs_stringrepcache VALUES (13, 6342, 'amsr-e-l3-dailyland-v06-20090611');
INSERT INTO cs_stringrepcache VALUES (13, 6343, 'amsr-e-l3-dailyland-v06-20090612');
INSERT INTO cs_stringrepcache VALUES (13, 6344, 'amsr-e-l3-dailyland-v06-20090613');
INSERT INTO cs_stringrepcache VALUES (13, 6345, 'amsr-e-l3-dailyland-v06-20090614');
INSERT INTO cs_stringrepcache VALUES (13, 6346, 'amsr-e-l3-dailyland-v06-20090615');
INSERT INTO cs_stringrepcache VALUES (13, 6347, 'amsr-e-l3-dailyland-v06-20090616');
INSERT INTO cs_stringrepcache VALUES (13, 6348, 'amsr-e-l3-dailyland-v06-20090617');
INSERT INTO cs_stringrepcache VALUES (13, 6349, 'amsr-e-l3-dailyland-v06-20090618');
INSERT INTO cs_stringrepcache VALUES (13, 6350, 'amsr-e-l3-dailyland-v06-20090619');
INSERT INTO cs_stringrepcache VALUES (13, 6351, 'amsr-e-l3-dailyland-v06-20090620');
INSERT INTO cs_stringrepcache VALUES (13, 6352, 'amsr-e-l3-dailyland-v06-20090621');
INSERT INTO cs_stringrepcache VALUES (13, 6353, 'amsr-e-l3-dailyland-v06-20090622');
INSERT INTO cs_stringrepcache VALUES (13, 6354, 'amsr-e-l3-dailyland-v06-20090623');
INSERT INTO cs_stringrepcache VALUES (13, 6355, 'amsr-e-l3-dailyland-v06-20090624');
INSERT INTO cs_stringrepcache VALUES (13, 6356, 'amsr-e-l3-dailyland-v06-20090625');
INSERT INTO cs_stringrepcache VALUES (13, 6357, 'amsr-e-l3-dailyland-v06-20090626');
INSERT INTO cs_stringrepcache VALUES (13, 6358, 'amsr-e-l3-dailyland-v06-20090627');
INSERT INTO cs_stringrepcache VALUES (13, 6359, 'amsr-e-l3-dailyland-v06-20090628');
INSERT INTO cs_stringrepcache VALUES (13, 6360, 'amsr-e-l3-dailyland-v06-20090629');
INSERT INTO cs_stringrepcache VALUES (13, 6361, 'amsr-e-l3-dailyland-v06-20090630');
INSERT INTO cs_stringrepcache VALUES (13, 6362, 'amsr-e-l3-dailyland-v06-20090701');
INSERT INTO cs_stringrepcache VALUES (13, 6363, 'amsr-e-l3-dailyland-v06-20090702');
INSERT INTO cs_stringrepcache VALUES (13, 6364, 'amsr-e-l3-dailyland-v06-20090703');
INSERT INTO cs_stringrepcache VALUES (13, 6365, 'amsr-e-l3-dailyland-v06-20090704');
INSERT INTO cs_stringrepcache VALUES (13, 6366, 'amsr-e-l3-dailyland-v06-20090705');
INSERT INTO cs_stringrepcache VALUES (13, 6367, 'amsr-e-l3-dailyland-v06-20090706');
INSERT INTO cs_stringrepcache VALUES (13, 6368, 'amsr-e-l3-dailyland-v06-20090707');
INSERT INTO cs_stringrepcache VALUES (13, 6369, 'amsr-e-l3-dailyland-v06-20090708');
INSERT INTO cs_stringrepcache VALUES (13, 6370, 'amsr-e-l3-dailyland-v06-20090709');
INSERT INTO cs_stringrepcache VALUES (13, 6371, 'amsr-e-l3-dailyland-v06-20090710');
INSERT INTO cs_stringrepcache VALUES (13, 6372, 'amsr-e-l3-dailyland-v06-20090711');
INSERT INTO cs_stringrepcache VALUES (13, 6373, 'amsr-e-l3-dailyland-v06-20090712');
INSERT INTO cs_stringrepcache VALUES (13, 6374, 'amsr-e-l3-dailyland-v06-20090713');
INSERT INTO cs_stringrepcache VALUES (13, 6375, 'amsr-e-l3-dailyland-v06-20090714');
INSERT INTO cs_stringrepcache VALUES (13, 6376, 'amsr-e-l3-dailyland-v06-20090715');
INSERT INTO cs_stringrepcache VALUES (13, 6377, 'amsr-e-l3-dailyland-v06-20090716');
INSERT INTO cs_stringrepcache VALUES (13, 6378, 'amsr-e-l3-dailyland-v06-20090717');
INSERT INTO cs_stringrepcache VALUES (13, 6379, 'amsr-e-l3-dailyland-v06-20090718');
INSERT INTO cs_stringrepcache VALUES (13, 6380, 'amsr-e-l3-dailyland-v06-20090719');
INSERT INTO cs_stringrepcache VALUES (13, 6381, 'amsr-e-l3-dailyland-v06-20090720');
INSERT INTO cs_stringrepcache VALUES (13, 6382, 'amsr-e-l3-dailyland-v06-20090721');
INSERT INTO cs_stringrepcache VALUES (13, 6383, 'amsr-e-l3-dailyland-v06-20090722');
INSERT INTO cs_stringrepcache VALUES (13, 6384, 'amsr-e-l3-dailyland-v06-20090723');
INSERT INTO cs_stringrepcache VALUES (13, 6385, 'amsr-e-l3-dailyland-v06-20090724');
INSERT INTO cs_stringrepcache VALUES (13, 6386, 'amsr-e-l3-dailyland-v06-20090725');
INSERT INTO cs_stringrepcache VALUES (13, 6387, 'amsr-e-l3-dailyland-v06-20090726');
INSERT INTO cs_stringrepcache VALUES (13, 6388, 'amsr-e-l3-dailyland-v06-20090727');
INSERT INTO cs_stringrepcache VALUES (13, 6389, 'amsr-e-l3-dailyland-v06-20090728');
INSERT INTO cs_stringrepcache VALUES (13, 6390, 'amsr-e-l3-dailyland-v06-20090729');
INSERT INTO cs_stringrepcache VALUES (13, 6391, 'amsr-e-l3-dailyland-v06-20090730');
INSERT INTO cs_stringrepcache VALUES (13, 6392, 'amsr-e-l3-dailyland-v06-20090731');
INSERT INTO cs_stringrepcache VALUES (13, 6393, 'amsr-e-l3-dailyland-v06-20090801');
INSERT INTO cs_stringrepcache VALUES (13, 6394, 'amsr-e-l3-dailyland-v06-20090802');
INSERT INTO cs_stringrepcache VALUES (13, 6395, 'amsr-e-l3-dailyland-v06-20090803');
INSERT INTO cs_stringrepcache VALUES (13, 6396, 'amsr-e-l3-dailyland-v06-20090804');
INSERT INTO cs_stringrepcache VALUES (13, 6397, 'amsr-e-l3-dailyland-v06-20090805');
INSERT INTO cs_stringrepcache VALUES (13, 6398, 'amsr-e-l3-dailyland-v06-20090806');
INSERT INTO cs_stringrepcache VALUES (13, 6399, 'amsr-e-l3-dailyland-v06-20090807');
INSERT INTO cs_stringrepcache VALUES (13, 6400, 'amsr-e-l3-dailyland-v06-20090808');
INSERT INTO cs_stringrepcache VALUES (13, 6401, 'amsr-e-l3-dailyland-v06-20090809');
INSERT INTO cs_stringrepcache VALUES (13, 6402, 'amsr-e-l3-dailyland-v06-20090810');
INSERT INTO cs_stringrepcache VALUES (13, 6403, 'amsr-e-l3-dailyland-v06-20090811');
INSERT INTO cs_stringrepcache VALUES (13, 6404, 'amsr-e-l3-dailyland-v06-20090812');
INSERT INTO cs_stringrepcache VALUES (13, 6405, 'amsr-e-l3-dailyland-v06-20090813');
INSERT INTO cs_stringrepcache VALUES (13, 6406, 'amsr-e-l3-dailyland-v06-20090814');
INSERT INTO cs_stringrepcache VALUES (13, 6407, 'amsr-e-l3-dailyland-v06-20090815');
INSERT INTO cs_stringrepcache VALUES (13, 6408, 'amsr-e-l3-dailyland-v06-20090816');
INSERT INTO cs_stringrepcache VALUES (13, 6409, 'amsr-e-l3-dailyland-v06-20090817');
INSERT INTO cs_stringrepcache VALUES (13, 6410, 'amsr-e-l3-dailyland-v06-20090818');
INSERT INTO cs_stringrepcache VALUES (13, 6411, 'amsr-e-l3-dailyland-v06-20090819');
INSERT INTO cs_stringrepcache VALUES (13, 6412, 'amsr-e-l3-dailyland-v06-20090820');
INSERT INTO cs_stringrepcache VALUES (13, 6413, 'amsr-e-l3-dailyland-v06-20090821');
INSERT INTO cs_stringrepcache VALUES (13, 6414, 'amsr-e-l3-dailyland-v06-20090822');
INSERT INTO cs_stringrepcache VALUES (13, 6415, 'amsr-e-l3-dailyland-v06-20090823');
INSERT INTO cs_stringrepcache VALUES (13, 6416, 'amsr-e-l3-dailyland-v06-20090824');
INSERT INTO cs_stringrepcache VALUES (13, 6417, 'amsr-e-l3-dailyland-v06-20090825');
INSERT INTO cs_stringrepcache VALUES (13, 6418, 'amsr-e-l3-dailyland-v06-20090826');
INSERT INTO cs_stringrepcache VALUES (13, 6419, 'amsr-e-l3-dailyland-v06-20090827');
INSERT INTO cs_stringrepcache VALUES (13, 6420, 'amsr-e-l3-dailyland-v06-20090828');
INSERT INTO cs_stringrepcache VALUES (13, 6421, 'amsr-e-l3-dailyland-v06-20090829');
INSERT INTO cs_stringrepcache VALUES (13, 6422, 'amsr-e-l3-dailyland-v06-20090830');
INSERT INTO cs_stringrepcache VALUES (13, 6423, 'amsr-e-l3-dailyland-v06-20090831');
INSERT INTO cs_stringrepcache VALUES (13, 6424, 'amsr-e-l3-dailyland-v06-20090901');
INSERT INTO cs_stringrepcache VALUES (13, 6425, 'amsr-e-l3-dailyland-v06-20090902');
INSERT INTO cs_stringrepcache VALUES (13, 6426, 'amsr-e-l3-dailyland-v06-20090903');
INSERT INTO cs_stringrepcache VALUES (13, 6427, 'amsr-e-l3-dailyland-v06-20090904');
INSERT INTO cs_stringrepcache VALUES (13, 6428, 'amsr-e-l3-dailyland-v06-20090905');
INSERT INTO cs_stringrepcache VALUES (13, 6429, 'amsr-e-l3-dailyland-v06-20090906');
INSERT INTO cs_stringrepcache VALUES (13, 6430, 'amsr-e-l3-dailyland-v06-20090907');
INSERT INTO cs_stringrepcache VALUES (13, 6431, 'amsr-e-l3-dailyland-v06-20090908');
INSERT INTO cs_stringrepcache VALUES (13, 6432, 'amsr-e-l3-dailyland-v06-20090909');
INSERT INTO cs_stringrepcache VALUES (13, 6433, 'amsr-e-l3-dailyland-v06-20090910');
INSERT INTO cs_stringrepcache VALUES (13, 6434, 'amsr-e-l3-dailyland-v06-20090911');
INSERT INTO cs_stringrepcache VALUES (13, 6435, 'amsr-e-l3-dailyland-v06-20090912');
INSERT INTO cs_stringrepcache VALUES (13, 6436, 'amsr-e-l3-dailyland-v06-20090913');
INSERT INTO cs_stringrepcache VALUES (13, 6437, 'amsr-e-l3-dailyland-v06-20090914');
INSERT INTO cs_stringrepcache VALUES (13, 6438, 'amsr-e-l3-dailyland-v06-20090915');
INSERT INTO cs_stringrepcache VALUES (13, 6439, 'amsr-e-l3-dailyland-v06-20090916');
INSERT INTO cs_stringrepcache VALUES (13, 6440, 'amsr-e-l3-dailyland-v06-20090917');
INSERT INTO cs_stringrepcache VALUES (13, 6441, 'amsr-e-l3-dailyland-v06-20090918');
INSERT INTO cs_stringrepcache VALUES (13, 6442, 'amsr-e-l3-dailyland-v06-20090919');
INSERT INTO cs_stringrepcache VALUES (13, 6443, 'amsr-e-l3-dailyland-v06-20090920');
INSERT INTO cs_stringrepcache VALUES (13, 6444, 'amsr-e-l3-dailyland-v06-20090921');
INSERT INTO cs_stringrepcache VALUES (13, 6445, 'amsr-e-l3-dailyland-v06-20090922');
INSERT INTO cs_stringrepcache VALUES (13, 6446, 'amsr-e-l3-dailyland-v06-20090923');
INSERT INTO cs_stringrepcache VALUES (13, 6447, 'amsr-e-l3-dailyland-v06-20090924');
INSERT INTO cs_stringrepcache VALUES (13, 6448, 'amsr-e-l3-dailyland-v06-20090925');
INSERT INTO cs_stringrepcache VALUES (13, 6449, 'amsr-e-l3-dailyland-v06-20090926');
INSERT INTO cs_stringrepcache VALUES (13, 6450, 'amsr-e-l3-dailyland-v06-20090927');
INSERT INTO cs_stringrepcache VALUES (13, 6451, 'amsr-e-l3-dailyland-v06-20090928');
INSERT INTO cs_stringrepcache VALUES (13, 6452, 'amsr-e-l3-dailyland-v06-20090929');
INSERT INTO cs_stringrepcache VALUES (13, 6453, 'amsr-e-l3-dailyland-v06-20090930');
INSERT INTO cs_stringrepcache VALUES (13, 6454, 'amsr-e-l3-dailyland-v06-20091001');
INSERT INTO cs_stringrepcache VALUES (13, 6455, 'amsr-e-l3-dailyland-v06-20091002');
INSERT INTO cs_stringrepcache VALUES (13, 6456, 'amsr-e-l3-dailyland-v06-20091003');
INSERT INTO cs_stringrepcache VALUES (13, 6457, 'amsr-e-l3-dailyland-v06-20091004');
INSERT INTO cs_stringrepcache VALUES (13, 6458, 'amsr-e-l3-dailyland-v06-20091005');
INSERT INTO cs_stringrepcache VALUES (13, 6459, 'amsr-e-l3-dailyland-v06-20091006');
INSERT INTO cs_stringrepcache VALUES (13, 6460, 'amsr-e-l3-dailyland-v06-20091007');
INSERT INTO cs_stringrepcache VALUES (13, 6461, 'amsr-e-l3-dailyland-v06-20091008');
INSERT INTO cs_stringrepcache VALUES (13, 6462, 'amsr-e-l3-dailyland-v06-20091009');
INSERT INTO cs_stringrepcache VALUES (13, 6463, 'amsr-e-l3-dailyland-v06-20091010');
INSERT INTO cs_stringrepcache VALUES (13, 6464, 'amsr-e-l3-dailyland-v06-20091011');
INSERT INTO cs_stringrepcache VALUES (13, 6465, 'amsr-e-l3-dailyland-v06-20091012');
INSERT INTO cs_stringrepcache VALUES (13, 6466, 'amsr-e-l3-dailyland-v06-20091013');
INSERT INTO cs_stringrepcache VALUES (13, 6467, 'amsr-e-l3-dailyland-v06-20091014');
INSERT INTO cs_stringrepcache VALUES (13, 6468, 'amsr-e-l3-dailyland-v06-20091015');
INSERT INTO cs_stringrepcache VALUES (13, 6469, 'amsr-e-l3-dailyland-v06-20091016');
INSERT INTO cs_stringrepcache VALUES (13, 6470, 'amsr-e-l3-dailyland-v06-20091017');
INSERT INTO cs_stringrepcache VALUES (13, 6471, 'amsr-e-l3-dailyland-v06-20091018');
INSERT INTO cs_stringrepcache VALUES (13, 6472, 'amsr-e-l3-dailyland-v06-20091019');
INSERT INTO cs_stringrepcache VALUES (13, 6473, 'amsr-e-l3-dailyland-v06-20091020');
INSERT INTO cs_stringrepcache VALUES (13, 6474, 'amsr-e-l3-dailyland-v06-20091021');
INSERT INTO cs_stringrepcache VALUES (13, 6475, 'amsr-e-l3-dailyland-v06-20091022');
INSERT INTO cs_stringrepcache VALUES (13, 6476, 'amsr-e-l3-dailyland-v06-20091023');
INSERT INTO cs_stringrepcache VALUES (13, 6477, 'amsr-e-l3-dailyland-v06-20091024');
INSERT INTO cs_stringrepcache VALUES (13, 6478, 'amsr-e-l3-dailyland-v06-20091025');
INSERT INTO cs_stringrepcache VALUES (13, 6479, 'amsr-e-l3-dailyland-v06-20091026');
INSERT INTO cs_stringrepcache VALUES (13, 6480, 'amsr-e-l3-dailyland-v06-20091027');
INSERT INTO cs_stringrepcache VALUES (13, 6481, 'amsr-e-l3-dailyland-v06-20091028');
INSERT INTO cs_stringrepcache VALUES (13, 6482, 'amsr-e-l3-dailyland-v06-20091029');
INSERT INTO cs_stringrepcache VALUES (13, 6483, 'amsr-e-l3-dailyland-v06-20091030');
INSERT INTO cs_stringrepcache VALUES (13, 6484, 'amsr-e-l3-dailyland-v06-20091031');
INSERT INTO cs_stringrepcache VALUES (13, 6485, 'amsr-e-l3-dailyland-v06-20091101');
INSERT INTO cs_stringrepcache VALUES (13, 6486, 'amsr-e-l3-dailyland-v06-20091102');
INSERT INTO cs_stringrepcache VALUES (13, 6487, 'amsr-e-l3-dailyland-v06-20091103');
INSERT INTO cs_stringrepcache VALUES (13, 6488, 'amsr-e-l3-dailyland-v06-20091104');
INSERT INTO cs_stringrepcache VALUES (13, 6489, 'amsr-e-l3-dailyland-v06-20091105');
INSERT INTO cs_stringrepcache VALUES (13, 6490, 'amsr-e-l3-dailyland-v06-20091106');
INSERT INTO cs_stringrepcache VALUES (13, 6491, 'amsr-e-l3-dailyland-v06-20091107');
INSERT INTO cs_stringrepcache VALUES (13, 6492, 'amsr-e-l3-dailyland-v06-20091108');
INSERT INTO cs_stringrepcache VALUES (13, 6493, 'amsr-e-l3-dailyland-v06-20091109');
INSERT INTO cs_stringrepcache VALUES (13, 6494, 'amsr-e-l3-dailyland-v06-20091110');
INSERT INTO cs_stringrepcache VALUES (13, 6495, 'amsr-e-l3-dailyland-v06-20091111');
INSERT INTO cs_stringrepcache VALUES (13, 6496, 'amsr-e-l3-dailyland-v06-20091112');
INSERT INTO cs_stringrepcache VALUES (13, 6497, 'amsr-e-l3-dailyland-v06-20091113');
INSERT INTO cs_stringrepcache VALUES (13, 6498, 'amsr-e-l3-dailyland-v06-20091114');
INSERT INTO cs_stringrepcache VALUES (13, 6499, 'amsr-e-l3-dailyland-v06-20091115');
INSERT INTO cs_stringrepcache VALUES (13, 6500, 'amsr-e-l3-dailyland-v06-20091116');
INSERT INTO cs_stringrepcache VALUES (13, 6501, 'amsr-e-l3-dailyland-v06-20091117');
INSERT INTO cs_stringrepcache VALUES (13, 6502, 'amsr-e-l3-dailyland-v06-20091118');
INSERT INTO cs_stringrepcache VALUES (13, 6503, 'amsr-e-l3-dailyland-v06-20091119');
INSERT INTO cs_stringrepcache VALUES (13, 6504, 'amsr-e-l3-dailyland-v06-20091120');
INSERT INTO cs_stringrepcache VALUES (13, 6505, 'amsr-e-l3-dailyland-v06-20091121');
INSERT INTO cs_stringrepcache VALUES (13, 6506, 'amsr-e-l3-dailyland-v06-20091122');
INSERT INTO cs_stringrepcache VALUES (13, 6507, 'amsr-e-l3-dailyland-v06-20091123');
INSERT INTO cs_stringrepcache VALUES (13, 6508, 'amsr-e-l3-dailyland-v06-20091124');
INSERT INTO cs_stringrepcache VALUES (13, 6509, 'amsr-e-l3-dailyland-v06-20091125');
INSERT INTO cs_stringrepcache VALUES (13, 6510, 'amsr-e-l3-dailyland-v06-20091126');
INSERT INTO cs_stringrepcache VALUES (13, 6511, 'amsr-e-l3-dailyland-v06-20091127');
INSERT INTO cs_stringrepcache VALUES (13, 6512, 'amsr-e-l3-dailyland-v06-20091128');
INSERT INTO cs_stringrepcache VALUES (13, 6513, 'amsr-e-l3-dailyland-v06-20091129');
INSERT INTO cs_stringrepcache VALUES (13, 6514, 'amsr-e-l3-dailyland-v06-20091130');
INSERT INTO cs_stringrepcache VALUES (13, 6515, 'amsr-e-l3-dailyland-v06-20091201');
INSERT INTO cs_stringrepcache VALUES (13, 6516, 'amsr-e-l3-dailyland-v06-20091202');
INSERT INTO cs_stringrepcache VALUES (13, 6517, 'amsr-e-l3-dailyland-v06-20091203');
INSERT INTO cs_stringrepcache VALUES (13, 6518, 'amsr-e-l3-dailyland-v06-20091204');
INSERT INTO cs_stringrepcache VALUES (13, 6519, 'amsr-e-l3-dailyland-v06-20091205');
INSERT INTO cs_stringrepcache VALUES (13, 6520, 'amsr-e-l3-dailyland-v06-20091206');
INSERT INTO cs_stringrepcache VALUES (13, 6521, 'amsr-e-l3-dailyland-v06-20091207');
INSERT INTO cs_stringrepcache VALUES (13, 6522, 'amsr-e-l3-dailyland-v06-20091208');
INSERT INTO cs_stringrepcache VALUES (13, 6523, 'amsr-e-l3-dailyland-v06-20091209');
INSERT INTO cs_stringrepcache VALUES (13, 6524, 'amsr-e-l3-dailyland-v06-20091210');
INSERT INTO cs_stringrepcache VALUES (13, 6525, 'amsr-e-l3-dailyland-v06-20091211');
INSERT INTO cs_stringrepcache VALUES (13, 6526, 'amsr-e-l3-dailyland-v06-20091212');
INSERT INTO cs_stringrepcache VALUES (13, 6527, 'amsr-e-l3-dailyland-v06-20091213');
INSERT INTO cs_stringrepcache VALUES (13, 6528, 'amsr-e-l3-dailyland-v06-20091214');
INSERT INTO cs_stringrepcache VALUES (13, 6529, 'amsr-e-l3-dailyland-v06-20091215');
INSERT INTO cs_stringrepcache VALUES (13, 6530, 'amsr-e-l3-dailyland-v06-20091216');
INSERT INTO cs_stringrepcache VALUES (13, 6531, 'amsr-e-l3-dailyland-v06-20091217');
INSERT INTO cs_stringrepcache VALUES (13, 6532, 'amsr-e-l3-dailyland-v06-20091218');
INSERT INTO cs_stringrepcache VALUES (13, 6533, 'amsr-e-l3-dailyland-v06-20091219');
INSERT INTO cs_stringrepcache VALUES (13, 6534, 'amsr-e-l3-dailyland-v06-20091220');
INSERT INTO cs_stringrepcache VALUES (13, 6535, 'amsr-e-l3-dailyland-v06-20091221');
INSERT INTO cs_stringrepcache VALUES (13, 6536, 'amsr-e-l3-dailyland-v06-20091222');
INSERT INTO cs_stringrepcache VALUES (13, 6537, 'amsr-e-l3-dailyland-v06-20091223');
INSERT INTO cs_stringrepcache VALUES (13, 6538, 'amsr-e-l3-dailyland-v06-20091224');
INSERT INTO cs_stringrepcache VALUES (13, 6539, 'amsr-e-l3-dailyland-v06-20091225');
INSERT INTO cs_stringrepcache VALUES (13, 6540, 'amsr-e-l3-dailyland-v06-20091226');
INSERT INTO cs_stringrepcache VALUES (13, 6541, 'amsr-e-l3-dailyland-v06-20091227');
INSERT INTO cs_stringrepcache VALUES (13, 6542, 'amsr-e-l3-dailyland-v06-20091228');
INSERT INTO cs_stringrepcache VALUES (13, 6543, 'amsr-e-l3-dailyland-v06-20091229');
INSERT INTO cs_stringrepcache VALUES (13, 6544, 'amsr-e-l3-dailyland-v06-20091230');
INSERT INTO cs_stringrepcache VALUES (13, 6545, 'amsr-e-l3-dailyland-v06-20091231');
INSERT INTO cs_stringrepcache VALUES (13, 6546, 'amsr-e-l3-dailyland-v06-20100101');
INSERT INTO cs_stringrepcache VALUES (13, 6547, 'amsr-e-l3-dailyland-v06-20100102');
INSERT INTO cs_stringrepcache VALUES (13, 6548, 'amsr-e-l3-dailyland-v06-20100103');
INSERT INTO cs_stringrepcache VALUES (13, 6549, 'amsr-e-l3-dailyland-v06-20100104');
INSERT INTO cs_stringrepcache VALUES (13, 6550, 'amsr-e-l3-dailyland-v06-20100105');
INSERT INTO cs_stringrepcache VALUES (13, 6551, 'amsr-e-l3-dailyland-v06-20100106');
INSERT INTO cs_stringrepcache VALUES (13, 6552, 'amsr-e-l3-dailyland-v06-20100107');
INSERT INTO cs_stringrepcache VALUES (13, 6553, 'amsr-e-l3-dailyland-v06-20100108');
INSERT INTO cs_stringrepcache VALUES (13, 6554, 'amsr-e-l3-dailyland-v06-20100109');
INSERT INTO cs_stringrepcache VALUES (13, 6555, 'amsr-e-l3-dailyland-v06-20100110');
INSERT INTO cs_stringrepcache VALUES (13, 6556, 'amsr-e-l3-dailyland-v06-20100111');
INSERT INTO cs_stringrepcache VALUES (13, 6557, 'amsr-e-l3-dailyland-v06-20100112');
INSERT INTO cs_stringrepcache VALUES (13, 6558, 'amsr-e-l3-dailyland-v06-20100113');
INSERT INTO cs_stringrepcache VALUES (13, 6559, 'amsr-e-l3-dailyland-v06-20100114');
INSERT INTO cs_stringrepcache VALUES (13, 6560, 'amsr-e-l3-dailyland-v06-20100115');
INSERT INTO cs_stringrepcache VALUES (13, 6561, 'amsr-e-l3-dailyland-v06-20100116');
INSERT INTO cs_stringrepcache VALUES (13, 6562, 'amsr-e-l3-dailyland-v06-20100117');
INSERT INTO cs_stringrepcache VALUES (13, 6563, 'amsr-e-l3-dailyland-v06-20100118');
INSERT INTO cs_stringrepcache VALUES (13, 6564, 'amsr-e-l3-dailyland-v06-20100119');
INSERT INTO cs_stringrepcache VALUES (13, 6565, 'amsr-e-l3-dailyland-v06-20100120');
INSERT INTO cs_stringrepcache VALUES (13, 6566, 'amsr-e-l3-dailyland-v06-20100121');
INSERT INTO cs_stringrepcache VALUES (13, 6567, 'amsr-e-l3-dailyland-v06-20100122');
INSERT INTO cs_stringrepcache VALUES (13, 6568, 'amsr-e-l3-dailyland-v06-20100123');
INSERT INTO cs_stringrepcache VALUES (13, 6569, 'amsr-e-l3-dailyland-v06-20100124');
INSERT INTO cs_stringrepcache VALUES (13, 6570, 'amsr-e-l3-dailyland-v06-20100125');
INSERT INTO cs_stringrepcache VALUES (13, 6571, 'amsr-e-l3-dailyland-v06-20100126');
INSERT INTO cs_stringrepcache VALUES (13, 6572, 'amsr-e-l3-dailyland-v06-20100127');
INSERT INTO cs_stringrepcache VALUES (13, 6573, 'amsr-e-l3-dailyland-v06-20100128');
INSERT INTO cs_stringrepcache VALUES (13, 6574, 'amsr-e-l3-dailyland-v06-20100129');
INSERT INTO cs_stringrepcache VALUES (13, 6575, 'amsr-e-l3-dailyland-v06-20100130');
INSERT INTO cs_stringrepcache VALUES (13, 6576, 'amsr-e-l3-dailyland-v06-20100131');
INSERT INTO cs_stringrepcache VALUES (13, 6577, 'amsr-e-l3-dailyland-v06-20100201');
INSERT INTO cs_stringrepcache VALUES (13, 6578, 'amsr-e-l3-dailyland-v06-20100202');
INSERT INTO cs_stringrepcache VALUES (13, 6579, 'amsr-e-l3-dailyland-v06-20100203');
INSERT INTO cs_stringrepcache VALUES (13, 6580, 'amsr-e-l3-dailyland-v06-20100204');
INSERT INTO cs_stringrepcache VALUES (13, 6581, 'amsr-e-l3-dailyland-v06-20100205');
INSERT INTO cs_stringrepcache VALUES (13, 6582, 'amsr-e-l3-dailyland-v06-20100206');
INSERT INTO cs_stringrepcache VALUES (13, 6583, 'amsr-e-l3-dailyland-v06-20100207');
INSERT INTO cs_stringrepcache VALUES (13, 6584, 'amsr-e-l3-dailyland-v06-20100208');
INSERT INTO cs_stringrepcache VALUES (13, 6585, 'amsr-e-l3-dailyland-v06-20100209');
INSERT INTO cs_stringrepcache VALUES (13, 6586, 'amsr-e-l3-dailyland-v06-20100210');
INSERT INTO cs_stringrepcache VALUES (13, 6587, 'amsr-e-l3-dailyland-v06-20100211');
INSERT INTO cs_stringrepcache VALUES (13, 6588, 'amsr-e-l3-dailyland-v06-20100212');
INSERT INTO cs_stringrepcache VALUES (13, 6589, 'amsr-e-l3-dailyland-v06-20100213');
INSERT INTO cs_stringrepcache VALUES (13, 6590, 'amsr-e-l3-dailyland-v06-20100214');
INSERT INTO cs_stringrepcache VALUES (13, 6591, 'amsr-e-l3-dailyland-v06-20100215');
INSERT INTO cs_stringrepcache VALUES (13, 6592, 'amsr-e-l3-dailyland-v06-20100216');
INSERT INTO cs_stringrepcache VALUES (13, 6593, 'amsr-e-l3-dailyland-v06-20100217');
INSERT INTO cs_stringrepcache VALUES (13, 6594, 'amsr-e-l3-dailyland-v06-20100218');
INSERT INTO cs_stringrepcache VALUES (13, 6595, 'amsr-e-l3-dailyland-v06-20100219');
INSERT INTO cs_stringrepcache VALUES (13, 6596, 'amsr-e-l3-dailyland-v06-20100220');
INSERT INTO cs_stringrepcache VALUES (13, 6597, 'amsr-e-l3-dailyland-v06-20100221');
INSERT INTO cs_stringrepcache VALUES (13, 6598, 'amsr-e-l3-dailyland-v06-20100222');
INSERT INTO cs_stringrepcache VALUES (13, 6599, 'amsr-e-l3-dailyland-v06-20100223');
INSERT INTO cs_stringrepcache VALUES (13, 6600, 'amsr-e-l3-dailyland-v06-20100224');
INSERT INTO cs_stringrepcache VALUES (13, 6601, 'amsr-e-l3-dailyland-v06-20100225');
INSERT INTO cs_stringrepcache VALUES (13, 6602, 'amsr-e-l3-dailyland-v06-20100226');
INSERT INTO cs_stringrepcache VALUES (13, 6603, 'amsr-e-l3-dailyland-v06-20100227');
INSERT INTO cs_stringrepcache VALUES (13, 6604, 'amsr-e-l3-dailyland-v06-20100228');
INSERT INTO cs_stringrepcache VALUES (13, 6605, 'amsr-e-l3-dailyland-v06-20100301');
INSERT INTO cs_stringrepcache VALUES (13, 6606, 'amsr-e-l3-dailyland-v06-20100302');
INSERT INTO cs_stringrepcache VALUES (13, 6607, 'amsr-e-l3-dailyland-v06-20100303');
INSERT INTO cs_stringrepcache VALUES (13, 6608, 'amsr-e-l3-dailyland-v06-20100304');
INSERT INTO cs_stringrepcache VALUES (13, 6609, 'amsr-e-l3-dailyland-v06-20100305');
INSERT INTO cs_stringrepcache VALUES (13, 6610, 'amsr-e-l3-dailyland-v06-20100306');
INSERT INTO cs_stringrepcache VALUES (13, 6611, 'amsr-e-l3-dailyland-v06-20100307');
INSERT INTO cs_stringrepcache VALUES (13, 6612, 'amsr-e-l3-dailyland-v06-20100308');
INSERT INTO cs_stringrepcache VALUES (13, 6613, 'amsr-e-l3-dailyland-v06-20100309');
INSERT INTO cs_stringrepcache VALUES (13, 6614, 'amsr-e-l3-dailyland-v06-20100310');
INSERT INTO cs_stringrepcache VALUES (13, 6615, 'amsr-e-l3-dailyland-v06-20100311');
INSERT INTO cs_stringrepcache VALUES (13, 6616, 'amsr-e-l3-dailyland-v06-20100312');
INSERT INTO cs_stringrepcache VALUES (13, 6617, 'amsr-e-l3-dailyland-v06-20100313');
INSERT INTO cs_stringrepcache VALUES (13, 6618, 'amsr-e-l3-dailyland-v06-20100314');
INSERT INTO cs_stringrepcache VALUES (13, 6619, 'amsr-e-l3-dailyland-v06-20100315');
INSERT INTO cs_stringrepcache VALUES (13, 6620, 'amsr-e-l3-dailyland-v06-20100316');
INSERT INTO cs_stringrepcache VALUES (13, 6621, 'amsr-e-l3-dailyland-v06-20100317');
INSERT INTO cs_stringrepcache VALUES (13, 6622, 'amsr-e-l3-dailyland-v06-20100318');
INSERT INTO cs_stringrepcache VALUES (13, 6623, 'amsr-e-l3-dailyland-v06-20100319');
INSERT INTO cs_stringrepcache VALUES (13, 6624, 'amsr-e-l3-dailyland-v06-20100320');
INSERT INTO cs_stringrepcache VALUES (13, 6625, 'amsr-e-l3-dailyland-v06-20100321');
INSERT INTO cs_stringrepcache VALUES (13, 6626, 'amsr-e-l3-dailyland-v06-20100322');
INSERT INTO cs_stringrepcache VALUES (13, 6627, 'amsr-e-l3-dailyland-v06-20100323');
INSERT INTO cs_stringrepcache VALUES (13, 6628, 'amsr-e-l3-dailyland-v06-20100324');
INSERT INTO cs_stringrepcache VALUES (13, 6629, 'amsr-e-l3-dailyland-v06-20100325');
INSERT INTO cs_stringrepcache VALUES (13, 6630, 'amsr-e-l3-dailyland-v06-20100326');
INSERT INTO cs_stringrepcache VALUES (13, 6631, 'amsr-e-l3-dailyland-v06-20100327');
INSERT INTO cs_stringrepcache VALUES (13, 6632, 'amsr-e-l3-dailyland-v06-20100328');
INSERT INTO cs_stringrepcache VALUES (13, 6633, 'amsr-e-l3-dailyland-v06-20100329');
INSERT INTO cs_stringrepcache VALUES (13, 6634, 'amsr-e-l3-dailyland-v06-20100330');
INSERT INTO cs_stringrepcache VALUES (13, 6635, 'amsr-e-l3-dailyland-v06-20100331');
INSERT INTO cs_stringrepcache VALUES (13, 6636, 'amsr-e-l3-dailyland-v06-20100401');
INSERT INTO cs_stringrepcache VALUES (13, 6637, 'amsr-e-l3-dailyland-v06-20100402');
INSERT INTO cs_stringrepcache VALUES (13, 6638, 'amsr-e-l3-dailyland-v06-20100403');
INSERT INTO cs_stringrepcache VALUES (13, 6639, 'amsr-e-l3-dailyland-v06-20100404');
INSERT INTO cs_stringrepcache VALUES (13, 6640, 'amsr-e-l3-dailyland-v06-20100405');
INSERT INTO cs_stringrepcache VALUES (13, 6641, 'amsr-e-l3-dailyland-v06-20100406');
INSERT INTO cs_stringrepcache VALUES (13, 6642, 'amsr-e-l3-dailyland-v06-20100407');
INSERT INTO cs_stringrepcache VALUES (13, 6643, 'amsr-e-l3-dailyland-v06-20100408');
INSERT INTO cs_stringrepcache VALUES (13, 6644, 'amsr-e-l3-dailyland-v06-20100409');
INSERT INTO cs_stringrepcache VALUES (13, 6645, 'amsr-e-l3-dailyland-v06-20100410');
INSERT INTO cs_stringrepcache VALUES (13, 6646, 'amsr-e-l3-dailyland-v06-20100411');
INSERT INTO cs_stringrepcache VALUES (13, 6647, 'amsr-e-l3-dailyland-v06-20100412');
INSERT INTO cs_stringrepcache VALUES (13, 6648, 'amsr-e-l3-dailyland-v06-20100413');
INSERT INTO cs_stringrepcache VALUES (13, 6649, 'amsr-e-l3-dailyland-v06-20100414');
INSERT INTO cs_stringrepcache VALUES (13, 6650, 'amsr-e-l3-dailyland-v06-20100415');
INSERT INTO cs_stringrepcache VALUES (13, 6651, 'amsr-e-l3-dailyland-v06-20100416');
INSERT INTO cs_stringrepcache VALUES (13, 6652, 'amsr-e-l3-dailyland-v06-20100417');
INSERT INTO cs_stringrepcache VALUES (13, 6653, 'amsr-e-l3-dailyland-v06-20100418');
INSERT INTO cs_stringrepcache VALUES (13, 6654, 'amsr-e-l3-dailyland-v06-20100419');
INSERT INTO cs_stringrepcache VALUES (13, 6655, 'amsr-e-l3-dailyland-v06-20100420');
INSERT INTO cs_stringrepcache VALUES (13, 6656, 'amsr-e-l3-dailyland-v06-20100421');
INSERT INTO cs_stringrepcache VALUES (13, 6657, 'amsr-e-l3-dailyland-v06-20100422');
INSERT INTO cs_stringrepcache VALUES (13, 6658, 'amsr-e-l3-dailyland-v06-20100423');
INSERT INTO cs_stringrepcache VALUES (13, 6659, 'amsr-e-l3-dailyland-v06-20100424');
INSERT INTO cs_stringrepcache VALUES (13, 6660, 'amsr-e-l3-dailyland-v06-20100425');
INSERT INTO cs_stringrepcache VALUES (13, 6661, 'amsr-e-l3-dailyland-v06-20100426');
INSERT INTO cs_stringrepcache VALUES (13, 6662, 'amsr-e-l3-dailyland-v06-20100427');
INSERT INTO cs_stringrepcache VALUES (13, 6663, 'amsr-e-l3-dailyland-v06-20100428');
INSERT INTO cs_stringrepcache VALUES (13, 6664, 'amsr-e-l3-dailyland-v06-20100429');
INSERT INTO cs_stringrepcache VALUES (13, 6665, 'amsr-e-l3-dailyland-v06-20100430');
INSERT INTO cs_stringrepcache VALUES (13, 6666, 'amsr-e-l3-dailyland-v06-20100501');
INSERT INTO cs_stringrepcache VALUES (13, 6667, 'amsr-e-l3-dailyland-v06-20100502');
INSERT INTO cs_stringrepcache VALUES (13, 6668, 'amsr-e-l3-dailyland-v06-20100503');
INSERT INTO cs_stringrepcache VALUES (13, 6669, 'amsr-e-l3-dailyland-v06-20100504');
INSERT INTO cs_stringrepcache VALUES (13, 6670, 'amsr-e-l3-dailyland-v06-20100505');
INSERT INTO cs_stringrepcache VALUES (13, 6671, 'amsr-e-l3-dailyland-v06-20100506');
INSERT INTO cs_stringrepcache VALUES (13, 6672, 'amsr-e-l3-dailyland-v06-20100507');
INSERT INTO cs_stringrepcache VALUES (13, 6673, 'amsr-e-l3-dailyland-v06-20100508');
INSERT INTO cs_stringrepcache VALUES (13, 6674, 'amsr-e-l3-dailyland-v06-20100509');
INSERT INTO cs_stringrepcache VALUES (13, 6675, 'amsr-e-l3-dailyland-v06-20100510');
INSERT INTO cs_stringrepcache VALUES (13, 6676, 'amsr-e-l3-dailyland-v06-20100511');
INSERT INTO cs_stringrepcache VALUES (13, 6677, 'amsr-e-l3-dailyland-v06-20100512');
INSERT INTO cs_stringrepcache VALUES (13, 6678, 'amsr-e-l3-dailyland-v06-20100513');
INSERT INTO cs_stringrepcache VALUES (13, 6679, 'amsr-e-l3-dailyland-v06-20100514');
INSERT INTO cs_stringrepcache VALUES (13, 6680, 'amsr-e-l3-dailyland-v06-20100515');
INSERT INTO cs_stringrepcache VALUES (13, 6681, 'amsr-e-l3-dailyland-v06-20100516');
INSERT INTO cs_stringrepcache VALUES (13, 6682, 'amsr-e-l3-dailyland-v06-20100517');
INSERT INTO cs_stringrepcache VALUES (13, 6683, 'amsr-e-l3-dailyland-v06-20100518');
INSERT INTO cs_stringrepcache VALUES (13, 6684, 'amsr-e-l3-dailyland-v06-20100519');
INSERT INTO cs_stringrepcache VALUES (13, 6685, 'amsr-e-l3-dailyland-v06-20100520');
INSERT INTO cs_stringrepcache VALUES (13, 6686, 'amsr-e-l3-dailyland-v06-20100521');
INSERT INTO cs_stringrepcache VALUES (13, 6687, 'amsr-e-l3-dailyland-v06-20100522');
INSERT INTO cs_stringrepcache VALUES (13, 6688, 'amsr-e-l3-dailyland-v06-20100523');
INSERT INTO cs_stringrepcache VALUES (13, 6689, 'amsr-e-l3-dailyland-v06-20100524');
INSERT INTO cs_stringrepcache VALUES (13, 6690, 'amsr-e-l3-dailyland-v06-20100525');
INSERT INTO cs_stringrepcache VALUES (13, 6691, 'amsr-e-l3-dailyland-v06-20100526');
INSERT INTO cs_stringrepcache VALUES (13, 6692, 'amsr-e-l3-dailyland-v06-20100527');
INSERT INTO cs_stringrepcache VALUES (13, 6693, 'amsr-e-l3-dailyland-v06-20100528');
INSERT INTO cs_stringrepcache VALUES (13, 6694, 'amsr-e-l3-dailyland-v06-20100529');
INSERT INTO cs_stringrepcache VALUES (13, 6695, 'amsr-e-l3-dailyland-v06-20100530');
INSERT INTO cs_stringrepcache VALUES (13, 6696, 'amsr-e-l3-dailyland-v06-20100531');
INSERT INTO cs_stringrepcache VALUES (13, 6697, 'amsr-e-l3-dailyland-v06-20100601');
INSERT INTO cs_stringrepcache VALUES (13, 6698, 'amsr-e-l3-dailyland-v06-20100602');
INSERT INTO cs_stringrepcache VALUES (13, 6699, 'amsr-e-l3-dailyland-v06-20100603');
INSERT INTO cs_stringrepcache VALUES (13, 6700, 'amsr-e-l3-dailyland-v06-20100604');
INSERT INTO cs_stringrepcache VALUES (13, 6701, 'amsr-e-l3-dailyland-v06-20100605');
INSERT INTO cs_stringrepcache VALUES (13, 6702, 'amsr-e-l3-dailyland-v06-20100606');
INSERT INTO cs_stringrepcache VALUES (13, 6703, 'amsr-e-l3-dailyland-v06-20100607');
INSERT INTO cs_stringrepcache VALUES (13, 6704, 'amsr-e-l3-dailyland-v06-20100608');
INSERT INTO cs_stringrepcache VALUES (13, 6705, 'amsr-e-l3-dailyland-v06-20100609');
INSERT INTO cs_stringrepcache VALUES (13, 6706, 'amsr-e-l3-dailyland-v06-20100610');
INSERT INTO cs_stringrepcache VALUES (13, 6707, 'amsr-e-l3-dailyland-v06-20100611');
INSERT INTO cs_stringrepcache VALUES (13, 6708, 'amsr-e-l3-dailyland-v06-20100612');
INSERT INTO cs_stringrepcache VALUES (13, 6709, 'amsr-e-l3-dailyland-v06-20100613');
INSERT INTO cs_stringrepcache VALUES (13, 6710, 'amsr-e-l3-dailyland-v06-20100614');
INSERT INTO cs_stringrepcache VALUES (13, 6711, 'amsr-e-l3-dailyland-v06-20100615');
INSERT INTO cs_stringrepcache VALUES (13, 6712, 'amsr-e-l3-dailyland-v06-20100616');
INSERT INTO cs_stringrepcache VALUES (13, 6713, 'amsr-e-l3-dailyland-v06-20100617');
INSERT INTO cs_stringrepcache VALUES (13, 6714, 'amsr-e-l3-dailyland-v06-20100618');
INSERT INTO cs_stringrepcache VALUES (13, 6715, 'amsr-e-l3-dailyland-v06-20100619');
INSERT INTO cs_stringrepcache VALUES (13, 6716, 'amsr-e-l3-dailyland-v06-20100620');
INSERT INTO cs_stringrepcache VALUES (13, 6717, 'amsr-e-l3-dailyland-v06-20100621');
INSERT INTO cs_stringrepcache VALUES (13, 6718, 'amsr-e-l3-dailyland-v06-20100622');
INSERT INTO cs_stringrepcache VALUES (13, 6719, 'amsr-e-l3-dailyland-v06-20100623');
INSERT INTO cs_stringrepcache VALUES (13, 6720, 'amsr-e-l3-dailyland-v06-20100624');
INSERT INTO cs_stringrepcache VALUES (13, 6721, 'amsr-e-l3-dailyland-v06-20100625');
INSERT INTO cs_stringrepcache VALUES (13, 6722, 'amsr-e-l3-dailyland-v06-20100626');
INSERT INTO cs_stringrepcache VALUES (13, 6723, 'amsr-e-l3-dailyland-v06-20100627');
INSERT INTO cs_stringrepcache VALUES (13, 6724, 'amsr-e-l3-dailyland-v06-20100628');
INSERT INTO cs_stringrepcache VALUES (13, 6725, 'amsr-e-l3-dailyland-v06-20100629');
INSERT INTO cs_stringrepcache VALUES (13, 6726, 'amsr-e-l3-dailyland-v06-20100630');
INSERT INTO cs_stringrepcache VALUES (13, 6727, 'amsr-e-l3-dailyland-v06-20100701');
INSERT INTO cs_stringrepcache VALUES (13, 6728, 'amsr-e-l3-dailyland-v06-20100702');
INSERT INTO cs_stringrepcache VALUES (13, 6729, 'amsr-e-l3-dailyland-v06-20100703');
INSERT INTO cs_stringrepcache VALUES (13, 6730, 'amsr-e-l3-dailyland-v06-20100704');
INSERT INTO cs_stringrepcache VALUES (13, 6731, 'amsr-e-l3-dailyland-v06-20100705');
INSERT INTO cs_stringrepcache VALUES (13, 6732, 'amsr-e-l3-dailyland-v06-20100706');
INSERT INTO cs_stringrepcache VALUES (13, 6733, 'amsr-e-l3-dailyland-v06-20100707');
INSERT INTO cs_stringrepcache VALUES (13, 6734, 'amsr-e-l3-dailyland-v06-20100708');
INSERT INTO cs_stringrepcache VALUES (13, 6735, 'amsr-e-l3-dailyland-v06-20100709');
INSERT INTO cs_stringrepcache VALUES (13, 6736, 'amsr-e-l3-dailyland-v06-20100710');
INSERT INTO cs_stringrepcache VALUES (13, 6737, 'amsr-e-l3-dailyland-v06-20100711');
INSERT INTO cs_stringrepcache VALUES (13, 6738, 'amsr-e-l3-dailyland-v06-20100712');
INSERT INTO cs_stringrepcache VALUES (13, 6739, 'amsr-e-l3-dailyland-v06-20100713');
INSERT INTO cs_stringrepcache VALUES (13, 6740, 'amsr-e-l3-dailyland-v06-20100714');
INSERT INTO cs_stringrepcache VALUES (13, 6741, 'amsr-e-l3-dailyland-v06-20100715');
INSERT INTO cs_stringrepcache VALUES (13, 6742, 'amsr-e-l3-dailyland-v06-20100716');
INSERT INTO cs_stringrepcache VALUES (13, 6743, 'amsr-e-l3-dailyland-v06-20100717');
INSERT INTO cs_stringrepcache VALUES (13, 6744, 'amsr-e-l3-dailyland-v06-20100718');
INSERT INTO cs_stringrepcache VALUES (13, 6745, 'amsr-e-l3-dailyland-v06-20100719');
INSERT INTO cs_stringrepcache VALUES (13, 6746, 'amsr-e-l3-dailyland-v06-20100720');
INSERT INTO cs_stringrepcache VALUES (13, 6747, 'amsr-e-l3-dailyland-v06-20100721');
INSERT INTO cs_stringrepcache VALUES (13, 6748, 'amsr-e-l3-dailyland-v06-20100722');
INSERT INTO cs_stringrepcache VALUES (13, 6749, 'amsr-e-l3-dailyland-v06-20100723');
INSERT INTO cs_stringrepcache VALUES (13, 6750, 'amsr-e-l3-dailyland-v06-20100724');
INSERT INTO cs_stringrepcache VALUES (13, 6751, 'amsr-e-l3-dailyland-v06-20100725');
INSERT INTO cs_stringrepcache VALUES (13, 6752, 'amsr-e-l3-dailyland-v06-20100726');
INSERT INTO cs_stringrepcache VALUES (13, 6753, 'amsr-e-l3-dailyland-v06-20100727');
INSERT INTO cs_stringrepcache VALUES (13, 6754, 'amsr-e-l3-dailyland-v06-20100728');
INSERT INTO cs_stringrepcache VALUES (13, 6755, 'amsr-e-l3-dailyland-v06-20100729');
INSERT INTO cs_stringrepcache VALUES (13, 6756, 'amsr-e-l3-dailyland-v06-20100730');
INSERT INTO cs_stringrepcache VALUES (13, 6757, 'amsr-e-l3-dailyland-v06-20100731');
INSERT INTO cs_stringrepcache VALUES (13, 6758, 'amsr-e-l3-dailyland-v06-20100801');
INSERT INTO cs_stringrepcache VALUES (13, 6759, 'amsr-e-l3-dailyland-v06-20100802');
INSERT INTO cs_stringrepcache VALUES (13, 6760, 'amsr-e-l3-dailyland-v06-20100803');
INSERT INTO cs_stringrepcache VALUES (13, 6761, 'amsr-e-l3-dailyland-v06-20100804');
INSERT INTO cs_stringrepcache VALUES (13, 6762, 'amsr-e-l3-dailyland-v06-20100805');
INSERT INTO cs_stringrepcache VALUES (13, 6763, 'amsr-e-l3-dailyland-v06-20100806');
INSERT INTO cs_stringrepcache VALUES (13, 6764, 'amsr-e-l3-dailyland-v06-20100807');
INSERT INTO cs_stringrepcache VALUES (13, 6765, 'amsr-e-l3-dailyland-v06-20100808');
INSERT INTO cs_stringrepcache VALUES (13, 6766, 'amsr-e-l3-dailyland-v06-20100809');
INSERT INTO cs_stringrepcache VALUES (13, 6767, 'amsr-e-l3-dailyland-v06-20100810');
INSERT INTO cs_stringrepcache VALUES (13, 6768, 'amsr-e-l3-dailyland-v06-20100811');
INSERT INTO cs_stringrepcache VALUES (13, 6769, 'amsr-e-l3-dailyland-v06-20100812');
INSERT INTO cs_stringrepcache VALUES (13, 6770, 'amsr-e-l3-dailyland-v06-20100813');
INSERT INTO cs_stringrepcache VALUES (13, 6771, 'amsr-e-l3-dailyland-v06-20100814');
INSERT INTO cs_stringrepcache VALUES (13, 6772, 'amsr-e-l3-dailyland-v06-20100815');
INSERT INTO cs_stringrepcache VALUES (13, 6773, 'amsr-e-l3-dailyland-v06-20100816');
INSERT INTO cs_stringrepcache VALUES (13, 6774, 'amsr-e-l3-dailyland-v06-20100817');
INSERT INTO cs_stringrepcache VALUES (13, 6775, 'amsr-e-l3-dailyland-v06-20100818');
INSERT INTO cs_stringrepcache VALUES (13, 6776, 'amsr-e-l3-dailyland-v06-20100819');
INSERT INTO cs_stringrepcache VALUES (13, 6777, 'amsr-e-l3-dailyland-v06-20100820');
INSERT INTO cs_stringrepcache VALUES (13, 6778, 'amsr-e-l3-dailyland-v06-20100821');
INSERT INTO cs_stringrepcache VALUES (13, 6779, 'amsr-e-l3-dailyland-v06-20100822');
INSERT INTO cs_stringrepcache VALUES (13, 6780, 'amsr-e-l3-dailyland-v06-20100823');
INSERT INTO cs_stringrepcache VALUES (13, 6781, 'amsr-e-l3-dailyland-v06-20100824');
INSERT INTO cs_stringrepcache VALUES (13, 6782, 'amsr-e-l3-dailyland-v06-20100825');
INSERT INTO cs_stringrepcache VALUES (13, 6783, 'amsr-e-l3-dailyland-v06-20100826');
INSERT INTO cs_stringrepcache VALUES (13, 6784, 'amsr-e-l3-dailyland-v06-20100827');
INSERT INTO cs_stringrepcache VALUES (13, 6785, 'amsr-e-l3-dailyland-v06-20100828');
INSERT INTO cs_stringrepcache VALUES (13, 6786, 'amsr-e-l3-dailyland-v06-20100829');
INSERT INTO cs_stringrepcache VALUES (13, 6787, 'amsr-e-l3-dailyland-v06-20100830');
INSERT INTO cs_stringrepcache VALUES (13, 6788, 'amsr-e-l3-dailyland-v06-20100831');
INSERT INTO cs_stringrepcache VALUES (13, 6789, 'amsr-e-l3-dailyland-v06-20100901');
INSERT INTO cs_stringrepcache VALUES (13, 6790, 'amsr-e-l3-dailyland-v06-20100902');
INSERT INTO cs_stringrepcache VALUES (13, 6791, 'amsr-e-l3-dailyland-v06-20100903');
INSERT INTO cs_stringrepcache VALUES (13, 6792, 'amsr-e-l3-dailyland-v06-20100904');
INSERT INTO cs_stringrepcache VALUES (13, 6793, 'amsr-e-l3-dailyland-v06-20100905');
INSERT INTO cs_stringrepcache VALUES (13, 6794, 'amsr-e-l3-dailyland-v06-20100906');
INSERT INTO cs_stringrepcache VALUES (13, 6795, 'amsr-e-l3-dailyland-v06-20100907');
INSERT INTO cs_stringrepcache VALUES (13, 6796, 'amsr-e-l3-dailyland-v06-20100908');
INSERT INTO cs_stringrepcache VALUES (13, 6797, 'amsr-e-l3-dailyland-v06-20100909');
INSERT INTO cs_stringrepcache VALUES (13, 6798, 'amsr-e-l3-dailyland-v06-20100910');
INSERT INTO cs_stringrepcache VALUES (13, 6799, 'amsr-e-l3-dailyland-v06-20100911');
INSERT INTO cs_stringrepcache VALUES (13, 6800, 'amsr-e-l3-dailyland-v06-20100912');
INSERT INTO cs_stringrepcache VALUES (13, 6801, 'amsr-e-l3-dailyland-v06-20100913');
INSERT INTO cs_stringrepcache VALUES (13, 6802, 'amsr-e-l3-dailyland-v06-20100914');
INSERT INTO cs_stringrepcache VALUES (13, 6803, 'amsr-e-l3-dailyland-v06-20100915');
INSERT INTO cs_stringrepcache VALUES (13, 6804, 'amsr-e-l3-dailyland-v06-20100916');
INSERT INTO cs_stringrepcache VALUES (13, 6805, 'amsr-e-l3-dailyland-v06-20100917');
INSERT INTO cs_stringrepcache VALUES (13, 6806, 'amsr-e-l3-dailyland-v06-20100918');
INSERT INTO cs_stringrepcache VALUES (13, 6807, 'amsr-e-l3-dailyland-v06-20100919');
INSERT INTO cs_stringrepcache VALUES (13, 6808, 'amsr-e-l3-dailyland-v06-20100920');
INSERT INTO cs_stringrepcache VALUES (13, 6809, 'amsr-e-l3-dailyland-v06-20100921');
INSERT INTO cs_stringrepcache VALUES (13, 6810, 'amsr-e-l3-dailyland-v06-20100922');
INSERT INTO cs_stringrepcache VALUES (13, 6811, 'amsr-e-l3-dailyland-v06-20100923');
INSERT INTO cs_stringrepcache VALUES (13, 6812, 'amsr-e-l3-dailyland-v06-20100924');
INSERT INTO cs_stringrepcache VALUES (13, 6813, 'amsr-e-l3-dailyland-v06-20100925');
INSERT INTO cs_stringrepcache VALUES (13, 6814, 'amsr-e-l3-dailyland-v06-20100926');
INSERT INTO cs_stringrepcache VALUES (13, 6815, 'amsr-e-l3-dailyland-v06-20100927');
INSERT INTO cs_stringrepcache VALUES (13, 6816, 'amsr-e-l3-dailyland-v06-20100928');
INSERT INTO cs_stringrepcache VALUES (13, 6817, 'amsr-e-l3-dailyland-v06-20100929');
INSERT INTO cs_stringrepcache VALUES (13, 6818, 'amsr-e-l3-dailyland-v06-20100930');
INSERT INTO cs_stringrepcache VALUES (13, 6819, 'amsr-e-l3-dailyland-v06-20101001');
INSERT INTO cs_stringrepcache VALUES (13, 6820, 'amsr-e-l3-dailyland-v06-20101002');
INSERT INTO cs_stringrepcache VALUES (13, 6821, 'amsr-e-l3-dailyland-v06-20101003');
INSERT INTO cs_stringrepcache VALUES (13, 6822, 'amsr-e-l3-dailyland-v06-20101004');
INSERT INTO cs_stringrepcache VALUES (13, 6823, 'amsr-e-l3-dailyland-v06-20101005');
INSERT INTO cs_stringrepcache VALUES (13, 6824, 'amsr-e-l3-dailyland-v06-20101006');
INSERT INTO cs_stringrepcache VALUES (13, 6825, 'amsr-e-l3-dailyland-v06-20101007');
INSERT INTO cs_stringrepcache VALUES (13, 6826, 'amsr-e-l3-dailyland-v06-20101008');
INSERT INTO cs_stringrepcache VALUES (13, 6827, 'amsr-e-l3-dailyland-v06-20101009');
INSERT INTO cs_stringrepcache VALUES (13, 6828, 'amsr-e-l3-dailyland-v06-20101010');
INSERT INTO cs_stringrepcache VALUES (13, 6829, 'amsr-e-l3-dailyland-v06-20101011');
INSERT INTO cs_stringrepcache VALUES (13, 6830, 'amsr-e-l3-dailyland-v06-20101012');
INSERT INTO cs_stringrepcache VALUES (13, 6831, 'amsr-e-l3-dailyland-v06-20101013');
INSERT INTO cs_stringrepcache VALUES (13, 6832, 'amsr-e-l3-dailyland-v06-20101014');
INSERT INTO cs_stringrepcache VALUES (13, 6833, 'amsr-e-l3-dailyland-v06-20101015');
INSERT INTO cs_stringrepcache VALUES (13, 6834, 'amsr-e-l3-dailyland-v06-20101016');
INSERT INTO cs_stringrepcache VALUES (13, 6835, 'amsr-e-l3-dailyland-v06-20101017');
INSERT INTO cs_stringrepcache VALUES (13, 6836, 'amsr-e-l3-dailyland-v06-20101018');
INSERT INTO cs_stringrepcache VALUES (13, 6837, 'amsr-e-l3-dailyland-v06-20101019');
INSERT INTO cs_stringrepcache VALUES (13, 6838, 'amsr-e-l3-dailyland-v06-20101020');
INSERT INTO cs_stringrepcache VALUES (13, 6839, 'amsr-e-l3-dailyland-v06-20101021');
INSERT INTO cs_stringrepcache VALUES (13, 6840, 'amsr-e-l3-dailyland-v06-20101022');
INSERT INTO cs_stringrepcache VALUES (13, 6841, 'amsr-e-l3-dailyland-v06-20101023');
INSERT INTO cs_stringrepcache VALUES (13, 6842, 'amsr-e-l3-dailyland-v06-20101024');
INSERT INTO cs_stringrepcache VALUES (13, 6843, 'amsr-e-l3-dailyland-v06-20101025');
INSERT INTO cs_stringrepcache VALUES (13, 6844, 'amsr-e-l3-dailyland-v06-20101026');
INSERT INTO cs_stringrepcache VALUES (13, 6845, 'amsr-e-l3-dailyland-v06-20101027');
INSERT INTO cs_stringrepcache VALUES (13, 6846, 'amsr-e-l3-dailyland-v06-20101028');
INSERT INTO cs_stringrepcache VALUES (13, 6847, 'amsr-e-l3-dailyland-v06-20101029');
INSERT INTO cs_stringrepcache VALUES (13, 6848, 'amsr-e-l3-dailyland-v06-20101030');
INSERT INTO cs_stringrepcache VALUES (13, 6849, 'amsr-e-l3-dailyland-v06-20101031');
INSERT INTO cs_stringrepcache VALUES (13, 6850, 'amsr-e-l3-dailyland-v06-20101101');
INSERT INTO cs_stringrepcache VALUES (13, 6851, 'amsr-e-l3-dailyland-v06-20101102');
INSERT INTO cs_stringrepcache VALUES (13, 6852, 'amsr-e-l3-dailyland-v06-20101103');
INSERT INTO cs_stringrepcache VALUES (13, 6853, 'amsr-e-l3-dailyland-v06-20101104');
INSERT INTO cs_stringrepcache VALUES (13, 6854, 'amsr-e-l3-dailyland-v06-20101105');
INSERT INTO cs_stringrepcache VALUES (13, 6855, 'amsr-e-l3-dailyland-v06-20101106');
INSERT INTO cs_stringrepcache VALUES (13, 6856, 'amsr-e-l3-dailyland-v06-20101107');
INSERT INTO cs_stringrepcache VALUES (13, 6857, 'amsr-e-l3-dailyland-v06-20101108');
INSERT INTO cs_stringrepcache VALUES (13, 6858, 'amsr-e-l3-dailyland-v06-20101109');
INSERT INTO cs_stringrepcache VALUES (13, 6859, 'amsr-e-l3-dailyland-v06-20101110');
INSERT INTO cs_stringrepcache VALUES (13, 6860, 'amsr-e-l3-dailyland-v06-20101111');
INSERT INTO cs_stringrepcache VALUES (13, 6861, 'amsr-e-l3-dailyland-v06-20101112');
INSERT INTO cs_stringrepcache VALUES (13, 6862, 'amsr-e-l3-dailyland-v06-20101113');
INSERT INTO cs_stringrepcache VALUES (13, 6863, 'amsr-e-l3-dailyland-v06-20101114');
INSERT INTO cs_stringrepcache VALUES (13, 6864, 'amsr-e-l3-dailyland-v06-20101115');
INSERT INTO cs_stringrepcache VALUES (13, 6865, 'amsr-e-l3-dailyland-v06-20101116');
INSERT INTO cs_stringrepcache VALUES (13, 6866, 'amsr-e-l3-dailyland-v06-20101117');
INSERT INTO cs_stringrepcache VALUES (13, 6867, 'amsr-e-l3-dailyland-v06-20101118');
INSERT INTO cs_stringrepcache VALUES (13, 6868, 'amsr-e-l3-dailyland-v06-20101119');
INSERT INTO cs_stringrepcache VALUES (13, 6869, 'amsr-e-l3-dailyland-v06-20101120');
INSERT INTO cs_stringrepcache VALUES (13, 6870, 'amsr-e-l3-dailyland-v06-20101121');
INSERT INTO cs_stringrepcache VALUES (13, 6871, 'amsr-e-l3-dailyland-v06-20101122');
INSERT INTO cs_stringrepcache VALUES (13, 6872, 'amsr-e-l3-dailyland-v06-20101123');
INSERT INTO cs_stringrepcache VALUES (13, 6873, 'amsr-e-l3-dailyland-v06-20101124');
INSERT INTO cs_stringrepcache VALUES (13, 6874, 'amsr-e-l3-dailyland-v06-20101125');
INSERT INTO cs_stringrepcache VALUES (13, 6875, 'amsr-e-l3-dailyland-v06-20101126');
INSERT INTO cs_stringrepcache VALUES (13, 6876, 'amsr-e-l3-dailyland-v06-20101127');
INSERT INTO cs_stringrepcache VALUES (13, 6877, 'amsr-e-l3-dailyland-v06-20101128');
INSERT INTO cs_stringrepcache VALUES (13, 6878, 'amsr-e-l3-dailyland-v06-20101129');
INSERT INTO cs_stringrepcache VALUES (13, 6879, 'amsr-e-l3-dailyland-v06-20101130');
INSERT INTO cs_stringrepcache VALUES (13, 6880, 'amsr-e-l3-dailyland-v06-20101201');
INSERT INTO cs_stringrepcache VALUES (13, 6881, 'amsr-e-l3-dailyland-v06-20101202');
INSERT INTO cs_stringrepcache VALUES (13, 6882, 'amsr-e-l3-dailyland-v06-20101203');
INSERT INTO cs_stringrepcache VALUES (13, 6883, 'amsr-e-l3-dailyland-v06-20101204');
INSERT INTO cs_stringrepcache VALUES (13, 6884, 'amsr-e-l3-dailyland-v06-20101205');
INSERT INTO cs_stringrepcache VALUES (13, 6885, 'amsr-e-l3-dailyland-v06-20101206');
INSERT INTO cs_stringrepcache VALUES (13, 6886, 'amsr-e-l3-dailyland-v06-20101207');
INSERT INTO cs_stringrepcache VALUES (13, 6887, 'amsr-e-l3-dailyland-v06-20101208');
INSERT INTO cs_stringrepcache VALUES (13, 6888, 'amsr-e-l3-dailyland-v06-20101209');
INSERT INTO cs_stringrepcache VALUES (13, 6889, 'amsr-e-l3-dailyland-v06-20101210');
INSERT INTO cs_stringrepcache VALUES (13, 6890, 'amsr-e-l3-dailyland-v06-20101211');
INSERT INTO cs_stringrepcache VALUES (13, 6891, 'amsr-e-l3-dailyland-v06-20101212');
INSERT INTO cs_stringrepcache VALUES (13, 6892, 'amsr-e-l3-dailyland-v06-20101213');
INSERT INTO cs_stringrepcache VALUES (13, 6893, 'amsr-e-l3-dailyland-v06-20101214');
INSERT INTO cs_stringrepcache VALUES (13, 6894, 'amsr-e-l3-dailyland-v06-20101215');
INSERT INTO cs_stringrepcache VALUES (13, 6895, 'amsr-e-l3-dailyland-v06-20101216');
INSERT INTO cs_stringrepcache VALUES (13, 6896, 'amsr-e-l3-dailyland-v06-20101217');
INSERT INTO cs_stringrepcache VALUES (13, 6897, 'amsr-e-l3-dailyland-v06-20101218');
INSERT INTO cs_stringrepcache VALUES (13, 6898, 'amsr-e-l3-dailyland-v06-20101219');
INSERT INTO cs_stringrepcache VALUES (13, 6899, 'amsr-e-l3-dailyland-v06-20101220');
INSERT INTO cs_stringrepcache VALUES (13, 6900, 'amsr-e-l3-dailyland-v06-20101221');
INSERT INTO cs_stringrepcache VALUES (13, 6901, 'amsr-e-l3-dailyland-v06-20101222');
INSERT INTO cs_stringrepcache VALUES (13, 6902, 'amsr-e-l3-dailyland-v06-20101223');
INSERT INTO cs_stringrepcache VALUES (13, 6903, 'amsr-e-l3-dailyland-v06-20101224');
INSERT INTO cs_stringrepcache VALUES (13, 6904, 'amsr-e-l3-dailyland-v06-20101225');
INSERT INTO cs_stringrepcache VALUES (13, 6905, 'amsr-e-l3-dailyland-v06-20101226');
INSERT INTO cs_stringrepcache VALUES (13, 6906, 'amsr-e-l3-dailyland-v06-20101227');
INSERT INTO cs_stringrepcache VALUES (13, 6907, 'amsr-e-l3-dailyland-v06-20101228');
INSERT INTO cs_stringrepcache VALUES (13, 6908, 'amsr-e-l3-dailyland-v06-20101229');
INSERT INTO cs_stringrepcache VALUES (13, 6909, 'amsr-e-l3-dailyland-v06-20101230');
INSERT INTO cs_stringrepcache VALUES (13, 6910, 'amsr-e-l3-dailyland-v06-20101231');
INSERT INTO cs_stringrepcache VALUES (13, 6911, 'amsr-e-l3-dailyland-v06-20110101');
INSERT INTO cs_stringrepcache VALUES (13, 6912, 'amsr-e-l3-dailyland-v06-20110102');
INSERT INTO cs_stringrepcache VALUES (13, 6913, 'amsr-e-l3-dailyland-v06-20110103');
INSERT INTO cs_stringrepcache VALUES (13, 6914, 'amsr-e-l3-dailyland-v06-20110104');
INSERT INTO cs_stringrepcache VALUES (13, 6915, 'amsr-e-l3-dailyland-v06-20110105');
INSERT INTO cs_stringrepcache VALUES (13, 6916, 'amsr-e-l3-dailyland-v06-20110106');
INSERT INTO cs_stringrepcache VALUES (13, 6917, 'amsr-e-l3-dailyland-v06-20110107');
INSERT INTO cs_stringrepcache VALUES (13, 6918, 'amsr-e-l3-dailyland-v06-20110108');
INSERT INTO cs_stringrepcache VALUES (13, 6919, 'amsr-e-l3-dailyland-v06-20110109');
INSERT INTO cs_stringrepcache VALUES (13, 6920, 'amsr-e-l3-dailyland-v06-20110110');
INSERT INTO cs_stringrepcache VALUES (13, 6921, 'amsr-e-l3-dailyland-v06-20110111');
INSERT INTO cs_stringrepcache VALUES (13, 6922, 'amsr-e-l3-dailyland-v06-20110112');
INSERT INTO cs_stringrepcache VALUES (13, 6923, 'amsr-e-l3-dailyland-v06-20110113');
INSERT INTO cs_stringrepcache VALUES (13, 6924, 'amsr-e-l3-dailyland-v06-20110114');
INSERT INTO cs_stringrepcache VALUES (13, 6925, 'amsr-e-l3-dailyland-v06-20110115');
INSERT INTO cs_stringrepcache VALUES (13, 6926, 'amsr-e-l3-dailyland-v06-20110116');
INSERT INTO cs_stringrepcache VALUES (13, 6927, 'amsr-e-l3-dailyland-v06-20110117');
INSERT INTO cs_stringrepcache VALUES (13, 6928, 'amsr-e-l3-dailyland-v06-20110118');
INSERT INTO cs_stringrepcache VALUES (13, 6929, 'amsr-e-l3-dailyland-v06-20110119');
INSERT INTO cs_stringrepcache VALUES (13, 6930, 'amsr-e-l3-dailyland-v06-20110120');
INSERT INTO cs_stringrepcache VALUES (13, 6931, 'amsr-e-l3-dailyland-v06-20110121');
INSERT INTO cs_stringrepcache VALUES (13, 6932, 'amsr-e-l3-dailyland-v06-20110122');
INSERT INTO cs_stringrepcache VALUES (13, 6933, 'amsr-e-l3-dailyland-v06-20110123');
INSERT INTO cs_stringrepcache VALUES (13, 6934, 'amsr-e-l3-dailyland-v06-20110124');
INSERT INTO cs_stringrepcache VALUES (13, 6935, 'amsr-e-l3-dailyland-v06-20110125');
INSERT INTO cs_stringrepcache VALUES (13, 6936, 'amsr-e-l3-dailyland-v06-20110126');
INSERT INTO cs_stringrepcache VALUES (13, 6937, 'amsr-e-l3-dailyland-v06-20110127');
INSERT INTO cs_stringrepcache VALUES (13, 6938, 'amsr-e-l3-dailyland-v06-20110128');
INSERT INTO cs_stringrepcache VALUES (13, 6939, 'amsr-e-l3-dailyland-v06-20110129');
INSERT INTO cs_stringrepcache VALUES (13, 6940, 'amsr-e-l3-dailyland-v06-20110130');
INSERT INTO cs_stringrepcache VALUES (13, 6941, 'amsr-e-l3-dailyland-v06-20110131');
INSERT INTO cs_stringrepcache VALUES (13, 6942, 'amsr-e-l3-dailyland-v06-20110201');
INSERT INTO cs_stringrepcache VALUES (13, 6943, 'amsr-e-l3-dailyland-v06-20110202');
INSERT INTO cs_stringrepcache VALUES (13, 6944, 'amsr-e-l3-dailyland-v06-20110203');
INSERT INTO cs_stringrepcache VALUES (13, 6945, 'amsr-e-l3-dailyland-v06-20110204');
INSERT INTO cs_stringrepcache VALUES (13, 6946, 'amsr-e-l3-dailyland-v06-20110205');
INSERT INTO cs_stringrepcache VALUES (13, 6947, 'amsr-e-l3-dailyland-v06-20110206');
INSERT INTO cs_stringrepcache VALUES (13, 6948, 'amsr-e-l3-dailyland-v06-20110207');
INSERT INTO cs_stringrepcache VALUES (13, 6949, 'amsr-e-l3-dailyland-v06-20110208');
INSERT INTO cs_stringrepcache VALUES (13, 6950, 'amsr-e-l3-dailyland-v06-20110209');
INSERT INTO cs_stringrepcache VALUES (13, 6951, 'amsr-e-l3-dailyland-v06-20110210');
INSERT INTO cs_stringrepcache VALUES (13, 6952, 'amsr-e-l3-dailyland-v06-20110211');
INSERT INTO cs_stringrepcache VALUES (13, 6953, 'amsr-e-l3-dailyland-v06-20110212');
INSERT INTO cs_stringrepcache VALUES (13, 6954, 'amsr-e-l3-dailyland-v06-20110213');
INSERT INTO cs_stringrepcache VALUES (13, 6955, 'amsr-e-l3-dailyland-v06-20110214');
INSERT INTO cs_stringrepcache VALUES (13, 6956, 'amsr-e-l3-dailyland-v06-20110215');
INSERT INTO cs_stringrepcache VALUES (13, 6957, 'amsr-e-l3-dailyland-v06-20110216');
INSERT INTO cs_stringrepcache VALUES (13, 6958, 'amsr-e-l3-dailyland-v06-20110217');
INSERT INTO cs_stringrepcache VALUES (13, 6959, 'amsr-e-l3-dailyland-v06-20110218');
INSERT INTO cs_stringrepcache VALUES (13, 6960, 'amsr-e-l3-dailyland-v06-20110219');
INSERT INTO cs_stringrepcache VALUES (13, 6961, 'amsr-e-l3-dailyland-v06-20110220');
INSERT INTO cs_stringrepcache VALUES (13, 6962, 'amsr-e-l3-dailyland-v06-20110221');
INSERT INTO cs_stringrepcache VALUES (13, 6963, 'amsr-e-l3-dailyland-v06-20110222');
INSERT INTO cs_stringrepcache VALUES (13, 6964, 'amsr-e-l3-dailyland-v06-20110223');
INSERT INTO cs_stringrepcache VALUES (13, 6965, 'amsr-e-l3-dailyland-v06-20110224');
INSERT INTO cs_stringrepcache VALUES (13, 6966, 'amsr-e-l3-dailyland-v06-20110225');
INSERT INTO cs_stringrepcache VALUES (13, 6967, 'amsr-e-l3-dailyland-v06-20110226');
INSERT INTO cs_stringrepcache VALUES (13, 6968, 'amsr-e-l3-dailyland-v06-20110227');
INSERT INTO cs_stringrepcache VALUES (13, 6969, 'amsr-e-l3-dailyland-v06-20110228');
INSERT INTO cs_stringrepcache VALUES (13, 6970, 'amsr-e-l3-dailyland-v06-20110301');
INSERT INTO cs_stringrepcache VALUES (13, 6971, 'amsr-e-l3-dailyland-v06-20110302');
INSERT INTO cs_stringrepcache VALUES (13, 6972, 'amsr-e-l3-dailyland-v06-20110303');
INSERT INTO cs_stringrepcache VALUES (13, 6973, 'amsr-e-l3-dailyland-v06-20110304');
INSERT INTO cs_stringrepcache VALUES (13, 6974, 'amsr-e-l3-dailyland-v06-20110305');
INSERT INTO cs_stringrepcache VALUES (13, 6975, 'amsr-e-l3-dailyland-v06-20110306');
INSERT INTO cs_stringrepcache VALUES (13, 6976, 'amsr-e-l3-dailyland-v06-20110307');
INSERT INTO cs_stringrepcache VALUES (13, 6977, 'amsr-e-l3-dailyland-v06-20110308');
INSERT INTO cs_stringrepcache VALUES (13, 6978, 'amsr-e-l3-dailyland-v06-20110309');
INSERT INTO cs_stringrepcache VALUES (13, 6979, 'amsr-e-l3-dailyland-v06-20110310');
INSERT INTO cs_stringrepcache VALUES (13, 6980, 'amsr-e-l3-dailyland-v06-20110311');
INSERT INTO cs_stringrepcache VALUES (13, 6981, 'amsr-e-l3-dailyland-v06-20110312');
INSERT INTO cs_stringrepcache VALUES (13, 6982, 'amsr-e-l3-dailyland-v06-20110313');
INSERT INTO cs_stringrepcache VALUES (13, 6983, 'amsr-e-l3-dailyland-v06-20110314');
INSERT INTO cs_stringrepcache VALUES (13, 6984, 'amsr-e-l3-dailyland-v06-20110315');
INSERT INTO cs_stringrepcache VALUES (13, 6985, 'amsr-e-l3-dailyland-v06-20110316');
INSERT INTO cs_stringrepcache VALUES (13, 6986, 'amsr-e-l3-dailyland-v06-20110317');
INSERT INTO cs_stringrepcache VALUES (13, 6987, 'amsr-e-l3-dailyland-v06-20110318');
INSERT INTO cs_stringrepcache VALUES (13, 6988, 'amsr-e-l3-dailyland-v06-20110319');
INSERT INTO cs_stringrepcache VALUES (13, 6989, 'amsr-e-l3-dailyland-v06-20110320');
INSERT INTO cs_stringrepcache VALUES (13, 6990, 'amsr-e-l3-dailyland-v06-20110321');
INSERT INTO cs_stringrepcache VALUES (13, 6991, 'amsr-e-l3-dailyland-v06-20110322');
INSERT INTO cs_stringrepcache VALUES (13, 6992, 'amsr-e-l3-dailyland-v06-20110323');
INSERT INTO cs_stringrepcache VALUES (13, 6993, 'amsr-e-l3-dailyland-v06-20110324');
INSERT INTO cs_stringrepcache VALUES (13, 6994, 'amsr-e-l3-dailyland-v06-20110325');
INSERT INTO cs_stringrepcache VALUES (13, 6995, 'amsr-e-l3-dailyland-v06-20110326');
INSERT INTO cs_stringrepcache VALUES (13, 6996, 'amsr-e-l3-dailyland-v06-20110327');
INSERT INTO cs_stringrepcache VALUES (13, 6997, 'amsr-e-l3-dailyland-v06-20110328');
INSERT INTO cs_stringrepcache VALUES (13, 6998, 'amsr-e-l3-dailyland-v06-20110329');
INSERT INTO cs_stringrepcache VALUES (13, 6999, 'amsr-e-l3-dailyland-v06-20110330');
INSERT INTO cs_stringrepcache VALUES (13, 7000, 'amsr-e-l3-dailyland-v06-20110331');
INSERT INTO cs_stringrepcache VALUES (13, 7001, 'amsr-e-l3-dailyland-v06-20110401');
INSERT INTO cs_stringrepcache VALUES (13, 7002, 'amsr-e-l3-dailyland-v06-20110402');
INSERT INTO cs_stringrepcache VALUES (13, 7003, 'amsr-e-l3-dailyland-v06-20110403');
INSERT INTO cs_stringrepcache VALUES (13, 7004, 'amsr-e-l3-dailyland-v06-20110404');
INSERT INTO cs_stringrepcache VALUES (13, 7005, 'amsr-e-l3-dailyland-v06-20110405');
INSERT INTO cs_stringrepcache VALUES (13, 7006, 'amsr-e-l3-dailyland-v06-20110406');
INSERT INTO cs_stringrepcache VALUES (13, 7007, 'amsr-e-l3-dailyland-v06-20110407');
INSERT INTO cs_stringrepcache VALUES (13, 7008, 'amsr-e-l3-dailyland-v06-20110408');
INSERT INTO cs_stringrepcache VALUES (13, 7009, 'amsr-e-l3-dailyland-v06-20110409');
INSERT INTO cs_stringrepcache VALUES (13, 7010, 'amsr-e-l3-dailyland-v06-20110410');
INSERT INTO cs_stringrepcache VALUES (13, 7011, 'amsr-e-l3-dailyland-v06-20110411');
INSERT INTO cs_stringrepcache VALUES (13, 7012, 'amsr-e-l3-dailyland-v06-20110412');
INSERT INTO cs_stringrepcache VALUES (13, 7013, 'amsr-e-l3-dailyland-v06-20110413');
INSERT INTO cs_stringrepcache VALUES (13, 7014, 'amsr-e-l3-dailyland-v06-20110414');
INSERT INTO cs_stringrepcache VALUES (13, 7015, 'amsr-e-l3-dailyland-v06-20110415');
INSERT INTO cs_stringrepcache VALUES (13, 7016, 'amsr-e-l3-dailyland-v06-20110416');
INSERT INTO cs_stringrepcache VALUES (13, 7017, 'amsr-e-l3-dailyland-v06-20110417');
INSERT INTO cs_stringrepcache VALUES (13, 7018, 'amsr-e-l3-dailyland-v06-20110418');
INSERT INTO cs_stringrepcache VALUES (13, 7019, 'amsr-e-l3-dailyland-v06-20110419');
INSERT INTO cs_stringrepcache VALUES (13, 7020, 'amsr-e-l3-dailyland-v06-20110420');
INSERT INTO cs_stringrepcache VALUES (13, 7021, 'amsr-e-l3-dailyland-v06-20110421');
INSERT INTO cs_stringrepcache VALUES (13, 7022, 'amsr-e-l3-dailyland-v06-20110422');
INSERT INTO cs_stringrepcache VALUES (13, 7023, 'amsr-e-l3-dailyland-v06-20110423');
INSERT INTO cs_stringrepcache VALUES (13, 7024, 'amsr-e-l3-dailyland-v06-20110424');
INSERT INTO cs_stringrepcache VALUES (13, 7025, 'amsr-e-l3-dailyland-v06-20110425');
INSERT INTO cs_stringrepcache VALUES (13, 7026, 'amsr-e-l3-dailyland-v06-20110426');
INSERT INTO cs_stringrepcache VALUES (13, 7027, 'amsr-e-l3-dailyland-v06-20110427');
INSERT INTO cs_stringrepcache VALUES (13, 7028, 'amsr-e-l3-dailyland-v06-20110428');
INSERT INTO cs_stringrepcache VALUES (13, 7029, 'amsr-e-l3-dailyland-v06-20110429');
INSERT INTO cs_stringrepcache VALUES (13, 7030, 'amsr-e-l3-dailyland-v06-20110430');
INSERT INTO cs_stringrepcache VALUES (13, 7031, 'amsr-e-l3-dailyland-v06-20110501');
INSERT INTO cs_stringrepcache VALUES (13, 7032, 'amsr-e-l3-dailyland-v06-20110502');
INSERT INTO cs_stringrepcache VALUES (13, 7033, 'amsr-e-l3-dailyland-v06-20110503');
INSERT INTO cs_stringrepcache VALUES (13, 7034, 'amsr-e-l3-dailyland-v06-20110504');
INSERT INTO cs_stringrepcache VALUES (13, 7035, 'amsr-e-l3-dailyland-v06-20110505');
INSERT INTO cs_stringrepcache VALUES (13, 7036, 'amsr-e-l3-dailyland-v06-20110506');
INSERT INTO cs_stringrepcache VALUES (13, 7037, 'amsr-e-l3-dailyland-v06-20110507');
INSERT INTO cs_stringrepcache VALUES (13, 7038, 'amsr-e-l3-dailyland-v06-20110508');
INSERT INTO cs_stringrepcache VALUES (13, 7039, 'amsr-e-l3-dailyland-v06-20110509');
INSERT INTO cs_stringrepcache VALUES (13, 7040, 'amsr-e-l3-dailyland-v06-20110510');
INSERT INTO cs_stringrepcache VALUES (13, 7041, 'amsr-e-l3-dailyland-v06-20110511');
INSERT INTO cs_stringrepcache VALUES (13, 7042, 'amsr-e-l3-dailyland-v06-20110512');
INSERT INTO cs_stringrepcache VALUES (13, 7043, 'amsr-e-l3-dailyland-v06-20110513');
INSERT INTO cs_stringrepcache VALUES (13, 7044, 'amsr-e-l3-dailyland-v06-20110514');
INSERT INTO cs_stringrepcache VALUES (13, 7045, 'amsr-e-l3-dailyland-v06-20110515');
INSERT INTO cs_stringrepcache VALUES (13, 7046, 'amsr-e-l3-dailyland-v06-20110516');
INSERT INTO cs_stringrepcache VALUES (13, 7047, 'amsr-e-l3-dailyland-v06-20110517');
INSERT INTO cs_stringrepcache VALUES (13, 7048, 'amsr-e-l3-dailyland-v06-20110518');
INSERT INTO cs_stringrepcache VALUES (13, 7049, 'amsr-e-l3-dailyland-v06-20110519');
INSERT INTO cs_stringrepcache VALUES (13, 7050, 'amsr-e-l3-dailyland-v06-20110520');
INSERT INTO cs_stringrepcache VALUES (13, 7051, 'amsr-e-l3-dailyland-v06-20110521');
INSERT INTO cs_stringrepcache VALUES (13, 7052, 'amsr-e-l3-dailyland-v06-20110522');
INSERT INTO cs_stringrepcache VALUES (13, 7053, 'amsr-e-l3-dailyland-v06-20110523');
INSERT INTO cs_stringrepcache VALUES (13, 7054, 'amsr-e-l3-dailyland-v06-20110524');
INSERT INTO cs_stringrepcache VALUES (13, 7055, 'amsr-e-l3-dailyland-v06-20110525');
INSERT INTO cs_stringrepcache VALUES (13, 7056, 'amsr-e-l3-dailyland-v06-20110526');
INSERT INTO cs_stringrepcache VALUES (13, 7057, 'amsr-e-l3-dailyland-v06-20110527');
INSERT INTO cs_stringrepcache VALUES (13, 7058, 'amsr-e-l3-dailyland-v06-20110528');
INSERT INTO cs_stringrepcache VALUES (13, 7059, 'amsr-e-l3-dailyland-v06-20110529');
INSERT INTO cs_stringrepcache VALUES (13, 7060, 'amsr-e-l3-dailyland-v06-20110530');
INSERT INTO cs_stringrepcache VALUES (13, 7061, 'amsr-e-l3-dailyland-v06-20110531');
INSERT INTO cs_stringrepcache VALUES (13, 7062, 'amsr-e-l3-dailyland-v06-20110601');
INSERT INTO cs_stringrepcache VALUES (13, 7063, 'amsr-e-l3-dailyland-v06-20110602');
INSERT INTO cs_stringrepcache VALUES (13, 7064, 'amsr-e-l3-dailyland-v06-20110603');
INSERT INTO cs_stringrepcache VALUES (13, 7065, 'amsr-e-l3-dailyland-v06-20110604');
INSERT INTO cs_stringrepcache VALUES (13, 7066, 'amsr-e-l3-dailyland-v06-20110605');
INSERT INTO cs_stringrepcache VALUES (13, 7067, 'amsr-e-l3-dailyland-v06-20110606');
INSERT INTO cs_stringrepcache VALUES (13, 7068, 'amsr-e-l3-dailyland-v06-20110607');
INSERT INTO cs_stringrepcache VALUES (13, 7069, 'amsr-e-l3-dailyland-v06-20110608');
INSERT INTO cs_stringrepcache VALUES (13, 7070, 'amsr-e-l3-dailyland-v06-20110609');
INSERT INTO cs_stringrepcache VALUES (13, 7071, 'amsr-e-l3-dailyland-v06-20110610');
INSERT INTO cs_stringrepcache VALUES (13, 7072, 'amsr-e-l3-dailyland-v06-20110611');
INSERT INTO cs_stringrepcache VALUES (13, 7073, 'amsr-e-l3-dailyland-v06-20110612');
INSERT INTO cs_stringrepcache VALUES (13, 7074, 'amsr-e-l3-dailyland-v06-20110613');
INSERT INTO cs_stringrepcache VALUES (13, 7075, 'amsr-e-l3-dailyland-v06-20110614');
INSERT INTO cs_stringrepcache VALUES (13, 7076, 'amsr-e-l3-dailyland-v06-20110615');
INSERT INTO cs_stringrepcache VALUES (13, 7077, 'amsr-e-l3-dailyland-v06-20110616');
INSERT INTO cs_stringrepcache VALUES (13, 7078, 'amsr-e-l3-dailyland-v06-20110617');
INSERT INTO cs_stringrepcache VALUES (13, 7079, 'amsr-e-l3-dailyland-v06-20110618');
INSERT INTO cs_stringrepcache VALUES (13, 7080, 'amsr-e-l3-dailyland-v06-20110619');
INSERT INTO cs_stringrepcache VALUES (13, 7081, 'amsr-e-l3-dailyland-v06-20110620');
INSERT INTO cs_stringrepcache VALUES (13, 7082, 'amsr-e-l3-dailyland-v06-20110621');
INSERT INTO cs_stringrepcache VALUES (13, 7083, 'amsr-e-l3-dailyland-v06-20110622');
INSERT INTO cs_stringrepcache VALUES (13, 7084, 'amsr-e-l3-dailyland-v06-20110623');
INSERT INTO cs_stringrepcache VALUES (13, 7085, 'amsr-e-l3-dailyland-v06-20110624');
INSERT INTO cs_stringrepcache VALUES (13, 7086, 'amsr-e-l3-dailyland-v06-20110625');
INSERT INTO cs_stringrepcache VALUES (13, 7087, 'amsr-e-l3-dailyland-v06-20110626');
INSERT INTO cs_stringrepcache VALUES (13, 7088, 'amsr-e-l3-dailyland-v06-20110627');
INSERT INTO cs_stringrepcache VALUES (13, 7089, 'amsr-e-l3-dailyland-v06-20110628');
INSERT INTO cs_stringrepcache VALUES (13, 7090, 'amsr-e-l3-dailyland-v06-20110629');
INSERT INTO cs_stringrepcache VALUES (13, 7091, 'amsr-e-l3-dailyland-v06-20110630');
INSERT INTO cs_stringrepcache VALUES (13, 7092, 'amsr-e-l3-dailyland-v06-20110701');
INSERT INTO cs_stringrepcache VALUES (13, 7093, 'amsr-e-l3-dailyland-v06-20110702');
INSERT INTO cs_stringrepcache VALUES (13, 7094, 'amsr-e-l3-dailyland-v06-20110703');
INSERT INTO cs_stringrepcache VALUES (13, 7095, 'amsr-e-l3-dailyland-v06-20110704');
INSERT INTO cs_stringrepcache VALUES (13, 7096, 'amsr-e-l3-dailyland-v06-20110705');
INSERT INTO cs_stringrepcache VALUES (13, 7097, 'amsr-e-l3-dailyland-v06-20110706');
INSERT INTO cs_stringrepcache VALUES (13, 7098, 'amsr-e-l3-dailyland-v06-20110707');
INSERT INTO cs_stringrepcache VALUES (13, 7099, 'amsr-e-l3-dailyland-v06-20110708');
INSERT INTO cs_stringrepcache VALUES (13, 7100, 'amsr-e-l3-dailyland-v06-20110709');
INSERT INTO cs_stringrepcache VALUES (13, 7101, 'amsr-e-l3-dailyland-v06-20110710');
INSERT INTO cs_stringrepcache VALUES (13, 7102, 'amsr-e-l3-dailyland-v06-20110711');
INSERT INTO cs_stringrepcache VALUES (13, 7103, 'amsr-e-l3-dailyland-v06-20110712');
INSERT INTO cs_stringrepcache VALUES (13, 7104, 'amsr-e-l3-dailyland-v06-20110713');
INSERT INTO cs_stringrepcache VALUES (13, 7105, 'amsr-e-l3-dailyland-v06-20110714');
INSERT INTO cs_stringrepcache VALUES (13, 7106, 'amsr-e-l3-dailyland-v06-20110715');
INSERT INTO cs_stringrepcache VALUES (13, 7107, 'amsr-e-l3-dailyland-v06-20110716');
INSERT INTO cs_stringrepcache VALUES (13, 7108, 'amsr-e-l3-dailyland-v06-20110717');
INSERT INTO cs_stringrepcache VALUES (13, 7109, 'amsr-e-l3-dailyland-v06-20110718');
INSERT INTO cs_stringrepcache VALUES (13, 7110, 'amsr-e-l3-dailyland-v06-20110719');
INSERT INTO cs_stringrepcache VALUES (13, 7111, 'amsr-e-l3-dailyland-v06-20110720');
INSERT INTO cs_stringrepcache VALUES (13, 7112, 'amsr-e-l3-dailyland-v06-20110721');
INSERT INTO cs_stringrepcache VALUES (13, 7113, 'amsr-e-l3-dailyland-v06-20110722');
INSERT INTO cs_stringrepcache VALUES (13, 7114, 'amsr-e-l3-dailyland-v06-20110723');
INSERT INTO cs_stringrepcache VALUES (13, 7115, 'amsr-e-l3-dailyland-v06-20110724');
INSERT INTO cs_stringrepcache VALUES (13, 7116, 'amsr-e-l3-dailyland-v06-20110725');
INSERT INTO cs_stringrepcache VALUES (13, 7117, 'amsr-e-l3-dailyland-v06-20110726');
INSERT INTO cs_stringrepcache VALUES (13, 7118, 'amsr-e-l3-dailyland-v06-20110727');
INSERT INTO cs_stringrepcache VALUES (13, 7119, 'amsr-e-l3-dailyland-v06-20110728');
INSERT INTO cs_stringrepcache VALUES (13, 7120, 'amsr-e-l3-dailyland-v06-20110729');
INSERT INTO cs_stringrepcache VALUES (13, 7121, 'amsr-e-l3-dailyland-v06-20110730');
INSERT INTO cs_stringrepcache VALUES (13, 7122, 'amsr-e-l3-dailyland-v06-20110731');
INSERT INTO cs_stringrepcache VALUES (13, 7123, 'amsr-e-l3-dailyland-v06-20110801');
INSERT INTO cs_stringrepcache VALUES (13, 7124, 'amsr-e-l3-dailyland-v06-20110802');
INSERT INTO cs_stringrepcache VALUES (13, 7125, 'amsr-e-l3-dailyland-v06-20110803');
INSERT INTO cs_stringrepcache VALUES (13, 7126, 'amsr-e-l3-dailyland-v06-20110804');
INSERT INTO cs_stringrepcache VALUES (13, 7127, 'amsr-e-l3-dailyland-v06-20110805');
INSERT INTO cs_stringrepcache VALUES (13, 7128, 'amsr-e-l3-dailyland-v06-20110806');
INSERT INTO cs_stringrepcache VALUES (13, 7129, 'amsr-e-l3-dailyland-v06-20110807');
INSERT INTO cs_stringrepcache VALUES (13, 7130, 'amsr-e-l3-dailyland-v06-20110808');
INSERT INTO cs_stringrepcache VALUES (13, 7131, 'amsr-e-l3-dailyland-v06-20110809');
INSERT INTO cs_stringrepcache VALUES (13, 7132, 'amsr-e-l3-dailyland-v06-20110810');
INSERT INTO cs_stringrepcache VALUES (13, 7133, 'amsr-e-l3-dailyland-v06-20110811');
INSERT INTO cs_stringrepcache VALUES (13, 7134, 'amsr-e-l3-dailyland-v06-20110812');
INSERT INTO cs_stringrepcache VALUES (13, 7135, 'amsr-e-l3-dailyland-v06-20110813');
INSERT INTO cs_stringrepcache VALUES (13, 7136, 'amsr-e-l3-dailyland-v06-20110814');
INSERT INTO cs_stringrepcache VALUES (13, 7137, 'amsr-e-l3-dailyland-v06-20110815');
INSERT INTO cs_stringrepcache VALUES (13, 7138, 'amsr-e-l3-dailyland-v06-20110816');
INSERT INTO cs_stringrepcache VALUES (13, 7139, 'amsr-e-l3-dailyland-v06-20110817');
INSERT INTO cs_stringrepcache VALUES (13, 7140, 'amsr-e-l3-dailyland-v06-20110818');
INSERT INTO cs_stringrepcache VALUES (13, 7141, 'amsr-e-l3-dailyland-v06-20110819');
INSERT INTO cs_stringrepcache VALUES (13, 7142, 'amsr-e-l3-dailyland-v06-20110820');
INSERT INTO cs_stringrepcache VALUES (13, 7143, 'amsr-e-l3-dailyland-v06-20110821');
INSERT INTO cs_stringrepcache VALUES (13, 7144, 'amsr-e-l3-dailyland-v06-20110822');
INSERT INTO cs_stringrepcache VALUES (13, 7145, 'amsr-e-l3-dailyland-v06-20110823');
INSERT INTO cs_stringrepcache VALUES (13, 7146, 'amsr-e-l3-dailyland-v06-20110824');
INSERT INTO cs_stringrepcache VALUES (13, 7147, 'amsr-e-l3-dailyland-v06-20110825');
INSERT INTO cs_stringrepcache VALUES (13, 7148, 'amsr-e-l3-dailyland-v06-20110826');
INSERT INTO cs_stringrepcache VALUES (13, 7149, 'amsr-e-l3-dailyland-v06-20110827');
INSERT INTO cs_stringrepcache VALUES (13, 7150, 'amsr-e-l3-dailyland-v06-20110828');
INSERT INTO cs_stringrepcache VALUES (13, 7151, 'amsr-e-l3-dailyland-v06-20110829');
INSERT INTO cs_stringrepcache VALUES (13, 7152, 'amsr-e-l3-dailyland-v06-20110830');
INSERT INTO cs_stringrepcache VALUES (13, 7153, 'amsr-e-l3-dailyland-v06-20110831');
INSERT INTO cs_stringrepcache VALUES (13, 7154, 'amsr-e-l3-dailyland-v06-20110901');
INSERT INTO cs_stringrepcache VALUES (13, 7155, 'amsr-e-l3-dailyland-v06-20110902');
INSERT INTO cs_stringrepcache VALUES (13, 7156, 'amsr-e-l3-dailyland-v06-20110903');
INSERT INTO cs_stringrepcache VALUES (13, 7157, 'amsr-e-l3-dailyland-v06-20110904');
INSERT INTO cs_stringrepcache VALUES (13, 7158, 'amsr-e-l3-dailyland-v06-20110905');
INSERT INTO cs_stringrepcache VALUES (13, 7159, 'amsr-e-l3-dailyland-v06-20110906');
INSERT INTO cs_stringrepcache VALUES (13, 7160, 'amsr-e-l3-dailyland-v06-20110907');
INSERT INTO cs_stringrepcache VALUES (13, 7161, 'amsr-e-l3-dailyland-v06-20110908');
INSERT INTO cs_stringrepcache VALUES (13, 7162, 'amsr-e-l3-dailyland-v06-20110909');
INSERT INTO cs_stringrepcache VALUES (13, 7163, 'amsr-e-l3-dailyland-v06-20110910');
INSERT INTO cs_stringrepcache VALUES (13, 7164, 'amsr-e-l3-dailyland-v06-20110911');
INSERT INTO cs_stringrepcache VALUES (13, 7165, 'amsr-e-l3-dailyland-v06-20110912');
INSERT INTO cs_stringrepcache VALUES (13, 7166, 'amsr-e-l3-dailyland-v06-20110913');
INSERT INTO cs_stringrepcache VALUES (13, 7167, 'amsr-e-l3-dailyland-v06-20110914');
INSERT INTO cs_stringrepcache VALUES (13, 7168, 'amsr-e-l3-dailyland-v06-20110915');
INSERT INTO cs_stringrepcache VALUES (13, 7169, 'amsr-e-l3-dailyland-v06-20110916');
INSERT INTO cs_stringrepcache VALUES (13, 7170, 'amsr-e-l3-dailyland-v06-20110917');
INSERT INTO cs_stringrepcache VALUES (13, 7171, 'amsr-e-l3-dailyland-v06-20110918');
INSERT INTO cs_stringrepcache VALUES (13, 7172, 'amsr-e-l3-dailyland-v06-20110919');
INSERT INTO cs_stringrepcache VALUES (13, 7173, 'amsr-e-l3-dailyland-v06-20110920');
INSERT INTO cs_stringrepcache VALUES (13, 7174, 'amsr-e-l3-dailyland-v06-20110921');
INSERT INTO cs_stringrepcache VALUES (13, 7175, 'amsr-e-l3-dailyland-v06-20110922');
INSERT INTO cs_stringrepcache VALUES (13, 7176, 'amsr-e-l3-dailyland-v06-20110923');
INSERT INTO cs_stringrepcache VALUES (13, 7177, 'amsr-e-l3-dailyland-v06-20110924');
INSERT INTO cs_stringrepcache VALUES (13, 7178, 'amsr-e-l3-dailyland-v06-20110925');
INSERT INTO cs_stringrepcache VALUES (13, 7179, 'amsr-e-l3-dailyland-v06-20110926');
INSERT INTO cs_stringrepcache VALUES (13, 7180, 'amsr-e-l3-dailyland-v06-20110927');
INSERT INTO cs_stringrepcache VALUES (13, 7181, 'amsr-e-l3-dailyland-v06-20110928');
INSERT INTO cs_stringrepcache VALUES (13, 7182, 'amsr-e-l3-dailyland-v06-20110929');
INSERT INTO cs_stringrepcache VALUES (13, 7183, 'amsr-e-l3-dailyland-v06-20110930');
INSERT INTO cs_stringrepcache VALUES (13, 7184, 'amsr-e-l3-dailyland-v06-20111001');
INSERT INTO cs_stringrepcache VALUES (13, 7185, 'amsr-e-l3-dailyland-v06-20111002');
INSERT INTO cs_stringrepcache VALUES (13, 7186, 'amsr-e-l3-dailyland-v06-20111003');
INSERT INTO cs_stringrepcache VALUES (13, 7187, 'AMSR-E/Aqua Daily L3 Surface Soil Moisture, Interpretive Parameters, & QC EASE-Grids');
INSERT INTO cs_stringrepcache VALUES (13, 7188, '0ad_pop.zip');
INSERT INTO cs_stringrepcache VALUES (13, 7209, 'Land use by NUTS 2 regions');


--
-- TOC entry 4078 (class 0 OID 52270)
-- Dependencies: 311
-- Data for Name: cs_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_type VALUES (1, 'cids_GEOMETRY', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (2, 'INTEGER', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (3, 'INT2', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (4, 'INT4', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (5, 'INT8', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (6, 'NUMERIC', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (7, 'CHAR', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (8, 'VARCHAR', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (9, 'TEXT', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (10, 'BOOL', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (11, 'FLOAT4', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (12, 'FLOAT8', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (13, 'DATE', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (14, 'TIMESTAMP', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (15, 'BPCHAR', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (16, 'Extension Type', NULL, false, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (17, 'URL_BASE', 3, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (18, 'URL', 2, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (19, 'GEOM', 1, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (21, 'taggroup', 5, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (22, 'tag', 6, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (23, 'representation', 7, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (24, 'jt_representation_tag', 8, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (25, 'jt_resource_tag', 9, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (26, 'jt_metadata_tag', 10, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (27, 'jt_relationship_tag', 11, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (28, 'jt_resource_representation', 12, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (29, 'resource', 13, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (30, 'jt_metadata_resource', 14, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (31, 'metadata', 15, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (32, 'jt_fromresource_relationship', 16, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (33, 'jt_metadata_relationship', 17, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (34, 'relationship', 18, true, NULL, NULL, NULL);
INSERT INTO cs_type VALUES (20, 'contact', 4, true, NULL, NULL, NULL);


--
-- TOC entry 4079 (class 0 OID 52282)
-- Dependencies: 314
-- Data for Name: cs_ug; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug VALUES (1, 'Administratoren', NULL, 1, 0);
INSERT INTO cs_ug VALUES (2, 'Gäste', NULL, 1, 1);


--
-- TOC entry 4080 (class 0 OID 52289)
-- Dependencies: 315
-- Data for Name: cs_ug_attr_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4081 (class 0 OID 52295)
-- Dependencies: 317
-- Data for Name: cs_ug_cat_node_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4082 (class 0 OID 52303)
-- Dependencies: 320
-- Data for Name: cs_ug_class_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug_class_perm VALUES (3, 1, 5, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (4, 1, 6, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (7, 1, 8, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (8, 1, 9, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (9, 1, 10, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (10, 1, 11, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (11, 1, 12, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (13, 1, 14, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (14, 1, 13, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (16, 1, 17, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (17, 1, 18, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (18, 1, 15, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (19, 1, 1, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (20, 1, 16, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (21, 1, 2, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (22, 1, 3, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (1, 1, 4, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (24, 1, 7, 1, NULL);


--
-- TOC entry 4083 (class 0 OID 52309)
-- Dependencies: 322
-- Data for Name: cs_ug_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug_membership VALUES (1, 1, NULL, 1);
INSERT INTO cs_ug_membership VALUES (2, 2, NULL, 2);


--
-- TOC entry 4084 (class 0 OID 52313)
-- Dependencies: 323
-- Data for Name: cs_ug_method_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4085 (class 0 OID 52319)
-- Dependencies: 325
-- Data for Name: cs_usr; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_usr VALUES (1, 'admin', 'cismet', '2014-08-21 22:10:06.114849', true);
INSERT INTO cs_usr VALUES (2, 'gast', 'cismet', '2014-08-21 22:10:06.114849', false);


--
-- TOC entry 3740 (class 0 OID 50381)
-- Dependencies: 178
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3901 (class 2606 OID 66381)
-- Name: attr_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_attr_perm
    ADD CONSTRAINT attr_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3903 (class 2606 OID 66383)
-- Name: cat_node_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_cat_node_perm
    ADD CONSTRAINT cat_node_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3891 (class 2606 OID 66385)
-- Name: cid_oid; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_stringrepcache
    ADD CONSTRAINT cid_oid PRIMARY KEY (class_id, object_id);


--
-- TOC entry 3905 (class 2606 OID 66387)
-- Name: class_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_class_perm
    ADD CONSTRAINT class_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3813 (class 2606 OID 66391)
-- Name: cs_all_attr_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_all_attr_mapping
    ADD CONSTRAINT cs_all_attr_mapping_pkey PRIMARY KEY (id);


--
-- TOC entry 3824 (class 2606 OID 66393)
-- Name: cs_cat_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_link
    ADD CONSTRAINT cs_cat_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3835 (class 2606 OID 66395)
-- Name: cs_class_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class_attr
    ADD CONSTRAINT cs_class_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3837 (class 2606 OID 66397)
-- Name: cs_config_attr_exempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_pkey PRIMARY KEY (id);


--
-- TOC entry 3839 (class 2606 OID 66399)
-- Name: cs_config_attr_exempt_usr_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_key_id_key UNIQUE (usr_id, key_id);


--
-- TOC entry 3841 (class 2606 OID 66401)
-- Name: cs_config_attr_jt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_pkey PRIMARY KEY (id);


--
-- TOC entry 3843 (class 2606 OID 66403)
-- Name: cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key UNIQUE (usr_id, ug_id, dom_id, key_id);


--
-- TOC entry 3845 (class 2606 OID 66405)
-- Name: cs_config_attr_key_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_key
    ADD CONSTRAINT cs_config_attr_key_pkey PRIMARY KEY (id);


--
-- TOC entry 3847 (class 2606 OID 66407)
-- Name: cs_config_attr_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_type
    ADD CONSTRAINT cs_config_attr_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3849 (class 2606 OID 66409)
-- Name: cs_config_attr_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_value
    ADD CONSTRAINT cs_config_attr_value_pkey PRIMARY KEY (id);


--
-- TOC entry 3851 (class 2606 OID 66411)
-- Name: cs_domain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_domain
    ADD CONSTRAINT cs_domain_pkey PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 66413)
-- Name: cs_dynamic_children_helper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_dynamic_children_helper
    ADD CONSTRAINT cs_dynamic_children_helper_pkey PRIMARY KEY (id);


--
-- TOC entry 3855 (class 2606 OID 66415)
-- Name: cs_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_pkey PRIMARY KEY (class_id, object_id, valid_from);


--
-- TOC entry 3857 (class 2606 OID 66417)
-- Name: cs_icon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_icon
    ADD CONSTRAINT cs_icon_pkey PRIMARY KEY (id);


--
-- TOC entry 3859 (class 2606 OID 66419)
-- Name: cs_java_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_java_class
    ADD CONSTRAINT cs_java_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3861 (class 2606 OID 66421)
-- Name: cs_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_locks
    ADD CONSTRAINT cs_locks_pkey PRIMARY KEY (id);


--
-- TOC entry 3865 (class 2606 OID 66423)
-- Name: cs_method_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method_class_assoc
    ADD CONSTRAINT cs_method_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3867 (class 2606 OID 66425)
-- Name: cs_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_permission
    ADD CONSTRAINT cs_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3869 (class 2606 OID 66427)
-- Name: cs_policy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy
    ADD CONSTRAINT cs_policy_pkey PRIMARY KEY (id);


--
-- TOC entry 3871 (class 2606 OID 66429)
-- Name: cs_policy_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3873 (class 2606 OID 66431)
-- Name: cs_policy_rule_policy_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_policy_key UNIQUE (policy, permission);


--
-- TOC entry 3879 (class 2606 OID 66433)
-- Name: cs_query_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_class_assoc
    ADD CONSTRAINT cs_query_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3881 (class 2606 OID 66435)
-- Name: cs_query_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_link
    ADD CONSTRAINT cs_query_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3885 (class 2606 OID 66437)
-- Name: cs_query_store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store
    ADD CONSTRAINT cs_query_store_pkey PRIMARY KEY (id);


--
-- TOC entry 3887 (class 2606 OID 66439)
-- Name: cs_query_store_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store_ug_assoc
    ADD CONSTRAINT cs_query_store_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3889 (class 2606 OID 66441)
-- Name: cs_query_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_ug_assoc
    ADD CONSTRAINT cs_query_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3907 (class 2606 OID 66443)
-- Name: cs_ug_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_membership
    ADD CONSTRAINT cs_ug_membership_pkey PRIMARY KEY (id);


--
-- TOC entry 3897 (class 2606 OID 66445)
-- Name: cs_ug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_pkey PRIMARY KEY (id);


--
-- TOC entry 3899 (class 2606 OID 66447)
-- Name: cs_ug_prio_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_prio_key UNIQUE (prio);


--
-- TOC entry 3909 (class 2606 OID 66469)
-- Name: method_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_method_perm
    ADD CONSTRAINT method_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3815 (class 2606 OID 66485)
-- Name: x_cs_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_attr
    ADD CONSTRAINT x_cs_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3829 (class 2606 OID 66487)
-- Name: x_cs_cat_node_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_node
    ADD CONSTRAINT x_cs_cat_node_pkey PRIMARY KEY (id);


--
-- TOC entry 3831 (class 2606 OID 66489)
-- Name: x_cs_class_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_name_key UNIQUE (name);


--
-- TOC entry 3833 (class 2606 OID 66491)
-- Name: x_cs_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3863 (class 2606 OID 66493)
-- Name: x_cs_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method
    ADD CONSTRAINT x_cs_method_pkey PRIMARY KEY (id);


--
-- TOC entry 3875 (class 2606 OID 66495)
-- Name: x_cs_query_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_name_key UNIQUE (name);


--
-- TOC entry 3883 (class 2606 OID 66497)
-- Name: x_cs_query_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_parameter
    ADD CONSTRAINT x_cs_query_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 3877 (class 2606 OID 66499)
-- Name: x_cs_query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_pkey PRIMARY KEY (id);


--
-- TOC entry 3893 (class 2606 OID 66501)
-- Name: x_cs_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_name_key UNIQUE (name);


--
-- TOC entry 3895 (class 2606 OID 66503)
-- Name: x_cs_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3911 (class 2606 OID 66505)
-- Name: x_cs_usr_login_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_login_name_key UNIQUE (login_name);


--
-- TOC entry 3913 (class 2606 OID 66507)
-- Name: x_cs_usr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_pkey PRIMARY KEY (id);


--
-- TOC entry 3817 (class 1259 OID 66510)
-- Name: attr_object_derived_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index ON cs_attr_object_derived USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3818 (class 1259 OID 66511)
-- Name: attr_object_derived_index_acid_aoid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_acid_aoid ON cs_attr_object_derived USING btree (attr_class_id, attr_object_id);


--
-- TOC entry 3819 (class 1259 OID 66512)
-- Name: attr_object_derived_index_cid_oid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_cid_oid ON cs_attr_object_derived USING btree (class_id, object_id);


--
-- TOC entry 3816 (class 1259 OID 66513)
-- Name: attr_object_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_index ON cs_attr_object USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3825 (class 1259 OID 66514)
-- Name: cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cl_idx ON cs_cat_node USING btree (class_id);


--
-- TOC entry 3809 (class 1259 OID 66516)
-- Name: cs_all_attr_mapping_index1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index1 ON cs_all_attr_mapping USING btree (class_id);


--
-- TOC entry 3810 (class 1259 OID 66517)
-- Name: cs_all_attr_mapping_index2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index2 ON cs_all_attr_mapping USING btree (attr_class_id);


--
-- TOC entry 3811 (class 1259 OID 66518)
-- Name: cs_all_attr_mapping_index3; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index3 ON cs_all_attr_mapping USING btree (attr_object_id);


--
-- TOC entry 3820 (class 1259 OID 66519)
-- Name: cs_attr_string_class_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_class_idx ON cs_attr_string USING btree (class_id);


--
-- TOC entry 3821 (class 1259 OID 66520)
-- Name: cs_attr_string_object_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_object_idx ON cs_attr_string USING btree (object_id);


--
-- TOC entry 3822 (class 1259 OID 66522)
-- Name: i_cs_attr_string_aco_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX i_cs_attr_string_aco_id ON cs_attr_string USING btree (attr_id, class_id, object_id);


--
-- TOC entry 3826 (class 1259 OID 66549)
-- Name: ob_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ob_idx ON cs_cat_node USING btree (object_id);


--
-- TOC entry 3827 (class 1259 OID 66550)
-- Name: obj_cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX obj_cl_idx ON cs_cat_node USING btree (class_id, object_id);


--
-- TOC entry 3914 (class 2606 OID 66587)
-- Name: cs_config_attr_exempt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3915 (class 2606 OID 66592)
-- Name: cs_config_attr_exempt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3916 (class 2606 OID 66597)
-- Name: cs_config_attr_exempt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3917 (class 2606 OID 66602)
-- Name: cs_config_attr_jt_dom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_dom_id_fkey FOREIGN KEY (dom_id) REFERENCES cs_domain(id);


--
-- TOC entry 3918 (class 2606 OID 66607)
-- Name: cs_config_attr_jt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3919 (class 2606 OID 66612)
-- Name: cs_config_attr_jt_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_type_id_fkey FOREIGN KEY (type_id) REFERENCES cs_config_attr_type(id);


--
-- TOC entry 3920 (class 2606 OID 66617)
-- Name: cs_config_attr_jt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3921 (class 2606 OID 66622)
-- Name: cs_config_attr_jt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3922 (class 2606 OID 66627)
-- Name: cs_config_attr_jt_val_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_val_id_fkey FOREIGN KEY (val_id) REFERENCES cs_config_attr_value(id);


--
-- TOC entry 3923 (class 2606 OID 66632)
-- Name: cs_history_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_class_id_fkey FOREIGN KEY (class_id) REFERENCES cs_class(id);


--
-- TOC entry 3924 (class 2606 OID 66637)
-- Name: cs_history_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3925 (class 2606 OID 66642)
-- Name: cs_history_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


-- Completed on 2015-03-10 17:53:32

--
-- PostgreSQL database dump complete
--

