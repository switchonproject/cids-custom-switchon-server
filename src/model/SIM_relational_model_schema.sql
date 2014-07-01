--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.3
-- Dumped by pg_dump version 9.3.1
-- Started on 2014-07-01 10:54:43

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
-- TOC entry 194 (class 1259 OID 260763)
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
-- TOC entry 195 (class 1259 OID 260767)
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
-- TOC entry 196 (class 1259 OID 260782)
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
-- TOC entry 197 (class 1259 OID 260785)
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
-- TOC entry 199 (class 1259 OID 260790)
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
-- TOC entry 201 (class 1259 OID 260798)
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
-- TOC entry 202 (class 1259 OID 260805)
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
-- TOC entry 204 (class 1259 OID 260818)
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
-- TOC entry 206 (class 1259 OID 260830)
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
-- TOC entry 210 (class 1259 OID 260845)
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
-- TOC entry 212 (class 1259 OID 260851)
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
-- TOC entry 214 (class 1259 OID 260857)
-- Name: cs_config_attr_key; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_key (
    id integer DEFAULT nextval('cs_config_attr_key_sequence'::regclass) NOT NULL,
    key character varying(200) NOT NULL
);


ALTER TABLE public.cs_config_attr_key OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 260863)
-- Name: cs_config_attr_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_type (
    id integer DEFAULT nextval('cs_config_attr_type_sequence'::regclass) NOT NULL,
    type character(1) NOT NULL,
    descr character varying(200)
);


ALTER TABLE public.cs_config_attr_type OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 260869)
-- Name: cs_config_attr_value; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_value (
    id integer DEFAULT nextval('cs_config_attr_value_sequence'::regclass) NOT NULL,
    value text
);


ALTER TABLE public.cs_config_attr_value OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 260878)
-- Name: cs_domain; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_domain (
    id integer DEFAULT nextval('cs_domain_sequence'::regclass) NOT NULL,
    name character varying(30)
);


ALTER TABLE public.cs_domain OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 260882)
-- Name: cs_dynamic_children_helper; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_dynamic_children_helper (
    id numeric NOT NULL,
    name character varying(256),
    code text
);


