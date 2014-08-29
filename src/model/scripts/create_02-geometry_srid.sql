
-- Update of the srid for geom

DROP VIEW public.geosuche;

SELECT updategeometrysrid('geom', 'geo_field', 4326);
alter table geom add constraint enforce_srid_geo_field CHECK (st_srid(geo_field) = (4326));

CREATE OR REPLACE VIEW public.geosuche AS 
 SELECT DISTINCT x.class_id,
    x.object_id,
    c.name,
    x.geo_field
   FROM ( SELECT DISTINCT cs_attr_object.class_id,
            cs_attr_object.object_id,
            geom.geo_field
           FROM geom,
            cs_attr_object
          WHERE cs_attr_object.attr_class_id = (( SELECT cs_class.id
                   FROM cs_class
                  WHERE cs_class.table_name::text = 'GEOM'::text)) AND cs_attr_object.attr_object_id = geom.id
          ORDER BY cs_attr_object.class_id, cs_attr_object.object_id, geom.geo_field) x
     LEFT JOIN cs_cat_node c ON x.class_id = c.class_id AND x.object_id = c.object_id
  ORDER BY x.class_id, x.object_id, c.name, x.geo_field;

ALTER TABLE public.geosuche
  OWNER TO postgres;
