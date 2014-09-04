--DROP TRIGGER pyInsert on pycsw_view;


CREATE or REPLACE FUNCTION insert_py_to_switch() RETURNS trigger AS $insert_py_to_switch$
DECLARE dataset record;
DECLARE nya record;

DECLARE tag_raw character varying;
DECLARE tag_trimmed character varying;
DECLARE tagID integer;
DECLARE taggroupID integer = NULL;
DECLARE tagname character varying;
DECLARE tagdescription character varying;
DECLARE splitarray character varying[];
DECLARE count integer;
--Resource
DECLARE scopeID integer;
DECLARE sridID integer;
DECLARE locationID integer;
DECLARE accessConditionsID integer;
DECLARE reslangID integer;
DECLARE conformityID integer;
DECLARE contactRoleID integer;
DECLARE resourceTypeID integer;
DECLARE rescontactID integer;
DECLARE geomID integer;
DECLARE topicID integer;
DECLARE collectionID integer;
DECLARE lopaID integer;
--Metadata
DECLARE metadataTypeID integer;
DECLARE metalangID integer;
DECLARE metastandardID integer;
DECLARE metacontactArray character varying[];
DECLARE metacontactName character Varying;
DECLARE metacontactMail character Varying;
DECLARE metacontactOrgan character varying = 'SWITCH-ON';
DECLARE metacontactDescr character varying = 'Sharing Water-related Information to Tackle Changes in the Hydrosphere – for Operational Needs (SWITCH-ON).';
DECLARE metacontactURL character varying = 'http://www.water-switch-on.eu/';
DECLARE metacontactID integer;
DECLARE metadatadesc character varying = 'Meta-Data record harvested by CSW by the SWITCH-ON project according to the SWITCH-ON Standard Information Model (SIM) for Meta-Data for the SWITCH-ON Spatial Information Platform (SIP).';
DECLARE metacontentTypeID integer;
--Representation
DECLARE protocolID integer;
DECLARE functionID integer;
DECLARE contentTypeID integer;
DECLARE reptypeID integer;
DECLARE firstElement boolean;
DECLARE elementnumber integer;
DECLARE repdescr character varying;
DECLARE repTyp character varying;
DECLARE repURL character varying;
DECLARE linkElement character varying;
BEGIN
	IF (EXISTS( SELECT 1 FROM resource WHERE uuid = NEW.identifier)) THEN --If the dataset iss already in de SO-Datastructure, just return.
		raise EXCEPTION '% is already in the database',NEW.identifier;
		RETURN NEW;
	END IF;
	--defaultvalue catcher
	taggroupID = (SELECT id FROM taggroup WHERE name = 'srid');
	tagname = 'EPSG:4326';
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	sridID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'resource type');
	tagname = 'external data';
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	resourceTypeID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	--end defaultvalue catcher

	----preINSERT tagcaster----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'access conditions');
	tagname = NEW.conditionapplyingtoaccessanduse;
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		tagname = 'other';
		IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
			--00raise notice 'Tag % don''t exists', tagname;
			PERFORM createTag(tagname, taggroupID);
		END IF;
	END IF;
	accessconditionsID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'access limitations');
	tagdescription = NEW.accessconstraints;
	splitarray = regexp_split_to_array(NEW.accessconstraints, ',');
	tagname = splitarray[1];
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.description = tagdescription AND tag.taggroup = taggroupID) THEN
		raise notice 'Tag % don''t exists', tagname;
		lopaID = createTag(tagname, taggroupID);
		raise notice 'Description|: %', tagdescription;
		UPDATE tag SET description = tagdescription WHERE id = lopaID;
	END IF;
	lopaID = (SELECT id FROM tag WHERE description = tagdescription AND tag.taggroup = taggroupID);
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'collection');
	tagname = 'CSW imported';
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	collectionID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'language');
	tagname = NEW.resourcelanguage;
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	reslangID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'topic category');
	tagname = NEW.topiccategory;
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	topicID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'conformity');
	tagname = 'not evaluated';
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	conformityID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----end preINSERT tagcaster----
----contact intermezzo----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'role');
	tagname = NEW.responsiblepartyrole;
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	contactRoleID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	--00raise notice 'Contact: %, %, %',dataset.rpOrganisation, dataset.rpEmail, contactRoleID;   --TODO right INSERTion with final dataset.
	IF NOT EXISTS (SELECT 1 from contact WHERE contact.organisation = NEW.organization AND role = contactRoleID) THEN
		--00raise notice 'contact % - % - % doesen''t exist',dataset.rpOrganisation, dataset.rpEmail, contactRoleID;
		INSERT INTO contact (name, organisation, email, role) VALUES (NEW.creator, NEW.organization, '--', contactRoleID);
	END IF;
	rescontactID = (SELECT id from contact WHERE contact.organisation = dataset.rpOrganisation AND email = dataset.rpEmail AND role = contactRoleID);
