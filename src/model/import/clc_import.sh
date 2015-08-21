#! /bin/bash   
DB="switchon_dev"    
USR="switchon"    
PWD=""    
while IFS== read resid clcid          
do 
         
echo -e processing resource $resid and CLC layer $clcid 

ogrinfo $clcid.shp -sql "SELECT COUNT(*) FROM $clcid"
   
ogr2ogr -progress -simplify 500 --config PG_USE_COPY YES -f PostgreSQL PG:"host=127.0.0.1 port=5432 dbname=$DB password=$PWD user=$USR" -lco DIM=2 $clcid.shp -sql "SELECT id FROM $clcid" -overwrite -lco OVERWRITE=YES -t_srs "EPSG:4326" -a_srs "EPSG:4326" -lco SCHEMA=import_tables -lco GEOMETRY_NAME=geom -nln geosearch_import -gt 65536 -nlt PROMOTE_TO_MULTI

psql $DB $USR -c "INSERT INTO public.geom_search(resource, geo_field) SELECT $resid, geom FROM import_tables.geosearch_import;"
	       
psql $DB $USR -c "WITH rep as (INSERT INTO public.representation (type, spatialresolution, name, description, applicationprofile, tags, function, contentlocation, temporalresolution, protocol, content, spatialscale, contenttype, uuid, uploadmessage, uploadstatus) VALUES (213, NULL, 'corine:$clcid Tileserver', 'corine:$clcid Tileserver', 1359, 11950, 72, 'http://tl-243.xtr.deltares.nl/tileserver/corine:$clcid@EPSG:900913@png/{z}/{x}/{y}.png', NULL, 205, NULL, NULL, 59, 'corine:$clcid', NULL, NULL) RETURNING id) INSERT INTO public.jt_resource_representation (representationid, resource_reference) SELECT id, $resid from rep;"	       
	       
done < clc_import.txt
