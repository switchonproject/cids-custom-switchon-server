DROP TABLE IF EXISTS pycsw.data_table;
CREATE SCHEMA IF NOT EXISTS pycsw;
CREATE TABLE pycsw.data_table AS (SELECT * FROM pycsw.pycsw_view);

ALTER TABLE ONLY pycsw.data_table
ADD CONSTRAINT pk_pycsw_data_table PRIMARY KEY (identifier);

CREATE UNIQUE INDEX index_identifier ON pycsw.data_table (identifier);
CREATE INDEX index_geometry ON pycsw.data_table USING GIST (wkb_geometry);
CREATE INDEX index_anytext ON pycsw.data_table USING gin(to_tsvector('english', anytext));
CREATE INDEX index_keywords ON pycsw.data_table USING gin(to_tsvector('english', keywords));
