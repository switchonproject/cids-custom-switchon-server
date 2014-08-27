DO $importFromSMHI$
DECLARE dataset record;
DECLARE nya record;

DECLARE tag_raw character varying;
DECLARE tag_trimmed character varying;
DECLARE tagID integer;
DECLARE taggroupID integer = NULL;
DECLARE tagname character varying;
DECLARE tagdescription character varying;
DECLARE splitarray character varying[];
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
DECLARE metadatadesc character varying = 'Meta-Data record created, derived or imported by the SWITCH-ON project according to the SWITCH-ON Standard Information Model (SIM) for Meta-Data for the SWITCH-ON Spatial Information Platform (SIP).';
--Representation
DECLARE protocolID integer;
DECLARE functionID integer;
DECLARE contentTypeID integer;
DECLARE reptypeID integer;


BEGIN
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
	For dataset in (SELECT * FROM 
--Here, the table, which shall be imported, can be changed
	import_tables.importTable
--Here, the table, which shall be imported, can be changed
	) LOOP
		--11raise info 'Beginning of Time';
		IF (EXISTS( SELECT 1 FROM resource WHERE uuid = dataset.uniqueresourceidentifü)) THEN --If the dataset iss already in de SO-Datastructure, just return.
			--11raise info '% is already in the database',dataset.codespace || dataset.uniqueresourceidentifü;
		ELSE 
		IF (char_length( dataset.uniqueresourceidentifü ) > 200) THEN --Test for realy long unique resource identifiers
			raise WARNING '% unique identifier is to long',dataset.uniqueresourceidentifü ;
		ELSE
		IF (dataset.fromtime LIKE '-%') THEN
			raise WARNING 'Date is out of boundry (%)',dataset.fromtime;
		ELSE
		IF (dataset.totime LIKE '-%') THEN
			raise WARNING 'Date is out of boundry (%)',dataset.totime ;
		ELSE
			----preINSERT tagcaster----
			taggroupID = (SELECT id FROM taggroup WHERE name = 'location');
			IF (dataset.westBoundLong::float < -160) THEN
				tagname = 'World';
			ELSE
				tagname = 'Europe';
			END IF;
			--00raise notice 'location: %', tagname;		
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			locationID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			----
			taggroupID = (SELECT id FROM taggroup WHERE name = 'access conditions');
			tagname = dataset.constraintsrelatedtoaau;
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
			tagdescription = dataset.limitationsonpublicaccess;
			splitarray = regexp_split_to_array(dataset.limitationsonpublicaccess, ',');
			tagname = splitarray[1];
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.description = tagdescription AND tag.taggroup = taggroupID) THEN
				if tagname LIKE '%Centre for Ecology & Hydrology%' THEN
					raise notice 'CEH !! CEH';
					tagname = 'Centre for Ecology & Hydrology Terms and Conditions';
				END IF;
				if tagname LIKE '%User need to register and login to acces the data%(LLNL)%' THEN
					raise notice '... !! ...';
					tagname = 'User need to register and login to acces the data. (LLNL)';
				END IF;
				if tagname LIKE '%The United Nations maintains this web site%' THEN
					raise notice 'UN !! UN';
					tagname = 'United Nations permission required';
				END IF;
				if tagname LIKE 'We respect the privacy of our visitors%' THEN
					raise notice 'KLUMPF?';
					tagname = 'Actually no real restriction at all';
				END IF;
				if tagname ilike '%Users may apply HydroSHEDS for non-commercial purposes.%' THEN
					raise notice 'HYDRO';
					tagname = 'Hydrosheds restrictions';
				END IF;
				raise notice 'Tag % don''t exists', tagname;
				lopaID = createTag(tagname, taggroupID);
				raise notice 'Description|: %', tagdescription;
				UPDATE tag SET description = tagdescription WHERE id = lopaID;
			END IF;
			lopaID = (SELECT id FROM tag WHERE description = tagdescription AND tag.taggroup = taggroupID);
			----
			taggroupID = (SELECT id FROM taggroup WHERE name = 'collection');
			tagname = dataset.emmasdataset;
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			collectionID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			----
			taggroupID = (SELECT id FROM taggroup WHERE name = 'language');
			tagname = dataset.resourcelanguage;
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			reslangID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			----
			taggroupID = (SELECT id FROM taggroup WHERE name = 'topic category');
			tagname = dataset.topiccategory;
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			topicID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			----
			taggroupID = (SELECT id FROM taggroup WHERE name = 'conformity');
			tagname = dataset.conformity;
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			conformityID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			----end preINSERT tagcaster----
			
			----contact intermezzo----
			taggroupID = (SELECT id FROM taggroup WHERE name = 'role');
			tagname = dataset.rpRole;
