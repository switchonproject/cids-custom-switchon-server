--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.3
-- Dumped by pg_dump version 9.3.1
-- Started on 2014-06-25 14:08:56

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 4029 (class 1262 OID 210169)
-- Name: SWITCH-ON_Enrichment-XI; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "SWITCH-ON_Enrichment-XI" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'German_Germany.1252' LC_CTYPE = 'German_Germany.1252';


ALTER DATABASE "SWITCH-ON_Enrichment-XI" OWNER TO postgres;

\connect "SWITCH-ON_Enrichment-XI"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 9 (class 2615 OID 242903)
-- Name: csdc; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA csdc;


ALTER SCHEMA csdc OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 210171)
-- Name: geonet; Type: SCHEMA; Schema: -; Owner: geonetwork
--

CREATE SCHEMA geonet;


ALTER SCHEMA geonet OWNER TO geonetwork;

--
-- TOC entry 7 (class 2615 OID 210170)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- TOC entry 313 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 4032 (class 0 OID 0)
-- Dependencies: 313
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 314 (class 3079 OID 210172)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4033 (class 0 OID 0)
-- Dependencies: 314
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- TOC entry 315 (class 3079 OID 211458)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 4034 (class 0 OID 0)
-- Dependencies: 315
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = csdc, pg_catalog;

--
-- TOC entry 1475 (class 1255 OID 242904)
-- Name: cidsobjects(character varying, character varying); Type: FUNCTION; Schema: csdc; Owner: postgres
--

CREATE FUNCTION cidsobjects(class_id character varying, table_name character varying) RETURNS character varying
    LANGUAGE sql
    AS $_$ select'SELECT -1 AS id,
	name AS name,
	'||$1||' AS class_id,
	id AS object_id,
	''O'' AS node_type,
	null AS url,
	null AS dynamic_children,
	false AS sql_sort,
	true AS derive_permissions_from_class
	from '||$2||'
	order by id
	'::varchar $_$;


ALTER FUNCTION csdc.cidsobjects(class_id character varying, table_name character varying) OWNER TO postgres;

--
-- TOC entry 1477 (class 1255 OID 242906)
-- Name: entities(integer, integer); Type: FUNCTION; Schema: csdc; Owner: postgres
--

CREATE FUNCTION entities(level_id integer, hydrocon_id integer) RETURNS character varying
    LANGUAGE sql
    AS $_$ select'SELECT -1 AS id,
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
	tag_1.id = '||$1||' AND
	tag_2.id = '||$2||' 
      Group by
	resource.name,
	resource.id,
        cs_class.id;'::varchar $_$;


ALTER FUNCTION csdc.entities(level_id integer, hydrocon_id integer) OWNER TO postgres;

--
-- TOC entry 1476 (class 1255 OID 242905)
-- Name: hydrologicalconcepts(integer); Type: FUNCTION; Schema: csdc; Owner: postgres
--

CREATE FUNCTION hydrologicalconcepts(level_id integer) RETURNS character varying
    LANGUAGE sql
    AS $_$ select'SELECT -1 AS id,
	tag.name AS name,
	cs_class.id AS class_id,
	NULL AS object_id,
	''N'' AS node_type,
	null AS url,
        csdc.entities('||$1||' , tag.id) as dynamic_children, --first Tag = Level, second tag = hydroConc
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
        cs_class.id;'::varchar $_$;


