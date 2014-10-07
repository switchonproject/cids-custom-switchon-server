-- Dynamic Children Helper

-- cs_dynamic_children_helper
DROP TABLE IF EXISTS cs_dynamic_children_helper;
CREATE TABLE cs_dynamic_children_helper
(
  id numeric NOT NULL,
  name character varying(256),
  code text,
  CONSTRAINT cs_dynamic_children_helper_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

-- execute()
CREATE OR REPLACE FUNCTION execute(_command character varying)
  RETURNS character varying AS
$BODY$
DECLARE _r int;
BEGIN
EXECUTE _command;
    RETURN 'Yes: ' || _command || ' executed';
EXCEPTION
    WHEN OTHERS THEN
    RETURN 'No:  ' || _command || ' failed';
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- cs_refresh_dynchilds_functions()
CREATE OR REPLACE FUNCTION cs_refresh_dynchilds_functions()
  RETURNS character varying AS
$BODY$
BEGIN
 
DROP schema csdc cascade;
CREATE schema csdc;
perform execute('CREATE OR REPLACE FUNCTION csdc.'||name||' RETURNS VARCHAR AS $$ select'''||regexp_replace(REPLACE(code,'''',''''''),'(.*?)<ds::param.*>(.*?)</ds::param>(.*?)',E'\\1''||$\\2||''\\3','g')||'''::varchar $$ LANGUAGE ''sql'';') FROM cs_dynamic_children_helper;
    RETURN 'Functions refreshed';
EXCEPTION
    WHEN OTHERS THEN
    RETURN 'Error occured';
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



