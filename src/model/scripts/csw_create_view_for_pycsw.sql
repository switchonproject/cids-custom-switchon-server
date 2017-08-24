-- View: pycsw.pycsw_view

-- DROP VIEW pycsw.pycsw_view;

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
            concat(translate(rep.name, ','::text, ''::text), ',', translate(rep.description, ','::text, ''::text), ',', type.name, ',', rep.contentlocation) AS link
           FROM resource
             LEFT JOIN jt_resource_representation jt_rep ON jt_rep.resource_reference = resource.id
             LEFT JOIN representation rep ON rep.id = jt_rep.representationid
             LEFT JOIN tag type ON rep.protocol = type.id
        ), temptable_scoperesource AS (
         SELECT resource.id,
            tag.name AS scope
           FROM resource,
            jt_resource_tag,
            taggroup,
            tag
          WHERE tag.taggroup = taggroup.id AND taggroup.name::text = 'scope'::text AND resource.tags = jt_resource_tag.resource_reference AND jt_resource_tag.tagid = tag.id
        ), temptable_languageresource AS (
         SELECT resource.id,
            tag.name AS language
           FROM resource,
            taggroup,
            tag
          WHERE tag.taggroup = taggroup.id AND taggroup.name::text = 'language'::text AND resource.language = tag.id
        ), temptable_languagemetadata AS (
         SELECT metadata.id,
            tag.name AS language
           FROM metadata,
            taggroup,
            tag
          WHERE tag.taggroup = taggroup.id AND taggroup.name::text = 'language'::text AND metadata.language = tag.id
        ), temptable_keywords AS (
         SELECT resource.id,
            array_to_string(array_accum(accumulatedtags_resource.value), ', '::text) AS keywords
           FROM accumulatedtags_resource,
            resource,
            taggroup
          WHERE accumulatedtags_resource.taggroup = taggroup.id AND taggroup.name::text ~~ 'keywords - X-CUAHSI'::text AND resource.id = accumulatedtags_resource.resid
          GROUP BY resource.id
        ), temptable_topic AS (
         SELECT resource.id,
            tag.name AS topiccategory
           FROM resource,
            taggroup,
            tag
          WHERE tag.taggroup = taggroup.id AND taggroup.name::text = 'topic category'::text AND resource.topiccategory = tag.id
        ), temptabotherconst AS (
         SELECT resource.id,
            accumulatedtags_resource.value AS otherconstraints
           FROM accumulatedtags_resource,
            resource,
            taggroup
          WHERE accumulatedtags_resource.taggroup = taggroup.id AND taggroup.name::text = 'constraints'::text AND resource.id = accumulatedtags_resource.resid
        ), temptable_links AS (
         SELECT accumulatedlinks.id,
            concat(array_to_string(array_accum(accumulatedlinks.link), '^'::text)) AS links
           FROM accumulatedlinks
          GROUP BY accumulatedlinks.id
        ), temptable_accessstuff AS (
         SELECT resource.id,
            conditions.name::text AS conditions,
            limitations.description AS limitations,
            resource.licensestatement AS other
           FROM resource,
            tag conditions,
            tag limitations
          WHERE resource.accessconditions = conditions.id AND resource.accesslimitations = limitations.id
        ), pycsw_view AS (
         SELECT DISTINCT resource.id AS resource_id,
            resource.uuid::text AS identifier,
            'eu.water-switch-on.data'::text AS parentidentifier,
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
            access.conditions AS conditionapplyingtoaccessanduse,
            reslang.language AS resourcelanguage,
            temptable_keywords.keywords,
            ( SELECT st_astext(spatia.geo_field) AS wkt_geometry) AS wkt_geometry,
            metadata.content AS xml,
            metalang.language,
            topic.topiccategory,
            access.limitations AS accessconstraints,
            access.other AS otherconstraints,
            metadata.creationdate AS date,
            resconrole.name AS responsiblepartyrole,
            temptable_links.links,
            NULL::text AS date_revision,
            metadata.creationdate::text AS insert_date,
            NULL::text AS relation,
            NULL::text AS contributor,
            concat('http://www.water-switch-on.eu/sip-webclient/byod/#/resource/', resource.id) AS mdsource,
            'dataset'::text AS type,
            NULL::text AS schema,
            NULL::text AS format,
            metacontact.name::text AS publisher,
            resource.id::text AS title_alternate,
            NULL::text AS typename
           FROM resource
             LEFT JOIN temptable_languageresource reslang ON resource.id = reslang.id
             LEFT JOIN temptable_scoperesource scope ON resource.id = scope.id
             LEFT JOIN temptable_keywords ON resource.id = temptable_keywords.id
             LEFT JOIN contact rescontact ON resource.contact = rescontact.id
             LEFT JOIN geom spatia ON resource.spatialcoverage = spatia.id
             LEFT JOIN jt_metadata_resource ON resource.metadata = jt_metadata_resource.resource_reference
             LEFT JOIN metadata ON jt_metadata_resource.metadataid = metadata.id
             LEFT JOIN contact metacontact ON metadata.contact = metacontact.id
             LEFT JOIN temptable_languagemetadata metalang ON metadata.id = metalang.id
             LEFT JOIN temptable_topic topic ON resource.id = topic.id
             LEFT JOIN temptable_links ON resource.id = temptable_links.id
             LEFT JOIN relationship ON resource.id = relationship.toresource
             LEFT JOIN jt_fromresource_relationship ON jt_fromresource_relationship.relationship_reference = relationship.id
             LEFT JOIN resource sourceresource ON jt_fromresource_relationship.resourceid = sourceresource.id
             LEFT JOIN temptable_accessstuff access ON resource.id = access.id
             LEFT JOIN tag resconrole ON rescontact.role = resconrole.id
          WHERE metadata.type = (( SELECT tag.id
                   FROM tag
                  WHERE tag.name::text ~~* 'basic meta-data'::text))
          ORDER BY resource.id
        )
 SELECT DISTINCT pycsw_view.identifier,
    pycsw_view.parentidentifier,
    pycsw_view.title,
    pycsw_view.abstract,
    pycsw_view.time_begin,
    pycsw_view.time_end,
    pycsw_view.wkb_geometry,
    pycsw_view.date_creation,
    pycsw_view.date_publication,
    pycsw_view.date_modified,
    pycsw_view.creator,
    pycsw_view.organization,
    pycsw_view.contact_email,
    pycsw_view.source,
    pycsw_view.conditionapplyingtoaccessanduse,
    pycsw_view.resourcelanguage,
    pycsw_view.keywords,
    pycsw_view.wkt_geometry,
    pycsw_view.xml,
    pycsw_view.language,
    pycsw_view.topiccategory,
    pycsw_view.accessconstraints,
    pycsw_view.otherconstraints,
    pycsw_view.date,
    pycsw_view.responsiblepartyrole,
    pycsw_view.links,
    pycsw_view.date_revision,
    pycsw_view.insert_date,
    pycsw_view.relation,
    pycsw_view.contributor,
    pycsw_view.mdsource,
    pycsw_view.type,
    pycsw_view.schema,
    pycsw_view.format,
    pycsw_view.publisher,
    pycsw_view.title_alternate,
    pycsw_view.typename,
    concat(pycsw_view.title, ' ', pycsw_view.abstract, ' ', pycsw_view.keywords) AS anytext
   FROM pycsw_view;

ALTER TABLE pycsw.pycsw_view
  OWNER TO postgres;
GRANT ALL ON TABLE pycsw.pycsw_view TO postgres;
GRANT ALL ON TABLE pycsw.pycsw_view TO public;
