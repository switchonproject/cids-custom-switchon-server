#!/bin/bash
#===============================================================================
#
# FILE: getgeo.sh
#
# USAGE: ./getgeo.sh
#
# DESCRIPTION: run the script so that the geodata will be downloaded and inserted into your
# database in schema "geonames"
#
# OPTIONS: ---
# REQUIREMENTS: PostgreSQL 9.1 w/ modules: postgis
# BUGS: ---
# NOTES: ---
# AUTHOR: Andreas (aka Harpagophyt )
# COMPANY: <a href="http://forum.geonames.org/gforum/posts/list/926.page" target="_blank" rel="nofollow">http://forum.geonames.org/gforum/posts/list/926.page</a>
# VERSION: 1.7
# CREATED: 07/06/2008
# REVISION: 1.1 2008-06-07 replace COPY continentCodes through INSERT statements.
# 1.2 2008-11-25 Adjusted by Bastiaan Wakkie in order to not unnessisarily
# download.
# 1.3 2011-08-07 Updated script with tree changes. Removes 2 obsolete records from "countryinfo" dump image,
#                updated timeZones table with raw_offset and updated postalcode to varchar(20).
# 1.4 2012-10-01 (Scott Wilson) Added is_historical and is_colloquial to alternate names table, and country
#                code to time zones.  Add column constraints after loading data, runs super fast on my machine.
#                Normalized column naming, various other tweaks.
# 1.6 2014-08-27 (Pascal Dihé) added PostGis geometry colums, added hierarchy
# 1.7 2014-08-28 (Pascal Dihé) modified for cids Integration Base and SWITCH-ON Project
#===============================================================================
#!/bin/bash

WORKPATH="/tmp/geonames"
TMPPATH="tmp"
PCPATH="pc"
PREFIX="_"
DBHOST="127.0.0.1"
DBPORT="5432"
DBUSER="postgres"
FILES="allCountries.zip alternateNames.zip userTags.zip admin1CodesASCII.txt admin2Codes.txt countryInfo.txt featureCodes_en.txt iso-languagecodes.txt timeZones.txt hierarchy.zip"
DBNAME="switchon"

psql -U $DBUSER -h $DBHOST -p $DBPORT $DBNAME <<EOT

DROP SCHEMA IF EXISTS geonames;
CREATE SCHEMA geonames;

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
-- CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;

DROP TABLE IF EXISTS geonames.geoname CASCADE;
CREATE TABLE geonames.geoname (
    id              INT PRIMARY KEY,
    name            VARCHAR,
    ascii_name      VARCHAR,
    alternate_names VARCHAR,
    latitude        FLOAT,
    longitude       FLOAT,
    fclass          CHAR(1),
    fcode           CHAR(10),
    country         CHAR(2),
    cc2             VARCHAR,
    admin1          VARCHAR,
    admin2          VARCHAR,
    admin3          VARCHAR,
    admin4          VARCHAR,
    population      BIGINT,
    elevation       INT,
    gtopo30         INT,
    timezone        VARCHAR,
    modified_date   DATE
);

-- PostGis stuff
SELECT AddGeometryColumn( 'geonames','geoname','the_geom', 4326, 'GEOMETRY', 2 );
ALTER TABLE geonames.geoname ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(the_geom) = 4326);
ALTER TABLE geonames.geoname ADD CONSTRAINT enforce_dims_geom CHECK (st_ndims(the_geom) = 2);
ALTER TABLE geonames.geoname ADD CONSTRAINT enforce_geotype_geom CHECK (geometrytype(the_geom) = 'POINT'::text OR the_geom IS NULL);

DROP TABLE IF EXISTS geonames.alternatename;
CREATE TABLE geonames.alternatename (
    id                INT PRIMARY KEY,
    geoname_id        INT,
    iso_lang          VARCHAR,
    alternate_name    VARCHAR,
    is_preferred_name BOOLEAN,
    is_short_name     BOOLEAN,
    is_colloquial     BOOLEAN,
    is_historic       BOOLEAN
);

DROP TABLE IF EXISTS geonames.countryinfo;
CREATE TABLE geonames.countryinfo (
    iso_alpha2           CHAR(2) PRIMARY KEY,
    iso_alpha3           CHAR(3),
    iso_numeric          INTEGER,
    fips_code            VARCHAR(3),
    country              VARCHAR,
    capital              VARCHAR,
    area                 DOUBLE PRECISION, -- square km
    population           INTEGER,
    continent            CHAR(2),
    tld                  VARCHAR,
    currency_code        CHAR(3),
    currency_name        VARCHAR,
    phone                VARCHAR,
    postal               VARCHAR,
    postal_regex         VARCHAR,
    languages            VARCHAR,
    geoname_id           INT,
    neighbours           VARCHAR,
    equivalent_fips_code VARCHAR(3)
);



DROP TABLE IF EXISTS geonames.iso_languagecodes;
CREATE TABLE geonames.iso_languagecodes(
    iso_639_3     CHAR(4),
    iso_639_2     VARCHAR(50),
    iso_639_1     VARCHAR(50),
    language_name VARCHAR
);


