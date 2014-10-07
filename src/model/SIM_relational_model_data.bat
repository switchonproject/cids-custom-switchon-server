@ECHO OFF
@pg_dump --host brainslug --port 5432 --username "postgres" --no-password  --format plain --data-only --verbose --file "SIM_relational_model_data.sql" --table "public.contact" --table "public.geom" --table "public.jt_fromresource_relationship" --table "public.jt_metadata_relationship" --table "public.jt_metadata_resource" --table "public.jt_metadata_tag" --table "public.jt_relationship_tag" --table "public.jt_representation_tag" --table "public.jt_resource_representation" --table "public.jt_resource_tag" --table "public.jt_tag_taggroup" --table "public.jt_toresource_relationship" --table "public.metadata" --table "public.relationship" --table "public.representation" --table "public.resource" --table "public.tag" --table "public.taggroup" --table "public.url" --table "public.url_base" --schema "csdc" "switchon_demo_video_dev"

pause