----end of contact----
	IF (NEW.wkb_geometry IS NULL) THEN
		INSERT INTO geom (geo_field) VALUES (public.geometry(NEW.wkt_geometry));
	ELSE
		INSERT INTO geom (geo_field) VALUES (NEW.wkb_geometry);
	END IF;
	INSERT INTO resource (id, uuid, name, description, spatialcoverage, fromDate, toDate, licenseStatement, srid, accessconditions, language, conformity, tags, metadata, representation, contact, type, topiccategory, collection, accesslimitations)
	VALUES (nextval('resource_seq'), NEW.identifier, NEW.title, New.abstrace , geomID, 
	NEW.time_begin, new.time_end, NEW.conditionsappliningtoaccessanduse, sridID, accessconditionsID, reslangID, conformityID, 
	currval('resource_seq'), currval('resource_seq'), currval('resource_seq'), rescontactID, resourceTypeID, topicID, collectionID, lopaID);


	INSERT INTO public.metadata VALUES ( nextval('metadata_seq'), NEW.title, currval('metadata_seq'), NEW.abstract, currval('contact_seq'), NEW.date, 'application/xml', NULL, NEW.xml);
	INSERT INTO public.jt_metadata_resource (metaID, resource_reference) VALUES (currval('metadata_seq'), currval('resource_seq'));
	--Tagginator starting here
	--active Taggroup: topic category
	FOREACH tag_raw IN ARRAY (SELECT (regexp_split_to_array(NEW.keywords, ',')))
	LOOP
		--knupf
		tag_trimmed = trim(tag_raw);
		--raise NOTICE '%',tag_trimmed; --return current row of select
		IF (tag_trimmed IS NOT NULL) THEN
			IF (EXISTS (SELECT 1 FROM public.tag WHERE public.tag.name = tag_trimmed)) THEN
				--raise NOTICE 'IT EXISTS!!!!!!';
				tagID = (SELECT id FROM public.tag WHERE public.tag.name = tag_trimmed);
				--raise NOTICE '%',tagID;
				--raise NOTICE 'I could insert here!!!';
			ELSE
				IF (taggroup_id IS NULL) THEN
					taggroupID = (SELECT id FROM public.taggroup WHERE public.taggroup.name LIKE 'keywords%');
				END IF;
				--raise NOTICE 'Tag % doesn''t exist',tag_trimmed;
				--raise NOTICE 'Create Tag, with nextval(tag_Seq) | tag_trimmed | NULL | currval(tag_Seq)';
				INSERT INTO public.tag VALUES (nextval('tag_seq'), tag_trimmed, NULL, currval('tag_seq'));
				tagID = currval('tag_seq');
				INSERT INTO public.jt_tag_taggroup (tag_reference, tgid) VALUES (tagID, taggroup_id);
				--raise NOTICE 'Insert into public.jt_T_TG  with Taggroup = taggroup_id, Tagref = currval';
			END IF;
			INSERT INTO public.jt_resource_tag (resource_reference, tagID) VALUES (currval('resource_seq'), tagID);
		END IF;
	END LOOP;
	-- End of resource






	
	--Basic Metadata
	----Collect single tags for metadata
	taggroupID = (SELECT id FROM taggroup WHERE name = 'meta-data type');
	tagname = 'basic meta-data';
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	metadataTypeID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'language');
	tagname = NEW.language;
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	metalangID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----Collection finished
	--Point of Metacontact
	metacontactMail = 'switch-on@cismet.de';
	--00raise notice 'kyu: % - % - %',metacontactName , metacontactMail , metacontactArray;

	taggroupID = (SELECT id FROM taggroup WHERE name = 'role');
	tagname = 'user';
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	contactRoleID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	--00raise notice 'Contact: %, %, %, %',metacontactName, metacontactOrgan,  metacontactMail, contactRoleID;
	IF NOT EXISTS (SELECT 1 from contact WHERE email = metacontactMail AND role = contactRoleID) THEN
		--00raise notice 'contact % - % - % - % doesen''t exist',metacontactName, metacontactOrgan,  metacontactMail, contactRoleID;
		INSERT INTO contact (organisation, email, role, description, url) VALUES (metacontactOrgan, metacontactMail, contactRoleID, metacontactDescr, metacontactURL);
	END IF;
	metacontactID = (SELECT id from contact WHERE contact.organisation = metacontactOrgan AND email = metacontactMail AND role = contactRoleID);
	--Metacontact done
	INSERT INTO metadata (id, tags, name, description, type, language, standard, contact, creationDate)
	VALUES (nextval('metadata_seq'), currval('metadata_seq'), 'SWITCH-ON Basic Meta-Data' , metadatadesc , metadatatypeID, metalangID, metaStandardID, metacontactID, dataset.metadatadate::timestamp);
	INSERT INTO jt_metadata_resource (metaID, resource_reference) VALUES (currval('metadata_seq'),currval('resource_seq'));
	--/Basic Metadata 
	--Origin Metadata
		--Standard Origin Contact
		taggroupID = (SELECT id FROM taggroup WHERE name = 'role');
		tagname = 'resourceProvider';
		IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
			--00raise notice 'Tag % don''t exists', tagname;
			PERFORM createTag(tagname, taggroupID);
		END IF;
		contactRoleID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
		--00raise notice 'Contact: %, %, %, %',metacontactName, metacontactOrgan,  metacontactMail, contactRoleID;
		IF NOT EXISTS (SELECT 1 from contact WHERE name = NEW.source AND role = contactRoleID) THEN
			--00raise notice 'contact % - % - % - % doesen''t exist',metacontactName, metacontactOrgan,  metacontactMail, contactRoleID;
			INSERT INTO contact (name, role) VALUES (NEW.source, contactRoleID);
		END IF;
		metacontactID = (SELECT id from contact WHERE contact.name = NEW.source AND role = contactRoleID);
		--/Standard Origin Contact
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'meta-data type');
	tagname = 'origin meta-data';
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	metadataTypeID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'meta-data type');
	tagname = 'origin meta-data';
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	metadataTypeID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----
	taggroupID = (SELECT id FROM taggroup WHERE name = 'content type');
	tagname = 'application/xml';
	IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
		--00raise notice 'Tag % don''t exists', tagname;
		PERFORM createTag(tagname, taggroupID);
	END IF;
	metacontentTypeID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
	----
	INSERT INTO metadata (id, tags, name, description, type, language, standard, contact, creationDate, content, contenttype)
	VALUES (nextval('metadata_seq'), currval('metadata_seq'), 'SWITCH-ON Basic Meta-Data' , metadatadesc , metadatatypeID, metalangID, metaStandardID, metacontactID, NEW.date, NEW.xml, metacontentTypeID);
	INSERT INTO jt_metadata_resource (metaID, resource_reference) VALUES (currval('metadata_seq'),currval('resource_seq'));
	--/Origin Metadata TODO
	--Representations
	IF NEW.links IS NOT NULL THEN
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
						-- here a new representation should be build.
						if ( repDescr IS NOT NULL OR repTyp IS NOT NULL OR repURL IS NOT NULL) THEN
							taggroupID = (SELECT id FROM taggroup WHERE name = 'function');
							tagname = 'information';
							IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
								--00raise notice 'Tag % don''t exists', tagname;
								PERFORM createTag(tagname, taggroupID);
							END IF;
							functionID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
							----
							taggroupID = (SELECT id FROM taggroup WHERE name = 'protocol');
							tagname = 'WWW:LINK';
							IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
								--00raise notice 'Tag % don''t exists', tagname;
								PERFORM createTag(tagname, taggroupID);
							END IF;
							protocolID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
							----
							taggroupID = (SELECT id FROM taggroup WHERE name = 'content type');
							tagname = repTyp;
							IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
								--00raise notice 'Tag % don''t exists', tagname;
								PERFORM createTag(tagname, taggroupID);
							END IF;
							contenttypeID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
							----
							taggroupID = (SELECT id FROM taggroup WHERE name = 'representation type');
							tagname = 'original data';
							IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
								--00raise notice 'Tag % don''t exists', tagname;
								PERFORM createTag(tagname, taggroupID);
							END IF;
							reptypeID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
							----
							INSERT INTO representation (id, name, description, tags, protocol, type, function, contenttype, contentlocation)
							VALUES (nextval('representation_seq'), NEW.title || ' Representation', repDescr , currval('representation_seq'), protocolID, reptypeID, functionID, contenttypeID, RepURL);
							INSERT INTO jt_resource_representation (resource_reference, repID) VALUES (currval('resource_seq'), currval('representation_seq'));
						END IF;
				END CASE;
				count=count+1;
			END IF;
		END LOOP;
	END IF;
	RETURN NEW;
	END;
	$insert_py_to_switch$
LANGUAGE 'plpgsql';

CREATE TRIGGER pyInsert INSTEAD OF INSERT -- AFTER INSERT -- 
ON pycsw_view
FOR EACH ROW
EXECUTE PROCEDURE insert_py_to_switch();