ALTER FUNCTION csdc.hydrologicalconcepts(level_id integer) OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 1479 (class 1255 OID 242909)
-- Name: checkoid(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION checkoid(class_id integer, object_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE class_name character varying;
DECLARE objectExists boolean = false;
BEGIN
	class_name = (SELECT table_name FROM cs_class WHERE class_id = cs_class.id);
	EXECUTE ('SELECT count(*)=1 FROM ' || class_name || ' WHERE ' || class_name || '.id = ' || object_id) INTO objectExists;
	return objectExists;
END;
$$;


ALTER FUNCTION public.checkoid(class_id integer, object_id integer) OWNER TO postgres;

--
-- TOC entry 1480 (class 1255 OID 242910)
-- Name: cidsobjectexists(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cidsobjectexists(cid integer, oid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
 b boolean;
 table_name varchar;
 pk_field varchar;
 s1 varchar;
 s2 varchar;
begin 
 s1='select table_name,primary_key_field from cs_class where id='||cid;
 execute(s1) into table_name,pk_field;
 --raise NOTICE 'tablename:%', table_name;
 --raise NOTICE 'pk:%', pk_field;


 s2='select count(*)>0 from '||table_name ||' where ' || pk_field || '='||oid;
 execute(s2) into b;

 --raise NOTICE '%', s1;
 --raise NOTICE '%', s2;

 return b;
exception
 when OTHERS THEN
 return false;
end
$$;


ALTER FUNCTION public.cidsobjectexists(cid integer, oid integer) OWNER TO postgres;

--
-- TOC entry 1473 (class 1255 OID 212184)
-- Name: cs_refresh_dynchilds_functions(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cs_refresh_dynchilds_functions() RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
BEGIN
 
DROP schema csdc cascade;
CREATE schema csdc;
perform execute('CREATE OR REPLACE FUNCTION csdc.'||name||' RETURNS VARCHAR AS $$ select'''||regexp_replace(REPLACE(code,'''',''''''),'(.*?)<ds::param.*>(.*?)</ds::param>(.*?)',E'\\1''||$\\2||''\\3','g')||'''::varchar $$ LANGUAGE ''sql'';') FROM cs_dynamic_children_helper;
    RETURN 'Functions refreshed';
EXCEPTION
    WHEN OTHERS THEN
    RETURN 'Error occured';
END;
$_$;


ALTER FUNCTION public.cs_refresh_dynchilds_functions() OWNER TO postgres;

--
-- TOC entry 1474 (class 1255 OID 212519)
-- Name: delete_py_to_switch(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION delete_py_to_switch() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE resourceID integer;
	DECLARE metaID integer;
	DECLARE repID integer;
	DECLARE relID integer;
	DECLARE contID integer;
	DECLARE ausgabe text;
	BEGIN
	raise NOTICE 'Für Hydra, Für Starfall, Für Drakenheim!';
	resourceID = (SELECT resource.id FROM public.resource where uuid = OLD.identifier);
	FOR repID IN SELECT jt.repid FROM jt_resource_representation as jt WHERE jt.resource_reference = resourceID
	LOOP
		raise NOTICE 'representation: %',repID;
		DELETE FROM jt_resource_representation WHERE resource_reference = resourceID;
		DELETE FROM jt_representation_tag WHERE representation_reference = repID;
		DELETE FROM representation WHERE id = repID;
	END LOOP;
	
	FOR metaID IN SELECT jt.metaid FROM public.jt_metadata_resource as jt WHERE jt.resource_reference = resourceID
	LOOP
		raise NOTICE 'Metadata: %',metaID;
		FOR ausgabe IN SELECT jt.tagid FROM public.jt_metadata_tag as jt WHERE jt.metadata_reference = metaID
		LOOP
			raise NOTICE 'Metatag: %', ausgabe;
		END LOOP;
		DELETE FROM jt_metadata_resource WHERE resource_reference = resourceID;
		DELETE FROM jt_metadata_tag WHERE metadata_reference = metaID;
		DELETE FROM metadata WHERE id = metaID;
	END LOOP;
	
	FOR relID IN SELECT jt.relationship_reference FROM jt_toresource_relationship as jt WHERE jt.resid = resourceID
	LOOP
		raise NOTICE 'relationship: %',relID;
		FOR metaID IN SELECT jt.metaid FROM public.jt_metadata_relationship as jt WHERE jt.relationship_reference = relID
		LOOP
		raise NOTICE 'relation meta: %',metaID;
			DELETE FROM jt_metadata_relationship WHERE relationship_reference = relID;
			DELETE FROM jt_metadata_tag WHERE metadata_reference = metaID;
			DELETE FROM metadata WHERE id = metaID;
		END LOOP;
		DELETE FROM jt_toresource_relationship WHERE resid = resourceID;
		DELETE FROM jt_metadata_relationship WHERE relationship_reference = relID;
		DELETE FROM relationship WHERE id = relID;
	END LOOP;
	
	FOR relID IN SELECT jt.relationship_reference FROM jt_fromresource_relationship as jt WHERE jt.resid = resourceID
	LOOP
		raise NOTICE 'relationship: %',relID;
		FOR metaID IN SELECT jt.metaid FROM public.jt_metadata_relationship as jt WHERE jt.relationship_reference = relID
		LOOP
		raise NOTICE 'relation meta: %',metaID;
			DELETE FROM jt_metadata_relationship WHERE relationship_reference = relID;
			DELETE FROM jt_metadata_tag WHERE metadata_reference = metaID;
			DELETE FROM metadata WHERE id = metaID;
		END LOOP;
		DELETE FROM jt_fromresource_relationship WHERE resid = resourceID;
		DELETE FROM jt_metadata_relationship WHERE relationship_reference = relID;
		DELETE FROM relationship WHERE id = relID;
	END LOOP;
	FOR ausgabe IN SELECT jt.tagid FROM public.jt_resource_tag as jt WHERE jt.resource_reference = resourceID
	LOOP
			raise NOTICE 'Resourcetag: %', ausgabe;
	END LOOP;
	raise NOTICE 'contact Data: %' , (SELECT contact.id FROM contact, resource WHERE contact.id = resource.contact AND resource.id = resourceID);
	contID = (SELECT contact.id FROM contact, resource WHERE contact.id = resource.contact AND resource.id = resourceID);
	DELETE FROM public.jt_resource_tag as jt WHERE jt.resource_reference = resourceID;
	DELETE FROM resource WHERE id = resourceID;
	DELETE FROM contact WHERE contact.id = contID;
	RETURN OLD;
	END;
	$$;


ALTER FUNCTION public.delete_py_to_switch() OWNER TO postgres;

--
-- TOC entry 1472 (class 1255 OID 212183)
-- Name: execute(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION execute(_command character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE _r int;
BEGIN
EXECUTE _command;
    RETURN 'Yes: ' || _command || ' executed';
EXCEPTION
    WHEN OTHERS THEN
    RETURN 'No:  ' || _command || ' failed';
END;
$$;


ALTER FUNCTION public.execute(_command character varying) OWNER TO postgres;

--
-- TOC entry 1453 (class 1255 OID 212516)
-- Name: insert_py_to_switch(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION insert_py_to_switch() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE tag_raw character varying;
	DECLARE tag_trimmed character varying;
	DECLARE tagID integer;
	DECLARE taggroup_id integer = NULL;
	DECLARE count integer;
	DECLARE linkElement text;
	DECLARE firstElement boolean;
	DECLARE elementNumber integer;
	DECLARE repDescr text;
	DECLARE repTyp text;
	DECLARE repURL text;
	BEGIN
	IF (EXISTS( SELECT 1 FROM resource WHERE uuid = NEW.identifier)) THEN --If the dataset iss already in de SO-Datastructure, just return.
		raise EXCEPTION '% is already in the database',NEW.identifier;
		RETURN NEW;
	END IF;
	IF (NEW.wkb_geometry IS NULL) THEN
		INSERT INTO geom (geo_field) VALUES (public.geometry(NEW.wkt_geometry));
	ELSE
		INSERT INTO geom (geo_field) VALUES (NEW.wkb_geometry);
	END IF;
		-- License Tag initialising.
	tag_raw = NEW.conditionapplyingtoaccessanduse;
	tag_trimmed = trim(tag_raw);
	--raise NOTICE '%',tag_trimmed;
	IF (tag_trimmed IS NOT NULL) THEN
		If (EXISTS (SELECT 1 FROM public.tag WHERE public.tag.name = tag_trimmed)) THEN
			--raise NOTICE 'IT EXISTS!!!!!!';
			tagID = (SELECT id FROM public.tag WHERE public.tag.name = tag_trimmed);
			--raise NOTICE '%',tagID;
		ELSE
			taggroup_id = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'license');
			--raise NOTICE 'Tag % doesn''t exist',tag_trimmed;
			--raise NOTICE 'Create Tag, with nextval(tag_Seq) | tag_trimmed | NULL | currval(tag_Seq)';
			INSERT INTO public.tag (id, name, description, taggroup) VALUES (nextval('tag_seq'), tag_trimmed, NULL, currval('tag_seq'));
			tagID = currval('tag_seq');
			INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (tagID, taggroup_id);
		END IF;
	END IF;
	INSERT INTO public.contact (name, organisation, description) VALUES ( NEW.creator, NEW.organization, NEW.responsiblepartyrole);
	INSERT INTO public.resource (id, uuid, name, description, spatialcoverage, fromdate, todate, creationdate, publicationdate, lastmodificationdate, contact, license) 
		VALUES ( nextval('resource_seq'), NEW.identifier, NEW.title, NEW.abstract, currval('geom_seq'), NEW.time_begin, NEW.time_end, NEW.date_creation,
			 NEW.date_publication, NEW.date_modified, currval('contact_seq'), tagID);
	INSERT INTO public.metadata VALUES ( nextval('metadata_seq'), NEW.title, currval('metadata_seq'), NEW.abstract, currval('contact_seq'), NEW.date, 'application/xml', NULL, NEW.xml);
	INSERT INTO public.jt_metadata_resource (metaID, resource_reference) VALUES (currval('metadata_seq'), currval('resource_seq'));
	FOREACH tag_raw IN ARRAY (SELECT (regexp_split_to_array(NEW.keywords, ',')))
	LOOP
		--knupf
		tag_trimmed = trim(tag_raw);
		--raise NOTICE '%',tag_trimmed; --return current row of select
		IF (tag_trimmed IS NOT NULL) THEN
			IF (EXISTS (SELECT 1 FROM public.tag WHERE public.tag.name = tag_trimmed)) THEN
				--raise NOTICE 'IT EXISTS!!!!!!';
				tagID = (SELECT id FROM public.tag WHERE public.tag.name = tag_trimmed);
				--raise NOTICE '%',tagID;
				--raise NOTICE 'I could insert here!!!';
			ELSE
				IF (taggroup_id IS NULL) THEN
					taggroup_id = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'keywords');
				END IF;
				--raise NOTICE 'Tag % doesn''t exist',tag_trimmed;
				--raise NOTICE 'Create Tag, with nextval(tag_Seq) | tag_trimmed | NULL | currval(tag_Seq)';
				INSERT INTO public.tag VALUES (nextval('tag_seq'), tag_trimmed, NULL, currval('tag_seq'));
				tagID = currval('tag_seq');
				INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (tagID, taggroup_id);
				--raise NOTICE 'Insert into public.jt_T_TG  with Taggroup = taggroup_id, Tagref = currval';
			END IF;
			INSERT INTO public.jt_resource_tag (resource_reference, tagID) VALUES (currval('resource_seq'), tagID);
		END IF;
	END LOOP;	-- Next Taggroup
	tag_raw = NEW.resourcelanguage;
	tag_trimmed = trim(tag_raw);
	--raise NOTICE '%',tag_trimmed;
	IF (tag_trimmed IS NOT NULL) THEN
		If (EXISTS (SELECT 1 FROM public.tag WHERE public.tag.name = tag_trimmed)) THEN
			--raise NOTICE 'IT EXISTS!!!!!!';
			tagID = (SELECT id FROM public.tag WHERE public.tag.name = tag_trimmed);
			--raise NOTICE '%',tagID;
			--raise NOTICE 'I could insert here!!!';
		ELSE
			taggroup_id = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'language');
			--raise NOTICE 'Tag % doesn''t exist',tag_trimmed;
			--raise NOTICE 'Create Tag, with nextval(tag_Seq) | tag_trimmed | NULL | currval(tag_Seq)';
			INSERT INTO public.tag VALUES (nextval('tag_seq'), tag_trimmed, NULL, currval('tag_seq'));
			tagID =	currval('tag_seq');
			INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (tagID, taggroup_id);
			--raise NOTICE 'Insert into public.jt_T_TG  with Taggroup = taggroup_id, Tagref = currval';
		END IF;
		INSERT INTO public.jt_resource_tag (resource_reference, tagID) VALUES (currval('resource_seq'), tagID);
	END IF;
	-- Next Taggroup
	tag_raw = NEW.otherconstraints;
	tag_trimmed = trim(tag_raw);
	--raise NOTICE '%',tag_trimmed;	
	IF (tag_trimmed IS NOT NULL) THEN
		If (EXISTS (SELECT 1 FROM public.tag WHERE public.tag.name = tag_trimmed)) THEN
			--raise NOTICE 'IT EXISTS!!!!!!';
			tagID = (SELECT id FROM public.tag WHERE public.tag.name = tag_trimmed);
			--raise NOTICE '%',tagID;
			--raise NOTICE 'I could insert here!!!';
		ELSE
			taggroup_id = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'constraints');
			--raise NOTICE 'Tag % doesn''t exist',tag_trimmed;
			--raise NOTICE 'Create Tag, with nextval(tag_Seq) | tag_trimmed | NULL | currval(tag_Seq)';
			INSERT INTO public.tag VALUES (nextval('tag_seq'), tag_trimmed, NULL, currval('tag_seq'));
			tagID = currval('tag_seq');
			INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (tagID, taggroup_id);
			--raise NOTICE 'Insert into public.jt_T_TG  with Taggroup = taggroup_id, Tagref = currval';
		END IF;
		INSERT INTO public.jt_resource_tag (resource_reference, tagID) VALUES (currval('resource_seq'), tagID);
	END IF;
	-- Next Taggroup
	tag_raw = NEW.accessconstraints;
	tag_trimmed = trim(tag_raw);
	--raise NOTICE '%',tag_trimmed;
	IF (tag_trimmed IS NOT NULL) THEN
		If (EXISTS (SELECT 1 FROM public.tag WHERE public.tag.name = tag_trimmed)) THEN
			--raise NOTICE 'IT EXISTS!!!!!!';
			tagID = (SELECT id FROM public.tag WHERE public.tag.name = tag_trimmed);
			--raise NOTICE '%',tagID;
			--raise NOTICE 'I could insert here!!!';
		ELSE
			taggroup_id = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'constraints');
			--raise NOTICE 'Tag % doesn''t exist',tag_trimmed;
			--raise NOTICE 'Create Tag, with nextval(tag_Seq) | tag_trimmed | NULL | currval(tag_Seq)';
			INSERT INTO public.tag VALUES (nextval('tag_seq'), tag_trimmed, NULL, currval('tag_seq'));
			tagID = currval('tag_seq');
			INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (tagID, taggroup_id);
			--raise NOTICE 'Insert into public.jt_T_TG  with Taggroup = taggroup_id, Tagref = currval';
		END IF;
		INSERT INTO public.jt_resource_tag (resource_reference, tagID) VALUES (currval('resource_seq'), tagID);
	END IF;
	-- Next Taggroup
	tag_raw = NEW.topiccategory;
	tag_trimmed = trim(tag_raw);
	--raise NOTICE '%',tag_trimmed;
	IF (tag_trimmed IS NOT NULL) THEN
		If (EXISTS (SELECT 1 FROM public.tag WHERE public.tag.name = tag_trimmed)) THEN
			--raise NOTICE 'IT EXISTS!!!!!!';
			tagID = (SELECT id FROM public.tag WHERE public.tag.name = tag_trimmed);
			--raise NOTICE '%',tagID;
			--raise NOTICE 'I could insert here!!!';
		ELSE
			taggroup_id = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'topic category');
			--raise NOTICE 'Tag % doesn''t exist',tag_trimmed;
			--raise NOTICE 'Create Tag, with nextval(tag_Seq) | tag_trimmed | NULL | currval(tag_Seq)';
			INSERT INTO public.tag VALUES (nextval('tag_seq'), tag_trimmed, NULL, currval('tag_seq'));
			tagID = currval('tag_seq');
			INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (tagID, taggroup_id);
			--raise NOTICE 'Insert into public.jt_T_TG  with Taggroup = taggroup_id, Tagref = currval';
		END IF;
		INSERT INTO public.jt_resource_tag (resource_reference, tagID) VALUES (currval('resource_seq'), tagID);
	END IF;
		-- Next Taggroup
	tag_raw = NEW.language;
	tag_trimmed = trim(tag_raw);
	--raise NOTICE '%',tag_trimmed;
	IF (tag_trimmed IS NOT NULL) THEN
		If (EXISTS (SELECT 1 FROM public.tag WHERE public.tag.name = tag_trimmed)) THEN
			--raise NOTICE 'IT EXISTS!!!!!!';
			tagID = (SELECT id FROM public.tag WHERE public.tag.name = tag_trimmed);
			--raise NOTICE '%',tagID;
			--raise NOTICE 'I could insert here!!!';
		ELSE
			taggroup_id = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'language');
			--raise NOTICE 'Tag % doesn''t exist',tag_trimmed;
			--raise NOTICE 'Create Tag, with nextval(tag_Seq) | tag_trimmed | NULL | currval(tag_Seq)';
			INSERT INTO public.tag VALUES (nextval('tag_seq'), tag_trimmed, NULL, currval('tag_seq'));
			tagID = currval('tag_seq');
			INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (tagID, taggroup_id);
			--raise NOTICE 'Insert into public.jt_T_TG  with Taggroup = taggroup_id, Tagref = currval';
		END IF;
		INSERT INTO public.jt_metadata_tag (metadata_reference, tagID) VALUES (currval('metadata_seq'), tagID);
	END IF;
	IF NEW.links IS NOT NULL THEN
		count = 0;
		firstElement = true;
		raise NOTICE '%',NEW.links;
		FOREACH linkElement IN ARRAY (SELECT (regexp_split_to_array(NEW.links, ',')))
		LOOP
			IF (firstElement) THEN
				raise Notice 'Was auch immer: %',linkElement;
				firstElement = false;
			ELSE
				elementNumber = count%3;
				raise Notice 'nyu: %', elementNumber;
				CASE elementNumber
					WHEN 0 THEN
						--raise Notice 'Descr: %',linkElement;
						repDescr = linkElement;
					WHEN 1 THEN
						--raise Notice 'Typ: %',linkElement;
						repTyp = linkElement;
					WHEN 2 THEN
						--raise Notice 'URL: %',linkElement;
						repURL = linkElement;
						-- here a new representation should be build.
						if ( repDescr IS NOT NULL OR repTyp IS NOT NULL OR repURL IS NOT NULL) THEN
							INSERT INTO public.representation (id, name, description, contenttype, contentlocation)
								VALUES (nextval('representation_seq'), NEW.title, repDescr, repTyp, RepURL);
							INSERT INTO public.jt_resource_representation (repID, resource_reference)
								VALUES (currval('representation_seq'), currval('resource_seq'));
						END IF;
				END CASE;
				count=count+1;
			END IF;
		END LOOP;
	END IF;
	RETURN NEW;
	END;
	$$;


ALTER FUNCTION public.insert_py_to_switch() OWNER TO postgres;

--
-- TOC entry 1467 (class 1255 OID 212066)
-- Name: recreate_stringrepcache(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION recreate_stringrepcache() RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
	ids INTEGER;
begin
	FOR ids IN SELECT c.id FROM cs_class c, cs_class_attr a where c.id = a.class_id and a.attr_key='tostringcache' LOOP
		RAISE NOTICE 'reindex %', ids;
		PERFORM recreate_stringrepcache(ids);
	END LOOP;
end
$$;


ALTER FUNCTION public.recreate_stringrepcache() OWNER TO postgres;

--
-- TOC entry 1466 (class 1255 OID 212065)
-- Name: recreate_stringrepcache(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION recreate_stringrepcache(classid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
	BEGIN
	delete from cs_stringrepcache where class_id = classid;
	execute('insert into cs_stringrepcache (class_id,object_id,stringrep) select '||class_id||','||attr_value) from cs_class_attr where attr_key='tostringcache' and class_id = classid;
	EXCEPTION WHEN SYNTAX_ERROR_OR_ACCESS_RULE_VIOLATION OR DATA_EXCEPTION OR PROGRAM_LIMIT_EXCEEDED THEN
		RAISE WARNING 'Error occurs while recreating the stringrepcache for class %.', classid;
		RAISE WARNING '% %', SQLERRM, SQLSTATE;
		RETURN;
	END;
end
$$;


ALTER FUNCTION public.recreate_stringrepcache(classid integer) OWNER TO postgres;

--
-- TOC entry 1428 (class 1255 OID 212069)
-- Name: reindex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION reindex() RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
	ids INTEGER;
begin
	FOR ids IN SELECT id FROM cs_class LOOP
		RAISE NOTICE 'reindex %', ids;
		PERFORM reindexPure(ids);
	END LOOP;

	FOR ids IN SELECT id FROM cs_class where indexed LOOP
		RAISE NOTICE 'reindexDerived %', ids;
		PERFORM reindexDerivedObjects(ids);
	END LOOP;
end
$$;


ALTER FUNCTION public.reindex() OWNER TO postgres;

--
-- TOC entry 1470 (class 1255 OID 212070)
-- Name: reindex(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION reindex(class_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
	ids INTEGER;
begin
	FOR ids IN WITH recursive derived_child(father,child,depth) AS
                    ( SELECT father,
                            father ,
                            0
                    FROM    cs_class_hierarchy
                    WHERE   father IN (class_id)
                    
                    UNION ALL
                    
                    SELECT ch.father,
                           abs(ch.child) ,
                           dc.depth+1
                    FROM   derived_child dc,
                           cs_class_hierarchy ch
                    WHERE  ch.father=dc.child
                    )
             SELECT DISTINCT child
             FROM            derived_child LIMIT 100 LOOP
		RAISE NOTICE 'reindex  %', abs(ids) ;
		PERFORM reindexPure(abs(ids));
	END LOOP;

	FOR ids IN WITH recursive derived_child(father,child,depth) AS
                    ( SELECT father,
                            father ,
                            0
                    FROM    cs_class_hierarchy
                    WHERE   father IN (class_id)
                    
                    UNION ALL
                    
                    SELECT ch.father,
                           abs(ch.child) ,
                           dc.depth+1
                    FROM   derived_child dc,
                           cs_class_hierarchy ch
                    WHERE  ch.father=dc.child
                    )
             SELECT DISTINCT child
             FROM            derived_child dc join cs_class cc on (cc.id = dc.child) where cc.indexed LIMIT 100 LOOP
		RAISE NOTICE 'reindexDerivedObjects  %', abs(ids) ;
		PERFORM reindexDerivedObjects(abs(ids));
	END LOOP;
end
$$;


ALTER FUNCTION public.reindex(class_id integer) OWNER TO postgres;

--
-- TOC entry 1469 (class 1255 OID 212068)
-- Name: reindexderivedobjects(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION reindexderivedobjects(classid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
	ids INTEGER;
begin
	CREATE TEMP TABLE cs_attr_object_derived_temp (class_id integer, object_id integer, attr_class_id integer, attr_object_id integer);
	INSERT INTO   cs_attr_object_derived_temp WITH recursive derived_index
	       (
		      xocid,
		      xoid ,
		      ocid ,
		      oid  ,
		      acid ,
		      aid  ,
		      depth
	       )
	       AS
	       ( SELECT class_id,
		       object_id,
		       class_id ,
		       object_id,
		       class_id ,
		       object_id,
		       0
	       FROM    cs_attr_object
	       WHERE   class_id=classId
	       
	       UNION ALL
	       
	       SELECT di.xocid          ,
		      di.xoid           ,
		      aam.class_id      ,
		      aam.object_id     ,
		      aam.attr_class_id ,
		      aam.attr_object_id,
		      di.depth+1
	       FROM   cs_attr_object aam,
		      derived_index di
	       WHERE  aam.class_id =di.acid
	       AND    aam.object_id=di.aid
	       )
	SELECT DISTINCT xocid,
			xoid ,
			acid ,
			aid
	FROM            derived_index
	ORDER BY        1,2,3,4 limit 1000000000;
	DELETE FROM cs_attr_object_derived WHERE class_id = classid;
	INSERT INTO cs_attr_object_derived ( class_id, object_id, attr_class_id, attr_object_id) (SELECT class_id, object_id, attr_class_id, attr_object_id FROM cs_attr_object_derived_temp);
	DROP TABLE cs_attr_object_derived_temp;
end
$$;


ALTER FUNCTION public.reindexderivedobjects(classid integer) OWNER TO postgres;

--
-- TOC entry 1468 (class 1255 OID 212067)
-- Name: reindexpure(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION reindexpure(classid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
	attr cs_attr%ROWTYPE;
	obj RECORD;
	ids RECORD;
	objects RECORD;
	class cs_class%ROWTYPE;
	query TEXT;
	secQuery TEXT;
	attrClass cs_class%ROWTYPE;
	attrFieldName TEXT;
	objectCount INTEGER;
	foreignFieldName TEXT;
	backreference TEXT;
	
begin
	CREATE TEMP TABLE cs_attr_object_temp (class_id integer, object_id integer, attr_class_id integer, attr_object_id integer);
	CREATE TEMP TABLE cs_attr_string_temp (class_id integer, attr_id integer, object_id integer, string_val text);
	
	SELECT * INTO class FROM cs_class WHERE id = classId;

	FOR attr IN SELECT * FROM cs_attr WHERE class_id = classId LOOP	
		--RAISE NOTICE '%     %', attr.field_name, class.table_name ;
		IF attr.indexed THEN
			IF attr.foreign_key_references_to < 0 THEN
				query = 'SELECT ' || class.primary_key_field || ' AS pField, cast(' ||  class.primary_key_field || ' as text) AS fName FROM ' || class.table_name;
			ELSE
				query = 'SELECT ' || class.primary_key_field || ' AS pField, cast(' ||  attr.field_name || ' as text) AS fName FROM ' || class.table_name;
			END IF;
			FOR obj IN EXECUTE query LOOP
				IF attr.foreign_key THEN
					SELECT cs_class.* INTO attrClass FROM cs_class, cs_type WHERE cs_type.class_id = cs_class.id AND cs_type.id = attr.type_id;
					IF attr.foreign_key_references_to < 0 THEN
						select field_name into backreference from cs_attr where class_id = abs(attr.foreign_key_references_to) and foreign_key_references_to = attr.class_id limit 1;
						secQuery = 'SELECT id as id FROM ' || attrClass.table_name || ' WHERE ' || backreference  || ' =  ' || obj.pField;
						FOR ids IN EXECUTE secQuery LOOP
							insert into cs_attr_object_temp (class_id, object_id, attr_class_id, attr_object_id) values (class.id, obj.pField, attrClass.id, ids.id);
						END LOOP;
					ELSEIF attrClass.array_link THEN
						secQuery = 'SELECT id as id FROM ' || attrClass.table_name || ' WHERE ' || attr.array_key  || ' =  ' || obj.pField;
						FOR ids IN EXECUTE secQuery LOOP
							insert into cs_attr_object_temp (class_id, object_id, attr_class_id, attr_object_id) values (class.id, obj.pField, attrClass.id, ids.id);
						END LOOP;
					ELSE
						secQuery = 'select ' || class.table_name || '.' || attr.field_name || ' as fieldName from ' || class.table_name || ', ' || attrclass.table_name || ' WHERE ' || class.table_name || '.' || class.primary_key_field || ' = ' || obj.pField || ' AND ' || class.table_name || '.' || attr.field_name || ' = ' || attrClass.table_name || '.' || attrClass.primary_key_field;
						EXECUTE secQuery into objects;
						GET DIAGNOSTICS objectCount = ROW_COUNT;
						IF objectCount = 1 THEN
							insert into cs_attr_object_temp (class_id, object_id, attr_class_id, attr_object_id) values (class.id, obj.pField, attrClass.id, objects.fieldName);
						ELSE
							insert into cs_attr_object_temp (class_id, object_id, attr_class_id, attr_object_id) values (class.id, obj.pField, attrclass.id, -1);
						END IF;
					END IF;
				ELSE 
					IF obj.fName is not null THEN
						INSERT INTO cs_attr_string_temp (class_id, attr_id, object_id, string_val) VALUES (classId, attr.id, obj.pField, obj.fName);
					END IF;
				END IF;
			END LOOP;
		END IF;
	END LOOP;

	DELETE FROM cs_attr_object WHERE class_id = class.id;
	DELETE FROM cs_attr_string WHERE class_id = class.id;
	INSERT INTO cs_attr_object ( class_id, object_id, attr_class_id, attr_object_id) (SELECT class_id, object_id, attr_class_id, attr_object_id FROM cs_attr_object_temp);
	INSERT INTO cs_attr_string ( class_id, attr_id, object_id, string_val) (SELECT class_id, attr_id, object_id, string_val FROM cs_attr_string_temp);
	DROP TABLE cs_attr_object_temp;
	DROP TABLE cs_attr_string_temp;
	
end
$$;


ALTER FUNCTION public.reindexpure(classid integer) OWNER TO postgres;

--
-- TOC entry 1471 (class 1255 OID 212071)
-- Name: reindexpure(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION reindexpure(classid integer, objectid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
	attr cs_attr%ROWTYPE;
	obj RECORD;
	ids RECORD;
	objects RECORD;
	class cs_class%ROWTYPE;
	query TEXT;
	secQuery TEXT;
	attrClass cs_class%ROWTYPE;
	attrFieldName TEXT;
	objectCount INTEGER;
	foreignFieldName TEXT;
	backreference TEXT;
	
begin
	CREATE TEMP TABLE cs_attr_object_temp (class_id integer, object_id integer, attr_class_id integer, attr_object_id integer);
	CREATE TEMP TABLE cs_attr_string_temp (class_id integer, attr_id integer, object_id integer, string_val text);
	
	SELECT * INTO class FROM cs_class WHERE id = classId;

	FOR attr IN SELECT * FROM cs_attr WHERE class_id = classId LOOP	
		--RAISE NOTICE '%     %', attr.field_name, class.table_name ;
		IF attr.indexed THEN
			IF attr.foreign_key_references_to < 0 THEN
				query = 'SELECT ' || class.primary_key_field || ' AS pField, cast(' ||  class.primary_key_field || ' as text) AS fName FROM ' || class.table_name || ' where id = ' || objectid;
			ELSE
				query = 'SELECT ' || class.primary_key_field || ' AS pField, cast(' ||  attr.field_name || ' as text) AS fName FROM ' || class.table_name || ' where id = ' || objectid;
			END IF;
			FOR obj IN EXECUTE query LOOP
				IF attr.foreign_key THEN
					SELECT cs_class.* INTO attrClass FROM cs_class, cs_type WHERE cs_type.class_id = cs_class.id AND cs_type.id = attr.type_id;
					IF attr.foreign_key_references_to < 0 THEN
						select field_name into backreference from cs_attr where class_id = abs(attr.foreign_key_references_to) and foreign_key_references_to = attr.class_id;
						secQuery = 'SELECT id as id FROM ' || attrClass.table_name || ' WHERE ' || backreference  || ' =  ' || obj.pField;
						FOR ids IN EXECUTE secQuery LOOP
							insert into cs_attr_object_temp (class_id, object_id, attr_class_id, attr_object_id) values (class.id, obj.pField, attrClass.id, ids.id);
						END LOOP;
					ELSEIF attrClass.array_link THEN
						secQuery = 'SELECT id as id FROM ' || attrClass.table_name || ' WHERE ' || attr.array_key  || ' =  ' || obj.pField;
						FOR ids IN EXECUTE secQuery LOOP
							insert into cs_attr_object_temp (class_id, object_id, attr_class_id, attr_object_id) values (class.id, obj.pField, attrClass.id, ids.id);
						END LOOP;
					ELSE
						secQuery = 'select ' || class.table_name || '.' || attr.field_name || ' as fieldName from ' || class.table_name || ', ' || attrclass.table_name || ' WHERE ' || class.table_name || '.' || class.primary_key_field || ' = ' || obj.pField || ' AND ' || class.table_name || '.' || attr.field_name || ' = ' || attrClass.table_name || '.' || attrClass.primary_key_field;
						EXECUTE secQuery into objects;
						GET DIAGNOSTICS objectCount = ROW_COUNT;
						IF objectCount = 1 THEN
							insert into cs_attr_object_temp (class_id, object_id, attr_class_id, attr_object_id) values (class.id, obj.pField, attrClass.id, objects.fieldName);
						ELSE
							insert into cs_attr_object_temp (class_id, object_id, attr_class_id, attr_object_id) values (class.id, obj.pField, attrclass.id, -1);
						END IF;
					END IF;
				ELSE 
					IF obj.fName is not null THEN
						INSERT INTO cs_attr_string_temp (class_id, attr_id, object_id, string_val) VALUES (classId, attr.id, obj.pField, obj.fName);
					END IF;
				END IF;
			END LOOP;
		END IF;
	END LOOP;

	DELETE FROM cs_attr_object WHERE class_id = class.id and object_id = objectid;
	DELETE FROM cs_attr_string WHERE class_id = class.id and object_id = objectid;
	INSERT INTO cs_attr_object ( class_id, object_id, attr_class_id, attr_object_id) (SELECT class_id, object_id, attr_class_id, attr_object_id FROM cs_attr_object_temp);
	INSERT INTO cs_attr_string ( class_id, attr_id, object_id, string_val) (SELECT class_id, attr_id, object_id, string_val FROM cs_attr_string_temp);
	DROP TABLE cs_attr_object_temp;
	DROP TABLE cs_attr_string_temp;
	
end
$$;


ALTER FUNCTION public.reindexpure(classid integer, objectid integer) OWNER TO postgres;

--
-- TOC entry 1478 (class 1255 OID 242907)
-- Name: selexecute(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION selexecute(_command character varying) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
DECLARE _r record;
BEGIN
for _R in EXECUTE _command  loop
return next _r;
end loop;
RETURN;
END;
$$;


ALTER FUNCTION public.selexecute(_command character varying) OWNER TO postgres;

--
-- TOC entry 1376 (class 1255 OID 212521)
-- Name: update_py_to_switch(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION update_py_to_switch() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE olddata record;
	DECLARE newdata record;
	DECLARE contactID integer;
	DECLARE metadataID integer;
	DECLARE oldTagID integer;
	DECLARE newTagID integer;
	DECLARE tagGroupID integer;
	DECLARE resourceID integer;
	DECLARE oldTagArray character varying[];
	DECLARE newTagArray character varying[];
	DECLARE tagFound boolean;
	DECLARE representationID integer;
	--Keywords
	DECLARE oldElement character varying;
	DECLARE newElement character varying;
	--Links
	DECLARE count integer;
	DECLARE linkElement text;
	DECLARE firstElement boolean;
	DECLARE elementNumber integer;
	DECLARE repDescr text;
	DECLARE repTyp text;
	DECLARE repURL text;
	BEGIN
		tagFound = false;
		olddata = OLD;
		raise NOTICE 'Old data: %',olddata;
		newdata = NEW;
		raise notice 'New data: %',newdata;
		IF OLD IS DISTINCT FROM NEW THEN
	--resourceID
			resourceID = (SELECT id FROM resource WHERE uuid = OLD.identifier);
			raise notice 'Knupf';
			raise notice 'What''s new? Let''s check';
			IF OLD.identifier IS DISTINCT FROM NEW.identifier THEN
				raise notice 'Identifü!: %',NEW identifier;
				IF (SELECT 1 FROM resource WHERE uuid = NEW.identifier) THEN -- Identifiers have to be unique!
					raise EXCEPTION 'Identifier % already exists',NEW.identifier;
					return OLD;
				END IF;
				UPDATE resource SET uuid = NEW.identifier WHERE id = resourceID;
			END IF;
	--title
			IF OLD.title IS DISTINCT FROM NEW.title THEN
				raise notice 'title!!: %',NEW.title;
				UPDATE resource SET name = NEW.title WHERE id = resourceID; -- if the identifier had changed, the old one doesn't exist anymore, use the new (If it hadn't change, there are both the same.)
			END IF;
	--abstract
			IF OLD.abstract IS DISTINCT FROM NEW.abstract THEN
				raise notice 'abstract!!!: %',NEW.abstract;
				UPDATE resource SET description = NEW.abstract WHERE id = resourceID;
			END IF;
	--time_begin
			IF OLD.time_begin IS DISTINCT FROM NEW.time_begin THEN
				raise notice 'time_begin!!!!: %',NEW.time_begin;
				UPDATE resource SET fromtime = NEW.time_begin WHERE id = resourceID;
			END IF;
	--time_end
			IF OLD.time_end IS DISTINCT FROM NEW.time_end THEN
				raise notice 'time_end!!!!!: %',NEW.time_end;
				UPDATE resource SET totime = NEW.time_end WHERE id = resourceID;
			END IF;
	--date_creation
			IF OLD.date_creation IS DISTINCT FROM NEW.date_creation THEN
				raise notice 'date_creation!!!!!: %',NEW.date_creation;
				UPDATE resource SET creationdate = NEW.date_creation WHERE id = resourceID;
			END IF;
	--date_publication
			IF OLD.date_publication IS DISTINCT FROM NEW.date_publication THEN
				raise notice 'date_publication!!!!!: %',NEW.date_publication;
				UPDATE resource SET publicationdate = NEW.date_publication WHERE id = resourceID;
			END IF;
	--date_modified
			IF OLD.date_modified IS DISTINCT FROM NEW.date_modified THEN
				raise notice 'date_modified!!!!!: %',NEW.date_modified;
				UPDATE resource SET modificationdate = NEW.date_modified WHERE id = resourceID;
			END IF;
	--contact
			contactID = (SELECT contact FROM resource WHERE id = resourceID);
		--name
			IF OLD.creator IS DISTINCT FROM NEW.creator THEN
				raise notice 'Creator!!!!!!: %',NEW.creator;
				UPDATE contact SET name = NEW.creator WHERE id = contactID;
			END IF;
		--organisation
			IF OLD.organization IS DISTINCT FROM NEW.organization THEN
				raise notice 'organization!!!!!!: %',NEW.organization;
				UPDATE contact SET organisation = NEW.organization WHERE id = contactID;
			END IF;
	--resourcelanguage
			IF OLD.resourcelanguage IS DISTINCT FROM NEW.resourcelanguage THEN
				raise notice 'Resource Language!!!: %',NEW.resourcelanguage;
				oldTagID = (SELECT id from tag WHERE name = OLD.resourcelanguage);
				raise notice 'Old Tag: %',oldTagID;
				IF EXISTS (SELECT 1 FROM tag WHERE tag.name = NEW.resourcelanguage) THEN
					newTagID = (SELECT id from tag WHERE name = NEW.resourcelanguage);
				ELSE
					raise notice 'Tag % doesn''t exist, executing insertion procedure',NEW.resourcelanguage;
					tagGroupID = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'language');
					INSERT INTO public.tag VALUES (nextval('tag_seq'), NEW.resourcelanguage, NULL, currval('tag_seq'));
					newTagID = currval('tag_seq');
					INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (newTagID, tagGroupID);
				END IF;
				raise notice 'New Tag: %',newTagID;
				UPDATE jt_resource_tag SET tagid = newTagID WHERE resource_reference = resourceID AND oldTagID = tagid;
			END IF;
	--Keywords
			oldTagArray = regexp_split_to_array(OLD.keywords, ',');
			newTagArray = regexp_split_to_array(NEW.keywords, ',');
			IF OLD.keywords IS DISTINCT FROM NEW.keywords THEN
				raise notice 'Gott mit uns, keywords are different';
				IF oldTagArray <@ newTagArray AND oldTagArray @> newTagArray THEN --Check if arrays have same values
					raise notice 'EQUAL!';
				ELSE
					raise notice 'NOT EQUAL TODAY!';
					IF oldTagArray @> newTagArray THEN			--Check if new values are here
						raise notice 'NO NEW';
					ELSE
						raise notice 'SOME NEW';
						FOREACH newElement IN ARRAY newTagArray
						LOOP
							newElement = trim(newElement);
							tagFound = false;
							FOREACH oldElement IN ARRAY oldTagArray
							LOOP
								oldElement = trim(oldElement);
								IF newElement = oldElement THEN
									tagFound = true;
								end if;
							END LOOP;
							raise notice '% not new: %',newElement,tagFound;
							IF NOT tagFound THEN
								IF EXISTS (SELECT 1 FROM tag WHERE tag.name = newElement) THEN
									newTagID = (SELECT id from tag WHERE name = newElement);
								ELSE
									raise notice 'Tag % doesn''t exist, executing insertion procedure',newElement;
									tagGroupID = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'keywords');
									INSERT INTO public.tag VALUES (nextval('tag_seq'), newElement, NULL, currval('tag_seq'));
									newTagID = currval('tag_seq');
									INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (newTagID, tagGroupID);
								END IF;
								raise notice 'New Tag: %',newTagID;
							END IF;
						END LOOP;
					END IF;
					IF oldTagArray <@ newTagArray THEN			--Check  if something missing
						raise notice 'NO DELETED';
					ELSE
						raise notice 'SOME DELETED';
						FOREACH oldElement IN ARRAY oldTagArray
						LOOP
							oldElement = trim(oldElement);
							tagFound = false;		
							FOREACH newElement IN ARRAY newTagArray
							LOOP
								newElement = trim(newElement);
								IF oldElement = newElement THEN
									tagFound = true;
								end if;
							END LOOP;
							raise notice '% not deleted: %',oldElement,tagFound;
							IF NOT tagFound THEN
								raise notice 'you will be deleted: %',oldElement;
								oldTagID = (SELECT id from tag WHERE name = oldElement);
								raise notice 'Old Tag: %',oldTagID;
								DELETE FROM jt_resource_tag WHERE resource_reference = resource_id AND tagID = oldTagID;
							END IF;
						END LOOP;
					END IF;
				END IF;
			END IF;
	--geometry
			IF (NEW.wkb_geometry IS NULL) THEN
				IF OLD.wkt_geometry IS DISTINCT FROM NEW.wkt_geometry THEN
					raise notice 'New Geom wkt only';
					UPDATE geom SET geo_field = public.geometry(NEW.wkt_geometry) FROM resource WHERE geom.id = resource.spatialcoverage AND resource.id = resourceID;
				END IF;
			ELSE
				IF OLD.wkt_geometry IS DISTINCT FROM NEW.wkt_geometry THEN
					raise notice 'New Geom in wkb';
				UPDATE geom SET geo_field = NEW.wkb_geometry FROM resource WHERE geom.id = resource.spatialcoverage AND resource.id = resourceID;
				END IF;
			END IF;
			
	--xml
			metadataID = (SELECT metadata.id FROM metadata WHERE content = OLD.xml);
			IF (OLD.xml IS DISTINCT FROM NEW.xml) THEN
				raise notice 'xml file is changeging! Thanks captain';
				Update metadata SET content = NEW.xml WHERE metadata.id = metadataID;
			END IF;
	--metadatalanguage
			IF (OLD.language IS DISTINCT FROM NEW.language) THEN
				raise notice 'metadatalanguage changed!';
				oldTagID = (SELECT id from tag WHERE name = OLD.language);
				raise notice 'Old Tag: %',oldTagID;
				IF EXISTS (SELECT 1 FROM tag WHERE tag.name = NEW.language) THEN
					newTagID = (SELECT id from tag WHERE name = NEW.language);
				ELSE
					raise notice 'Tag % doesn''t exist, executing insertion procedure',NEW.language;
					tagGroupID = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'language');
					INSERT INTO public.tag VALUES (nextval('tag_seq'), NEW.language, NULL, currval('tag_seq'));
					newTagID = currval('tag_seq');
					INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (newTagID, tagGroupID);
				END IF;
				raise notice 'New Tag: %',newTagID;
				UPDATE jt_metadata_tag SET tagid = newTagID WHERE metadata_reference = metadataID AND oldTagID = tagID;
			END IF;
	--topiccategory
			IF OLD.topiccategory IS DISTINCT FROM NEW.topiccategory THEN
				raise notice 'Topiccategory!!!: %',NEW.topiccategory;
				oldTagID = (SELECT id from tag WHERE name = OLD.topiccategory);
				raise notice 'Old Tag: %',oldTagID;
				IF EXISTS (SELECT 1 FROM tag WHERE tag.name = NEW.topiccategory) THEN
					newTagID = (SELECT id from tag WHERE name = NEW.topiccategory);
				ELSE
					raise notice 'Tag % doesn''t exist, executing insertion procedure',NEW.topiccategory;
					tagGroupID = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'topic category');
					INSERT INTO public.tag VALUES (nextval('tag_seq'), NEW.topiccategory, NULL, currval('tag_seq'));
					newTagID = currval('tag_seq');
					INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (newTagID, tagGroupID);
				END IF;
				raise notice 'New Tag: %',newTagID;
				UPDATE jt_resource_tag SET tagid = newTagID WHERE resource_reference = resourceID AND oldTagID = tagid;
			END IF;
	--conditionapplyingtoaccessanduse (license)
			IF OLD.conditionapplyingtoaccessanduse IS DISTINCT FROM NEW.conditionapplyingtoaccessanduse THEN
				raise notice 'licence: %',NEW.conditionapplyingtoaccessanduse;
				oldTagID = (SELECT id from tag WHERE name = OLD.conditionapplyingtoaccessanduse);
				raise notice 'Old Tag: %',oldTagID;
				IF EXISTS (SELECT 1 FROM tag WHERE tag.name = NEW.conditionapplyingtoaccessanduse) THEN
					newTagID = (SELECT id from tag WHERE name = NEW.conditionapplyingtoaccessanduse);
				ELSE
					raise notice 'Tag % doesn''t exist, executing insertion procedure',NEW.conditionapplyingtoaccessanduse;
					tagGroupID = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'license');
					INSERT INTO public.tag VALUES (nextval('tag_seq'), NEW.conditionapplyingtoaccessanduse, NULL, currval('tag_seq'));
					newTagID = currval('tag_seq');
					INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (newTagID, tagGroupID);
				END IF;
				raise notice 'New Tag: %',newTagID;
				UPDATE resource SET resource.license = newTagID WHERE resource.id = resourceID;
				
			END IF;	
	--otherConstraints
			IF OLD.otherConstraints IS DISTINCT FROM NEW.otherConstraints THEN
				raise notice 'OtherConstraints!!!: %',NEW.otherConstraints;
				oldTagID = (SELECT id from tag WHERE name = OLD.otherConstraints);
				raise notice 'Old Tag: %',oldTagID;
				IF EXISTS (SELECT 1 FROM tag WHERE tag.name = NEW.otherConstraints) THEN
					newTagID = (SELECT id from tag WHERE name = NEW.otherConstraints);
				ELSE
					raise notice 'Tag % doesn''t exist, executing insertion procedure',NEW.otherConstraints;
					tagGroupID = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'topic category');
					INSERT INTO public.tag VALUES (nextval('tag_seq'), NEW.topiccategory, NULL, currval('tag_seq'));
					newTagID = currval('tag_seq');
					INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (newTagID, tagGroupID);
				END IF;
				raise notice 'New Tag: %',newTagID;
				UPDATE jt_resource_tag SET tagid = newTagID WHERE resource_reference = resourceID AND oldTagID = tagid;
			END IF;		
	--metadata creation date
			IF OLD.date IS DISTINCT FROM NEW.date THEN
				raise notice 'MD Data date: %',NEW.date;
				UPDATE metadata SET creationdate = NEW.date WHERE id = metadataID;
			END IF;
	--responisble party role
			IF OLD.responsiblepartyrole IS DISTINCT FROM NEW.responsiblepartyrole THEN
				raise notice 'responsibleparty role has changed: %',NEW.responsiblepartyrole;
				UPDATE contact SET description = NEM.responsiblepartyrole WHERE id = contactID;
			END IF;
	--Links
			IF OLD.links IS DISTINCT FROM NEW.links THEN
				raise notice 'Hey listen! Link has changed: %',new.links;
				-- Deletion of old representations, should go faster o.O I suppose...
				FOR representationID IN (SELECT representation.id FROM representation, jt_resource_representation WHERE representation.id = repID AND resource_reference = resourceID)
				LOOP
					DELETE FROM jt_resource_representation WHERE resource_reference = resourceID AND repID = representationID; -- Can be done, because its 1 to n, so one representation only hangs at one resource.
					DELETE FROM representation WHERE id = representationID;
				END LOOP;
				count = 0;
				firstElement = true;
				raise NOTICE '%',NEW.links;
				FOREACH linkElement IN ARRAY (SELECT (regexp_split_to_array(NEW.links, ',')))
				LOOP
					IF (firstElement) THEN
						raise Notice 'Was auch immer: %',linkElement;
						firstElement = false;
					ELSE
						elementNumber = count%3;
						raise Notice 'nyu: %', elementNumber;
						CASE elementNumber
							WHEN 0 THEN
								--raise Notice 'Descr: %',linkElement;
								repDescr = linkElement;
							WHEN 1 THEN
								--raise Notice 'Typ: %',linkElement;
								repTyp = linkElement;
							WHEN 2 THEN
								--raise Notice 'URL: %',linkElement;
								repURL = linkElement;
								--here a new representation should be build.
								if ( repDescr IS NOT NULL OR repTyp IS NOT NULL OR repURL IS NOT NULL) THEN
									INSERT INTO public.representation (id, name, description, contenttype, contentlocation)
										VALUES (nextval('representation_seq'), NEW.title, repDescr, repTyp, RepURL);
									INSERT INTO public.jt_resource_representation (repID, resource_reference)
										VALUES (currval('representation_seq'), currval('resource_seq'));
								END IF;
						END CASE;
						count=count+1;
					END IF;
				END LOOP;
			END IF;
		END IF;
	RETURN NEW;
	END;
	$$;


ALTER FUNCTION public.update_py_to_switch() OWNER TO postgres;

--
-- TOC entry 2211 (class 1255 OID 211608)
-- Name: array_accum(anyelement); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE array_accum(anyelement) (
    SFUNC = array_append,
    STYPE = anyarray,
    INITCOND = '{}'
);


ALTER AGGREGATE public.array_accum(anyelement) OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 211619)
-- Name: contact_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contact_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 298 (class 1259 OID 212229)
-- Name: contact; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE contact (
    id integer DEFAULT nextval('contact_seq'::regclass) NOT NULL,
    name character varying(64),
    organisation character varying(100),
    description character varying(200),
    email character varying,
    url character varying(150)
);


ALTER TABLE public.contact OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 211643)
-- Name: cs_all_attr_mapping_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_all_attr_mapping_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_all_attr_mapping_sequence OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 211645)
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
-- TOC entry 213 (class 1259 OID 211655)
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
-- TOC entry 211 (class 1259 OID 211649)
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
-- TOC entry 212 (class 1259 OID 211652)
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
-- TOC entry 261 (class 1259 OID 211882)
-- Name: cs_attr_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_attr_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_attr_sequence OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 211670)
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
-- TOC entry 215 (class 1259 OID 211676)
-- Name: cs_cat_link_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_cat_link_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_cat_link_sequence OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 211678)
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
-- TOC entry 217 (class 1259 OID 211685)
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
-- TOC entry 262 (class 1259 OID 211884)
-- Name: cs_cat_node_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_cat_node_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_cat_node_sequence OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 211696)
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
-- TOC entry 219 (class 1259 OID 211706)
-- Name: cs_class_attr_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_class_attr_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_class_attr_sequence OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 211708)
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
-- TOC entry 280 (class 1259 OID 212030)
-- Name: cs_class_hierarchy; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW cs_class_hierarchy AS
 SELECT father_child.father,
    father_child.child
   FROM ( SELECT a.foreign_key_references_to AS child,
            a.class_id AS father,
            c.primary_key_field AS pk,
            c.table_name,
            a.field_name,
            a.isarray
           FROM cs_attr a,
            cs_class c
          WHERE (((a.foreign_key = true) AND (a.class_id = c.id)) AND (a.indexed = true))) father_child;


ALTER TABLE public.cs_class_hierarchy OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 211886)
-- Name: cs_class_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_class_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_class_sequence OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 212139)
-- Name: cs_config_attr_exempt_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_config_attr_exempt_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_config_attr_exempt_sequence OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 212141)
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
-- TOC entry 289 (class 1259 OID 212099)
-- Name: cs_config_attr_jt_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_config_attr_jt_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_config_attr_jt_sequence OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 212101)
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
-- TOC entry 283 (class 1259 OID 212072)
-- Name: cs_config_attr_key_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_config_attr_key_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_config_attr_key_sequence OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 212074)
-- Name: cs_config_attr_key; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_key (
    id integer DEFAULT nextval('cs_config_attr_key_sequence'::regclass) NOT NULL,
    key character varying(200) NOT NULL
);


