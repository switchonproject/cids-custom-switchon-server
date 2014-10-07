--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.5
-- Dumped by pg_dump version 9.3.1
-- Started on 2014-10-07 16:31:11

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
-- TOC entry 252 (class 1259 OID 18323)
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
-- TOC entry 253 (class 1259 OID 18327)
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
-- TOC entry 254 (class 1259 OID 18342)
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
-- TOC entry 255 (class 1259 OID 18345)
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
-- TOC entry 257 (class 1259 OID 18350)
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
-- TOC entry 259 (class 1259 OID 18358)
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
-- TOC entry 260 (class 1259 OID 18365)
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
-- TOC entry 262 (class 1259 OID 18378)
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
-- TOC entry 264 (class 1259 OID 18390)
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
-- TOC entry 268 (class 1259 OID 18405)
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
-- TOC entry 270 (class 1259 OID 18411)
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
-- TOC entry 272 (class 1259 OID 18417)
-- Name: cs_config_attr_key; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_key (
    id integer DEFAULT nextval('cs_config_attr_key_sequence'::regclass) NOT NULL,
    key character varying(200) NOT NULL
);


ALTER TABLE public.cs_config_attr_key OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 18423)
-- Name: cs_config_attr_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_type (
    id integer DEFAULT nextval('cs_config_attr_type_sequence'::regclass) NOT NULL,
    type character(1) NOT NULL,
    descr character varying(200)
);


ALTER TABLE public.cs_config_attr_type OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 18429)
-- Name: cs_config_attr_value; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_value (
    id integer DEFAULT nextval('cs_config_attr_value_sequence'::regclass) NOT NULL,
    value text
);


ALTER TABLE public.cs_config_attr_value OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 18438)
-- Name: cs_domain; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_domain (
    id integer DEFAULT nextval('cs_domain_sequence'::regclass) NOT NULL,
    name character varying(30)
);


ALTER TABLE public.cs_domain OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 18442)
-- Name: cs_dynamic_children_helper; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_dynamic_children_helper (
    id numeric NOT NULL,
    name character varying(256),
    code text
);


