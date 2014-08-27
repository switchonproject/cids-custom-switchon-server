--DROP TRIGGER pyDelete on pycsw_view;


CREATE or REPLACE FUNCTION delete_py_to_switch() RETURNS trigger AS $delete_py_to_switch$
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
	DELETE FROM public.jt_resource_tag as jt WHERE jt.resource_reference = resourceID;
	DELETE FROM resource WHERE id = resourceID;
	RETURN OLD;
	END;
	$delete_py_to_switch$
LANGUAGE 'plpgsql';

CREATE TRIGGER pyDelete INSTEAD OF DELETE -- AFTER INSERT -- 
ON pycsw_view
FOR EACH ROW
EXECUTE PROCEDURE delete_py_to_switch();