DROP TABLE IF EXISTS geonames.admin1CodesAscii;
CREATE TABLE geonames.admin1CodesAscii (
    code       CHAR(20) PRIMARY KEY,
    name       TEXT,
    name_ascii  TEXT,
    geoname_id INT
);

DROP TABLE IF EXISTS geonames.admin2CodesAscii;
CREATE TABLE geonames.admin2CodesAscii (
    code      CHAR(80) PRIMARY KEY,
    name      TEXT,
    name_ascii TEXT,
    geoname_id INT
);

DROP TABLE IF EXISTS geonames.featureCodes;
CREATE TABLE geonames.featureCodes (
    code        CHAR(7) PRIMARY KEY,
    name        VARCHAR,
    description TEXT
);

DROP TABLE IF EXISTS geonames.timeZones;
CREATE TABLE geonames.timeZones (
    id           VARCHAR PRIMARY KEY,
    country_code VARCHAR(2),
    GMT_offset NUMERIC(3,1),
    DST_offset NUMERIC(3,1),
    raw_offset NUMERIC(3,1)
);

DROP TABLE IF EXISTS geonames.continentCodes;
CREATE TABLE geonames.continentCodes (
    code       CHAR(2) PRIMARY KEY,
    name       VARCHAR,
    geoname_id INT
);

DROP TABLE IF EXISTS geonames.postalcodes;
CREATE TABLE geonames.postalcodes (
    country_code CHAR(2),
    postal_code  VARCHAR,
    place_name   VARCHAR,
    admin1_name  VARCHAR,
    admin1_code  VARCHAR,
    admin2_name  VARCHAR,
    admin2_code  VARCHAR,
    admin3_name  VARCHAR,
    admin3_code  VARCHAR,
    latitude     FLOAT,
    longitude    FLOAT,
    accuracy     SMALLINT
);

DROP TABLE IF EXISTS geonames.hierarchy;
CREATE TABLE geonames.hierarchy (
    parent_id INT, 
    child_id  INT,
    htype   VARCHAR
);

-- PostGis stuff
SELECT AddGeometryColumn( 'geonames','postalcodes','the_geom', 4326, 'GEOMETRY', 2 );
ALTER TABLE geonames.postalcodes ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(the_geom) = 4326);
ALTER TABLE geonames.postalcodes ADD CONSTRAINT enforce_dims_geom CHECK (st_ndims(the_geom) = 2);
ALTER TABLE geonames.postalcodes ADD CONSTRAINT enforce_geotype_geom CHECK (geometrytype(the_geom) = 'POINT'::text OR the_geom IS NULL);

EOT

# check if needed directories do already exsist
if [ -d "$WORKPATH" ]; then
    echo "$WORKPATH exists..."
    sleep 0
else
    echo "$WORKPATH and subdirectories will be created..."
    mkdir -p $WORKPATH/{$TMPPATH,$PCPATH}
    echo "created $WORKPATH"
fi

echo
echo ",---- STARTING (downloading, unpacking and preparing)"
cd $WORKPATH/$TMPPATH
for i in $FILES
do
    wget -nv -N --progress=bar "http://download.geonames.org/export/dump/$i" # get newer files
    if [ $i -nt $PREFIX$i ] || [ ! -e $PREFIX$i ] ; then
        cp -p $i $PREFIX$i
        if [[ $i =~ \.zip$ ]]; then
          echo "| unzipping $i";
          unzip -u -q $i
          echo "| $i has been unzipped";
        fi

        case "$i" in
            iso-languagecodes.txt)
                tail -n +2 iso-languagecodes.txt > iso-languagecodes.txt.tmp;
                ;;
            countryInfo.txt)
                grep -v '^#' countryInfo.txt > countryInfo.txt.tmp;
                ;;
            timeZones.txt)
                tail -n +2 timeZones.txt > timeZones.txt.tmp;
                ;;
        esac
        echo "| $i has been downloaded";
    else
        echo "| $i is already the latest version"
    fi
done

# download the postalcodes (ZIP Codes). You must know yourself the url
cd $WORKPATH/$PCPATH
wget -nv -N "http://download.geonames.org/export/zip/allCountries.zip"

if [ $WORKPATH/$PCPATH/allCountries.zip -nt $WORKPATH/$PCPATH/allCountries$PREFIX.zip ] || [ ! -e $WORKPATH/$PCPATH/allCountries.zip ]; then
    echo "| Attempt to unzip $WORKPATH/$PCPATH/allCountries.zip file..."
    unzip -u -q $WORKPATH/$PCPATH/allCountries.zip
    cp -p $WORKPATH/$PCPATH/allCountries.zip $WORKPATH/$PCPATH/allCountries$PREFIX.zip
    echo "| allCountries.zip (ZIP Codes) has been downloaded"
else
    echo "| allCountries.zip (ZIP Codes) is already the latest version"
fi

echo "+---- FILL DATABASE ------+"

psql -e -U $DBUSER -h $DBHOST -p $DBPORT $DBNAME <<EOT
copy geonames.geoname (id,name,ascii_name,alternate_names,latitude,
              longitude,fclass,fcode,country,cc2,admin1,admin2,
              admin3,admin4,population,elevation,gtopo30,
              timezone,modified_date)
    from '${WORKPATH}/${TMPPATH}/allCountries.txt' null as '';