ALTER TABLE public.cs_config_attr_key OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 212091)
-- Name: cs_config_attr_type_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_config_attr_type_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_config_attr_type_sequence OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 212093)
-- Name: cs_config_attr_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_type (
    id integer DEFAULT nextval('cs_config_attr_type_sequence'::regclass) NOT NULL,
    type character(1) NOT NULL,
    descr character varying(200)
);


ALTER TABLE public.cs_config_attr_type OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 212080)
-- Name: cs_config_attr_value_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_config_attr_value_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_config_attr_value_sequence OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 212082)
-- Name: cs_config_attr_value; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_config_attr_value (
    id integer DEFAULT nextval('cs_config_attr_value_sequence'::regclass) NOT NULL,
    value text
);


ALTER TABLE public.cs_config_attr_value OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 211715)
-- Name: cs_domain_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_domain_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_domain_sequence OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 211717)
-- Name: cs_domain; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_domain (
    id integer DEFAULT nextval('cs_domain_sequence'::regclass) NOT NULL,
    name character varying(30)
);


ALTER TABLE public.cs_domain OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 212175)
-- Name: cs_dynamic_children_helper; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_dynamic_children_helper (
    id numeric NOT NULL,
    name character varying(256),
    code text
);


ALTER TABLE public.cs_dynamic_children_helper OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 212034)
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
-- TOC entry 223 (class 1259 OID 211721)
-- Name: cs_icon_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_icon_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_icon_sequence OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 211723)
-- Name: cs_icon; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_icon (
    id integer DEFAULT nextval('cs_icon_sequence'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    file_name character varying(100) DEFAULT 'default_icon.gif'::character varying NOT NULL
);


ALTER TABLE public.cs_icon OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 211728)
-- Name: cs_java_class_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_java_class_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_java_class_sequence OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 211730)
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
-- TOC entry 227 (class 1259 OID 211738)
-- Name: cs_locks_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_locks_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_locks_sequence OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 211740)
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
-- TOC entry 229 (class 1259 OID 211747)
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
-- TOC entry 230 (class 1259 OID 211758)
-- Name: cs_method_class_assoc_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_method_class_assoc_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_method_class_assoc_sequence OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 211760)
-- Name: cs_method_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_method_class_assoc (
    class_id integer NOT NULL,
    method_id integer NOT NULL,
    id integer DEFAULT nextval('cs_method_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_method_class_assoc OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 211888)
-- Name: cs_method_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_method_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_method_sequence OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 211764)
-- Name: cs_permission_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_permission_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_permission_sequence OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 211766)
-- Name: cs_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_permission (
    id integer DEFAULT nextval('cs_permission_sequence'::regclass) NOT NULL,
    key character varying(10),
    description character varying(100)
);


