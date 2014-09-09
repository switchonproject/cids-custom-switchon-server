drop view pycsw.pycsw_view;
UPDATE cs_attr SET type_id = (SELECT id from cs_type where name ilike 'timestamp') where field_name = 'publicationdate';
DELETE FROM cs_attr WHERE id = 112;
ALTER TABLE resource ALTER publicationdate SET DATA TYPE timestamp without time zone;

CREATE OR REPLACE VIEW pycsw.pycsw_view AS 
 WITH tag_to_group_resource AS (
         SELECT jt_resource_tag.resource_reference AS resid,
            tag.name,
            tag.taggroup
           FROM jt_resource_tag,
            tag
          WHERE jt_resource_tag.tagid = tag.id
        ), tag_to_group_metadata AS (
         SELECT jt_metadata_tag.metadata_reference AS metaid,
            tag.name,
            tag.taggroup
           FROM jt_metadata_tag,
            tag
          WHERE jt_metadata_tag.tagid = tag.id
        ), accumulatedtags_resource AS (
         SELECT tag_to_group_resource.resid,
            tag_to_group_resource.taggroup,
            array_to_string(array_accum(tag_to_group_resource.name), ', '::text) AS value
           FROM tag_to_group_resource
          GROUP BY tag_to_group_resource.taggroup, tag_to_group_resource.resid
        ), accumulatedtags_metadata AS (
         SELECT tag_to_group_metadata.metaid,
            tag_to_group_metadata.taggroup,
            array_to_string(array_accum(tag_to_group_metadata.name), ', '::text) AS value
           FROM tag_to_group_metadata
          GROUP BY tag_to_group_metadata.taggroup, tag_to_group_metadata.metaid
        ), accumulatedlinks AS (
         SELECT resource.id,
            resource.name,
            concat(rep.description, ',', type.name, ',', rep.contentlocation) AS link
           FROM resource
             LEFT JOIN jt_resource_representation jt_rep ON jt_rep.resource_reference = resource.id
             LEFT JOIN representation rep ON rep.id = jt_rep.representationid
             LEFT JOIN tag type ON rep.protocol = type.id
        ), temptabscoperesource AS (
         SELECT resource.id,
            tag.name AS scope
           FROM resource,
            jt_resource_tag,
            taggroup,
            tag
          WHERE tag.taggroup = taggroup.id AND taggroup.name::text = 'scope'::text AND resource.tags = jt_resource_tag.resource_reference AND jt_resource_tag.tagid = tag.id
        ), temptablanguageresource AS (
         SELECT resource.id,
            tag.name AS language
           FROM resource,
            taggroup,
            tag
          WHERE tag.taggroup = taggroup.id AND taggroup.name::text = 'language'::text AND resource.language = tag.id
        ), temptablanguagemetadata AS (
         SELECT metadata.id,
            tag.name AS language
           FROM metadata,
            taggroup,
            tag
          WHERE tag.taggroup = taggroup.id AND taggroup.name::text = 'language'::text AND metadata.language = tag.id
        ), temptabkeywords AS (
         SELECT resource.id,
            array_to_string(array_accum(accumulatedtags_resource.value), ', '::text) AS keywords
           FROM accumulatedtags_resource,
            resource,
            taggroup
          WHERE accumulatedtags_resource.taggroup = taggroup.id AND taggroup.name::text ~~ 'keywords%'::text AND resource.id = accumulatedtags_resource.resid
          GROUP BY resource.id
        ), temptabtopic AS (
         SELECT resource.id,
            accumulatedtags_resource.value AS topiccategory
           FROM accumulatedtags_resource,
            resource,
            taggroup
          WHERE accumulatedtags_resource.taggroup = taggroup.id AND taggroup.name::text = 'topic category'::text AND resource.id = accumulatedtags_resource.resid
        ), temptabotherconst AS (
         SELECT resource.id,
            accumulatedtags_resource.value AS otherconstraints
           FROM accumulatedtags_resource,
            resource,
            taggroup
          WHERE accumulatedtags_resource.taggroup = taggroup.id AND taggroup.name::text = 'constraints'::text AND resource.id = accumulatedtags_resource.resid
        ), temptablinks AS (
         SELECT accumulatedlinks.id,
            concat('none', ',', array_to_string(array_accum(accumulatedlinks.link), ', '::text)) AS links
           FROM accumulatedlinks
          GROUP BY accumulatedlinks.id
        ), temptabaccessstuff AS (
         SELECT resource.id,
            conditions.description AS conditions,
            limitations.description AS limitations,
            resource.licensestatement AS other
           FROM resource,
            tag conditions,
            tag limitations
          WHERE resource.accessconditions = conditions.id AND resource.accesslimitations = limitations.id
        ), fulltablewoanytext AS (
         SELECT DISTINCT resource.uuid::text AS identifier,
            NULL::text AS parentidentifier,
            resource.name AS title,
            resource.description AS abstract,
            resource.fromdate AS time_begin,
            resource.todate AS time_end,
            spatia.geo_field AS wkb_geometry,
            resource.creationdate AS date_creation,
            resource.publicationdate AS date_publication,
            resource.lastmodificationdate AS date_modified,
            rescontact.name AS creator,
            rescontact.organisation AS organization,
            rescontact.email AS contact_email,
            sourceresource.uuid AS source,
            access.other AS conditionapplyingtoaccessanduse,
            reslang.language AS resourcelanguage,
            temptabkeywords.keywords,
            ( SELECT st_astext(spatia.geo_field) AS wkt_geometry) AS wkt_geometry,
            metadata.content AS xml,
            metalang.language,
            topic.topiccategory,
            access.limitations AS accessconstraints,
            NULL::text AS otherconstraints,
            metadata.creationdate AS date,
            resconrole.name AS responsiblepartyrole,
            temptablinks.links,
            NULL::text AS date_revision,
            NULL::text AS insert_date,
            NULL::text AS relation,
            NULL::text AS contributor,
            NULL::text AS mdsource,
            scope.scope AS type,
            NULL::text AS schema,
            NULL::text AS format,
            NULL::text AS publisher,
            NULL::text AS title_alternate,
            NULL::text AS typename
           FROM resource
             LEFT JOIN temptablanguageresource reslang ON resource.id = reslang.id
             LEFT JOIN temptabscoperesource scope ON resource.id = scope.id
             LEFT JOIN temptabkeywords ON resource.id = temptabkeywords.id
             LEFT JOIN contact rescontact ON resource.contact = rescontact.id
             LEFT JOIN geom spatia ON resource.spatialcoverage = spatia.id
             LEFT JOIN jt_metadata_resource ON resource.metadata = jt_metadata_resource.resource_reference
             LEFT JOIN metadata ON jt_metadata_resource.metadataid = metadata.id
             LEFT JOIN contact metacontact ON metadata.contact = metacontact.id
             LEFT JOIN temptablanguagemetadata metalang ON metadata.id = metalang.id
             LEFT JOIN temptabtopic topic ON resource.id = topic.id
             LEFT JOIN temptablinks ON resource.id = temptablinks.id
             LEFT JOIN relationship ON resource.id = relationship.toresource
             LEFT JOIN jt_fromresource_relationship ON jt_fromresource_relationship.relationship_reference = relationship.id
             LEFT JOIN resource sourceresource ON jt_fromresource_relationship.resourceid = sourceresource.id
             LEFT JOIN temptabaccessstuff access ON resource.id = access.id
             LEFT JOIN tag resconrole ON rescontact.role = resconrole.id
        )
 SELECT DISTINCT fulltablewoanytext.identifier,
    fulltablewoanytext.parentidentifier,
    fulltablewoanytext.title,
    fulltablewoanytext.abstract,
    fulltablewoanytext.time_begin,
    fulltablewoanytext.time_end,
    fulltablewoanytext.wkb_geometry,
    fulltablewoanytext.date_creation,
    fulltablewoanytext.date_publication,
    fulltablewoanytext.date_modified,
    fulltablewoanytext.creator,
    fulltablewoanytext.organization,
    fulltablewoanytext.contact_email,
    fulltablewoanytext.source,
    fulltablewoanytext.conditionapplyingtoaccessanduse,
    fulltablewoanytext.resourcelanguage,
    fulltablewoanytext.keywords,
    fulltablewoanytext.wkt_geometry,
    fulltablewoanytext.xml,
    fulltablewoanytext.language,
    fulltablewoanytext.topiccategory,
    fulltablewoanytext.accessconstraints,
    fulltablewoanytext.otherconstraints,
    fulltablewoanytext.date,
    fulltablewoanytext.responsiblepartyrole,
    fulltablewoanytext.links,
    fulltablewoanytext.date_revision,
    fulltablewoanytext.insert_date,
    fulltablewoanytext.relation,
    fulltablewoanytext.contributor,
    fulltablewoanytext.mdsource,
    fulltablewoanytext.type,
    fulltablewoanytext.schema,
    fulltablewoanytext.format,
    fulltablewoanytext.publisher,
    fulltablewoanytext.title_alternate,
    fulltablewoanytext.typename,
    concat(fulltablewoanytext.*) AS anytext
   FROM fulltablewoanytext;

ALTER TABLE pycsw.pycsw_view
  OWNER TO postgres;
GRANT ALL ON TABLE pycsw.pycsw_view TO postgres;
GRANT ALL ON TABLE pycsw.pycsw_view TO public;
