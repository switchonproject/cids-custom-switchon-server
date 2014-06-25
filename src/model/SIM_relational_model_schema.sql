--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.3
-- Dumped by pg_dump version 9.3.1
-- Started on 2014-06-25 14:40:46

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
-- TOC entry 209 (class 1259 OID 211645)
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
-- TOC entry 212 (class 1259 OID 211655)
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
-- TOC entry 210 (class 1259 OID 211649)
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
-- TOC entry 211 (class 1259 OID 211652)
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
-- TOC entry 213 (class 1259 OID 211670)
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
-- TOC entry 215 (class 1259 OID 211678)
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
-- TOC entry 216 (class 1259 OID 211685)
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
-- TOC entry 217 (class 1259 OID 211696)
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
-- TOC entry 219 (class 1259 OID 211708)
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
-- TOC entry 291 (class 1259 OID 212141)
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
-- TOC entry 289 (class 1259 OID 212101)
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
-- TOC entry 283 (class 1259 OID 212074)
-- Name: cs_config_attr_key; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_key (
    id integer DEFAULT nextval('cs_config_attr_key_sequence'::regclass) NOT NULL,
    key character varying(200) NOT NULL
);


ALTER TABLE public.cs_config_attr_key OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 212093)
-- Name: cs_config_attr_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_type (
    id integer DEFAULT nextval('cs_config_attr_type_sequence'::regclass) NOT NULL,
    type character(1) NOT NULL,
    descr character varying(200)
);


ALTER TABLE public.cs_config_attr_type OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 212082)
-- Name: cs_config_attr_value; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_value (
    id integer DEFAULT nextval('cs_config_attr_value_sequence'::regclass) NOT NULL,
    value text
);


ALTER TABLE public.cs_config_attr_value OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 211717)
-- Name: cs_domain; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_domain (
    id integer DEFAULT nextval('cs_domain_sequence'::regclass) NOT NULL,
    name character varying(30)
);


ALTER TABLE public.cs_domain OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 212175)
-- Name: cs_dynamic_children_helper; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_dynamic_children_helper (
    id numeric NOT NULL,
    name character varying(256),
    code text
);