ALTER TABLE public.cs_permission OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 211770)
-- Name: cs_policy_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_policy_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_policy_sequence OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 211772)
-- Name: cs_policy; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_policy (
    id integer DEFAULT nextval('cs_policy_sequence'::regclass) NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.cs_policy OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 211776)
-- Name: cs_policy_rule_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_policy_rule_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_policy_rule_sequence OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 211778)
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
-- TOC entry 238 (class 1259 OID 211782)
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
-- TOC entry 239 (class 1259 OID 211795)
-- Name: cs_query_class_assoc_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_query_class_assoc_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_query_class_assoc_sequence OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 211797)
-- Name: cs_query_class_assoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_query_class_assoc (
    class_id integer NOT NULL,
    query_id integer NOT NULL,
    id integer DEFAULT nextval('cs_query_class_assoc_sequence'::regclass) NOT NULL
);


ALTER TABLE public.cs_query_class_assoc OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 211801)
-- Name: cs_query_link_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_query_link_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_query_link_sequence OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 211803)
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
-- TOC entry 243 (class 1259 OID 211807)
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
-- TOC entry 265 (class 1259 OID 211890)
-- Name: cs_query_parameter_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_query_parameter_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_query_parameter_sequence OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 211892)
-- Name: cs_query_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_query_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_query_sequence OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 211816)
-- Name: cs_query_store_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_query_store_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_query_store_sequence OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 211818)
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
-- TOC entry 246 (class 1259 OID 211822)
-- Name: cs_query_store_ug_assoc_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_query_store_ug_assoc_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_query_store_ug_assoc_sequence OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 211824)
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
-- TOC entry 248 (class 1259 OID 211828)
-- Name: cs_query_ug_assoc_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_query_ug_assoc_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_query_ug_assoc_sequence OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 211830)
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
-- TOC entry 282 (class 1259 OID 212057)
-- Name: cs_stringrepcache; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cs_stringrepcache (
    class_id integer NOT NULL,
    object_id integer NOT NULL,
    stringrep character varying(512)
);