ALTER TABLE public.cs_dynamic_children_helper OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 18448)
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
-- TOC entry 282 (class 1259 OID 18456)
-- Name: cs_icon; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_icon (
    id integer DEFAULT nextval('cs_icon_sequence'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    file_name character varying(100) DEFAULT 'default_icon.gif'::character varying NOT NULL
);


ALTER TABLE public.cs_icon OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 18463)
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
-- TOC entry 286 (class 1259 OID 18473)
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
-- TOC entry 287 (class 1259 OID 18480)
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
-- TOC entry 289 (class 1259 OID 18493)
-- Name: cs_method_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_method_class_assoc (
    class_id integer NOT NULL,
    method_id integer NOT NULL,
    id integer DEFAULT nextval('cs_method_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_method_class_assoc OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 18501)
-- Name: cs_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_permission (
    id integer DEFAULT nextval('cs_permission_sequence'::regclass) NOT NULL,
    key character varying(10),
    description character varying(100)
);


ALTER TABLE public.cs_permission OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 18507)
-- Name: cs_policy; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_policy (
    id integer DEFAULT nextval('cs_policy_sequence'::regclass) NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.cs_policy OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 18513)
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
-- TOC entry 297 (class 1259 OID 18517)
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
-- TOC entry 299 (class 1259 OID 18532)
-- Name: cs_query_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_class_assoc (
    class_id integer NOT NULL,
    query_id integer NOT NULL,
    id integer DEFAULT nextval('cs_query_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_query_class_assoc OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 18538)
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
-- TOC entry 302 (class 1259 OID 18542)
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
-- TOC entry 306 (class 1259 OID 18557)
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
-- TOC entry 308 (class 1259 OID 18563)
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
-- TOC entry 310 (class 1259 OID 18569)
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
-- TOC entry 311 (class 1259 OID 18573)
-- Name: cs_stringrepcache; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_stringrepcache (
    class_id integer NOT NULL,
    object_id integer NOT NULL,
    stringrep character varying(512)
);


ALTER TABLE public.cs_stringrepcache OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 18579)
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
-- TOC entry 315 (class 1259 OID 18591)
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
-- TOC entry 316 (class 1259 OID 18598)
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
-- TOC entry 318 (class 1259 OID 18604)
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
-- TOC entry 321 (class 1259 OID 18612)
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
-- TOC entry 323 (class 1259 OID 18618)
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
-- TOC entry 324 (class 1259 OID 18622)
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
-- TOC entry 326 (class 1259 OID 18628)
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
-- TOC entry 4019 (class 0 OID 18323)
-- Dependencies: 252
-- Data for Name: cs_all_attr_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4020 (class 0 OID 18327)
-- Dependencies: 253
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
INSERT INTO cs_attr VALUES (110, 15, 13, 'creationDate', 'creationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 10, NULL, NULL, false);
INSERT INTO cs_attr VALUES (111, 15, 9, 'content', 'content', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr VALUES (23, 7, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, 200, NULL, false);
INSERT INTO cs_attr VALUES (28, 7, 9, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (27, 13, 14, 'publicationDate', 'publicationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 25, NULL, NULL, false);
INSERT INTO cs_attr VALUES (35, 7, 8, 'uuid', 'uuid', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 9, 200, NULL, false);
INSERT INTO cs_attr VALUES (112, 7, 22, 'uploadStatus', 'uploadstatus', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 16, NULL, NULL, false);
INSERT INTO cs_attr VALUES (113, 7, 9, 'uploadMessage', 'uploadmessage', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 17, NULL, NULL, false);


--
-- TOC entry 4021 (class 0 OID 18342)
-- Dependencies: 254
-- Data for Name: cs_attr_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_attr_object VALUES (13, 7235, 1, 7239);
INSERT INTO cs_attr_object VALUES (13, 7209, 1, 7213);
INSERT INTO cs_attr_object VALUES (13, 7204, 1, 7208);
INSERT INTO cs_attr_object VALUES (13, 7221, 1, 7225);
INSERT INTO cs_attr_object VALUES (13, 7187, 1, 7191);
INSERT INTO cs_attr_object VALUES (13, 7230, 1, 7234);
INSERT INTO cs_attr_object VALUES (13, 7231, 1, 7235);
INSERT INTO cs_attr_object VALUES (13, 7232, 1, 7236);
INSERT INTO cs_attr_object VALUES (13, 7236, 1, 7240);
INSERT INTO cs_attr_object VALUES (13, 7224, 1, 7338);
INSERT INTO cs_attr_object VALUES (13, 7242, 1, 7339);
INSERT INTO cs_attr_object VALUES (13, 7243, 1, 7340);
INSERT INTO cs_attr_object VALUES (13, 7245, 1, 7341);
INSERT INTO cs_attr_object VALUES (13, 7239, 1, 7315);
INSERT INTO cs_attr_object VALUES (13, 7246, 1, 7343);
INSERT INTO cs_attr_object VALUES (13, 7247, 1, 7344);
INSERT INTO cs_attr_object VALUES (13, 7244, 1, 7345);
INSERT INTO cs_attr_object VALUES (13, 7240, 1, 7317);
INSERT INTO cs_attr_object VALUES (13, 7249, 1, 7347);
INSERT INTO cs_attr_object VALUES (13, 7248, 1, 7348);
INSERT INTO cs_attr_object VALUES (13, 7250, 1, 7349);
INSERT INTO cs_attr_object VALUES (13, 7251, 1, 7350);
INSERT INTO cs_attr_object VALUES (13, 7252, 1, 7352);
INSERT INTO cs_attr_object VALUES (13, 7253, 1, 7351);
INSERT INTO cs_attr_object VALUES (13, 7254, 1, 7353);
INSERT INTO cs_attr_object VALUES (13, 7255, 1, 7354);
INSERT INTO cs_attr_object VALUES (13, 7257, 1, 7355);
INSERT INTO cs_attr_object VALUES (13, 7256, 1, 7357);


--
-- TOC entry 4022 (class 0 OID 18345)
-- Dependencies: 255
-- Data for Name: cs_attr_object_derived; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4023 (class 0 OID 18350)
-- Dependencies: 257
-- Data for Name: cs_attr_string; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_attr_string VALUES (13, 60, 7235, 'expert');
INSERT INTO cs_attr_string VALUES (13, 66, 7235, 'expert');
INSERT INTO cs_attr_string VALUES (13, 60, 7209, 'Tool that can generate a rainevent from an IDF curve');
INSERT INTO cs_attr_string VALUES (13, 66, 7209, 'IDF to Rainevent Generator Tool');
INSERT INTO cs_attr_string VALUES (13, 60, 7221, 'advanced resource');
INSERT INTO cs_attr_string VALUES (13, 66, 7221, 'advanced resource');
INSERT INTO cs_attr_string VALUES (13, 60, 7187, 'The Advanced Microwave Scanning Radiometer - Earth Observing System (AMSR-E) instrument on the NASA Earth Observing System (EOS) Aqua satellite provides global passive microwave measurements of terrestrial, oceanic, and atmospheric variables for the investigation of water and energy cycles. Soil moisture and other land surface variables are key variables in understanding land surface hydrology and in modeling ecosystems, weather, and climate. This gridded Level-3 land surface product (AE_Land3) includes daily measurements of surface soil moisture and vegetation/roughness water content interpretive information, as well as brightness temperatures and quality control variables. Ancillary data include time, geolocation, and quality assessment. Input brightness temperature data, corresponding to a 56 km mean spatial resolution, are resampled to a global cylindrical 25 km Equal-Area Scalable Earth Grid (EASE-Grid) cell spacing. Data are stored in HDF-EOS format, and are available from 19 June 2002 to the present via FTP.');
INSERT INTO cs_attr_string VALUES (13, 66, 7187, 'AMSR-E/Aqua Daily L3 Surface Soil Moisture, Interpretive Parameters, & QC EASE-Grids');
INSERT INTO cs_attr_string VALUES (13, 60, 7204, 'IDF curve from the Austria Lebensministerium dataset');
INSERT INTO cs_attr_string VALUES (13, 66, 7204, 'Kostra IDF Curve 3093');
INSERT INTO cs_attr_string VALUES (13, 60, 7230, 'f');
INSERT INTO cs_attr_string VALUES (13, 66, 7230, 'f');
INSERT INTO cs_attr_string VALUES (13, 60, 7231, 'jop');
INSERT INTO cs_attr_string VALUES (13, 66, 7231, 'new basic');
INSERT INTO cs_attr_string VALUES (13, 60, 7232, 'ff');
INSERT INTO cs_attr_string VALUES (13, 66, 7232, 'ff');
INSERT INTO cs_attr_string VALUES (13, 60, 7244, 'uploadTest');
INSERT INTO cs_attr_string VALUES (13, 66, 7244, 'uploadTest');
INSERT INTO cs_attr_string VALUES (13, 60, 7236, 'fe');
INSERT INTO cs_attr_string VALUES (13, 66, 7236, 'fre');
INSERT INTO cs_attr_string VALUES (13, 60, 7239, '"Eurostat''s mission: to be the leading provider of high quality statistics on Europe. 
Eurostat is the statistical office of the European Union situated in Luxembourg. Its task is to provide the European Union with statistics at European level that enable comparisons between countries and regions. 
This is a key task. Democratic societies do not function properly without a solid basis of reliable and objective statistics. On one hand, decision-makers at EU level, in Member States, in local government and in business need statistics to make those decisions. On the other hand, the public and media need statistics for an accurate picture of contemporary society and to evaluate the performance of politicians and others. Of course, national statistics are still important for national purposes in Member States whereas EU statistics are essential for decisions and evaluation at European level."');
INSERT INTO cs_attr_string VALUES (13, 66, 7239, 'Land use by NUTS 2 regions');
INSERT INTO cs_attr_string VALUES (13, 60, 7249, 'fe');
INSERT INTO cs_attr_string VALUES (13, 66, 7249, 'newUpload');
INSERT INTO cs_attr_string VALUES (13, 60, 7248, 'fe');
INSERT INTO cs_attr_string VALUES (13, 66, 7248, 'newUpload');
INSERT INTO cs_attr_string VALUES (13, 60, 7240, '"Eurostat''s mission: to be the leading provider of high quality statistics on Europe. 
Eurostat is the statistical office of the European Union situated in Luxembourg. Its task is to provide the European Union with statistics at European level that enable comparisons between countries and regions. 
This is a key task. Democratic societies do not function properly without a solid basis of reliable and objective statistics. On one hand, decision-makers at EU level, in Member States, in local government and in business need statistics to make those decisions. On the other hand, the public and media need statistics for an accurate picture of contemporary society and to evaluate the performance of politicians and others. Of course, national statistics are still important for national purposes in Member States whereas EU statistics are essential for decisions and evaluation at European level."');
INSERT INTO cs_attr_string VALUES (13, 66, 7240, 'Land use by NUTS 2 regionsXXX');
INSERT INTO cs_attr_string VALUES (13, 60, 7250, 'veryNewUpdate');
INSERT INTO cs_attr_string VALUES (13, 66, 7250, 'veryNewUpdate');
INSERT INTO cs_attr_string VALUES (13, 60, 7251, 'veryNewUpdate');
INSERT INTO cs_attr_string VALUES (13, 66, 7251, 'veryNewUpdate');
INSERT INTO cs_attr_string VALUES (13, 60, 7252, 'fef');
INSERT INTO cs_attr_string VALUES (13, 66, 7252, 'ultiNewUpdate');
INSERT INTO cs_attr_string VALUES (13, 60, 7253, 'fef');
INSERT INTO cs_attr_string VALUES (13, 66, 7253, 'ultiNewUpdate');
INSERT INTO cs_attr_string VALUES (13, 60, 7254, 'fr');
INSERT INTO cs_attr_string VALUES (13, 66, 7254, 'foobar');
INSERT INTO cs_attr_string VALUES (13, 60, 7255, 'fr');
INSERT INTO cs_attr_string VALUES (13, 66, 7255, 'foobar');
INSERT INTO cs_attr_string VALUES (13, 60, 7224, 'Land use based on subbasin division. The data shows proportions of land-use for each land-use class and subbasin.Unit of measurement: %');
INSERT INTO cs_attr_string VALUES (13, 66, 7224, 'Land-use on subbasins');
INSERT INTO cs_attr_string VALUES (13, 60, 7257, 'fobar2');
INSERT INTO cs_attr_string VALUES (13, 66, 7257, 'fobar2');
INSERT INTO cs_attr_string VALUES (13, 60, 7242, 'g');
INSERT INTO cs_attr_string VALUES (13, 66, 7242, 'g');
INSERT INTO cs_attr_string VALUES (13, 60, 7243, 'g');
INSERT INTO cs_attr_string VALUES (13, 66, 7243, 'g');
INSERT INTO cs_attr_string VALUES (13, 60, 7245, 'uploadTest');
INSERT INTO cs_attr_string VALUES (13, 66, 7245, 'uploadTest');
INSERT INTO cs_attr_string VALUES (13, 60, 7246, 'testUpload');
INSERT INTO cs_attr_string VALUES (13, 66, 7246, 'testUpload');
INSERT INTO cs_attr_string VALUES (13, 60, 7247, 'testUpload');
INSERT INTO cs_attr_string VALUES (13, 66, 7247, 'testUpload');
INSERT INTO cs_attr_string VALUES (13, 60, 7256, 'fobar2');
INSERT INTO cs_attr_string VALUES (13, 66, 7256, 'fobar2');


--
-- TOC entry 4024 (class 0 OID 18358)
-- Dependencies: 259
-- Data for Name: cs_cat_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_cat_link VALUES (3, 1, NULL, 1, 3);
INSERT INTO cs_cat_link VALUES (3, 2, NULL, 1, 4);
INSERT INTO cs_cat_link VALUES (3, 4, NULL, 1, 5);
INSERT INTO cs_cat_link VALUES (3, 9, NULL, 1, 9);


--
-- TOC entry 4025 (class 0 OID 18365)
-- Dependencies: 260
-- Data for Name: cs_cat_node; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_cat_node VALUES (1, 'Internal', NULL, NULL, NULL, 'N', false, NULL, 'SELECT  	-1 as id,  	tag.name,  	cs_class.id as class_id,  	null as object_id,  	''N'' as node_type,  	null as url,  	csdc.hydrologicalconcepts(tag.id) as dynamic_children, 	false as sql_sort      FROM  	tag 	LEFT JOIN taggroup ON 		tag.taggroup = taggroup.id,         cs_class     WHERE         cs_class.name = ''tag'' AND 	taggroup.name = ''geography''     GROUP BY  	tag.name, 	tag.id,        cs_class.id     ORDER BY tag.name;', false, NULL, false, NULL, '', '');
INSERT INTO cs_cat_node VALUES (4, 'Administration', NULL, NULL, NULL, 'N', false, NULL, 'SELECT 
	-1 as id, 
	cs_class.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.cidsobjects(cs_class.id::varchar , cs_class.table_name) as dynamic_children, 
	false as sql_sort 
    FROM 
	cs_class,
	cs_attr
    WHERE cs_class.id = cs_attr.class_id
	AND cs_attr.field_name ilike ''name''', true, NULL, false, NULL, NULL, NULL);
INSERT INTO cs_cat_node VALUES (3, 'SWITCH-ON', NULL, NULL, NULL, 'N', true, NULL, NULL, true, NULL, false, NULL, NULL, NULL);
INSERT INTO cs_cat_node VALUES (9, 'Taggroups', NULL, NULL, NULL, 'N', false, NULL, 'SELECT  	-1 as id,  	taggroup.name,  	cs_class.id as class_id,  	null as object_id,  	''N'' as node_type,  	null as url,  	csdc.tags(taggroup.id) as dynamic_children, 	false as sql_sort      FROM  	taggroup,        cs_class     WHERE         cs_class.name = ''taggroup''     ORDER BY taggroup.name;', false, NULL, false, NULL, NULL, NULL);
INSERT INTO cs_cat_node VALUES (2, 'External', NULL, NULL, NULL, 'N', false, NULL, 'SELECT 
        -1 as id, 
	tag.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.collectionsexternal(tag.id) as dynamic_children,
	false as sql_sort 
    FROM 
	tag
	LEFT JOIN taggroup ON
		tag.taggroup = taggroup.id
        LEFT JOIN resource  ON
             resource.collection = tag.id,
        cs_class        
    WHERE
        cs_class.name = ''tag'' AND
	taggroup.name = ''collection'' 
    GROUP BY 
	tag.name,
	tag.id,
        cs_class.id 
    HAVING ( COUNT(resource.id) > 0 )
    ORDER BY tag.name ASC;', true, NULL, false, NULL, NULL, NULL);


--
-- TOC entry 4026 (class 0 OID 18378)
-- Dependencies: 262
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
INSERT INTO cs_class VALUES (13, 'resource', '', 2, 2, 'RESOURCE', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (4, 'contact', '', 2, 2, 'CONTACT', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);


--
-- TOC entry 4027 (class 0 OID 18390)
-- Dependencies: 264
-- Data for Name: cs_class_attr; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4028 (class 0 OID 18405)
-- Dependencies: 268
-- Data for Name: cs_config_attr_exempt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4029 (class 0 OID 18411)
-- Dependencies: 270
-- Data for Name: cs_config_attr_jt; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_config_attr_jt VALUES (1, NULL, 1, 1, 1, 1, 2);


--
-- TOC entry 4030 (class 0 OID 18417)
-- Dependencies: 272
-- Data for Name: cs_config_attr_key; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_config_attr_key VALUES (1, 'csa://webDavTunnelAction');


--
-- TOC entry 4031 (class 0 OID 18423)
-- Dependencies: 274
-- Data for Name: cs_config_attr_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_config_attr_type VALUES (1, 'C', 'regular configuration attribute, a simple string value');
INSERT INTO cs_config_attr_type VALUES (2, 'A', 'action tag configuration attribute, value of no relevance');
INSERT INTO cs_config_attr_type VALUES (3, 'X', 'XML configuration attribute, XML content wrapped by some root element');


--
-- TOC entry 4032 (class 0 OID 18429)
-- Dependencies: 276
-- Data for Name: cs_config_attr_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_config_attr_value VALUES (1, 'true');


--
-- TOC entry 4033 (class 0 OID 18438)
-- Dependencies: 278
-- Data for Name: cs_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_domain VALUES (1, 'LOCAL');


--
-- TOC entry 4034 (class 0 OID 18442)
-- Dependencies: 279
-- Data for Name: cs_dynamic_children_helper; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_dynamic_children_helper VALUES (5, 'tags(taggroup_id integer)', 'SELECT 
  -1 as id, 
	tag.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.collectionsexternal(tag.id) as dynamic_children,
	false as sql_sort 
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
INSERT INTO cs_dynamic_children_helper VALUES (3, 'Entities(level_id integer, hydroCon_id integer)', 'SELECT DISTINCT -1 AS id,
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
      Group by
	resource.name,
	resource.id,
        cs_class.id;');
INSERT INTO cs_dynamic_children_helper VALUES (2, 'HydrologicalConcepts(level_id integer)', 'SELECT -1 AS id,
	tag.name AS name,
	cs_class.id AS class_id,
	NULL AS object_id,
	''N'' AS node_type,
	null AS url,
        csdc.entities(<ds::param name=''level_id''>1</ds::param> , tag.id) as dynamic_children, 
	false AS sql_sort,
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
        cs_class.id;');
INSERT INTO cs_dynamic_children_helper VALUES (1, 'CidsObjects(class_id varchar, table_name varchar)', 'SELECT -1 AS id, 	null AS name, 	<ds::param name=''class_id''>1</ds::param> AS class_id, 	id AS object_id, 	''O'' AS node_type, 	null AS url, 	null AS dynamic_children, 	false AS sql_sort, 	true AS derive_permissions_from_class 	from <ds::param name=''table_name''>2</ds::param> 	order by name');
INSERT INTO cs_dynamic_children_helper VALUES (4, 'collectionsExternal(collection_id integer)', 'SELECT -1 AS id,
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
      Group by
	resource.name,
	resource.id,
        cs_class.id
	ORDER BY resource.name;
');


--
-- TOC entry 4035 (class 0 OID 18448)
-- Dependencies: 280
-- Data for Name: cs_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4036 (class 0 OID 18456)
-- Dependencies: 282
-- Data for Name: cs_icon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_icon VALUES (1, 'Georeferenz', 'georeferenz.gif');
INSERT INTO cs_icon VALUES (2, 'Erde', 'erde.gif');


--
-- TOC entry 4037 (class 0 OID 18463)
-- Dependencies: 284
-- Data for Name: cs_java_class; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4038 (class 0 OID 18473)
-- Dependencies: 286
-- Data for Name: cs_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_locks VALUES (NULL, NULL, 'ABF_EXCLUSIVE_LOCK_1412691510555', 'pascal@KNECHT-RUPRECHT', 33);


--
-- TOC entry 4039 (class 0 OID 18480)
-- Dependencies: 287
-- Data for Name: cs_method; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4040 (class 0 OID 18493)
-- Dependencies: 289
-- Data for Name: cs_method_class_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4041 (class 0 OID 18501)
-- Dependencies: 292
-- Data for Name: cs_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_permission VALUES (0, 'read', 'Leserecht');
INSERT INTO cs_permission VALUES (1, 'write', 'Schreibrecht');


--
-- TOC entry 4042 (class 0 OID 18507)
-- Dependencies: 294
-- Data for Name: cs_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_policy VALUES (0, 'STANDARD');
INSERT INTO cs_policy VALUES (1, 'WIKI');
INSERT INTO cs_policy VALUES (2, 'SECURE');


--
-- TOC entry 4043 (class 0 OID 18513)
-- Dependencies: 296
-- Data for Name: cs_policy_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_policy_rule VALUES (1, 0, 0, true);
INSERT INTO cs_policy_rule VALUES (2, 0, 1, false);
INSERT INTO cs_policy_rule VALUES (3, 1, 0, true);
INSERT INTO cs_policy_rule VALUES (4, 1, 1, true);
INSERT INTO cs_policy_rule VALUES (5, 2, 0, false);
INSERT INTO cs_policy_rule VALUES (6, 2, 1, false);


--
-- TOC entry 4044 (class 0 OID 18517)
-- Dependencies: 297
-- Data for Name: cs_query; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4045 (class 0 OID 18532)
-- Dependencies: 299
-- Data for Name: cs_query_class_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4046 (class 0 OID 18538)
-- Dependencies: 301
-- Data for Name: cs_query_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4047 (class 0 OID 18542)
-- Dependencies: 302
-- Data for Name: cs_query_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4048 (class 0 OID 18557)
-- Dependencies: 306
-- Data for Name: cs_query_store; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4049 (class 0 OID 18563)
-- Dependencies: 308
-- Data for Name: cs_query_store_ug_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4050 (class 0 OID 18569)
-- Dependencies: 310
-- Data for Name: cs_query_ug_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4051 (class 0 OID 18573)
-- Dependencies: 311
-- Data for Name: cs_stringrepcache; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4052 (class 0 OID 18579)
-- Dependencies: 312
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
-- TOC entry 4053 (class 0 OID 18591)
-- Dependencies: 315
-- Data for Name: cs_ug; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug VALUES (1, 'Administratoren', NULL, 1, 0);
INSERT INTO cs_ug VALUES (2, 'Gäste', NULL, 1, 1);


--
-- TOC entry 4054 (class 0 OID 18598)
-- Dependencies: 316
-- Data for Name: cs_ug_attr_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4055 (class 0 OID 18604)
-- Dependencies: 318
-- Data for Name: cs_ug_cat_node_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4056 (class 0 OID 18612)
-- Dependencies: 321
-- Data for Name: cs_ug_class_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug_class_perm VALUES (3, 1, 5, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (4, 1, 6, 1, NULL);
INSERT INTO cs_ug_class_perm VALUES (6, 1, 7, 1, NULL);
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


--
-- TOC entry 4057 (class 0 OID 18618)
-- Dependencies: 323
-- Data for Name: cs_ug_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug_membership VALUES (1, 1, NULL, 1);
INSERT INTO cs_ug_membership VALUES (2, 2, NULL, 2);


--
-- TOC entry 4058 (class 0 OID 18622)
-- Dependencies: 324
-- Data for Name: cs_ug_method_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4059 (class 0 OID 18628)
-- Dependencies: 326
-- Data for Name: cs_usr; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_usr VALUES (1, 'admin', 'cismet', '2014-08-21 22:10:06.114849', true);
INSERT INTO cs_usr VALUES (2, 'gast', 'cismet', '2014-08-21 22:10:06.114849', false);


--
-- TOC entry 3717 (class 0 OID 16668)
-- Dependencies: 176
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3877 (class 2606 OID 46687)
-- Name: attr_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_attr_perm
    ADD CONSTRAINT attr_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3879 (class 2606 OID 46689)
-- Name: cat_node_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_cat_node_perm
    ADD CONSTRAINT cat_node_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3867 (class 2606 OID 46691)
-- Name: cid_oid; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_stringrepcache
    ADD CONSTRAINT cid_oid PRIMARY KEY (class_id, object_id);


--
-- TOC entry 3881 (class 2606 OID 46693)
-- Name: class_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_class_perm
    ADD CONSTRAINT class_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3789 (class 2606 OID 46698)
-- Name: cs_all_attr_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_all_attr_mapping
    ADD CONSTRAINT cs_all_attr_mapping_pkey PRIMARY KEY (id);


--
-- TOC entry 3800 (class 2606 OID 46700)
-- Name: cs_cat_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_link
    ADD CONSTRAINT cs_cat_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3811 (class 2606 OID 46702)
-- Name: cs_class_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class_attr
    ADD CONSTRAINT cs_class_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3813 (class 2606 OID 46704)
-- Name: cs_config_attr_exempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_pkey PRIMARY KEY (id);


--
-- TOC entry 3815 (class 2606 OID 46706)
-- Name: cs_config_attr_exempt_usr_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_key_id_key UNIQUE (usr_id, key_id);


--
-- TOC entry 3817 (class 2606 OID 46708)
-- Name: cs_config_attr_jt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_pkey PRIMARY KEY (id);


--
-- TOC entry 3819 (class 2606 OID 46710)
-- Name: cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key UNIQUE (usr_id, ug_id, dom_id, key_id);


--
-- TOC entry 3821 (class 2606 OID 46712)
-- Name: cs_config_attr_key_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_key
    ADD CONSTRAINT cs_config_attr_key_pkey PRIMARY KEY (id);


--
-- TOC entry 3823 (class 2606 OID 46714)
-- Name: cs_config_attr_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_type
    ADD CONSTRAINT cs_config_attr_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3825 (class 2606 OID 46716)
-- Name: cs_config_attr_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_value
    ADD CONSTRAINT cs_config_attr_value_pkey PRIMARY KEY (id);


--
-- TOC entry 3827 (class 2606 OID 46718)
-- Name: cs_domain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_domain
    ADD CONSTRAINT cs_domain_pkey PRIMARY KEY (id);


--
-- TOC entry 3829 (class 2606 OID 46720)
-- Name: cs_dynamic_children_helper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_dynamic_children_helper
    ADD CONSTRAINT cs_dynamic_children_helper_pkey PRIMARY KEY (id);


--
-- TOC entry 3831 (class 2606 OID 46722)
-- Name: cs_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_pkey PRIMARY KEY (class_id, object_id, valid_from);


--
-- TOC entry 3833 (class 2606 OID 46724)
-- Name: cs_icon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_icon
    ADD CONSTRAINT cs_icon_pkey PRIMARY KEY (id);


--
-- TOC entry 3835 (class 2606 OID 46726)
-- Name: cs_java_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_java_class
    ADD CONSTRAINT cs_java_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3837 (class 2606 OID 46728)
-- Name: cs_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_locks
    ADD CONSTRAINT cs_locks_pkey PRIMARY KEY (id);


--
-- TOC entry 3841 (class 2606 OID 46730)
-- Name: cs_method_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method_class_assoc
    ADD CONSTRAINT cs_method_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3843 (class 2606 OID 46732)
-- Name: cs_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_permission
    ADD CONSTRAINT cs_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3845 (class 2606 OID 46734)
-- Name: cs_policy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy
    ADD CONSTRAINT cs_policy_pkey PRIMARY KEY (id);


--
-- TOC entry 3847 (class 2606 OID 46736)
-- Name: cs_policy_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3849 (class 2606 OID 46738)
-- Name: cs_policy_rule_policy_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_policy_key UNIQUE (policy, permission);


--
-- TOC entry 3855 (class 2606 OID 46740)
-- Name: cs_query_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_class_assoc
    ADD CONSTRAINT cs_query_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3857 (class 2606 OID 46742)
-- Name: cs_query_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_link
    ADD CONSTRAINT cs_query_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3861 (class 2606 OID 46744)
-- Name: cs_query_store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store
    ADD CONSTRAINT cs_query_store_pkey PRIMARY KEY (id);


--
-- TOC entry 3863 (class 2606 OID 46746)
-- Name: cs_query_store_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store_ug_assoc
    ADD CONSTRAINT cs_query_store_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3865 (class 2606 OID 46748)
-- Name: cs_query_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_ug_assoc
    ADD CONSTRAINT cs_query_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3883 (class 2606 OID 46750)
-- Name: cs_ug_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_membership
    ADD CONSTRAINT cs_ug_membership_pkey PRIMARY KEY (id);


--
-- TOC entry 3873 (class 2606 OID 46752)
-- Name: cs_ug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_pkey PRIMARY KEY (id);


--
-- TOC entry 3875 (class 2606 OID 46754)
-- Name: cs_ug_prio_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_prio_key UNIQUE (prio);


--
-- TOC entry 3885 (class 2606 OID 46776)
-- Name: method_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_method_perm
    ADD CONSTRAINT method_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3791 (class 2606 OID 46792)
-- Name: x_cs_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_attr
    ADD CONSTRAINT x_cs_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3805 (class 2606 OID 46794)
-- Name: x_cs_cat_node_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_node
    ADD CONSTRAINT x_cs_cat_node_pkey PRIMARY KEY (id);


--
-- TOC entry 3807 (class 2606 OID 46796)
-- Name: x_cs_class_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_name_key UNIQUE (name);


--
-- TOC entry 3809 (class 2606 OID 46798)
-- Name: x_cs_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3839 (class 2606 OID 46800)
-- Name: x_cs_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method
    ADD CONSTRAINT x_cs_method_pkey PRIMARY KEY (id);


--
-- TOC entry 3851 (class 2606 OID 46802)
-- Name: x_cs_query_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_name_key UNIQUE (name);


--
-- TOC entry 3859 (class 2606 OID 46804)
-- Name: x_cs_query_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_parameter
    ADD CONSTRAINT x_cs_query_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 46806)
-- Name: x_cs_query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_pkey PRIMARY KEY (id);


--
-- TOC entry 3869 (class 2606 OID 46808)
-- Name: x_cs_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_name_key UNIQUE (name);


--
-- TOC entry 3871 (class 2606 OID 46810)
-- Name: x_cs_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3887 (class 2606 OID 46812)
-- Name: x_cs_usr_login_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_login_name_key UNIQUE (login_name);


--
-- TOC entry 3889 (class 2606 OID 46814)
-- Name: x_cs_usr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_pkey PRIMARY KEY (id);


--
-- TOC entry 3793 (class 1259 OID 46815)
-- Name: attr_object_derived_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index ON cs_attr_object_derived USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3794 (class 1259 OID 46816)
-- Name: attr_object_derived_index_acid_aoid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_acid_aoid ON cs_attr_object_derived USING btree (attr_class_id, attr_object_id);


--
-- TOC entry 3795 (class 1259 OID 46817)
-- Name: attr_object_derived_index_cid_oid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_cid_oid ON cs_attr_object_derived USING btree (class_id, object_id);


--
-- TOC entry 3792 (class 1259 OID 46818)
-- Name: attr_object_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_index ON cs_attr_object USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3801 (class 1259 OID 46819)
-- Name: cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cl_idx ON cs_cat_node USING btree (class_id);


--
-- TOC entry 3785 (class 1259 OID 46821)
-- Name: cs_all_attr_mapping_index1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index1 ON cs_all_attr_mapping USING btree (class_id);


--
-- TOC entry 3786 (class 1259 OID 46822)
-- Name: cs_all_attr_mapping_index2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index2 ON cs_all_attr_mapping USING btree (attr_class_id);


--
-- TOC entry 3787 (class 1259 OID 46823)
-- Name: cs_all_attr_mapping_index3; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index3 ON cs_all_attr_mapping USING btree (attr_object_id);


--
-- TOC entry 3796 (class 1259 OID 46824)
-- Name: cs_attr_string_class_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_class_idx ON cs_attr_string USING btree (class_id);


--
-- TOC entry 3797 (class 1259 OID 46825)
-- Name: cs_attr_string_object_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_object_idx ON cs_attr_string USING btree (object_id);


--
-- TOC entry 3798 (class 1259 OID 46827)
-- Name: i_cs_attr_string_aco_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX i_cs_attr_string_aco_id ON cs_attr_string USING btree (attr_id, class_id, object_id);


--
-- TOC entry 3802 (class 1259 OID 46829)
-- Name: ob_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ob_idx ON cs_cat_node USING btree (object_id);


--
-- TOC entry 3803 (class 1259 OID 46830)
-- Name: obj_cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX obj_cl_idx ON cs_cat_node USING btree (class_id, object_id);


--
-- TOC entry 3890 (class 2606 OID 46836)
-- Name: cs_config_attr_exempt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3891 (class 2606 OID 46841)
-- Name: cs_config_attr_exempt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3892 (class 2606 OID 46846)
-- Name: cs_config_attr_exempt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3893 (class 2606 OID 46851)
-- Name: cs_config_attr_jt_dom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_dom_id_fkey FOREIGN KEY (dom_id) REFERENCES cs_domain(id);


--
-- TOC entry 3894 (class 2606 OID 46856)
-- Name: cs_config_attr_jt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3895 (class 2606 OID 46861)
-- Name: cs_config_attr_jt_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_type_id_fkey FOREIGN KEY (type_id) REFERENCES cs_config_attr_type(id);


--
-- TOC entry 3896 (class 2606 OID 46866)
-- Name: cs_config_attr_jt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3897 (class 2606 OID 46871)
-- Name: cs_config_attr_jt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3898 (class 2606 OID 46876)
-- Name: cs_config_attr_jt_val_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_val_id_fkey FOREIGN KEY (val_id) REFERENCES cs_config_attr_value(id);


--
-- TOC entry 3899 (class 2606 OID 46881)
-- Name: cs_history_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_class_id_fkey FOREIGN KEY (class_id) REFERENCES cs_class(id);


--
-- TOC entry 3900 (class 2606 OID 46886)
-- Name: cs_history_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3901 (class 2606 OID 46891)
-- Name: cs_history_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


-- Completed on 2014-10-07 16:31:14

--
-- PostgreSQL database dump complete
--