copy geonames.postalcodes (country_code,postal_code,place_name,
                  admin1_name,admin1_code,admin2_name,admin2_code,
                  admin3_name,admin3_code,latitude,longitude,accuracy)
    from '${WORKPATH}/${PCPATH}/allCountries.txt' null as '';

copy geonames.timeZones (country_code,id,GMT_offset,DST_offset,raw_offset)
    from '${WORKPATH}/${TMPPATH}/timeZones.txt.tmp' null as '';

copy geonames.featureCodes (code,name,description)
    from '${WORKPATH}/${TMPPATH}/featureCodes_en.txt' null as '';

copy geonames.admin1CodesAscii (code,name,name_ascii,geoname_id)
    from '${WORKPATH}/${TMPPATH}/admin1CodesASCII.txt' null as '';

copy geonames.admin2CodesAscii (code,name,name_ascii,geoname_id)
    from '${WORKPATH}/${TMPPATH}/admin2Codes.txt' null as '';

copy geonames.iso_languagecodes (iso_639_3,iso_639_2,iso_639_1,language_name)
    from '${WORKPATH}/${TMPPATH}/iso-languagecodes.txt.tmp' null as '';

copy geonames.countryInfo (iso_alpha2,iso_alpha3,iso_numeric,fips_code,country,
                  capital,area,population,continent,tld,currency_code,
                  currency_name,phone,postal,postal_regex,languages,
                  geoname_id,neighbours,equivalent_fips_code)
    from '${WORKPATH}/${TMPPATH}/countryInfo.txt.tmp' null as '';

copy geonames.alternatename (id,geoname_id,iso_lang,alternate_name,
                    is_preferred_name,is_short_name,
                    is_colloquial,is_historic)
    from '${WORKPATH}/${TMPPATH}/alternateNames.txt' null as '';
    
copy geonames.hierarchy (parent_id, child_id, htype)
    from '${WORKPATH}/${TMPPATH}/hierarchy.txt' null as ''; 

INSERT INTO geonames.continentCodes VALUES ('AF', 'Africa', 6255146);
INSERT INTO geonames.continentCodes VALUES ('AS', 'Asia', 6255147);
INSERT INTO geonames.continentCodes VALUES ('EU', 'Europe', 6255148);
INSERT INTO geonames.continentCodes VALUES ('NA', 'North America', 6255149);
INSERT INTO geonames.continentCodes VALUES ('OC', 'Oceania', 6255150);
INSERT INTO geonames.continentCodes VALUES ('SA', 'South America', 6255151);
INSERT INTO geonames.continentCodes VALUES ('AN', 'Antarctica', 6255152);
CREATE INDEX index_countryinfo_geonameid ON geonames.countryinfo (geoname_id);
CREATE INDEX index_alternatename_geonameid ON geonames.alternatename (geoname_id);
CREATE UNIQUE INDEX index_geoname_id ON geonames.geoname (id);

-- PostGis Stuff -  populate the geometry columns
UPDATE geonames.geoname SET the_geom = ST_GeomFromText('POINT(' || longitude || ' ' || latitude || ')',4326);
UPDATE geonames.postalcodes SET the_geom = ST_GeomFromText('POINT(' || longitude || ' ' || latitude || ')',4326);
-- CREATE INDEX index_geoname_geom ON geonames.geoname USING GIST (the_geom);

EOT

psql -U $DBUSER -h $DBHOST -p $DBPORT $DBNAME <<EOT
ALTER TABLE ONLY geonames.countryinfo
    ADD CONSTRAINT fk_geonameid FOREIGN KEY (geoname_id)
        REFERENCES geonames.geoname(id);
ALTER TABLE ONLY geonames.alternatename
    ADD CONSTRAINT fk_geonameid FOREIGN KEY (geoname_id)
        REFERENCES geonames.geoname(id);
-- FK constraint disabled since 7522530 and 0 are not in geoname tabe!?
-- ALTER TABLE ONLY geonames.hierarchy
--     ADD CONSTRAINT fk_parentid FOREIGN KEY (parent_id)
--         REFERENCES geonames.geoname(id);
-- ALTER TABLE ONLY geonames.hierarchy
--     ADD CONSTRAINT fk_childid FOREIGN KEY (child_id)
--         REFERENCES geonames.geoname(id);


-- create a country table as materialized view
DROP MATERIALIZED VIEW IF EXISTS geonames.country;
CREATE MATERIALIZED VIEW 
    geonames.country AS select c.geoname_id as id, c.country, g.the_geom from geonames.countryinfo c, geonames.geoname g WHERE c.geoname_id = g.id ORDER BY c.country;
-- CREATE INDEX index_country_geom ON geonames.country USING GIST (the_geom);

-- create european countries table as view
CREATE OR REPLACE VIEW geonames.europe AS
	SELECT * from geonames.country WHERE id IN (SELECT child_id FROM geonames.hierarchy WHERE parent_id = 6255148);

EOT

echo "'----- DONE ( have fun... )"