ALTER TABLE public.cs_stringrepcache OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 211834)
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
-- TOC entry 267 (class 1259 OID 211894)
-- Name: cs_type_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_type_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_type_sequence OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 211842)
-- Name: cs_ug_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_ug_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_ug_sequence OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 211844)
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
-- TOC entry 253 (class 1259 OID 211853)
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
-- TOC entry 268 (class 1259 OID 211896)
-- Name: cs_ug_attr_perm_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_ug_attr_perm_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_ug_attr_perm_sequence OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 211857)
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
-- TOC entry 269 (class 1259 OID 211898)
-- Name: cs_ug_cat_node_perm_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_ug_cat_node_perm_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_ug_cat_node_perm_sequence OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 211861)
-- Name: cs_ug_class_perm_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_ug_class_perm_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_ug_class_perm_sequence OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 211863)
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
-- TOC entry 257 (class 1259 OID 211867)
-- Name: cs_ug_membership_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_ug_membership_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_ug_membership_sequence OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 211869)
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
-- TOC entry 259 (class 1259 OID 211873)
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
-- TOC entry 270 (class 1259 OID 211900)
-- Name: cs_ug_method_perm_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_ug_method_perm_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_ug_method_perm_sequence OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 211877)
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
-- TOC entry 271 (class 1259 OID 211902)
-- Name: cs_usr_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cs_usr_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cs_usr_sequence OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 211987)
-- Name: geom_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE geom_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.geom_seq OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 211989)
-- Name: geom; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE geom (
    id integer DEFAULT nextval('geom_seq'::regclass) NOT NULL,
    geo_field geometry
);


ALTER TABLE public.geom OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 212025)
-- Name: geosuche; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW geosuche AS
 SELECT DISTINCT x.class_id,
    x.object_id,
    c.name,
    x.geo_field
   FROM (( SELECT DISTINCT cs_attr_object.class_id,
            cs_attr_object.object_id,
            geom.geo_field
           FROM geom,
            cs_attr_object
          WHERE ((cs_attr_object.attr_class_id = ( SELECT cs_class.id
                   FROM cs_class
                  WHERE ((cs_class.table_name)::text = 'GEOM'::text))) AND (cs_attr_object.attr_object_id = geom.id))
          ORDER BY cs_attr_object.class_id, cs_attr_object.object_id, geom.geo_field) x
   LEFT JOIN cs_cat_node c ON (((x.class_id = c.class_id) AND (x.object_id = c.object_id))))
  ORDER BY x.class_id, x.object_id, c.name, x.geo_field;


ALTER TABLE public.geosuche OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 211637)
-- Name: jt_fromresource_relationship_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_fromresource_relationship_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_fromresource_relationship_seq OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 212471)
-- Name: jt_fromresource_relationship; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_fromresource_relationship (
    id integer DEFAULT nextval('jt_fromresource_relationship_seq'::regclass) NOT NULL,
    resid integer NOT NULL,
    relationship_reference integer NOT NULL
);


ALTER TABLE public.jt_fromresource_relationship OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 211635)
-- Name: jt_metadata_relationship_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_metadata_relationship_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_metadata_relationship_seq OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 212453)
-- Name: jt_metadata_relationship; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_metadata_relationship (
    id integer DEFAULT nextval('jt_metadata_relationship_seq'::regclass) NOT NULL,
    metaid integer NOT NULL,
    relationship_reference integer NOT NULL
);


ALTER TABLE public.jt_metadata_relationship OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 211623)
-- Name: jt_metadata_resource_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_metadata_resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_metadata_resource_seq OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 212336)
-- Name: jt_metadata_resource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_metadata_resource (
    id integer DEFAULT nextval('jt_metadata_resource_seq'::regclass) NOT NULL,
    metaid integer NOT NULL,
    resource_reference integer NOT NULL
);


ALTER TABLE public.jt_metadata_resource OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 211615)
-- Name: jt_metadata_tag_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_metadata_tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_metadata_tag_seq OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 212258)
-- Name: jt_metadata_tag; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_metadata_tag (
    id integer DEFAULT nextval('jt_metadata_tag_seq'::regclass) NOT NULL,
    tagid integer NOT NULL,
    metadata_reference integer
);


ALTER TABLE public.jt_metadata_tag OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 211633)
-- Name: jt_relationship_tag_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_relationship_tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_relationship_tag_seq OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 212435)
-- Name: jt_relationship_tag; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_relationship_tag (
    id integer DEFAULT nextval('jt_relationship_tag_seq'::regclass) NOT NULL,
    relationship_reference integer NOT NULL,
    tagid integer NOT NULL
);


ALTER TABLE public.jt_relationship_tag OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 211627)
-- Name: jt_representation_tag_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_representation_tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_representation_tag_seq OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 212369)
-- Name: jt_representation_tag; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_representation_tag (
    id integer DEFAULT nextval('jt_representation_tag_seq'::regclass) NOT NULL,
    representation_reference integer NOT NULL,
    tagid integer NOT NULL
);


ALTER TABLE public.jt_representation_tag OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 211629)
-- Name: jt_resource_representation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_resource_representation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_resource_representation_seq OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 212387)
-- Name: jt_resource_representation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_resource_representation (
    id integer DEFAULT nextval('jt_resource_representation_seq'::regclass) NOT NULL,
    resource_reference integer NOT NULL,
    repid integer NOT NULL
);


ALTER TABLE public.jt_resource_representation OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 211621)
-- Name: jt_resource_tag_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_resource_tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_resource_tag_seq OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 212318)
-- Name: jt_resource_tag; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_resource_tag (
    id integer DEFAULT nextval('jt_resource_tag_seq'::regclass) NOT NULL,
    resource_reference integer NOT NULL,
    tagid integer NOT NULL
);


ALTER TABLE public.jt_resource_tag OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 211611)
-- Name: jt_tag_taggroup_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_tag_taggroup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_tag_taggroup_seq OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 212211)
-- Name: jt_tag_taggroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_tag_taggroup (
    id integer DEFAULT nextval('jt_tag_taggroup_seq'::regclass) NOT NULL,
    tag_reference integer NOT NULL,
    tgid integer NOT NULL
);


ALTER TABLE public.jt_tag_taggroup OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 211639)
-- Name: jt_toresource_relationship_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jt_toresource_relationship_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jt_toresource_relationship_seq OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 212489)
-- Name: jt_toresource_relationship; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jt_toresource_relationship (
    id integer DEFAULT nextval('jt_toresource_relationship_seq'::regclass) NOT NULL,
    resid integer NOT NULL,
    relationship_reference integer NOT NULL
);


ALTER TABLE public.jt_toresource_relationship OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 211617)
-- Name: metadata_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metadata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadata_seq OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 212238)
-- Name: metadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE metadata (
    id integer DEFAULT nextval('metadata_seq'::regclass) NOT NULL,
    name character varying(150) NOT NULL,
    tags integer NOT NULL,
    description text,
    contact integer,
    creationdate timestamp without time zone,
    contenttype character varying(200) NOT NULL,
    contentlocation character varying(200),
    content text NOT NULL
);


ALTER TABLE public.metadata OWNER TO postgres;

--
-- TOC entry 4035 (class 0 OID 0)
-- Dependencies: 299
-- Name: COLUMN metadata.tags; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metadata.tags IS 'jt_metadata_tag';