--			tagname = 'pointOfContact';
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			contactRoleID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			--00raise notice 'Contact: %, %, %',dataset.rpOrganisation, dataset.rpEmail, contactRoleID;   --TODO right INSERTion with final dataset.
			IF NOT EXISTS (SELECT 1 from contact WHERE contact.organisation = dataset.rpOrganisation AND email = dataset.rpEmail AND role = contactRoleID) THEN
				--00raise notice 'contact % - % - % doesen''t exist',dataset.rpOrganisation, dataset.rpEmail, contactRoleID;
				INSERT INTO contact (organisation, email, role) VALUES (dataset.rpOrganisation, dataset.rpEmail, contactRoleID);
			END IF;
			rescontactID = (SELECT id from contact WHERE contact.organisation = dataset.rpOrganisation AND email = dataset.rpEmail AND role = contactRoleID);
			----end of contact----
			
			----to the resource----
			--11raise info 'AHHHHHHHHHHHHHHHHHHHHHH';
			--00raise notice 'geom: %' , ST_GeomFromText('Polygon(( ' || dataset.westBoundLong || ' ' || dataset.southBoundLat || ',' || dataset.eastBoundLong || ' ' || dataset.southBoundLat || ',' || dataset.eastBoundLong || ' ' || dataset.northBoundLat || ',' || dataset.westBoundLong || ' ' || dataset.northBoundLat || ',' || dataset.westBoundLong || ' ' || dataset.southBoundLat || ' ))');
			IF NOT EXISTS (SELECT 1 FROM geom WHERE geo_field = ST_GeomFromText('Polygon(( ' || dataset.westBoundLong || ' ' || dataset.southBoundLat || ',' || dataset.eastBoundLong || ' ' || dataset.southBoundLat || ',' || dataset.eastBoundLong || ' ' || dataset.northBoundLat || ',' || dataset.westBoundLong || ' ' || dataset.northBoundLat || ',' || dataset.westBoundLong || ' ' || dataset.southBoundLat || ' ))' , 4326)) THEN
				--00raise notice 'We need a new Geom';
				INSERT INTO geom (geo_field) SELECT ST_GeomFromText('Polygon(( ' || dataset.westBoundLong || ' ' || dataset.southBoundLat || ',' || dataset.eastBoundLong || ' ' || dataset.southBoundLat || ',' || dataset.eastBoundLong || ' ' || dataset.northBoundLat || ',' || dataset.westBoundLong || ' ' || dataset.northBoundLat || ',' || dataset.westBoundLong || ' ' || dataset.southBoundLat || ' ))' , 4326);
			END IF;
			geomID = (SELECT id FROM geom WHERE geo_field = ST_GeomFromText('Polygon(( ' || dataset.westBoundLong || ' ' || dataset.southBoundLat || ',' || dataset.eastBoundLong || ' ' || dataset.southBoundLat || ',' || dataset.eastBoundLong || ' ' || dataset.northBoundLat || ',' || dataset.westBoundLong || ' ' || dataset.northBoundLat || ',' || dataset.westBoundLong || ' ' || dataset.southBoundLat || ' ))' , 4326));
			
			INSERT INTO resource (id, uuid, name, description, spatialcoverage, fromDate, toDate, licenseStatement, srid, location, accessconditions, language, conformity, tags, metadata, representation, contact, type, topiccategory, collection, accesslimitations)
			VALUES (nextval('resource_seq'), dataset.uniqueresourceidentifü, dataset.resourcetitle, dataset.resourceabstraction , geomID, 
			dataset.fromtime::date, dataset.totime::date, dataset.constraintsrelatedtoaau, sridID, locationID, accessconditionsID, reslangID, conformityID, 
			currval('resource_seq'), currval('resource_seq'), currval('resource_seq'), rescontactID, resourceTypeID, topicID, collectionID, lopaID);

			--Tagginator starting here
			--active Taggroup: keywords
			taggroupID = (SELECT id FROM taggroup WHERE name = 'keywords - open');
			FOREACH tag_raw IN ARRAY (SELECT (regexp_split_to_array(dataset.keywordvalue, ',')))
			LOOP
				--knupf
				tag_trimmed = trim(tag_raw);
				raise notice 'Tag: %',tag_trimmed; --return current row of select
				IF (tag_trimmed IS NOT NULL) THEN
					IF (EXISTS (SELECT 1 FROM tag, taggroup as tgroup WHERE tag.name = tag_trimmed AND taggroup = tgroup.id AND tgroup.name LIKE 'keyword%')) THEN
						raise notice 'IT EXISTS!!!!!!';
						raise notice '%',tagID;
						raise notice 'I could INSERT here!!!';
					ELSE
						raise notice 'Tag % doesn''t exist',tag_trimmed;
						raise notice 'SELECT create Tag, with SELECT create_tag(%,%)',tag_trimmed, taggroupID;
						PERFORM createtag(tag_trimmed, taggroupID);
					END IF;
					tagID = (SELECT tag.id FROM tag, taggroup as tgroup WHERE tag.name = tag_trimmed AND taggroup = tgroup.id AND tgroup.name LIKE 'keyword%');
					INSERT INTO public.jt_resource_tag (resource_reference, tagID) VALUES (currval('resource_seq'), tagID);
				END IF;
			END LOOP;	-- Next Taggroup
			--Final end of Resource
			--Here begins the metameta data
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
			tagname = dataset.metadatalanguage;
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			metalangID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			----Collection finished
			--Point of Metacontact
			metacontactArray = regexp_split_to_array(dataset.metadatapointofcontact, '<');
			metacontactName = metacontactArray[1];
			metacontactArray = regexp_split_to_array(metacontactArray[2], '>');
			metacontactMail = metacontactArray[1];
			--00raise notice 'kyu: % - % - %',metacontactName , metacontactMail , metacontactArray;

			taggroupID = (SELECT id FROM taggroup WHERE name = 'role');
			tagname = 'user';
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			contactRoleID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			--00raise notice 'Contact: %, %, %, %',metacontactName, metacontactOrgan,  metacontactMail, contactRoleID;
			IF NOT EXISTS (SELECT 1 from contact WHERE contact.name = metacontactName AND email = metacontactMail AND role = contactRoleID) THEN
				--00raise notice 'contact % - % - % - % doesen''t exist',metacontactName, metacontactOrgan,  metacontactMail, contactRoleID;
				INSERT INTO contact (name, organisation, email, role, description, url) VALUES (metacontactName, metacontactOrgan, metacontactMail, contactRoleID, metacontactDescr, metacontactURL);
			END IF;
			metacontactID = (SELECT id from contact WHERE contact.name = metacontactName AND contact.organisation = metacontactOrgan AND email = metacontactMail AND role = contactRoleID);
			--Metacontact done
			INSERT INTO metadata (id, tags, name, description, type, language, standard, contact, creationDate)
			VALUES (nextval('metadata_seq'), currval('metadata_seq'), 'SWITCH-ON Basic Meta-Data' , metadatadesc , metadatatypeID, metalangID, metaStandardID, metacontactID, dataset.metadatadate::timestamp);
			INSERT INTO jt_metadata_resource (metaID, resource_reference) VALUES (currval('metadata_seq'),currval('resource_seq'));
			--End of Metadata
			--Preperation for Representation
			taggroupID = (SELECT id FROM taggroup WHERE name = 'function');
			IF (dataset.loginrequired LIKE '%yes%') then
				tagname = 'order';
			else
				IF (dataset.directdownload LIKE '%yes%' OR dataset.directdownload LIKE '%form%' OR dataset.directdownload LIKE '%question%') then
					tagname = 'download';
				ELSE
					tagname = 'information';
				END IF;
			END IF;
			--00raise notice 'Function: %',tagname;
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
			tagname = dataset.mimecontenttype;
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
			INSERT INTO representation (id, name, description, tags, protocol, type, spatialResolution, spatialScale, function, contenttype, contentlocation)
			VALUES (nextval('representation_seq'), dataset.resourcetitle || ' Representation', 'Representation of Resource ' || dataset.resourcetitle , currval('representation_seq'), protocolID, reptypeID, dataset.spatialresolution, dataset.spatialscale::integer, functionID, contenttypeID, dataset.resourcelocation);
			INSERT INTO jt_resource_representation (resource_reference, repID) VALUES (currval('resource_seq'), currval('representation_seq'));
			--End of representation
			--Here follows the linage metadata
			taggroupID = (SELECT id FROM taggroup WHERE name = 'meta-data type');
			tagname = 'lineage meta-data';
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			metadataTypeID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			----
			taggroupID = (SELECT id FROM taggroup WHERE name = 'language');
			tagname = 'eng';
			IF NOT EXISTS (SELECT 1 from tag WHERE tag.name = tagname AND tag.taggroup = taggroupID) THEN
				--00raise notice 'Tag % don''t exists', tagname;
				PERFORM createTag(tagname, taggroupID);
			END IF;
			metalangID = (SELECT id FROM tag WHERE name = tagname AND tag.taggroup = taggroupID);
			----
			INSERT INTO metadata (id, tags, name, description, type, language, creationDate)
			VALUES (nextval('metadata_seq'), currval('metadata_seq'), 'Basic Lineage Meta-Data' , dataset.lineage , metadatatypeID, metalangID, dataset.metadatadate::timestamp);
			INSERT INTO jt_metadata_resource (metaID, resource_reference) VALUES (currval('metadata_seq'),currval('resource_seq'));
		END IF; END IF; END IF; END IF;
	END LOOP;
END
$importFromSMHI$
LANGUAGE plpgsql;