#! /bin/bash   
DB="switchon"    
USR="switchon"    
PWD=""
SHP="EcrFEC"
LYR="ECRINS:ECRINS_FEC"
RES="121"    
         
echo -e processing resource $RES and CLC layer $LYR 

ogrinfo $SHP.shp -sql "SELECT COUNT(*) FROM '$SHP'"

ogr2ogr -progress --config PG_USE_COPY YES -f PostgreSQL PG:"host=127.0.0.1 port=5432 dbname=$DB password=$PWD user=$USR" -lco DIM=2 $SHP.shp -sql "SELECT OBJECTID FROM $SHP" -overwrite -lco OVERWRITE=YES -t_srs "EPSG:4326" -a_srs "EPSG:4326" -lco SCHEMA=import_tables -lco GEOMETRY_NAME=geom -nln geosearch_import -gt 65536 -nlt PROMOTE_TO_MULTI

psql $DB $USR -c "INSERT INTO public.geom_search(resource, geo_field) SELECT $RES, ST_UNION(geom) FROM import_tables.geosearch_import;"

psql $DB $USR -c "WITH rep as (INSERT INTO public.representation (type, spatialresolution, name, description, applicationprofile, tags, function, contentlocation, temporalresolution, protocol, content, spatialscale, contenttype, uuid, uploadmessage, uploadstatus) VALUES (213, NULL, '$LYR Tileserver', '$LYR Tileserver', 1359, 11950, 72, 'http://tl-243.xtr.deltares.nl/tileserver/$LYR@EPSG:900913@png/{z}/{x}/{y}.png', NULL, 205, NULL, NULL, 59, '$LYR', NULL, NULL) RETURNING id) INSERT INTO public.jt_resource_representation (representationid, resource_reference) SELECT id, $RES from rep;"	