--
-- TOC entry 208 (class 1259 OID 211641)
-- Name: relationship_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE relationship_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relationship_seq OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 212405)
-- Name: relationship; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE relationship (
    id integer DEFAULT nextval('relationship_seq'::regclass) NOT NULL,
    name character varying(150),
    description character varying(200),
    tags integer NOT NULL,
    fromresource integer NOT NULL,
    toresource integer NOT NULL,
    metadata integer NOT NULL
);


ALTER TABLE public.relationship OWNER TO postgres;

--
-- TOC entry 4036 (class 0 OID 0)
-- Dependencies: 307
-- Name: COLUMN relationship.tags; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN relationship.tags IS 'jt_relationship_tag';


--
-- TOC entry 4037 (class 0 OID 0)
-- Dependencies: 307
-- Name: COLUMN relationship.fromresource; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN relationship.fromresource IS 'jt_fromresource_relationship';


--
-- TOC entry 4038 (class 0 OID 0)
-- Dependencies: 307
-- Name: COLUMN relationship.toresource; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN relationship.toresource IS 'jt_toresource_relationship';


--
-- TOC entry 4039 (class 0 OID 0)
-- Dependencies: 307
-- Name: COLUMN relationship.metadata; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN relationship.metadata IS 'jt_metadata_relationship';


--
-- TOC entry 203 (class 1259 OID 211631)
-- Name: representation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE representation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.representation_seq OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 212354)
-- Name: representation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE representation (
    id integer DEFAULT nextval('representation_seq'::regclass) NOT NULL,
    name character varying(150) NOT NULL,
    description text,
    tags integer,
    contenttype character varying(150),
    contentlocation character varying(200),
    content text
);


ALTER TABLE public.representation OWNER TO postgres;

--
-- TOC entry 4040 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN representation.tags; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN representation.tags IS 'jt_representation_tag';


--
-- TOC entry 200 (class 1259 OID 211625)
-- Name: resource_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resource_seq OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 212276)
-- Name: resource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE resource (
    id integer DEFAULT nextval('resource_seq'::regclass) NOT NULL,
    uuid character varying(100) NOT NULL,
    name character varying(150) NOT NULL,
    description text,
    tags integer NOT NULL,
    spatialcoverage integer NOT NULL,
    fromdate timestamp without time zone,
    todate timestamp without time zone,
    creationdate timestamp without time zone,
    publicationdate timestamp without time zone,
    lastmodificationdate timestamp without time zone,
    contact integer,
    representation integer NOT NULL,
    license integer,
    metadata integer NOT NULL
);


ALTER TABLE public.resource OWNER TO postgres;

--
-- TOC entry 4041 (class 0 OID 0)
-- Dependencies: 301
-- Name: COLUMN resource.tags; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN resource.tags IS 'jt_resource_tag';


--
-- TOC entry 4042 (class 0 OID 0)
-- Dependencies: 301
-- Name: COLUMN resource.representation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN resource.representation IS 'jt_resource_representation';


--
-- TOC entry 4043 (class 0 OID 0)
-- Dependencies: 301
-- Name: COLUMN resource.metadata; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN resource.metadata IS 'jt_metadata_resource';


--
-- TOC entry 194 (class 1259 OID 211613)
-- Name: tag_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_seq OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 212199)
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tag (
    id integer DEFAULT nextval('tag_seq'::regclass) NOT NULL,
    name character varying(200) NOT NULL,
    description character varying(500),
    taggroup integer NOT NULL
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- TOC entry 4044 (class 0 OID 0)
-- Dependencies: 296
-- Name: COLUMN tag.taggroup; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tag.taggroup IS 'jt_tag_taggroup';


--
-- TOC entry 192 (class 1259 OID 211609)
-- Name: taggroup_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE taggroup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggroup_seq OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 212193)
-- Name: taggroup; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE taggroup (
    id integer DEFAULT nextval('taggroup_seq'::regclass) NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(800)
);


ALTER TABLE public.taggroup OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 212565)
-- Name: pycsw_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW pycsw_view AS
 WITH tag_to_group_resource AS (
         SELECT jt_resource_tag.resource_reference AS resid,
            tag.name,
            jt_tag_taggroup.tgid AS taggroup
           FROM jt_resource_tag,
            tag,
            jt_tag_taggroup
          WHERE ((jt_resource_tag.tagid = tag.id) AND (jt_tag_taggroup.tag_reference = tag.taggroup))
        ), tag_to_group_metadata AS (
         SELECT jt_metadata_tag.metadata_reference AS metaid,
            tag.name,
            jt_tag_taggroup.tgid AS taggroup
           FROM jt_metadata_tag,
            tag,
            jt_tag_taggroup
          WHERE ((jt_metadata_tag.tagid = tag.id) AND (jt_tag_taggroup.tag_reference = tag.taggroup))
        ), accumulatedtags_resource AS (
         SELECT tag_to_group_resource.resid,
            tag_to_group_resource.taggroup,
            array_to_string(array_accum(tag_to_group_resource.name), ', '::text) AS value
           FROM tag_to_group_resource
          GROUP BY tag_to_group_resource.taggroup, tag_to_group_resource.resid
        ), accumulatedtags_metadata AS (
         SELECT tag_to_group_metadata.metaid,
            tag_to_group_metadata.taggroup,
            array_to_string(array_accum(tag_to_group_metadata.name), ', '::text) AS value
           FROM tag_to_group_metadata
          GROUP BY tag_to_group_metadata.taggroup, tag_to_group_metadata.metaid
        ), accumulatedlinks AS (
         SELECT resource.id,
            resource.name,
            concat(rep.description, ',', rep.contenttype, ',', rep.contentlocation) AS link
           FROM ((resource
      LEFT JOIN jt_resource_representation jt_rep ON ((jt_rep.resource_reference = resource.id)))
   LEFT JOIN representation rep ON ((rep.id = jt_rep.repid)))
        ), temptablanguageresource AS (
         SELECT resource.id,
            accumulatedtags_resource.value AS language
           FROM accumulatedtags_resource,
            resource,
            taggroup
          WHERE (((accumulatedtags_resource.taggroup = taggroup.id) AND ((taggroup.name)::text = 'language'::text)) AND (resource.id = accumulatedtags_resource.resid))
        ), temptablanguagemetadata AS (
         SELECT metadata.id,
            accumulatedtags_metadata.value AS language
           FROM accumulatedtags_metadata,
            metadata,
            taggroup
          WHERE (((accumulatedtags_metadata.taggroup = taggroup.id) AND ((taggroup.name)::text = 'language'::text)) AND (metadata.id = accumulatedtags_metadata.metaid))
        ), temptabkeywords AS (
         SELECT resource.id,
            accumulatedtags_resource.value AS keywords
           FROM accumulatedtags_resource,
            resource,
            taggroup
          WHERE (((accumulatedtags_resource.taggroup = taggroup.id) AND ((taggroup.name)::text = 'keywords'::text)) AND (resource.id = accumulatedtags_resource.resid))
        ), temptabtopic AS (
         SELECT resource.id,
            accumulatedtags_resource.value AS topiccategory
           FROM accumulatedtags_resource,
            resource,
            taggroup
          WHERE (((accumulatedtags_resource.taggroup = taggroup.id) AND ((taggroup.name)::text = 'topic category'::text)) AND (resource.id = accumulatedtags_resource.resid))
        ), temptabotherconst AS (
         SELECT resource.id,
            accumulatedtags_resource.value AS otherconstraints
           FROM accumulatedtags_resource,
            resource,
            taggroup
          WHERE (((accumulatedtags_resource.taggroup = taggroup.id) AND ((taggroup.name)::text = 'constraints'::text)) AND (resource.id = accumulatedtags_resource.resid))
        ), temptablinks AS (
         SELECT accumulatedlinks.id,
            concat('none', ',', array_to_string(array_accum(accumulatedlinks.link), ', '::text)) AS links
           FROM accumulatedlinks
          GROUP BY accumulatedlinks.id
        ), fulltablewoanytext AS (
         SELECT DISTINCT (resource.uuid)::text AS identifier,
            NULL::text AS parentidentifier,
            resource.name AS title,
            resource.description AS abstract,
            resource.fromdate AS time_begin,
            resource.todate AS time_end,
            spatia.geo_field AS wkb_geometry,
            resource.creationdate AS date_creation,
            resource.publicationdate AS date_publication,
            resource.lastmodificationdate AS date_modified,
            rescontact.name AS creator,
            rescontact.organisation AS organization,
            rescontact.email AS contact_email,
            sourceresource.uuid AS source,
            licensetag.name AS conditionapplyingtoaccessanduse,
            reslang.language AS resourcelanguage,
            temptabkeywords.keywords,
            ( SELECT st_astext(spatia.geo_field) AS wkt_geometry) AS wkt_geometry,
            metadata.content AS xml,
            metalang.language,
            topic.topiccategory,
            'otherRestrictions'::text AS accessconstraints,
            otherconst.otherconstraints,
            metadata.creationdate AS date,
            rescontact.description AS responsiblepartyrole,
            temptablinks.links,
            NULL::text AS date_revision,
            NULL::text AS insert_date,
            NULL::text AS relation,
            NULL::text AS contributor,
            NULL::text AS mdsource,
            NULL::text AS type,
            NULL::text AS schema,
            NULL::text AS format,
            NULL::text AS publisher,
            NULL::text AS title_alternate,
            NULL::text AS typename
           FROM ((((((((((((((((resource
      LEFT JOIN temptablanguageresource reslang ON ((resource.id = reslang.id)))
   LEFT JOIN temptabkeywords ON ((resource.id = temptabkeywords.id)))
   LEFT JOIN contact rescontact ON ((resource.contact = rescontact.id)))
   LEFT JOIN geom spatia ON ((resource.spatialcoverage = spatia.id)))
   LEFT JOIN jt_metadata_resource ON ((resource.metadata = jt_metadata_resource.resource_reference)))
   LEFT JOIN metadata ON ((jt_metadata_resource.metaid = metadata.id)))
   LEFT JOIN contact metacontact ON ((metadata.contact = metacontact.id)))
   LEFT JOIN temptablanguagemetadata metalang ON ((metadata.id = metalang.id)))
   LEFT JOIN temptabtopic topic ON ((resource.id = topic.id)))
   LEFT JOIN temptabotherconst otherconst ON ((resource.id = otherconst.id)))
   LEFT JOIN temptablinks ON ((resource.id = temptablinks.id)))
   LEFT JOIN jt_toresource_relationship ON ((resource.id = jt_toresource_relationship.resid)))
   LEFT JOIN relationship ON ((jt_toresource_relationship.relationship_reference = relationship.id)))
   LEFT JOIN jt_fromresource_relationship ON ((jt_fromresource_relationship.relationship_reference = relationship.id)))
   LEFT JOIN resource sourceresource ON ((jt_fromresource_relationship.resid = sourceresource.id)))
   LEFT JOIN tag licensetag ON ((resource.license = licensetag.id)))
        )
 SELECT DISTINCT fulltablewoanytext.identifier,
    fulltablewoanytext.parentidentifier,
    fulltablewoanytext.title,
    fulltablewoanytext.abstract,
    fulltablewoanytext.time_begin,
    fulltablewoanytext.time_end,
    fulltablewoanytext.wkb_geometry,
    fulltablewoanytext.date_creation,
    fulltablewoanytext.date_publication,
    fulltablewoanytext.date_modified,
    fulltablewoanytext.creator,
    fulltablewoanytext.organization,
    fulltablewoanytext.contact_email,
    fulltablewoanytext.source,
    fulltablewoanytext.conditionapplyingtoaccessanduse,
    fulltablewoanytext.resourcelanguage,
    fulltablewoanytext.keywords,
    fulltablewoanytext.wkt_geometry,
    fulltablewoanytext.xml,
    fulltablewoanytext.language,
    fulltablewoanytext.topiccategory,
    fulltablewoanytext.accessconstraints,
    fulltablewoanytext.otherconstraints,
    fulltablewoanytext.date,
    fulltablewoanytext.responsiblepartyrole,
    fulltablewoanytext.links,
    fulltablewoanytext.date_revision,
    fulltablewoanytext.insert_date,
    fulltablewoanytext.relation,
    fulltablewoanytext.contributor,
    fulltablewoanytext.mdsource,
    fulltablewoanytext.type,
    fulltablewoanytext.schema,
    fulltablewoanytext.format,
    fulltablewoanytext.publisher,
    fulltablewoanytext.title_alternate,
    fulltablewoanytext.typename,
    concat(fulltablewoanytext.*) AS anytext
   FROM fulltablewoanytext;


ALTER TABLE public.pycsw_view OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 212185)
-- Name: table_ignore; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE table_ignore (
    table_name text NOT NULL,
    ignore boolean
);


ALTER TABLE public.table_ignore OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 212021)
-- Name: textsearch; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW textsearch AS
 SELECT DISTINCT x.class_id,
    x.object_id,
    c.name,
    x.string_val
   FROM (cs_attr_string x
   LEFT JOIN cs_cat_node c ON (((x.class_id = c.class_id) AND (x.object_id = c.object_id))))
  ORDER BY x.class_id, x.object_id, c.name, x.string_val;


ALTER TABLE public.textsearch OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 212009)
-- Name: url_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE url_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.url_seq OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 212011)
-- Name: url; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE url (
    id integer DEFAULT nextval('url_seq'::regclass) NOT NULL,
    object_name text NOT NULL,
    url_base_id integer NOT NULL
);


ALTER TABLE public.url OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 211998)
-- Name: url_base_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE url_base_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.url_base_seq OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 212000)
-- Name: url_base; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE url_base (
    id integer DEFAULT nextval('url_base_seq'::regclass) NOT NULL,
    prot_prefix character varying NOT NULL,
    path text NOT NULL,
    server text NOT NULL
);