ALTER TABLE public.cs_dynamic_children_helper OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 212034)
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
-- TOC entry 223 (class 1259 OID 211723)
-- Name: cs_icon; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_icon (
    id integer DEFAULT nextval('cs_icon_sequence'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    file_name character varying(100) DEFAULT 'default_icon.gif'::character varying NOT NULL
);


ALTER TABLE public.cs_icon OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 211730)
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
-- TOC entry 227 (class 1259 OID 211740)
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
-- TOC entry 228 (class 1259 OID 211747)
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
-- TOC entry 230 (class 1259 OID 211760)
-- Name: cs_method_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_method_class_assoc (
    class_id integer NOT NULL,
    method_id integer NOT NULL,
    id integer DEFAULT nextval('cs_method_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_method_class_assoc OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 211766)
-- Name: cs_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_permission (
    id integer DEFAULT nextval('cs_permission_sequence'::regclass) NOT NULL,
    key character varying(10),
    description character varying(100)
);


ALTER TABLE public.cs_permission OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 211772)
-- Name: cs_policy; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_policy (
    id integer DEFAULT nextval('cs_policy_sequence'::regclass) NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.cs_policy OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 211778)
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
-- TOC entry 237 (class 1259 OID 211782)
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
-- TOC entry 239 (class 1259 OID 211797)
-- Name: cs_query_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_class_assoc (
    class_id integer NOT NULL,
    query_id integer NOT NULL,
    id integer DEFAULT nextval('cs_query_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_query_class_assoc OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 211803)
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
-- TOC entry 242 (class 1259 OID 211807)
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
-- TOC entry 244 (class 1259 OID 211818)
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
-- TOC entry 246 (class 1259 OID 211824)
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
-- TOC entry 248 (class 1259 OID 211830)
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
-- TOC entry 281 (class 1259 OID 212057)
-- Name: cs_stringrepcache; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_stringrepcache (
    class_id integer NOT NULL,
    object_id integer NOT NULL,
    stringrep character varying(512)
);


ALTER TABLE public.cs_stringrepcache OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 211834)
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
-- TOC entry 251 (class 1259 OID 211844)
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
-- TOC entry 252 (class 1259 OID 211853)
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
-- TOC entry 253 (class 1259 OID 211857)
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
-- TOC entry 255 (class 1259 OID 211863)
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
-- TOC entry 257 (class 1259 OID 211869)
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
-- TOC entry 258 (class 1259 OID 211873)
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
-- TOC entry 259 (class 1259 OID 211877)
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
-- TOC entry 3793 (class 0 OID 211645)
-- Dependencies: 209
-- Data for Name: cs_all_attr_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3796 (class 0 OID 211655)
-- Dependencies: 212
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
INSERT INTO cs_attr VALUES (36, 17, 8, 'contenttype', 'contenttype', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 4, 150, NULL, false);
INSERT INTO cs_attr VALUES (77, 16, 23, 'tags', 'tags', true, false, 9, '', true, false, true, 'relationship_reference', NULL, NULL, NULL, false, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (82, 13, 2, 'tag_reference', 'tag_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (27, 17, 9, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (40, 20, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (17, 15, 8, 'contentlocation', 'contentlocation', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 7, 200, NULL, false);
INSERT INTO cs_attr VALUES (78, 16, 32, 'fromresource', 'fromresource', true, false, 5, '', true, false, true, 'relationship_reference', NULL, NULL, NULL, false, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (35, 4, 8, 'email', 'email', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (45, 8, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (43, 4, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (21, 15, 8, 'contenttype', 'contenttype', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 6, 200, NULL, false);
INSERT INTO cs_attr VALUES (37, 4, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 1, 64, NULL, false);
INSERT INTO cs_attr VALUES (33, 20, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, 64, NULL, false);
INSERT INTO cs_attr VALUES (46, 18, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (75, 18, 22, 'metadata', 'metadata', true, false, 7, '', true, false, true, 'resource_reference', NULL, NULL, NULL, false, NULL, NULL, 14, NULL, NULL, false);
INSERT INTO cs_attr VALUES (88, 11, 2, 'resource_reference', 'resource_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (39, 19, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, 200, NULL, false);
INSERT INTO cs_attr VALUES (86, 12, 2, 'resource_reference', 'resource_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (56, 14, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (68, 8, 28, 'tagid', 'tagid', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (73, 18, 36, 'tags', 'tags', true, false, 12, '', true, false, true, 'resource_reference', NULL, NULL, NULL, false, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (87, 10, 2, 'representation_reference', 'representation_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (61, 11, 33, 'repid', 'repid', true, false, 17, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (84, 7, 2, 'resource_reference', 'resource_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (31, 18, 8, 'uuid', 'uuid', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, 100, NULL, false);
INSERT INTO cs_attr VALUES (66, 14, 34, 'resid', 'resid', true, false, 18, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (34, 17, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, 150, NULL, false);
INSERT INTO cs_attr VALUES (90, 5, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (10, 4, 8, 'organisation', 'organisation', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 2, 100, NULL, false);
INSERT INTO cs_attr VALUES (18, 15, 9, 'content', 'content', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 8, NULL, NULL, false);
INSERT INTO cs_attr VALUES (30, 18, 14, 'lastmodificationdate', 'lastmodificationdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 10, NULL, NULL, false);
INSERT INTO cs_attr VALUES (15, 4, 8, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 3, 200, NULL, false);
INSERT INTO cs_attr VALUES (62, 9, 28, 'tagid', 'tagid', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (70, 15, 29, 'contact', 'contact', true, false, 4, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr VALUES (53, 9, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (59, 10, 28, 'tagid', 'tagid', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (28, 15, 9, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (13, 17, 8, 'contentlocation', 'contentlocation', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 5, 200, NULL, false);
INSERT INTO cs_attr VALUES (79, 16, 24, 'toresource', 'toresource', true, false, 14, '', true, false, true, 'relationship_reference', NULL, NULL, NULL, false, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (29, 15, 8, 'name', 'name', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, 150, NULL, false);
INSERT INTO cs_attr VALUES (41, 19, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (63, 7, 26, 'metaid', 'metaid', true, false, 15, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (44, 15, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (47, 12, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (25, 17, 9, 'content', 'content', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (57, 18, 19, 'spatialcoverage', 'spatialcoverage', true, false, 1, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (22, 18, 14, 'fromdate', 'fromdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (69, 6, 26, 'metaid', 'metaid', true, false, 15, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr VALUES (32, 18, 14, 'publicationdate', 'publicationdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 9, NULL, NULL, false);
INSERT INTO cs_attr VALUES (50, 10, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (24, 4, 8, 'url', 'url', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 5, 150, NULL, false);
INSERT INTO cs_attr VALUES (42, 13, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (65, 12, 28, 'tagid', 'tagid', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (80, 16, 21, 'metadata', 'metadata', true, false, 6, '', true, false, true, 'relationship_reference', NULL, NULL, NULL, false, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr VALUES (85, 14, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
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
INSERT INTO cs_attr VALUES (11, 15, 14, 'creationdate', 'creationdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr VALUES (76, 17, 20, 'tags', 'tags', true, false, 10, '', true, false, true, 'representation_reference', NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (67, 13, 27, 'tgid', 'tgid', true, false, 20, '', true, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (58, 18, 28, 'license', 'license', true, false, 19, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 13, NULL, NULL, false);
INSERT INTO cs_attr VALUES (52, 16, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (72, 15, 31, 'tags', 'tags', true, false, 8, '', true, false, true, 'metadata_reference', NULL, NULL, NULL, false, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr VALUES (48, 7, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (54, 6, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (74, 18, 30, 'representation', 'representation', true, false, 11, '', true, false, true, 'resource_reference', NULL, NULL, NULL, false, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr VALUES (71, 19, 25, 'taggroup', 'taggroup', true, false, 13, '', true, false, true, 'tag_reference', NULL, NULL, NULL, false, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr VALUES (19, 20, 8, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 2, 800, NULL, false);
INSERT INTO cs_attr VALUES (49, 17, 4, 'id', 'id', false, false, NULL, 'Primärschlüssel', false, false, false, '', NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr VALUES (14, 18, 14, 'todate', 'todate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr VALUES (23, 18, 14, 'creationdate', 'creationdate', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 8, NULL, NULL, false);
INSERT INTO cs_attr VALUES (12, 19, 8, 'description', 'description', false, false, NULL, '', true, false, false, '', NULL, NULL, NULL, true, NULL, NULL, 2, 500, NULL, false);


--
-- TOC entry 3794 (class 0 OID 211649)
-- Dependencies: 210
-- Data for Name: cs_attr_object; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3795 (class 0 OID 211652)
-- Dependencies: 211
-- Data for Name: cs_attr_object_derived; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3797 (class 0 OID 211670)
-- Dependencies: 213
-- Data for Name: cs_attr_string; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3798 (class 0 OID 211678)
-- Dependencies: 215
-- Data for Name: cs_cat_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3799 (class 0 OID 211685)
-- Dependencies: 216
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
-- TOC entry 3800 (class 0 OID 211696)
-- Dependencies: 217
-- Data for Name: cs_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_class VALUES (1, 'GEOM', 'Cids Geodatentyp', 1, 1, 'GEOM', 'ID', true, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (2, 'URL', NULL, 2, 2, 'URL', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (3, 'URL_BASE', NULL, 2, 2, 'URL_BASE', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (4, 'contact', '''', 1, 1, 'CONTACT', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (5, 'jt_fromresource_relationship', '''', 1, 1, 'JT_FROMRESOURCE_RELATIONSHIP', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (6, 'jt_metadata_relationship', '''', 1, 1, 'JT_METADATA_RELATIONSHIP', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (7, 'jt_metadata_resource', '''', 1, 1, 'JT_METADATA_RESOURCE', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (8, 'jt_metadata_tag', '''', 1, 1, 'JT_METADATA_TAG', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (9, 'jt_relationship_tag', '''', 1, 1, 'JT_RELATIONSHIP_TAG', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (10, 'jt_representation_tag', '''', 1, 1, 'JT_REPRESENTATION_TAG', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (11, 'jt_resource_representation', '''', 1, 1, 'JT_RESOURCE_REPRESENTATION', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (12, 'jt_resource_tag', '''', 1, 1, 'JT_RESOURCE_TAG', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (13, 'jt_tag_taggroup', '''', 1, 1, 'JT_TAG_TAGGROUP', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (14, 'jt_toresource_relationship', '''', 1, 1, 'JT_TORESOURCE_RELATIONSHIP', 'id', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class VALUES (15, 'metadata', '''', 1, 1, 'METADATA', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (16, 'relationship', '''', 1, 1, 'RELATIONSHIP', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (17, 'representation', '''', 1, 1, 'REPRESENTATION', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (18, 'resource', '''', 1, 1, 'RESOURCE', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (19, 'tag', '''', 1, 1, 'TAG', 'id', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class VALUES (20, 'taggroup', '''', 1, 1, 'TAGGROUP', 'id', false, NULL, NULL, NULL, false, NULL, NULL);


--
-- TOC entry 3801 (class 0 OID 211708)
-- Dependencies: 219
-- Data for Name: cs_class_attr; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3832 (class 0 OID 212141)
-- Dependencies: 291
-- Data for Name: cs_config_attr_exempt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3831 (class 0 OID 212101)
-- Dependencies: 289
-- Data for Name: cs_config_attr_jt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3828 (class 0 OID 212074)
-- Dependencies: 283
-- Data for Name: cs_config_attr_key; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3830 (class 0 OID 212093)
-- Dependencies: 287
-- Data for Name: cs_config_attr_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_config_attr_type VALUES (1, 'C', 'regular configuration attribute, a simple string value');
INSERT INTO cs_config_attr_type VALUES (2, 'A', 'action tag configuration attribute, value of no relevance');
INSERT INTO cs_config_attr_type VALUES (3, 'X', 'XML configuration attribute, XML content wrapped by some root element');


--
-- TOC entry 3829 (class 0 OID 212082)
-- Dependencies: 285
-- Data for Name: cs_config_attr_value; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3802 (class 0 OID 211717)
-- Dependencies: 221
-- Data for Name: cs_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_domain VALUES (1, 'LOCAL');


--
-- TOC entry 3833 (class 0 OID 212175)
-- Dependencies: 292
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
-- TOC entry 3826 (class 0 OID 212034)
-- Dependencies: 280
-- Data for Name: cs_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3803 (class 0 OID 211723)
-- Dependencies: 223
-- Data for Name: cs_icon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_icon VALUES (1, 'Georeferenz', 'georeferenz_16.gif');
INSERT INTO cs_icon VALUES (2, 'Erde', 'erde_16.gif');


--
-- TOC entry 3804 (class 0 OID 211730)
-- Dependencies: 225
-- Data for Name: cs_java_class; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3805 (class 0 OID 211740)
-- Dependencies: 227
-- Data for Name: cs_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_locks VALUES (NULL, NULL, NULL, NULL, 1);


--
-- TOC entry 3806 (class 0 OID 211747)
-- Dependencies: 228
-- Data for Name: cs_method; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3807 (class 0 OID 211760)
-- Dependencies: 230
-- Data for Name: cs_method_class_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3808 (class 0 OID 211766)
-- Dependencies: 232
-- Data for Name: cs_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_permission VALUES (0, 'read', 'Leserecht');
INSERT INTO cs_permission VALUES (1, 'write', 'Schreibrecht');


--
-- TOC entry 3809 (class 0 OID 211772)
-- Dependencies: 234
-- Data for Name: cs_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_policy VALUES (0, 'STANDARD');
INSERT INTO cs_policy VALUES (1, 'WIKI');
INSERT INTO cs_policy VALUES (2, 'SECURE');


--
-- TOC entry 3810 (class 0 OID 211778)
-- Dependencies: 236
-- Data for Name: cs_policy_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_policy_rule VALUES (1, 0, 0, true);
INSERT INTO cs_policy_rule VALUES (2, 0, 1, false);
INSERT INTO cs_policy_rule VALUES (3, 1, 0, true);
INSERT INTO cs_policy_rule VALUES (4, 1, 1, true);
INSERT INTO cs_policy_rule VALUES (5, 2, 0, false);
INSERT INTO cs_policy_rule VALUES (6, 2, 1, false);


--
-- TOC entry 3811 (class 0 OID 211782)
-- Dependencies: 237
-- Data for Name: cs_query; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3812 (class 0 OID 211797)
-- Dependencies: 239
-- Data for Name: cs_query_class_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3813 (class 0 OID 211803)
-- Dependencies: 241
-- Data for Name: cs_query_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3814 (class 0 OID 211807)
-- Dependencies: 242
-- Data for Name: cs_query_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3815 (class 0 OID 211818)
-- Dependencies: 244
-- Data for Name: cs_query_store; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3816 (class 0 OID 211824)
-- Dependencies: 246
-- Data for Name: cs_query_store_ug_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3817 (class 0 OID 211830)
-- Dependencies: 248
-- Data for Name: cs_query_ug_assoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3827 (class 0 OID 212057)
-- Dependencies: 281
-- Data for Name: cs_stringrepcache; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3818 (class 0 OID 211834)
-- Dependencies: 249
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
INSERT INTO cs_type VALUES (24, 'JT_TORESOURCE_RELATIONSHIP', 14, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (25, 'JT_TAG_TAGGROUP', 13, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (26, 'METADATA', 15, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (27, 'TAGGROUP', 20, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (28, 'TAG', 19, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (29, 'CONTACT', 4, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (30, 'JT_RESOURCE_REPRESENTATION', 11, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (31, 'JT_METADATA_TAG', 8, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (32, 'JT_FROMRESOURCE_RELATIONSHIP', 5, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (33, 'REPRESENTATION', 17, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (34, 'RESOURCE', 18, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (35, 'RELATIONSHIP', 16, true, '''', NULL, NULL);
INSERT INTO cs_type VALUES (36, 'JT_RESOURCE_TAG', 12, true, '''', NULL, NULL);


--
-- TOC entry 3819 (class 0 OID 211844)
-- Dependencies: 251
-- Data for Name: cs_ug; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug VALUES (1, 'Administratoren', NULL, 1, 0);
INSERT INTO cs_ug VALUES (2, 'Gäste', NULL, 1, 1);


--
-- TOC entry 3820 (class 0 OID 211853)
-- Dependencies: 252
-- Data for Name: cs_ug_attr_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3821 (class 0 OID 211857)
-- Dependencies: 253
-- Data for Name: cs_ug_cat_node_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3822 (class 0 OID 211863)
-- Dependencies: 255
-- Data for Name: cs_ug_class_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3823 (class 0 OID 211869)
-- Dependencies: 257
-- Data for Name: cs_ug_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_ug_membership VALUES (1, 1, NULL, 1);
INSERT INTO cs_ug_membership VALUES (2, 2, NULL, 2);


--
-- TOC entry 3824 (class 0 OID 211873)
-- Dependencies: 258
-- Data for Name: cs_ug_method_perm; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3825 (class 0 OID 211877)
-- Dependencies: 259
-- Data for Name: cs_usr; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cs_usr VALUES (1, 'admin', 'cismet', '2014-05-26 09:38:00.104', true);
INSERT INTO cs_usr VALUES (2, 'gast', 'cismet', '2014-05-26 09:38:00.104', false);


--
-- TOC entry 3490 (class 0 OID 210440)
-- Dependencies: 173
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3630 (class 2606 OID 211905)
-- Name: attr_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_attr_perm
    ADD CONSTRAINT attr_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3632 (class 2606 OID 211907)
-- Name: cat_node_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_cat_node_perm
    ADD CONSTRAINT cat_node_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3646 (class 2606 OID 212064)
-- Name: cid_oid; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_stringrepcache
    ADD CONSTRAINT cid_oid PRIMARY KEY (class_id, object_id);


--
-- TOC entry 3634 (class 2606 OID 211909)
-- Name: class_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_class_perm
    ADD CONSTRAINT class_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3562 (class 2606 OID 211911)
-- Name: cs_all_attr_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_all_attr_mapping
    ADD CONSTRAINT cs_all_attr_mapping_pkey PRIMARY KEY (id);


--
-- TOC entry 3573 (class 2606 OID 211913)
-- Name: cs_cat_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_link
    ADD CONSTRAINT cs_cat_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3584 (class 2606 OID 211915)
-- Name: cs_class_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class_attr
    ADD CONSTRAINT cs_class_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3658 (class 2606 OID 212146)
-- Name: cs_config_attr_exempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_pkey PRIMARY KEY (id);


--
-- TOC entry 3660 (class 2606 OID 212148)
-- Name: cs_config_attr_exempt_usr_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_key_id_key UNIQUE (usr_id, key_id);


--
-- TOC entry 3654 (class 2606 OID 212106)
-- Name: cs_config_attr_jt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_pkey PRIMARY KEY (id);


--
-- TOC entry 3656 (class 2606 OID 212108)
-- Name: cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key UNIQUE (usr_id, ug_id, dom_id, key_id);


--
-- TOC entry 3648 (class 2606 OID 212079)
-- Name: cs_config_attr_key_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_key
    ADD CONSTRAINT cs_config_attr_key_pkey PRIMARY KEY (id);


--
-- TOC entry 3652 (class 2606 OID 212098)
-- Name: cs_config_attr_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_type
    ADD CONSTRAINT cs_config_attr_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3650 (class 2606 OID 212090)
-- Name: cs_config_attr_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_value
    ADD CONSTRAINT cs_config_attr_value_pkey PRIMARY KEY (id);


--
-- TOC entry 3586 (class 2606 OID 211917)
-- Name: cs_domain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_domain
    ADD CONSTRAINT cs_domain_pkey PRIMARY KEY (id);


--
-- TOC entry 3662 (class 2606 OID 212182)
-- Name: cs_dynamic_children_helper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_dynamic_children_helper
    ADD CONSTRAINT cs_dynamic_children_helper_pkey PRIMARY KEY (id);


--
-- TOC entry 3644 (class 2606 OID 212041)
-- Name: cs_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_pkey PRIMARY KEY (class_id, object_id, valid_from);


--
-- TOC entry 3588 (class 2606 OID 211919)
-- Name: cs_icon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_icon
    ADD CONSTRAINT cs_icon_pkey PRIMARY KEY (id);


--
-- TOC entry 3590 (class 2606 OID 211921)
-- Name: cs_java_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_java_class
    ADD CONSTRAINT cs_java_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3592 (class 2606 OID 211923)
-- Name: cs_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_locks
    ADD CONSTRAINT cs_locks_pkey PRIMARY KEY (id);


--
-- TOC entry 3596 (class 2606 OID 211925)
-- Name: cs_method_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method_class_assoc
    ADD CONSTRAINT cs_method_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3598 (class 2606 OID 211927)
-- Name: cs_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_permission
    ADD CONSTRAINT cs_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3600 (class 2606 OID 211929)
-- Name: cs_policy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy
    ADD CONSTRAINT cs_policy_pkey PRIMARY KEY (id);


--
-- TOC entry 3602 (class 2606 OID 211931)
-- Name: cs_policy_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3604 (class 2606 OID 211933)
-- Name: cs_policy_rule_policy_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_policy_key UNIQUE (policy, permission);


--
-- TOC entry 3610 (class 2606 OID 211935)
-- Name: cs_query_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_class_assoc
    ADD CONSTRAINT cs_query_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3612 (class 2606 OID 211937)
-- Name: cs_query_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_link
    ADD CONSTRAINT cs_query_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3616 (class 2606 OID 211939)
-- Name: cs_query_store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store
    ADD CONSTRAINT cs_query_store_pkey PRIMARY KEY (id);


--
-- TOC entry 3618 (class 2606 OID 211941)
-- Name: cs_query_store_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store_ug_assoc
    ADD CONSTRAINT cs_query_store_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3620 (class 2606 OID 211943)
-- Name: cs_query_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_ug_assoc
    ADD CONSTRAINT cs_query_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3636 (class 2606 OID 211945)
-- Name: cs_ug_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_membership
    ADD CONSTRAINT cs_ug_membership_pkey PRIMARY KEY (id);


--
-- TOC entry 3626 (class 2606 OID 211947)
-- Name: cs_ug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_pkey PRIMARY KEY (id);


--
-- TOC entry 3628 (class 2606 OID 211852)
-- Name: cs_ug_prio_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_prio_key UNIQUE (prio);


--
-- TOC entry 3638 (class 2606 OID 211949)
-- Name: method_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_method_perm
    ADD CONSTRAINT method_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3568 (class 2606 OID 211951)
-- Name: x_cs_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_attr
    ADD CONSTRAINT x_cs_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3578 (class 2606 OID 211953)
-- Name: x_cs_cat_node_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_node
    ADD CONSTRAINT x_cs_cat_node_pkey PRIMARY KEY (id);


--
-- TOC entry 3580 (class 2606 OID 211955)
-- Name: x_cs_class_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_name_key UNIQUE (name);


--
-- TOC entry 3582 (class 2606 OID 211957)
-- Name: x_cs_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3594 (class 2606 OID 211959)
-- Name: x_cs_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method
    ADD CONSTRAINT x_cs_method_pkey PRIMARY KEY (id);


--
-- TOC entry 3606 (class 2606 OID 211961)
-- Name: x_cs_query_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_name_key UNIQUE (name);


--
-- TOC entry 3614 (class 2606 OID 211963)
-- Name: x_cs_query_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_parameter
    ADD CONSTRAINT x_cs_query_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 3608 (class 2606 OID 211965)
-- Name: x_cs_query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_pkey PRIMARY KEY (id);


--
-- TOC entry 3622 (class 2606 OID 211967)
-- Name: x_cs_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_name_key UNIQUE (name);


--
-- TOC entry 3624 (class 2606 OID 211969)
-- Name: x_cs_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3640 (class 2606 OID 211971)
-- Name: x_cs_usr_login_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_login_name_key UNIQUE (login_name);


--
-- TOC entry 3642 (class 2606 OID 211973)
-- Name: x_cs_usr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_pkey PRIMARY KEY (id);


--
-- TOC entry 3564 (class 1259 OID 211982)
-- Name: attr_object_derived_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index ON cs_attr_object_derived USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3565 (class 1259 OID 211983)
-- Name: attr_object_derived_index_acid_aoid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_acid_aoid ON cs_attr_object_derived USING btree (attr_class_id, attr_object_id);


--
-- TOC entry 3566 (class 1259 OID 211984)
-- Name: attr_object_derived_index_cid_oid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_cid_oid ON cs_attr_object_derived USING btree (class_id, object_id);


--
-- TOC entry 3563 (class 1259 OID 211981)
-- Name: attr_object_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_index ON cs_attr_object USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3574 (class 1259 OID 211974)
-- Name: cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cl_idx ON cs_cat_node USING btree (class_id);


--
-- TOC entry 3558 (class 1259 OID 211975)
-- Name: cs_all_attr_mapping_index1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index1 ON cs_all_attr_mapping USING btree (class_id);


--
-- TOC entry 3559 (class 1259 OID 211976)
-- Name: cs_all_attr_mapping_index2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index2 ON cs_all_attr_mapping USING btree (attr_class_id);


--
-- TOC entry 3560 (class 1259 OID 211977)
-- Name: cs_all_attr_mapping_index3; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index3 ON cs_all_attr_mapping USING btree (attr_object_id);


--
-- TOC entry 3569 (class 1259 OID 211985)
-- Name: cs_attr_string_class_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_class_idx ON cs_attr_string USING btree (class_id);


--
-- TOC entry 3570 (class 1259 OID 211986)
-- Name: cs_attr_string_object_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_object_idx ON cs_attr_string USING btree (object_id);


--
-- TOC entry 3571 (class 1259 OID 211978)
-- Name: i_cs_attr_string_aco_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX i_cs_attr_string_aco_id ON cs_attr_string USING btree (attr_id, class_id, object_id);


--
-- TOC entry 3575 (class 1259 OID 211979)
-- Name: ob_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ob_idx ON cs_cat_node USING btree (object_id);


--
-- TOC entry 3576 (class 1259 OID 211980)
-- Name: obj_cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX obj_cl_idx ON cs_cat_node USING btree (class_id, object_id);


--
-- TOC entry 3673 (class 2606 OID 212154)
-- Name: cs_config_attr_exempt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3674 (class 2606 OID 212159)
-- Name: cs_config_attr_exempt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3672 (class 2606 OID 212149)
-- Name: cs_config_attr_exempt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3668 (class 2606 OID 212119)
-- Name: cs_config_attr_jt_dom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_dom_id_fkey FOREIGN KEY (dom_id) REFERENCES cs_domain(id);


--
-- TOC entry 3669 (class 2606 OID 212124)
-- Name: cs_config_attr_jt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3671 (class 2606 OID 212134)
-- Name: cs_config_attr_jt_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_type_id_fkey FOREIGN KEY (type_id) REFERENCES cs_config_attr_type(id);


--
-- TOC entry 3667 (class 2606 OID 212114)
-- Name: cs_config_attr_jt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3666 (class 2606 OID 212109)
-- Name: cs_config_attr_jt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3670 (class 2606 OID 212129)
-- Name: cs_config_attr_jt_val_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_val_id_fkey FOREIGN KEY (val_id) REFERENCES cs_config_attr_value(id);


--
-- TOC entry 3663 (class 2606 OID 212042)
-- Name: cs_history_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_class_id_fkey FOREIGN KEY (class_id) REFERENCES cs_class(id);


--
-- TOC entry 3665 (class 2606 OID 212052)
-- Name: cs_history_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3664 (class 2606 OID 212047)
-- Name: cs_history_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


-- Completed on 2014-06-25 14:40:48

--
-- PostgreSQL database dump complete
--

