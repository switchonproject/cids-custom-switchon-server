--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.20
-- Dumped by pg_dump version 9.3.3
-- Started on 2014-08-22 14:13:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 3153 (class 0 OID 213112)
-- Dependencies: 145
-- Data for Name: cs_all_attr_mapping; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3156 (class 0 OID 213122)
-- Dependencies: 148
-- Data for Name: cs_attr; Type: TABLE DATA; Schema: public; Owner: switchon
--

INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (10, 4, 8, 'organisation', 'organisation', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 100, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (11, 4, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, 100, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (12, 4, 8, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, 200, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (13, 4, 8, 'email', 'email', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (14, 4, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (15, 4, 8, 'url', 'url', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, 1024, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (16, 5, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (17, 5, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 64, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (18, 5, 8, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, 800, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (19, 6, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 200, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (20, 6, 21, 'taggroup', 'taggroup', true, false, 5, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (21, 6, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (22, 6, 9, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (24, 4, 22, 'role', 'role', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (25, 7, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (27, 7, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 150, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (28, 7, 9, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (29, 7, 8, 'contentLocation', 'contentlocation', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 13, 1024, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (30, 7, 8, 'temporalResolution', 'temporalresolution', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 10, 100, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (31, 7, 22, 'protocol', 'protocol', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (32, 7, 9, 'content', 'content', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (33, 7, 2, 'spatialScale', 'spatialscale', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (34, 7, 22, 'function', 'function', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (35, 7, 8, 'uuid', 'uuid', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 9, 50, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (36, 7, 8, 'spatialResolution', 'spatialresolution', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 11, 100, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (37, 7, 22, 'applicationprofile', 'applicationprofile', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 8, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (38, 7, 22, 'type', 'type', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (39, 8, 22, 'tag', 'tagid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (40, 8, 2, 'representation_reference', 'representation_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (41, 8, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (42, 7, 24, 'tags', 'tags', true, false, 8, NULL, true, false, true, 'representation_reference', NULL, NULL, NULL, true, NULL, NULL, 14, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (43, 9, 22, 'tag', 'tagid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (44, 9, 2, 'resource_reference', 'resource_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (45, 9, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (46, 10, 22, 'tag', 'tagid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (47, 10, 2, 'metadata_reference', 'metadata_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (48, 10, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (49, 11, 22, 'tag', 'tagid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (50, 11, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (51, 11, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (52, 12, 23, 'representation', 'representationid', true, false, 7, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (53, 12, 2, 'resource_reference', 'resource_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (54, 12, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (55, 13, 22, 'type', 'type', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 9, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (56, 13, 14, 'fromDate', 'fromdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (57, 13, 22, 'location', 'location', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 10, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (58, 13, 22, 'topiccategory', 'topiccategory', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 11, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (59, 13, 14, 'creationdate', 'creationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 12, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (61, 13, 28, 'representations', 'representations', true, false, 12, NULL, true, false, true, 'resource_reference', NULL, NULL, NULL, true, NULL, NULL, 18, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (62, 13, 20, 'contact', 'contact', true, false, 4, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 16, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (63, 13, 22, 'accessconditions', 'accessconditions', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (64, 13, 14, 'lastModificationDate', 'lastmodificationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 19, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (65, 13, 22, 'geography', 'geography', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 17, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (68, 13, 22, 'conformity', 'conformity', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (69, 13, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (70, 13, 22, 'srid', 'srid', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (72, 13, 22, 'language', 'language', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (73, 13, 25, 'tags', 'tags', true, false, 9, NULL, true, false, true, 'resource_reference', NULL, NULL, NULL, true, NULL, NULL, 15, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (74, 13, 9, 'licensestatement', 'licensestatement', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 14, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (75, 13, 14, 'toDate', 'todate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (76, 14, 2, 'resource_reference', 'resource_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (77, 14, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (78, 15, 8, 'contentLocation', 'contentlocation', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 9, 1024, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (79, 15, 22, 'language', 'language', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (80, 15, 22, 'type', 'type', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (81, 15, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (82, 15, 9, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (83, 15, 26, 'tags', 'tags', true, false, 10, NULL, true, false, true, 'metadata_reference', NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (84, 15, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 150, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (85, 15, 8, 'uuid', 'uuid', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 8, 100, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (86, 15, 22, 'standard', 'standard', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (88, 14, 31, 'metadata', 'metadataid', true, false, 15, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (89, 13, 22, 'collection', 'collection', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 24, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (90, 13, 8, 'uuid', 'uuid', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 23, 200, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (91, 13, 13, 'publicationDate', 'publicationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 21, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (92, 13, 22, 'accesslimitations', 'accesslimitations', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 22, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (87, 15, 20, 'contact', 'contact', true, false, 4, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (66, 13, 8, 'name', 'name', false, false, NULL, NULL, true, true, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 13, 150, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (60, 13, 9, 'description', 'description', false, false, NULL, NULL, true, true, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 8, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (67, 13, 19, 'spatialCoverage', 'spatialcoverage', true, false, 1, NULL, true, true, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (93, 13, 30, 'metadata', 'metadata', true, false, 14, NULL, true, false, true, 'resource_reference', NULL, NULL, NULL, true, NULL, NULL, 20, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (94, 16, 29, 'resource', 'resourceid', true, false, 13, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (95, 16, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (96, 16, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (97, 17, 31, 'metadata', 'metadataid', true, false, 15, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (98, 17, 2, 'relationship_reference', 'relationship_reference', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (99, 17, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (100, 18, 33, 'metadata', 'metadata', true, false, 17, NULL, true, false, true, 'relationship_reference', NULL, NULL, NULL, true, NULL, NULL, 4, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (101, 18, 32, 'fromResources', 'fromresources', true, false, 16, NULL, true, false, true, 'relationship_reference', NULL, NULL, NULL, true, NULL, NULL, 5, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (102, 18, 8, 'description', 'description', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 2, 200, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (103, 18, 29, 'toResource', 'toresource', true, false, 13, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 6, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (104, 18, 2, 'id', 'ID', false, false, NULL, 'Primärschlüssel', false, false, false, NULL, NULL, NULL, NULL, false, NULL, NULL, 0, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (105, 18, 27, 'tags', 'tags', true, false, 11, NULL, true, false, true, 'relationship_reference', NULL, NULL, NULL, true, NULL, NULL, 3, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (106, 18, 8, 'name', 'name', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 1, 150, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (107, 18, 22, 'type', 'type', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 7, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (108, 7, 22, 'contentType', 'contenttype', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 15, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (109, 15, 22, 'contenttype', 'contenttype', true, false, 6, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 11, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (110, 15, 13, 'creationDate', 'creationdate', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 10, NULL, NULL, false);
INSERT INTO cs_attr (id, class_id, type_id, name, field_name, foreign_key, substitute, foreign_key_references_to, descr, visible, indexed, isarray, array_key, editor, tostring, complex_editor, optional, default_value, from_string, pos, "precision", scale, extension_attr) VALUES (111, 15, 9, 'content', 'content', false, false, NULL, NULL, true, false, false, NULL, NULL, NULL, NULL, true, NULL, NULL, 12, NULL, NULL, false);


--
-- TOC entry 3154 (class 0 OID 213116)
-- Dependencies: 146
-- Data for Name: cs_attr_object; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3155 (class 0 OID 213119)
-- Dependencies: 147
-- Data for Name: cs_attr_object_derived; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3157 (class 0 OID 213137)
-- Dependencies: 149
-- Data for Name: cs_attr_string; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3158 (class 0 OID 213145)
-- Dependencies: 151
-- Data for Name: cs_cat_link; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3159 (class 0 OID 213152)
-- Dependencies: 152
-- Data for Name: cs_cat_node; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3160 (class 0 OID 213163)
-- Dependencies: 153
-- Data for Name: cs_class; Type: TABLE DATA; Schema: public; Owner: switchon
--

INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (4, 'contact', '', 2, 2, 'CONTACT', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (5, 'taggroup', '', 2, 2, 'TAGGROUP', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (6, 'tag', '', 2, 2, 'TAG', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (7, 'representation', '', 2, 2, 'REPRESENTATION', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (8, 'jt_representation_tag', '', 2, 2, 'JT_REPRESENTATION_TAG', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (9, 'jt_resource_tag', '', 2, 2, 'JT_RESOURCE_TAG', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (10, 'jt_metadata_tag', '', 2, 2, 'JT_METADATA_TAG', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (11, 'jt_relationship_tag', '', 2, 2, 'JT_RELATIONSHIP_TAG', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (12, 'jt_resource_representation', '', 2, 2, 'JT_RESOURCE_REPRESENTATION', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (15, 'metadata', '', 2, 2, 'METADATA', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (14, 'jt_metadata_resource', '', 2, 2, 'JT_METADATA_RESOURCE', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (16, 'jt_fromresource_relationship', '', 2, 2, 'JT_FROMRESOURCE_RELATIONSHIP', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (17, 'jt_metadata_relationship', '', 2, 2, 'JT_METADATA_RELATIONSHIP', 'ID', false, NULL, NULL, NULL, true, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (18, 'relationship', '', 2, 2, 'RELATIONSHIP', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);
INSERT INTO cs_class (id, name, descr, class_icon_id, object_icon_id, table_name, primary_key_field, indexed, tostring, editor, renderer, array_link, policy, attribute_policy) VALUES (13, 'resource', '', 2, 2, 'RESOURCE', 'ID', false, NULL, NULL, NULL, false, NULL, NULL);


--
-- TOC entry 3161 (class 0 OID 213175)
-- Dependencies: 155
-- Data for Name: cs_class_attr; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3188 (class 0 OID 213544)
-- Dependencies: 219
-- Data for Name: cs_config_attr_key; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3179 (class 0 OID 213311)
-- Dependencies: 187
-- Data for Name: cs_ug; Type: TABLE DATA; Schema: public; Owner: switchon
--


--
-- TOC entry 3185 (class 0 OID 213344)
-- Dependencies: 195
-- Data for Name: cs_usr; Type: TABLE DATA; Schema: public; Owner: switchon
--


--
-- TOC entry 3192 (class 0 OID 213611)
-- Dependencies: 227
-- Data for Name: cs_config_attr_exempt; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3190 (class 0 OID 213563)
-- Dependencies: 223
-- Data for Name: cs_config_attr_type; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3189 (class 0 OID 213552)
-- Dependencies: 221
-- Data for Name: cs_config_attr_value; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3162 (class 0 OID 213184)
-- Dependencies: 157
-- Data for Name: cs_domain; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3191 (class 0 OID 213571)
-- Dependencies: 225
-- Data for Name: cs_config_attr_jt; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3186 (class 0 OID 213504)
-- Dependencies: 216
-- Data for Name: cs_history; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3163 (class 0 OID 213190)
-- Dependencies: 159
-- Data for Name: cs_icon; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3164 (class 0 OID 213197)
-- Dependencies: 161
-- Data for Name: cs_java_class; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3165 (class 0 OID 213207)
-- Dependencies: 163
-- Data for Name: cs_locks; Type: TABLE DATA; Schema: public; Owner: switchon
--

INSERT INTO cs_locks (class_id, object_id, user_string, additional_info, id) VALUES (NULL, NULL, 'ABF_EXCLUSIVE_LOCK_1408698139677', 'FabHewer@Nibbler', 3);


--
-- TOC entry 3166 (class 0 OID 213214)
-- Dependencies: 164
-- Data for Name: cs_method; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3167 (class 0 OID 213227)
-- Dependencies: 166
-- Data for Name: cs_method_class_assoc; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3168 (class 0 OID 213233)
-- Dependencies: 168
-- Data for Name: cs_permission; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3169 (class 0 OID 213239)
-- Dependencies: 170
-- Data for Name: cs_policy; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3170 (class 0 OID 213245)
-- Dependencies: 172
-- Data for Name: cs_policy_rule; Type: TABLE DATA; Schema: public; Owner: switchon
--


--
-- TOC entry 3171 (class 0 OID 213249)
-- Dependencies: 173
-- Data for Name: cs_query; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3172 (class 0 OID 213264)
-- Dependencies: 175
-- Data for Name: cs_query_class_assoc; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3173 (class 0 OID 213270)
-- Dependencies: 177
-- Data for Name: cs_query_link; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3174 (class 0 OID 213274)
-- Dependencies: 178
-- Data for Name: cs_query_parameter; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3175 (class 0 OID 213285)
-- Dependencies: 180
-- Data for Name: cs_query_store; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3176 (class 0 OID 213291)
-- Dependencies: 182
-- Data for Name: cs_query_store_ug_assoc; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3177 (class 0 OID 213297)
-- Dependencies: 184
-- Data for Name: cs_query_ug_assoc; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3187 (class 0 OID 213527)
-- Dependencies: 217
-- Data for Name: cs_stringrepcache; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3178 (class 0 OID 213301)
-- Dependencies: 185
-- Data for Name: cs_type; Type: TABLE DATA; Schema: public; Owner: switchon
--

INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (20, 'contact', 4, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (21, 'taggroup', 5, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (22, 'tag', 6, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (23, 'representation', 7, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (24, 'jt_representation_tag', 8, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (25, 'jt_resource_tag', 9, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (26, 'jt_metadata_tag', 10, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (27, 'jt_relationship_tag', 11, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (28, 'jt_resource_representation', 12, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (29, 'resource', 13, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (30, 'jt_metadata_resource', 14, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (31, 'metadata', 15, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (32, 'jt_fromresource_relationship', 16, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (33, 'jt_metadata_relationship', 17, true, NULL, NULL, NULL);
INSERT INTO cs_type (id, name, class_id, complex_type, descr, editor, renderer) VALUES (34, 'relationship', 18, true, NULL, NULL, NULL);


--
-- TOC entry 3180 (class 0 OID 213320)
-- Dependencies: 188
-- Data for Name: cs_ug_attr_perm; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3181 (class 0 OID 213324)
-- Dependencies: 189
-- Data for Name: cs_ug_cat_node_perm; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3182 (class 0 OID 213330)
-- Dependencies: 191
-- Data for Name: cs_ug_class_perm; Type: TABLE DATA; Schema: public; Owner: switchon
--

INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (3, 1, 5, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (4, 1, 6, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (5, 1, 4, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (6, 1, 7, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (7, 1, 8, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (8, 1, 9, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (9, 1, 10, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (10, 1, 11, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (11, 1, 12, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (13, 1, 14, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (14, 1, 13, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (16, 1, 17, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (17, 1, 18, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (18, 1, 15, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (19, 1, 1, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (20, 1, 16, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (21, 1, 2, 1, NULL);
INSERT INTO cs_ug_class_perm (id, ug_id, class_id, permission, domain) VALUES (22, 1, 3, 1, NULL);


--
-- TOC entry 3183 (class 0 OID 213336)
-- Dependencies: 193
-- Data for Name: cs_ug_membership; Type: TABLE DATA; Schema: public; Owner: switchon
--



--
-- TOC entry 3184 (class 0 OID 213340)
-- Dependencies: 194
-- Data for Name: cs_ug_method_perm; Type: TABLE DATA; Schema: public; Owner: switchon
--



-- Completed on 2014-08-22 14:13:37

--
-- PostgreSQL database dump complete
--