ALTER TABLE public.url_base OWNER TO postgres;

--
-- TOC entry 3762 (class 2606 OID 211905)
-- Name: attr_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_attr_perm
    ADD CONSTRAINT attr_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3764 (class 2606 OID 211907)
-- Name: cat_node_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_cat_node_perm
    ADD CONSTRAINT cat_node_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3785 (class 2606 OID 212064)
-- Name: cid_oid; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_stringrepcache
    ADD CONSTRAINT cid_oid PRIMARY KEY (class_id, object_id);


--
-- TOC entry 3766 (class 2606 OID 211909)
-- Name: class_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_class_perm
    ADD CONSTRAINT class_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3813 (class 2606 OID 212237)
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- TOC entry 3694 (class 2606 OID 211911)
-- Name: cs_all_attr_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_all_attr_mapping
    ADD CONSTRAINT cs_all_attr_mapping_pkey PRIMARY KEY (id);


--
-- TOC entry 3705 (class 2606 OID 211913)
-- Name: cs_cat_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_link
    ADD CONSTRAINT cs_cat_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3716 (class 2606 OID 211915)
-- Name: cs_class_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class_attr
    ADD CONSTRAINT cs_class_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3797 (class 2606 OID 212146)
-- Name: cs_config_attr_exempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_pkey PRIMARY KEY (id);


--
-- TOC entry 3799 (class 2606 OID 212148)
-- Name: cs_config_attr_exempt_usr_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_key_id_key UNIQUE (usr_id, key_id);


--
-- TOC entry 3793 (class 2606 OID 212106)
-- Name: cs_config_attr_jt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_pkey PRIMARY KEY (id);


--
-- TOC entry 3795 (class 2606 OID 212108)
-- Name: cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_ug_id_dom_id_key_id_key UNIQUE (usr_id, ug_id, dom_id, key_id);


--
-- TOC entry 3787 (class 2606 OID 212079)
-- Name: cs_config_attr_key_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_key
    ADD CONSTRAINT cs_config_attr_key_pkey PRIMARY KEY (id);


--
-- TOC entry 3791 (class 2606 OID 212098)
-- Name: cs_config_attr_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_type
    ADD CONSTRAINT cs_config_attr_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3789 (class 2606 OID 212090)
-- Name: cs_config_attr_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_config_attr_value
    ADD CONSTRAINT cs_config_attr_value_pkey PRIMARY KEY (id);


--
-- TOC entry 3718 (class 2606 OID 211917)
-- Name: cs_domain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_domain
    ADD CONSTRAINT cs_domain_pkey PRIMARY KEY (id);


--
-- TOC entry 3801 (class 2606 OID 212182)
-- Name: cs_dynamic_children_helper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_dynamic_children_helper
    ADD CONSTRAINT cs_dynamic_children_helper_pkey PRIMARY KEY (id);


--
-- TOC entry 3783 (class 2606 OID 212041)
-- Name: cs_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_pkey PRIMARY KEY (class_id, object_id, valid_from);


--
-- TOC entry 3720 (class 2606 OID 211919)
-- Name: cs_icon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_icon
    ADD CONSTRAINT cs_icon_pkey PRIMARY KEY (id);


--
-- TOC entry 3722 (class 2606 OID 211921)
-- Name: cs_java_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_java_class
    ADD CONSTRAINT cs_java_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3724 (class 2606 OID 211923)
-- Name: cs_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_locks
    ADD CONSTRAINT cs_locks_pkey PRIMARY KEY (id);


--
-- TOC entry 3728 (class 2606 OID 211925)
-- Name: cs_method_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method_class_assoc
    ADD CONSTRAINT cs_method_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3730 (class 2606 OID 211927)
-- Name: cs_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_permission
    ADD CONSTRAINT cs_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3732 (class 2606 OID 211929)
-- Name: cs_policy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy
    ADD CONSTRAINT cs_policy_pkey PRIMARY KEY (id);


--
-- TOC entry 3734 (class 2606 OID 211931)
-- Name: cs_policy_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3736 (class 2606 OID 211933)
-- Name: cs_policy_rule_policy_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_policy_rule
    ADD CONSTRAINT cs_policy_rule_policy_key UNIQUE (policy, permission);


--
-- TOC entry 3742 (class 2606 OID 211935)
-- Name: cs_query_class_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_class_assoc
    ADD CONSTRAINT cs_query_class_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3744 (class 2606 OID 211937)
-- Name: cs_query_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_link
    ADD CONSTRAINT cs_query_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3748 (class 2606 OID 211939)
-- Name: cs_query_store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store
    ADD CONSTRAINT cs_query_store_pkey PRIMARY KEY (id);


--
-- TOC entry 3750 (class 2606 OID 211941)
-- Name: cs_query_store_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_store_ug_assoc
    ADD CONSTRAINT cs_query_store_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3752 (class 2606 OID 211943)
-- Name: cs_query_ug_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_ug_assoc
    ADD CONSTRAINT cs_query_ug_assoc_pkey PRIMARY KEY (id);


--
-- TOC entry 3768 (class 2606 OID 211945)
-- Name: cs_ug_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_membership
    ADD CONSTRAINT cs_ug_membership_pkey PRIMARY KEY (id);


--
-- TOC entry 3758 (class 2606 OID 211947)
-- Name: cs_ug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_pkey PRIMARY KEY (id);


--
-- TOC entry 3760 (class 2606 OID 211852)
-- Name: cs_ug_prio_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug
    ADD CONSTRAINT cs_ug_prio_key UNIQUE (prio);


--
-- TOC entry 3777 (class 2606 OID 211994)
-- Name: geom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY geom
    ADD CONSTRAINT geom_pkey PRIMARY KEY (id);


--
-- TOC entry 3803 (class 2606 OID 212192)
-- Name: ignore_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY table_ignore
    ADD CONSTRAINT ignore_pk PRIMARY KEY (table_name);


--
-- TOC entry 3851 (class 2606 OID 212476)
-- Name: jt_fromresource_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_fromresource_relationship
    ADD CONSTRAINT jt_fromresource_relationship_pkey PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 212478)
-- Name: jt_fromresource_relationship_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_fromresource_relationship
    ADD CONSTRAINT jt_fromresource_relationship_unique UNIQUE (relationship_reference, resid);


--
-- TOC entry 3847 (class 2606 OID 212458)
-- Name: jt_metadata_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_metadata_relationship
    ADD CONSTRAINT jt_metadata_relationship_pkey PRIMARY KEY (id);


--
-- TOC entry 3849 (class 2606 OID 212460)
-- Name: jt_metadata_relationship_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_metadata_relationship
    ADD CONSTRAINT jt_metadata_relationship_unique UNIQUE (relationship_reference, metaid);


--
-- TOC entry 3827 (class 2606 OID 212341)
-- Name: jt_metadata_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_metadata_resource
    ADD CONSTRAINT jt_metadata_resource_pkey PRIMARY KEY (id);


--
-- TOC entry 3829 (class 2606 OID 212343)
-- Name: jt_metadata_resource_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_metadata_resource
    ADD CONSTRAINT jt_metadata_resource_unique UNIQUE (resource_reference, metaid);


--
-- TOC entry 3817 (class 2606 OID 212263)
-- Name: jt_metadata_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_metadata_tag
    ADD CONSTRAINT jt_metadata_tag_pkey PRIMARY KEY (id);


--
-- TOC entry 3819 (class 2606 OID 212265)
-- Name: jt_metadata_tag_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_metadata_tag
    ADD CONSTRAINT jt_metadata_tag_unique UNIQUE (metadata_reference, tagid);


--
-- TOC entry 3843 (class 2606 OID 212440)
-- Name: jt_relationship_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_relationship_tag
    ADD CONSTRAINT jt_relationship_tag_pkey PRIMARY KEY (id);


--
-- TOC entry 3845 (class 2606 OID 212442)
-- Name: jt_relationship_tag_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_relationship_tag
    ADD CONSTRAINT jt_relationship_tag_unique UNIQUE (relationship_reference, tagid);


--
-- TOC entry 3837 (class 2606 OID 212394)
-- Name: jt_representation_representation_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_resource_representation
    ADD CONSTRAINT jt_representation_representation_unique UNIQUE (repid, resource_reference);


--
-- TOC entry 3833 (class 2606 OID 212374)
-- Name: jt_representation_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_representation_tag
    ADD CONSTRAINT jt_representation_tags_pkey PRIMARY KEY (id);


--
-- TOC entry 3835 (class 2606 OID 212376)
-- Name: jt_representation_tags_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_representation_tag
    ADD CONSTRAINT jt_representation_tags_unique UNIQUE (representation_reference, tagid);


--
-- TOC entry 3839 (class 2606 OID 212392)
-- Name: jt_resource_representation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_resource_representation
    ADD CONSTRAINT jt_resource_representation_pkey PRIMARY KEY (id);


--
-- TOC entry 3823 (class 2606 OID 212323)
-- Name: jt_resource_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_resource_tag
    ADD CONSTRAINT jt_resource_tag_pkey PRIMARY KEY (id);


--
-- TOC entry 3825 (class 2606 OID 212325)
-- Name: jt_resource_tag_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_resource_tag
    ADD CONSTRAINT jt_resource_tag_unique UNIQUE (resource_reference, tagid);


--
-- TOC entry 3809 (class 2606 OID 212216)
-- Name: jt_tag_taggroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_tag_taggroup
    ADD CONSTRAINT jt_tag_taggroup_pkey PRIMARY KEY (id);


--
-- TOC entry 3811 (class 2606 OID 212218)
-- Name: jt_tag_taggroup_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_tag_taggroup
    ADD CONSTRAINT jt_tag_taggroup_unique UNIQUE (tag_reference, tgid);


--
-- TOC entry 3855 (class 2606 OID 212494)
-- Name: jt_toresource_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_toresource_relationship
    ADD CONSTRAINT jt_toresource_relationship_pkey PRIMARY KEY (id);


--
-- TOC entry 3857 (class 2606 OID 212496)
-- Name: jt_toresource_relationship_unique; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jt_toresource_relationship
    ADD CONSTRAINT jt_toresource_relationship_unique UNIQUE (relationship_reference, resid);


--
-- TOC entry 3815 (class 2606 OID 212247)
-- Name: metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metadata
    ADD CONSTRAINT metadata_pkey PRIMARY KEY (id);


--
-- TOC entry 3770 (class 2606 OID 211949)
-- Name: method_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_ug_method_perm
    ADD CONSTRAINT method_perm_pkey PRIMARY KEY (id);


--
-- TOC entry 3841 (class 2606 OID 212414)
-- Name: relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY relationship
    ADD CONSTRAINT relationship_pkey PRIMARY KEY (id);


--
-- TOC entry 3831 (class 2606 OID 212363)
-- Name: representation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY representation
    ADD CONSTRAINT representation_pkey PRIMARY KEY (id);


--
-- TOC entry 3821 (class 2606 OID 212287)
-- Name: resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (id);


--
-- TOC entry 3807 (class 2606 OID 212205)
-- Name: tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- TOC entry 3805 (class 2606 OID 212198)
-- Name: taggroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY taggroup
    ADD CONSTRAINT taggroup_pkey PRIMARY KEY (id);


--
-- TOC entry 3779 (class 2606 OID 212008)
-- Name: url_base_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY url_base
    ADD CONSTRAINT url_base_pkey PRIMARY KEY (id);


--
-- TOC entry 3781 (class 2606 OID 212019)
-- Name: url_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY url
    ADD CONSTRAINT url_pkey PRIMARY KEY (id);


--
-- TOC entry 3700 (class 2606 OID 211951)
-- Name: x_cs_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_attr
    ADD CONSTRAINT x_cs_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 3710 (class 2606 OID 211953)
-- Name: x_cs_cat_node_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_cat_node
    ADD CONSTRAINT x_cs_cat_node_pkey PRIMARY KEY (id);


--
-- TOC entry 3712 (class 2606 OID 211955)
-- Name: x_cs_class_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_name_key UNIQUE (name);


--
-- TOC entry 3714 (class 2606 OID 211957)
-- Name: x_cs_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_class
    ADD CONSTRAINT x_cs_class_pkey PRIMARY KEY (id);


--
-- TOC entry 3726 (class 2606 OID 211959)
-- Name: x_cs_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_method
    ADD CONSTRAINT x_cs_method_pkey PRIMARY KEY (id);


--
-- TOC entry 3738 (class 2606 OID 211961)
-- Name: x_cs_query_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_name_key UNIQUE (name);


--
-- TOC entry 3746 (class 2606 OID 211963)
-- Name: x_cs_query_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query_parameter
    ADD CONSTRAINT x_cs_query_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 3740 (class 2606 OID 211965)
-- Name: x_cs_query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_query
    ADD CONSTRAINT x_cs_query_pkey PRIMARY KEY (id);


--
-- TOC entry 3754 (class 2606 OID 211967)
-- Name: x_cs_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_name_key UNIQUE (name);


--
-- TOC entry 3756 (class 2606 OID 211969)
-- Name: x_cs_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_type
    ADD CONSTRAINT x_cs_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3772 (class 2606 OID 211971)
-- Name: x_cs_usr_login_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_login_name_key UNIQUE (login_name);


--
-- TOC entry 3774 (class 2606 OID 211973)
-- Name: x_cs_usr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cs_usr
    ADD CONSTRAINT x_cs_usr_pkey PRIMARY KEY (id);


--
-- TOC entry 3696 (class 1259 OID 211982)
-- Name: attr_object_derived_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index ON cs_attr_object_derived USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3697 (class 1259 OID 211983)
-- Name: attr_object_derived_index_acid_aoid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_acid_aoid ON cs_attr_object_derived USING btree (attr_class_id, attr_object_id);