ALTER TABLE public.cs_dynamic_children_helper OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 260888)
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
-- TOC entry 224 (class 1259 OID 260896)
-- Name: cs_icon; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_icon (
    id integer DEFAULT nextval('cs_icon_sequence'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    file_name character varying(100) DEFAULT 'default_icon.gif'::character varying NOT NULL
);


ALTER TABLE public.cs_icon OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 260903)
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
-- TOC entry 228 (class 1259 OID 260913)
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
-- TOC entry 229 (class 1259 OID 260920)
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
-- TOC entry 231 (class 1259 OID 260933)
-- Name: cs_method_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_method_class_assoc (
    class_id integer NOT NULL,
    method_id integer NOT NULL,
    id integer DEFAULT nextval('cs_method_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_method_class_assoc OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 260941)
-- Name: cs_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_permission (
    id integer DEFAULT nextval('cs_permission_sequence'::regclass) NOT NULL,
    key character varying(10),
    description character varying(100)
);


ALTER TABLE public.cs_permission OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 260947)
-- Name: cs_policy; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_policy (
    id integer DEFAULT nextval('cs_policy_sequence'::regclass) NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.cs_policy OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 260953)
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
-- TOC entry 239 (class 1259 OID 260957)
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
-- TOC entry 241 (class 1259 OID 260972)
-- Name: cs_query_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_class_assoc (
    class_id integer NOT NULL,
    query_id integer NOT NULL,
    id integer DEFAULT nextval('cs_query_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_query_class_assoc OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 260978)
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
-- TOC entry 244 (class 1259 OID 260982)
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
-- TOC entry 248 (class 1259 OID 260997)
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
-- TOC entry 250 (class 1259 OID 261003)
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
-- TOC entry 252 (class 1259 OID 261009)
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
-- TOC entry 253 (class 1259 OID 261013)
-- Name: cs_stringrepcache; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_stringrepcache (
    class_id integer NOT NULL,
    object_id integer NOT NULL,
    stringrep character varying(512)
);


ALTER TABLE public.cs_stringrepcache OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 261019)
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
-- TOC entry 257 (class 1259 OID 261031)
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
-- TOC entry 258 (class 1259 OID 261038)
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
-- TOC entry 260 (class 1259 OID 261044)
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
-- TOC entry 263 (class 1259 OID 261052)
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
-- TOC entry 265 (class 1259 OID 261058)
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
-- TOC entry 266 (class 1259 OID 261062)
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
-- TOC entry 268 (class 1259 OID 261068)
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
-- TOC entry 3783 (class 0 OID 260763)
-- Dependencies: 194
-- Data for Name: cs_all_attr_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3784 (class 0 OID 260767)
-- Dependencies: 195
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
INSERT INTO cs_attr VALUES (77, 16, 23, 'tags', 'tags', true, false, 9, '', true, false, true, 'relationship_reference', NULL, NULL, NULL, false, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (40, 20, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (45, 8, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (43, 4, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (33, 20, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, 64, NULL, false);
INSERT INTO cs_attr VALUES (46, 18, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (75, 18, 22, 'metadata', 'metadata', true, false, 7, '', true, false, true, 'resource_reference', NULL, NULL, NULL, false, NULL, NULL, 14, NULL, NULL, false);
INSERT INTO cs_attr VALUES (88, 11, 2, 'resource_reference', 'resource_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (39, 19, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, 200, NULL, false);
INSERT INTO cs_attr VALUES (86, 12, 2, 'resource_reference', 'resource_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (68, 8, 28, 'tagid', 'tagid', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (73, 18, 36, 'tags', 'tags', true, false, 12, '', true, false, true, 'resource_reference', NULL, NULL, NULL, false, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (87, 10, 2, 'representation_reference', 'representation_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (61, 11, 33, 'repid', 'repid', true, false, 17, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (84, 7, 2, 'resource_reference', 'resource_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (31, 18, 8, 'uuid', 'uuid', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, 100, NULL, false);
INSERT INTO cs_attr VALUES (90, 5, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (10, 4, 8, 'organisation', 'organisation', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 2, 100, NULL, false);
INSERT INTO cs_attr VALUES (30, 18, 14, 'lastmodificationdate', 'lastmodificationdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 10, NULL, NULL, false);
INSERT INTO cs_attr VALUES (15, 4, 8, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 3, 200, NULL, false);
INSERT INTO cs_attr VALUES (62, 9, 28, 'tagid', 'tagid', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (53, 9, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (59, 10, 28, 'tagid', 'tagid', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (41, 19, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (63, 7, 26, 'metaid', 'metaid', true, false, 15, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (44, 15, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (47, 12, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (57, 18, 19, 'spatialcoverage', 'spatialcoverage', true, false, 1, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (22, 18, 14, 'fromdate', 'fromdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (69, 6, 26, 'metaid', 'metaid', true, false, 15, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (32, 18, 14, 'publicationdate', 'publicationdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 9, NULL, NULL, false);
INSERT INTO cs_attr VALUES (50, 10, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (65, 12, 28, 'tagid', 'tagid', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (80, 16, 21, 'metadata', 'metadata', true, false, 6, '', true, false, true, 'relationship_reference', NULL, NULL, NULL, false, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (81, 8, 2, 'metadata_reference', 'metadata_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (16, 16, 8, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 2, 200, NULL, false);
INSERT INTO cs_attr VALUES (55, 5, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (64, 18, 29, 'contact', 'contact', true, false, 4, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 11, NULL, NULL, false);
INSERT INTO cs_attr VALUES (20, 18, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, 150, NULL, false);
INSERT INTO cs_attr VALUES (26, 18, 9, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (38, 16, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 1, 150, NULL, false);
INSERT INTO cs_attr VALUES (51, 11, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (60, 5, 34, 'resid', 'resid', true, false, 18, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (83, 6, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (89, 9, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (52, 16, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (48, 7, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (54, 6, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (74, 18, 30, 'representation', 'representation', true, false, 11, '', true, false, true, 'resource_reference', NULL, NULL, NULL, false, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr VALUES (19, 20, 8, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 2, 800, NULL, false);
INSERT INTO cs_attr VALUES (49, 17, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (28, 15, 9, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (37, 4, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, 64, NULL, false);
INSERT INTO cs_attr VALUES (58, 18, 28, 'accessConditions', 'accessconditions', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 13, NULL, NULL, false);
INSERT INTO cs_attr VALUES (78, 16, 32, 'fromResources', 'fromresources', true, false, 5, '', true, false, true, 'relationship_reference', NULL, NULL, NULL, false, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (70, 15, 29, 'contact', 'contact', true, false, 4, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 13, NULL, NULL, false);
INSERT INTO cs_attr VALUES (18, 15, 9, 'content', 'content', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 11, NULL, NULL, false);
INSERT INTO cs_attr VALUES (27, 17, 9, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (76, 17, 20, 'tags', 'tags', true, false, 10, '', true, false, true, 'representation_reference', NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (34, 17, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, 150, NULL, false);
INSERT INTO cs_attr VALUES (25, 17, 9, 'content', 'content', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 10, NULL, NULL, false);
INSERT INTO cs_attr VALUES (11, 15, 14, 'creationDate', 'creationdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr VALUES (29, 15, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 3, 150, NULL, false);
INSERT INTO cs_attr VALUES (72, 15, 31, 'tags', 'tags', true, false, 8, '', true, false, true, 'metadata_reference', NULL, NULL, NULL, false, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (14, 18, 14, 'todate', 'todate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (23, 18, 14, 'creationdate', 'creationdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 8, NULL, NULL, false);
INSERT INTO cs_attr VALUES (12, 19, 8, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 2, 500, NULL, false);
INSERT INTO cs_attr VALUES (97, 4, 28, 'role', 'role', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (100, 17, 28, 'contentType', 'contenttype', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (98, 19, 27, 'taggroup', 'taggroup', true, false, 20, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (102, 16, 34, 'toResource', 'toresource', true, false, 18, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (106, 16, 28, 'type', 'type', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 8, NULL, NULL, false);
INSERT INTO cs_attr VALUES (107, 16, 28, 'applicationProfile', 'applicationprofile', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 9, NULL, NULL, false);
INSERT INTO cs_attr VALUES (112, 18, 28, 'scope', 'scope', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 17, NULL, NULL, false);
INSERT INTO cs_attr VALUES (113, 18, 28, 'geography', 'geography', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 20, NULL, NULL, false);
INSERT INTO cs_attr VALUES (114, 18, 28, 'language', 'language', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 21, NULL, NULL, false);
INSERT INTO cs_attr VALUES (115, 18, 28, 'conformity', 'conformity', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 23, NULL, NULL, false);
INSERT INTO cs_attr VALUES (116, 18, 8, 'spatialResolution', 'spatialresolution', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 22, 100, NULL, false);
INSERT INTO cs_attr VALUES (117, 18, 28, 'srid', 'srid', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 16, NULL, NULL, false);
INSERT INTO cs_attr VALUES (118, 18, 28, 'accessLimitations', 'accesslimitations', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 19, NULL, NULL, false);
INSERT INTO cs_attr VALUES (119, 18, 28, 'location', 'location', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 18, NULL, NULL, false);
INSERT INTO cs_attr VALUES (122, 18, 9, 'licenseStatement', 'licensestatement', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 24, NULL, NULL, false);
INSERT INTO cs_attr VALUES (121, 17, 8, 'uuid', 'uuid', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 50, NULL, false);
INSERT INTO cs_attr VALUES (111, 17, 28, 'type', 'type', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (123, 15, 8, 'uuid', 'uuid', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 2, 100, NULL, false);
INSERT INTO cs_attr VALUES (104, 15, 28, 'type', 'type', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (124, 4, 18, 'url', 'url', true, false, 2, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (125, 4, 8, 'email', 'email', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 8, 50, NULL, false);
INSERT INTO cs_attr VALUES (99, 15, 28, 'contentType', 'contenttype', true, false, 19, NULL, true, true, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 8, NULL, NULL, false);
INSERT INTO cs_attr VALUES (126, 17, 18, 'contentLocation', 'contentlocation', true, false, 2, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 9, NULL, NULL, false);
INSERT INTO cs_attr VALUES (109, 17, 28, 'protocol', 'protocol', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 11, NULL, NULL, false);
INSERT INTO cs_attr VALUES (110, 17, 28, 'applicationProfile', 'applicationprofile', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 13, NULL, NULL, false);
INSERT INTO cs_attr VALUES (108, 17, 28, 'function', 'function', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr VALUES (127, 15, 18, 'contentLocation', 'contentlocation', true, false, 2, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 10, NULL, NULL, false);
INSERT INTO cs_attr VALUES (105, 15, 28, 'standard', 'standard', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 15, NULL, NULL, false);
INSERT INTO cs_attr VALUES (103, 15, 28, 'language', 'language', true, false, 19, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 14, NULL, NULL, false);


--
-- TOC entry 3785 (class 0 OID 260782)
-- Dependencies: 196
-- Data for Name: cs_attr_object; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3786 (class 0 OID 260785)
-- Dependencies: 197
-- Data for Name: cs_attr_object_derived; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3787 (class 0 OID 260790)
-- Dependencies: 199
-- Data for Name: cs_attr_string; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3788 (class 0 OID 260798)
-- Dependencies: 201
-- Data for Name: cs_cat_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3789 (class 0 OID 260805)
-- Dependencies: 202
-- Data for Name: cs_cat_node; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_cat_node VALUES (4, 'z', 1, 2, 2, 'O', false, '', 'SELECT 
	-1 as id, 
	tag.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.hydrologicalconcepts(tag.id) as dynamic_children,
	false as sql_sort 
    FROM 
	tag
	LEFT JOIN jt_tag_taggroup as jttt ON
		jttt.tag_reference = tag.id	
	LEFT JOIN taggroup ON
		jttt.tgid = taggroup.id,
        cs_class
    WHERE
        cs_class.name = ''tag'' AND
	taggroup.name = ''geography''
    GROUP BY 
	tag.name,
	tag.id,
        cs_class.id;', true, NULL, false, NULL, '', '');
INSERT INTO cs_cat_node VALUES (1, 'Switch-On', NULL, NULL, NULL, 'N', true, '', 'SELECT 
	-1 as id, 
	tag.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.hydrologicalconcepts(tag.id) as dynamic_children,
	false as sql_sort 
    FROM 
	tag
	LEFT JOIN jt_tag_taggroup as jttt ON
		jttt.tag_reference = tag.id	
	LEFT JOIN taggroup ON
		jttt.tgid = taggroup.id,
        cs_class
    WHERE
        cs_class.name = ''tag'' AND
	taggroup.name = ''geography''
    GROUP BY 
	tag.name,
	tag.id,
        cs_class.id;', true, NULL, false, NULL, '', '');
INSERT INTO cs_cat_node VALUES (2, 'x', 1, 1, 1, 'O', false, '', NULL, true, NULL, false, NULL, '', '');
INSERT INTO cs_cat_node VALUES (3, 'y', 1, 1, 2, 'O', false, '', NULL, true, NULL, false, NULL, '', '');


--
-- TOC entry 3790 (class 0 OID 260818)
-- Dependencies: 204
-- Data for Name: cs_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_class VALUES (1, 'GEOM', 'Cids Geodatentyp', 1, 1, 'GEOM', 'ID', true, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (2, 'URL', NULL, 2, 2, 'URL', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (3, 'URL_BASE', NULL, 2, 2, 'URL_BASE', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (5, 'jt_fromresource_relationship', '''', 1, 1, 'JT_FROMRESOURCE_RELATIONSHIP', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (6, 'jt_metadata_relationship', '''', 1, 1, 'JT_METADATA_RELATIONSHIP', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (7, 'jt_metadata_resource', '''', 1, 1, 'JT_METADATA_RESOURCE', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (8, 'jt_metadata_tag', '''', 1, 1, 'JT_METADATA_TAG', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (9, 'jt_relationship_tag', '''', 1, 1, 'JT_RELATIONSHIP_TAG', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (10, 'jt_representation_tag', '''', 1, 1, 'JT_REPRESENTATION_TAG', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (11, 'jt_resource_representation', '''', 1, 1, 'JT_RESOURCE_REPRESENTATION', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (12, 'jt_resource_tag', '''', 1, 1, 'JT_RESOURCE_TAG', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (16, 'relationship', '''', 1, 1, 'RELATIONSHIP', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (18, 'resource', 'SWITCH-ON Main Resource Class', 1, 1, 'RESOURCE', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (17, 'representation', 'Representation of the Resourrce', 1, 1, 'REPRESENTATION', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (15, 'metadata', 'Additional Quality, Lineage and Origin Meta-Data', 1, 1, 'METADATA', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (19, 'tag', 'Tags', 1, 1, 'TAG', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (20, 'taggroup', 'Tag Group', 1, 1, 'TAGGROUP', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (4, 'contact', 'Contact for Resources and Meta-Data', 1, 1, 'CONTACT', 'id', false, NULL, NULL, NULL, false, NULL, NULL);


--
-- TOC entry 3791 (class 0 OID 260830)
-- Dependencies: 206
-- Data for Name: cs_class_attr; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3792 (class 0 OID 260845)
-- Dependencies: 210
-- Data for Name: cs_config_attr_exempt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3793 (class 0 OID 260851)
-- Dependencies: 212
-- Data for Name: cs_config_attr_jt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3794 (class 0 OID 260857)
-- Dependencies: 214
-- Data for Name: cs_config_attr_key; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3795 (class 0 OID 260863)
-- Dependencies: 216
-- Data for Name: cs_config_attr_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_config_attr_type VALUES (1, 'C', 'regular configuration attribute, a simple string value');
INSERT INTO cs_config_attr_type VALUES (2, 'A', 'action tag configuration attribute, value of no relevance');
INSERT INTO cs_config_attr_type VALUES (3, 'X', 'XML configuration attribute, XML content wrapped by some root element');


--
-- TOC entry 3796 (class 0 OID 260869)
-- Dependencies: 218
-- Data for Name: cs_config_attr_value; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3797 (class 0 OID 260878)
-- Dependencies: 220
-- Data for Name: cs_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_domain VALUES (1, 'LOCAL');


--
-- TOC entry 3798 (class 0 OID 260882)
-- Dependencies: 221
-- Data for Name: cs_dynamic_children_helper; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_dynamic_children_helper VALUES (1, 'CidsObjects(class_id varchar, table_name varchar)', 'SELECT -1 AS id,
	name AS name,
	<ds::param name=''class_id''>1</ds::param> AS class_id,
	id AS object_id,
	''O'' AS node_type,
	null AS url,
	null AS dynamic_children,
	false AS sql_sort,
	true AS derive_permissions_from_class
	from <ds::param name=''table_name''>2</ds::param>
	order by id
	');
INSERT INTO cs_dynamic_children_helper VALUES (2, 'HydrologicalConcepts(level_id integer)', 'SELECT -1 AS id,
	tag.name AS name,
	cs_class.id AS class_id,
	NULL AS object_id,
	''N'' AS node_type,
	null AS url,
        csdc.entities(<ds::param name=''class_id''>1</ds::param> , tag.id) as dynamic_children, --first Tag = Level, second tag = hydroConc
	false AS sql_sort,
	true AS derive_permissions_from_class
    FROM
	tag
	LEFT JOIN jt_tag_taggroup as jttt ON
		jttt.tag_reference = tag.id	
	LEFT JOIN taggroup ON
		jttt.tgid = taggroup.id,
        cs_class
    WHERE
        cs_class.name = ''tag'' AND
	taggroup.name = ''hydrological concept''
    GROUP BY 
	tag.name,
	tag.id,
        cs_class.id;');
INSERT INTO cs_dynamic_children_helper VALUES (3, 'Entities(level_id integer, hydroCon_id integer)', 'SELECT -1 AS id,
	resource.name AS name,
	cs_class.id AS class_id,
	resource.id AS object_id,
	''O'' AS node_type,
	null AS url,
	NULL as dynamic_children, --first Tag = Level, second tag = hydroConc
	false AS sql_sort,
	true AS derive_permissions_from_class
    FROM 
	resource
	LEFT JOIN jt_resource_tag as jtrt_1 ON
		jtrt_1.resource_reference = resource.id
	LEFT JOIN tag as tag_1 ON
		jtrt_1.tagid = tag_1.id
	LEFT JOIN jt_resource_tag as jtrt_2 ON
		jtrt_2.resource_reference = resource.id
	LEFT JOIN tag as tag_2 ON
		jtrt_2.tagid = tag_2.id,
        cs_class
    WHERE
        cs_class.name = ''resource'' AND
	tag_1.id = <ds::param name=''level_id''>1</ds::param> AND
	tag_2.id = <ds::param name=''hydroCon_id''>2</ds::param> 
      Group by
	resource.name,
	resource.id,
        cs_class.id;');


--
-- TOC entry 3799 (class 0 OID 260888)
-- Dependencies: 222
-- Data for Name: cs_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3800 (class 0 OID 260896)
-- Dependencies: 224
-- Data for Name: cs_icon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_icon VALUES (1, 'Georeferenz', 'georeferenz_16.gif');
INSERT INTO cs_icon VALUES (2, 'Erde', 'erde_16.gif');


--
-- TOC entry 3801 (class 0 OID 260903)
-- Dependencies: 226
-- Data for Name: cs_java_class; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3802 (class 0 OID 260913)
-- Dependencies: 228
-- Data for Name: cs_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_locks VALUES (NULL, NULL, NULL, NULL, 1);
INSERT INTO cs_locks VALUES (NULL, NULL, 'ABF_EXCLUSIVE_LOCK_1404204781079', 'pascal@KNECHT-RUPRECHT', 16);


--
-- TOC entry 3803 (class 0 OID 260920)
-- Dependencies: 229
-- Data for Name: cs_method; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3804 (class 0 OID 260933)
-- Dependencies: 231
-- Data for Name: cs_method_class_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3805 (class 0 OID 260941)
-- Dependencies: 234
-- Data for Name: cs_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_permission VALUES (0, 'read', 'Leserecht');
INSERT INTO cs_permission VALUES (1, 'write', 'Schreibrecht');


--
-- TOC entry 3806 (class 0 OID 260947)
-- Dependencies: 236
-- Data for Name: cs_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_policy VALUES (0, 'STANDARD');
INSERT INTO cs_policy VALUES (1, 'WIKI');
INSERT INTO cs_policy VALUES (2, 'SECURE');


--
-- TOC entry 3807 (class 0 OID 260953)
-- Dependencies: 238
-- Data for Name: cs_policy_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_policy_rule VALUES (1, 0, 0, true);
INSERT INTO cs_policy_rule VALUES (2, 0, 1, false);
INSERT INTO cs_policy_rule VALUES (3, 1, 0, true);
INSERT INTO cs_policy_rule VALUES (4, 1, 1, true);
INSERT INTO cs_policy_rule VALUES (5, 2, 0, false);
INSERT INTO cs_policy_rule VALUES (6, 2, 1, false);


--
-- TOC entry 3808 (class 0 OID 260957)
-- Dependencies: 239
-- Data for Name: cs_query; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3809 (class 0 OID 260972)
-- Dependencies: 241
-- Data for Name: cs_query_class_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3810 (class 0 OID 260978)
-- Dependencies: 243
-- Data for Name: cs_query_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3811 (class 0 OID 260982)
-- Dependencies: 244
-- Data for Name: cs_query_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3812 (class 0 OID 260997)
-- Dependencies: 248
-- Data for Name: cs_query_store; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3813 (class 0 OID 261003)
-- Dependencies: 250
-- Data for Name: cs_query_store_ug_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3814 (class 0 OID 261009)
-- Dependencies: 252
-- Data for Name: cs_query_ug_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3815 (class 0 OID 261013)
-- Dependencies: 253
-- Data for Name: cs_stringrepcache; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3816 (class 0 OID 261019)
-- Dependencies: 254
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
INSERT INTO cs_type VALUES (20, 'JT_REPRESENTATION_TAG', 10, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (21, 'JT_METADATA_RELATIONSHIP', 6, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (22, 'JT_METADATA_RESOURCE', 7, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (23, 'JT_RELATIONSHIP_TAG', 9, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (30, 'JT_RESOURCE_REPRESENTATION', 11, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (31, 'JT_METADATA_TAG', 8, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (32, 'JT_FROMRESOURCE_RELATIONSHIP', 5, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (36, 'JT_RESOURCE_TAG', 12, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (28, 'tag', 19, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (27, 'taggroup', 20, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (29, 'contact', 4, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (26, 'metadata', 15, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (33, 'representation', 17, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (34, 'resource', 18, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (35, 'relationship', 16, true, '''', NULL, NULL);


--
-- TOC entry 3817 (class 0 OID 261031)
-- Dependencies: 257
-- Data for Name: cs_ug; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug VALUES (1, 'Administratoren', NULL, 1, 0);
INSERT INTO cs_ug VALUES (2, 'Gäste', NULL, 1, 1);


--
-- TOC entry 3818 (class 0 OID 261038)
-- Dependencies: 258
-- Data for Name: cs_ug_attr_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3819 (class 0 OID 261044)
-- Dependencies: 260
-- Data for Name: cs_ug_cat_node_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3820 (class 0 OID 261052)
-- Dependencies: 263
-- Data for Name: cs_ug_class_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3821 (class 0 OID 261058)
-- Dependencies: 265
-- Data for Name: cs_ug_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug_membership VALUES (1, 1, NULL, 1);
INSERT INTO cs_ug_membership VALUES (2, 2, NULL, 2);


--
-- TOC entry 3822 (class 0 OID 261062)
-- Dependencies: 266
-- Data for Name: cs_ug_method_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3823 (class 0 OID 261068)
-- Dependencies: 268
-- Data for Name: cs_usr; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_usr VALUES (1, 'admin', 'cismet', '2014-05-26 09:38:00.104', true);
INSERT INTO cs_usr VALUES (2, 'gast', 'cismet', '2014-05-26 09:38:00.104', false);


--
-- TOC entry 3481 (class 0 OID 259563)
-- Dependencies: 173
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3641 (class 2606 OID 261241)
-- Name: attr_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_attr_perm
    ADD CONSTRAINT attr_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3643 (class 2606 OID 261243)
-- Name: cat_node_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_cat_node_perm
    ADD CONSTRAINT cat_node_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3631 (class 2606 OID 261245)
-- Name: cid_oid; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_stringrepcache
    ADD CONSTRAINT cid_oid PRIMARY KEY (class_id, object_id);


--
-- TOC entry 3645 (class 2606 OID 261247)
-- Name: class_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_class_perm
    ADD CONSTRAINT class_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3553 (class 2606 OID 261251)
-- Name: cs_all_attr_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_all_attr_mapping
    ADD CONSTRAINT cs_all_attr_mapping_pkey PRIMARY KEY (id);


--
-- TOC entry 3564 (class 2606 OID 261253)
-- Name: cs_cat_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_link
    ADD CONSTRAINT cs_cat_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3575 (class 2606 OID 261255)
-- Name: cs_class_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class_attr
    ADD CONSTRAINT cs_class_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3577 (class 2606 OID 261257)
-- Name: cs_config_attr_exempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_pkey PRIMARY KEY (id);


--
-- TOC entry 3579 (class 2606 OID 261259)
-- Name: cs_config_attr_exempt_usr_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_key_id_key UNIQUE (usr_id, key_id);


--
-- TOC entry 3581 (class 2606 OID 261261)
-- Name: cs_config_attr_jt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_pkey PRIMARY KEY (id);


--
-- TOC entry 3583 (class 2606 OID 261263)
-- Name: cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key UNIQUE (usr_id, ug_id, dom_id, key_id);


--
-- TOC entry 3585 (class 2606 OID 261265)
-- Name: cs_config_attr_key_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_key
    ADD CONSTRAINT cs_config_attr_key_pkey PRIMARY KEY (id);


--
-- TOC entry 3587 (class 2606 OID 261267)
-- Name: cs_config_attr_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_type
    ADD CONSTRAINT cs_config_attr_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3589 (class 2606 OID 261269)
-- Name: cs_config_attr_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_value
    ADD CONSTRAINT cs_config_attr_value_pkey PRIMARY KEY (id);


--
-- TOC entry 3591 (class 2606 OID 261271)
-- Name: cs_domain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_domain
    ADD CONSTRAINT cs_domain_pkey PRIMARY KEY (id);


--
-- TOC entry 3593 (class 2606 OID 261273)
-- Name: cs_dynamic_children_helper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_dynamic_children_helper
    ADD CONSTRAINT cs_dynamic_children_helper_pkey PRIMARY KEY (id);


--
-- TOC entry 3595 (class 2606 OID 261275)
-- Name: cs_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_pkey PRIMARY KEY (class_id, object_id, valid_from);


--
-- TOC entry 3597 (class 2606 OID 261277)
-- Name: cs_icon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_icon
    ADD CONSTRAINT cs_icon_pkey PRIMARY KEY (id);


--
-- TOC entry 3599 (class 2606 OID 261279)
-- Name: cs_java_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_java_class
    ADD CONSTRAINT cs_java_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3601 (class 2606 OID 261281)
-- Name: cs_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_locks
    ADD CONSTRAINT cs_locks_pkey PRIMARY KEY (id);


--
-- TOC entry 3605 (class 2606 OID 261283)
-- Name: cs_method_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method_class_assoc
    ADD CONSTRAINT cs_method_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3607 (class 2606 OID 261285)
-- Name: cs_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_permission
    ADD CONSTRAINT cs_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3609 (class 2606 OID 261287)
-- Name: cs_policy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy
    ADD CONSTRAINT cs_policy_pkey PRIMARY KEY (id);


--
-- TOC entry 3611 (class 2606 OID 261289)
-- Name: cs_policy_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3613 (class 2606 OID 261291)
-- Name: cs_policy_rule_policy_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_policy_key UNIQUE (policy, permission);


--
-- TOC entry 3619 (class 2606 OID 261293)
-- Name: cs_query_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_class_assoc
    ADD CONSTRAINT cs_query_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3621 (class 2606 OID 261295)
-- Name: cs_query_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_link
    ADD CONSTRAINT cs_query_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3625 (class 2606 OID 261297)
-- Name: cs_query_store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store
    ADD CONSTRAINT cs_query_store_pkey PRIMARY KEY (id);


--
-- TOC entry 3627 (class 2606 OID 261299)
-- Name: cs_query_store_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store_ug_assoc
    ADD CONSTRAINT cs_query_store_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3629 (class 2606 OID 261301)
-- Name: cs_query_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_ug_assoc
    ADD CONSTRAINT cs_query_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3647 (class 2606 OID 261303)
-- Name: cs_ug_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_membership
    ADD CONSTRAINT cs_ug_membership_pkey PRIMARY KEY (id);


--
-- TOC entry 3637 (class 2606 OID 261305)
-- Name: cs_ug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_pkey PRIMARY KEY (id);


--
-- TOC entry 3639 (class 2606 OID 261307)
-- Name: cs_ug_prio_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_prio_key UNIQUE (prio);


--
-- TOC entry 3649 (class 2606 OID 261355)
-- Name: method_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_method_perm
    ADD CONSTRAINT method_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3555 (class 2606 OID 261371)
-- Name: x_cs_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_attr
    ADD CONSTRAINT x_cs_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3569 (class 2606 OID 261373)
-- Name: x_cs_cat_node_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_node
    ADD CONSTRAINT x_cs_cat_node_pkey PRIMARY KEY (id);


--
-- TOC entry 3571 (class 2606 OID 261375)
-- Name: x_cs_class_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_name_key UNIQUE (name);


--
-- TOC entry 3573 (class 2606 OID 261377)
-- Name: x_cs_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3603 (class 2606 OID 261379)
-- Name: x_cs_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method
    ADD CONSTRAINT x_cs_method_pkey PRIMARY KEY (id);


--
-- TOC entry 3615 (class 2606 OID 261381)
-- Name: x_cs_query_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_name_key UNIQUE (name);


--
-- TOC entry 3623 (class 2606 OID 261383)
-- Name: x_cs_query_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_parameter
    ADD CONSTRAINT x_cs_query_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 3617 (class 2606 OID 261385)
-- Name: x_cs_query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_pkey PRIMARY KEY (id);


--
-- TOC entry 3633 (class 2606 OID 261387)
-- Name: x_cs_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_name_key UNIQUE (name);


--
-- TOC entry 3635 (class 2606 OID 261389)
-- Name: x_cs_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3651 (class 2606 OID 261391)
-- Name: x_cs_usr_login_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_login_name_key UNIQUE (login_name);


--
-- TOC entry 3653 (class 2606 OID 261393)
-- Name: x_cs_usr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_pkey PRIMARY KEY (id);


--
-- TOC entry 3557 (class 1259 OID 261394)
-- Name: attr_object_derived_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index ON cs_attr_object_derived USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3558 (class 1259 OID 261395)
-- Name: attr_object_derived_index_acid_aoid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_acid_aoid ON cs_attr_object_derived USING btree (attr_class_id, attr_object_id);


--
-- TOC entry 3559 (class 1259 OID 261396)
-- Name: attr_object_derived_index_cid_oid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_cid_oid ON cs_attr_object_derived USING btree (class_id, object_id);


--
-- TOC entry 3556 (class 1259 OID 261397)
-- Name: attr_object_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_index ON cs_attr_object USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3565 (class 1259 OID 261398)
-- Name: cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cl_idx ON cs_cat_node USING btree (class_id);


--
-- TOC entry 3549 (class 1259 OID 261399)
-- Name: cs_all_attr_mapping_index1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index1 ON cs_all_attr_mapping USING btree (class_id);


--
-- TOC entry 3550 (class 1259 OID 261400)
-- Name: cs_all_attr_mapping_index2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index2 ON cs_all_attr_mapping USING btree (attr_class_id);


--
-- TOC entry 3551 (class 1259 OID 261401)
-- Name: cs_all_attr_mapping_index3; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index3 ON cs_all_attr_mapping USING btree (attr_object_id);


--
-- TOC entry 3560 (class 1259 OID 261402)
-- Name: cs_attr_string_class_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_class_idx ON cs_attr_string USING btree (class_id);


--
-- TOC entry 3561 (class 1259 OID 261403)
-- Name: cs_attr_string_object_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_object_idx ON cs_attr_string USING btree (object_id);


--
-- TOC entry 3562 (class 1259 OID 261405)
-- Name: i_cs_attr_string_aco_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX i_cs_attr_string_aco_id ON cs_attr_string USING btree (attr_id, class_id, object_id);


--
-- TOC entry 3566 (class 1259 OID 261406)
-- Name: ob_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ob_idx ON cs_cat_node USING btree (object_id);


--
-- TOC entry 3567 (class 1259 OID 261407)
-- Name: obj_cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX obj_cl_idx ON cs_cat_node USING btree (class_id, object_id);


--
-- TOC entry 3654 (class 2606 OID 261411)
-- Name: cs_config_attr_exempt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3655 (class 2606 OID 261416)
-- Name: cs_config_attr_exempt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3656 (class 2606 OID 261421)
-- Name: cs_config_attr_exempt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3657 (class 2606 OID 261426)
-- Name: cs_config_attr_jt_dom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_dom_id_fkey FOREIGN KEY (dom_id) REFERENCES cs_domain(id);


--
-- TOC entry 3658 (class 2606 OID 261431)
-- Name: cs_config_attr_jt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3659 (class 2606 OID 261436)
-- Name: cs_config_attr_jt_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_type_id_fkey FOREIGN KEY (type_id) REFERENCES cs_config_attr_type(id);


--
-- TOC entry 3660 (class 2606 OID 261441)
-- Name: cs_config_attr_jt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3661 (class 2606 OID 261446)
-- Name: cs_config_attr_jt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3662 (class 2606 OID 261451)
-- Name: cs_config_attr_jt_val_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_val_id_fkey FOREIGN KEY (val_id) REFERENCES cs_config_attr_value(id);


--
-- TOC entry 3663 (class 2606 OID 261456)
-- Name: cs_history_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_class_id_fkey FOREIGN KEY (class_id) REFERENCES cs_class(id);


--
-- TOC entry 3664 (class 2606 OID 261461)
-- Name: cs_history_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3665 (class 2606 OID 261466)
-- Name: cs_history_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


-- Completed on 2014-07-01 10:54:47

--
-- PostgreSQL database dump complete
--

