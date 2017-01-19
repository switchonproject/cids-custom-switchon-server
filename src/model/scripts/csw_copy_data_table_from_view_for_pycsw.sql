DROP TABLE IF EXISTS pycsw.data_table;


CREATE SCHEMA IF NOT EXISTS pycsw;


CREATE TABLE pycsw.data_table AS
  (SELECT *
   FROM pycsw.pycsw_view);


ALTER TABLE ONLY pycsw.data_table ADD CONSTRAINT pk_pycsw_data_table PRIMARY KEY (identifier);


DROP INDEX IF EXISTS data_table_index_identifier;


DROP INDEX IF EXISTS data_table_index_geometry;


DROP INDEX IF EXISTS data_table_index_anytext;


DROP INDEX IF EXISTS data_table_index_keywords;


CREATE UNIQUE INDEX data_table_index_identifier ON pycsw.data_table (identifier);


CREATE INDEX data_table_index_geometry ON pycsw.data_table USING GIST (wkb_geometry);


CREATE INDEX data_table_index_anytext ON pycsw.data_table USING gin(to_tsvector('simple'::regconfig, anytext::text));


CREATE INDEX data_table_index_keywords ON pycsw.data_table USING gin(to_tsvector('simple'::regconfig, keywords::text));