--
-- TOC entry 3698 (class 1259 OID 211984)
-- Name: attr_object_derived_index_cid_oid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_derived_index_cid_oid ON cs_attr_object_derived USING btree (class_id, object_id);


--
-- TOC entry 3695 (class 1259 OID 211981)
-- Name: attr_object_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX attr_object_index ON cs_attr_object USING btree (class_id, object_id, attr_class_id, attr_object_id);


--
-- TOC entry 3706 (class 1259 OID 211974)
-- Name: cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cl_idx ON cs_cat_node USING btree (class_id);


--
-- TOC entry 3690 (class 1259 OID 211975)
-- Name: cs_all_attr_mapping_index1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index1 ON cs_all_attr_mapping USING btree (class_id);


--
-- TOC entry 3691 (class 1259 OID 211976)
-- Name: cs_all_attr_mapping_index2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index2 ON cs_all_attr_mapping USING btree (attr_class_id);


--
-- TOC entry 3692 (class 1259 OID 211977)
-- Name: cs_all_attr_mapping_index3; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_all_attr_mapping_index3 ON cs_all_attr_mapping USING btree (attr_object_id);


--
-- TOC entry 3701 (class 1259 OID 211985)
-- Name: cs_attr_string_class_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_class_idx ON cs_attr_string USING btree (class_id);


--
-- TOC entry 3702 (class 1259 OID 211986)
-- Name: cs_attr_string_object_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX cs_attr_string_object_idx ON cs_attr_string USING btree (object_id);


--
-- TOC entry 3775 (class 1259 OID 212020)
-- Name: geo_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX geo_index ON geom USING gist (geo_field);


--
-- TOC entry 3703 (class 1259 OID 211978)
-- Name: i_cs_attr_string_aco_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX i_cs_attr_string_aco_id ON cs_attr_string USING btree (attr_id, class_id, object_id);


--
-- TOC entry 3707 (class 1259 OID 211979)
-- Name: ob_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ob_idx ON cs_cat_node USING btree (object_id);


--
-- TOC entry 3708 (class 1259 OID 211980)
-- Name: obj_cl_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX obj_cl_idx ON cs_cat_node USING btree (class_id, object_id);


--
-- TOC entry 3905 (class 2620 OID 212573)
-- Name: pydelete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER pydelete INSTEAD OF DELETE ON pycsw_view FOR EACH ROW EXECUTE PROCEDURE delete_py_to_switch();


--
-- TOC entry 3904 (class 2620 OID 212572)
-- Name: pyinsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER pyinsert INSTEAD OF INSERT ON pycsw_view FOR EACH ROW EXECUTE PROCEDURE insert_py_to_switch();


--
-- TOC entry 3906 (class 2620 OID 212575)
-- Name: pyupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER pyupdate INSTEAD OF UPDATE ON pycsw_view FOR EACH ROW EXECUTE PROCEDURE update_py_to_switch();


--
-- TOC entry 3868 (class 2606 OID 212154)
-- Name: cs_config_attr_exempt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3869 (class 2606 OID 212159)
-- Name: cs_config_attr_exempt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3867 (class 2606 OID 212149)
-- Name: cs_config_attr_exempt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_exempt
    ADD CONSTRAINT cs_config_attr_exempt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3863 (class 2606 OID 212119)
-- Name: cs_config_attr_jt_dom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_dom_id_fkey FOREIGN KEY (dom_id) REFERENCES cs_domain(id);


--
-- TOC entry 3864 (class 2606 OID 212124)
-- Name: cs_config_attr_jt_key_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_key_id_fkey FOREIGN KEY (key_id) REFERENCES cs_config_attr_key(id);


--
-- TOC entry 3866 (class 2606 OID 212134)
-- Name: cs_config_attr_jt_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_type_id_fkey FOREIGN KEY (type_id) REFERENCES cs_config_attr_type(id);


--
-- TOC entry 3862 (class 2606 OID 212114)
-- Name: cs_config_attr_jt_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3861 (class 2606 OID 212109)
-- Name: cs_config_attr_jt_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3865 (class 2606 OID 212129)
-- Name: cs_config_attr_jt_val_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_config_attr_jt
    ADD CONSTRAINT cs_config_attr_jt_val_id_fkey FOREIGN KEY (val_id) REFERENCES cs_config_attr_value(id);


--
-- TOC entry 3858 (class 2606 OID 212042)
-- Name: cs_history_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_class_id_fkey FOREIGN KEY (class_id) REFERENCES cs_class(id);


--
-- TOC entry 3860 (class 2606 OID 212052)
-- Name: cs_history_ug_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_ug_id_fkey FOREIGN KEY (ug_id) REFERENCES cs_ug(id);


--
-- TOC entry 3859 (class 2606 OID 212047)
-- Name: cs_history_usr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cs_history
    ADD CONSTRAINT cs_history_usr_id_fkey FOREIGN KEY (usr_id) REFERENCES cs_usr(id);


--
-- TOC entry 3901 (class 2606 OID 212484)
-- Name: jt_fromresource_relationship_fk_relationship; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_fromresource_relationship
    ADD CONSTRAINT jt_fromresource_relationship_fk_relationship FOREIGN KEY (relationship_reference) REFERENCES relationship(id);


--
-- TOC entry 3900 (class 2606 OID 212479)
-- Name: jt_fromresource_relationship_fk_resource; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_fromresource_relationship
    ADD CONSTRAINT jt_fromresource_relationship_fk_resource FOREIGN KEY (resid) REFERENCES resource(id);


--
-- TOC entry 3898 (class 2606 OID 212461)
-- Name: jt_metadata_relationship_fk_metadata; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_metadata_relationship
    ADD CONSTRAINT jt_metadata_relationship_fk_metadata FOREIGN KEY (metaid) REFERENCES metadata(id);


--
-- TOC entry 3899 (class 2606 OID 212466)
-- Name: jt_metadata_relationship_fk_relationship; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_metadata_relationship
    ADD CONSTRAINT jt_metadata_relationship_fk_relationship FOREIGN KEY (relationship_reference) REFERENCES relationship(id);


--
-- TOC entry 3885 (class 2606 OID 212344)
-- Name: jt_metadata_resource_fk_meta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_metadata_resource
    ADD CONSTRAINT jt_metadata_resource_fk_meta FOREIGN KEY (metaid) REFERENCES metadata(id);


--
-- TOC entry 3886 (class 2606 OID 212349)
-- Name: jt_metadata_resource_fk_resource; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_metadata_resource
    ADD CONSTRAINT jt_metadata_resource_fk_resource FOREIGN KEY (resource_reference) REFERENCES resource(id);


--
-- TOC entry 3876 (class 2606 OID 212271)
-- Name: jt_metadata_tag_fk_meta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_metadata_tag
    ADD CONSTRAINT jt_metadata_tag_fk_meta FOREIGN KEY (metadata_reference) REFERENCES metadata(id);


--
-- TOC entry 3875 (class 2606 OID 212266)
-- Name: jt_metadata_tag_fk_tag; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_metadata_tag
    ADD CONSTRAINT jt_metadata_tag_fk_tag FOREIGN KEY (tagid) REFERENCES tag(id);


--
-- TOC entry 3897 (class 2606 OID 212448)
-- Name: jt_relationship_tag_fk_relationship; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_relationship_tag
    ADD CONSTRAINT jt_relationship_tag_fk_relationship FOREIGN KEY (relationship_reference) REFERENCES relationship(id);


--
-- TOC entry 3896 (class 2606 OID 212443)
-- Name: jt_relationship_tag_fk_tag; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_relationship_tag
    ADD CONSTRAINT jt_relationship_tag_fk_tag FOREIGN KEY (tagid) REFERENCES tag(id);


--
-- TOC entry 3891 (class 2606 OID 212400)
-- Name: jt_representation_representation_fk_representation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_resource_representation
    ADD CONSTRAINT jt_representation_representation_fk_representation FOREIGN KEY (repid) REFERENCES representation(id);


--
-- TOC entry 3890 (class 2606 OID 212395)
-- Name: jt_representation_representation_fk_resource; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_resource_representation
    ADD CONSTRAINT jt_representation_representation_fk_resource FOREIGN KEY (resource_reference) REFERENCES resource(id);


--
-- TOC entry 3889 (class 2606 OID 212382)
-- Name: jt_representation_tags_fk_representation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_representation_tag
    ADD CONSTRAINT jt_representation_tags_fk_representation FOREIGN KEY (representation_reference) REFERENCES representation(id);


--
-- TOC entry 3888 (class 2606 OID 212377)
-- Name: jt_representation_tags_fk_tag; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_representation_tag
    ADD CONSTRAINT jt_representation_tags_fk_tag FOREIGN KEY (tagid) REFERENCES tag(id);


--
-- TOC entry 3884 (class 2606 OID 212331)
-- Name: jt_resource_tag_fk_resource; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_resource_tag
    ADD CONSTRAINT jt_resource_tag_fk_resource FOREIGN KEY (resource_reference) REFERENCES resource(id);


--
-- TOC entry 3883 (class 2606 OID 212326)
-- Name: jt_resource_tag_fk_tag; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_resource_tag
    ADD CONSTRAINT jt_resource_tag_fk_tag FOREIGN KEY (tagid) REFERENCES tag(id);


--
-- TOC entry 3871 (class 2606 OID 212219)
-- Name: jt_tag_taggroup_fk_tag; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_tag_taggroup
    ADD CONSTRAINT jt_tag_taggroup_fk_tag FOREIGN KEY (tag_reference) REFERENCES tag(id);


--
-- TOC entry 3872 (class 2606 OID 212224)
-- Name: jt_tag_taggroup_fk_taggroup; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_tag_taggroup
    ADD CONSTRAINT jt_tag_taggroup_fk_taggroup FOREIGN KEY (tgid) REFERENCES taggroup(id);


--
-- TOC entry 3903 (class 2606 OID 212502)
-- Name: jt_toresource_relationship_fk_relationship; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_toresource_relationship
    ADD CONSTRAINT jt_toresource_relationship_fk_relationship FOREIGN KEY (relationship_reference) REFERENCES relationship(id);


--
-- TOC entry 3902 (class 2606 OID 212497)
-- Name: jt_toresource_relationship_fk_resource; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jt_toresource_relationship
    ADD CONSTRAINT jt_toresource_relationship_fk_resource FOREIGN KEY (resid) REFERENCES resource(id);


--
-- TOC entry 3874 (class 2606 OID 212253)
-- Name: metadata_contact_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metadata
    ADD CONSTRAINT metadata_contact_fk FOREIGN KEY (contact) REFERENCES contact(id);


--
-- TOC entry 3873 (class 2606 OID 212248)
-- Name: metadata_jt_tag_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metadata
    ADD CONSTRAINT metadata_jt_tag_link FOREIGN KEY (tags) REFERENCES metadata(id);


--
-- TOC entry 3893 (class 2606 OID 212420)
-- Name: relationship_jt_fromresource_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationship
    ADD CONSTRAINT relationship_jt_fromresource_link FOREIGN KEY (fromresource) REFERENCES relationship(id);


--
-- TOC entry 3895 (class 2606 OID 212430)
-- Name: relationship_jt_metadata_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationship
    ADD CONSTRAINT relationship_jt_metadata_link FOREIGN KEY (metadata) REFERENCES relationship(id);


--
-- TOC entry 3892 (class 2606 OID 212415)
-- Name: relationship_jt_tags_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationship
    ADD CONSTRAINT relationship_jt_tags_link FOREIGN KEY (tags) REFERENCES relationship(id);


--
-- TOC entry 3894 (class 2606 OID 212425)
-- Name: relationship_jt_toresource_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relationship
    ADD CONSTRAINT relationship_jt_toresource_link FOREIGN KEY (toresource) REFERENCES relationship(id);


--
-- TOC entry 3887 (class 2606 OID 212364)
-- Name: representation_jt_tag_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY representation
    ADD CONSTRAINT representation_jt_tag_link FOREIGN KEY (tags) REFERENCES representation(id);


--
-- TOC entry 3879 (class 2606 OID 212298)
-- Name: resource_contact_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_contact_fk FOREIGN KEY (contact) REFERENCES contact(id);


--
-- TOC entry 3881 (class 2606 OID 212308)
-- Name: resource_geom_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_geom_fk FOREIGN KEY (spatialcoverage) REFERENCES geom(id);


--
-- TOC entry 3877 (class 2606 OID 212288)
-- Name: resource_jt_metadata; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_jt_metadata FOREIGN KEY (metadata) REFERENCES resource(id);


--
-- TOC entry 3882 (class 2606 OID 212313)
-- Name: resource_jt_repres_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_jt_repres_link FOREIGN KEY (representation) REFERENCES resource(id);


--
-- TOC entry 3878 (class 2606 OID 212293)
-- Name: resource_jt_tags_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_jt_tags_link FOREIGN KEY (tags) REFERENCES resource(id);


--
-- TOC entry 3880 (class 2606 OID 212303)
-- Name: resource_licensetag_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_licensetag_fk FOREIGN KEY (license) REFERENCES tag(id);


--
-- TOC entry 3870 (class 2606 OID 212206)
-- Name: tag_jt_taggroup_link; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_jt_taggroup_link FOREIGN KEY (taggroup) REFERENCES tag(id);


--
-- TOC entry 4031 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 4045 (class 0 OID 0)
-- Dependencies: 312
-- Name: pycsw_view; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE pycsw_view FROM PUBLIC;
REVOKE ALL ON TABLE pycsw_view FROM postgres;
GRANT ALL ON TABLE pycsw_view TO postgres;
GRANT ALL ON TABLE pycsw_view TO PUBLIC;


-- Completed on 2014-06-25 14:09:01

--
-- PostgreSQL database dump complete
--

