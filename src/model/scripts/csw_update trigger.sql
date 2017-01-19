--DROP TRIGGER pyUpdate on pycsw_view;


CREATE or REPLACE FUNCTION update_py_to_switch() RETURNS trigger AS $update_py_to_switch$
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
	DECLARE tagname character varying;
	DECLARE reslangID integer;
	DECLARE tagdescription character varying;
	DECLARE splitarray character varying[];
	DECLARE lopaID integer;
	DECLARE contactRoleID integer;
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
				raise notice 'Identifü!: %',NEW.identifier;
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
				taggroupID = (SELECT id FROM taggroup WHERE name = 'language');
				tagname = NEW.resourcelanguage;
				IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
					--00raise notice 'Tag % don''t exists', tagname;
					PERFORM createTag(tagname, taggroupID);
				END IF;
				reslangID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
				raise notice 'New Tag: %',reslangID;
				UPDATE resource SET language = reslangID WHERE resource.id = resourceID;
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
								IF EXISTS (SELECT 1 FROM tag, taggroup as tgroup WHERE tag.name = tag_trimmed AND taggroup = tgroup.id AND tgroup.name LIKE 'keyword%') THEN
									newTagID = (SELECT id from tag WHERE name = newElement);
								ELSE
									raise notice 'Tag % doesn''t exist, executing insertion procedure',newElement;
									tagGroupID = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'keywords - open');
									PERFORM createtag(tag_trimmed, taggroupID);
									newTagID = currval('tag_seq');
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
	--metadatalanguage /CHANGES HERE
			IF OLD.language IS DISTINCT FROM NEW.language THEN
				taggroupID = (SELECT id FROM taggroup WHERE name = 'language');
				tagname = NEW.language;
				IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
					--00raise notice 'Tag % don''t exists', tagname;
					PERFORM createTag(tagname, taggroupID);
				END IF;
				metadataID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
				raise notice 'New Tag: %',reslangID;
				UPDATE metadata SET language = metadataID WHERE metadata.id = resourceID;
			END IF;	
	--topiccategory
			IF OLD.topiccategory IS DISTINCT FROM NEW.topiccategory THEN
				raise notice 'Topiccategory!!!: %',NEW.topiccategory;
				IF NOT EXISTS (SELECT 1 FROM tag WHERE tag.name = NEW.topiccategory) THEN
					tagGroupID = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'topic category');
					PERFORM createTag(NEW.topiccategory, taggroupID);
				END IF;
				newTagID = (SELECT id FROM tag WHERE tag.name = NEW.topiccategory);
				raise notice 'New Tag: %',newTagID;
				UPDATE resource SET topiccategory = newTagID WHERE id = resourceID;
			END IF;
	--conditionapplyingtoaccessanduse (license)
			IF OLD.conditionapplyingtoaccessanduse IS DISTINCT FROM NEW.conditionapplyingtoaccessanduse THEN
				taggroupID = (SELECT id FROM taggroup WHERE name = 'access conditions');
				tagname = NEW.conditionapplyingtoaccessanduse;
				IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
					tagname = 'other';
					IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
						--00raise notice 'Tag % don''t exists', tagname;
						PERFORM createTag(tagname, taggroupID);
					END IF;
				END IF;
				newTagID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
				UPDATE resource SET resource.accesconditions = newTagID WHERE resource.id = resourceID;	
			END IF;	
	--otherConstraints
			IF OLD.otherConstraints IS DISTINCT FROM NEW.otherConstraints THEN
				taggroupID = (SELECT id FROM taggroup WHERE name = 'access limitations');
				tagdescription = dataset.limitationsonpublicaccess;
				splitarray = regexp_split_to_array(dataset.limitationsonpublicaccess, ',');
				tagname = splitarray[1];
				IF NOT EXISTS (SELECT 1 from tag WHERE tag.description = tagdescription AND tag.taggroup = taggroupID) THEN
					raise notice 'Tag % don''t exists', tagname;
					lopaID = createTag(tagname, taggroupID);
				END IF;
				raise notice 'Description|: %', tagdescription;
				UPDATE tag SET description = tagdescription WHERE id = lopaID;
			newTagID = (SELECT id FROM tag WHERE description = tagdescription AND tag.taggroup = taggroupID);
			UPDATE resource SET accesslimitations = newTagID WHERE id = resourceID;
			END IF;		
	--metadata creation date
			IF OLD.date IS DISTINCT FROM NEW.date THEN
				raise notice 'MD Data date: %',NEW.date;
				UPDATE metadata SET creationdate = NEW.date WHERE id = metadataID;
			END IF;
	--responisble party role
			IF OLD.responsiblepartyrole IS DISTINCT FROM NEW.responsiblepartyrole THEN
				taggroupID = (SELECT id FROM taggroup WHERE name = 'role');
				tagname = NEW.responsiblepartyrole;
				IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
					--00raise notice 'Tag % don''t exists', tagname;
					PERFORM createTag(tagname, taggroupID);
				END IF;
				contactRoleID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
				raise notice 'responsibleparty role has changed: %',NEW.responsiblepartyrole;
				UPDATE contact SET role = contactRoleID WHERE id = contactID;
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
	$update_py_to_switch$
LANGUAGE 'plpgsql';

CREATE TRIGGER pyUpdate INSTEAD OF UPDATE -- AFTER UPDATE -- 
ON pycsw_view
FOR EACH ROW
EXECUTE PROCEDURE update_py_to_switch();