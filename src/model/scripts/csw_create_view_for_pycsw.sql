-- View: public."pyCSW_View"

--DROP VIEW public.pycsw_view;
--DROP Table public.pycsw_view;

CREATE OR REPLACE View public.pycsw_view
 AS
WITH
  tag_to_group_resource AS (
	SELECT
	  jt_resource_tag.resource_reference as resID,
	  tag.name,
	  tag.taggroup
	FROM
	  public.jt_resource_tag,
	  public.tag
	WHERE
	  jt_resource_tag.tagid = tag.id
  ),

  tag_to_group_metadata AS (
	SELECT
	  jt_metadata_tag.metadata_reference as metaID,
	  tag.name,
	  tag.taggroup
	FROM
	  public.jt_metadata_tag,
	  public.tag
	WHERE
	  jt_metadata_tag.tagid = tag.id
  ),

  accumulatedTags_resource AS (
	SELECT
	  tag_to_group_resource.resID,
	  tag_to_group_resource.taggroup,
	  array_to_string(array_accum(tag_to_group_resource.name),', ') as value
	FROM
	  tag_to_group_resource
	GROUP BY
	  tag_to_group_resource.taggroup,
	  tag_to_group_resource.resID
  ),

  accumulatedTags_metadata AS (
	SELECT
	  tag_to_group_metadata.metaID,
	  tag_to_group_metadata.taggroup,
	  array_to_string(array_accum(tag_to_group_metadata.name),', ') as value
	FROM
	  tag_to_group_metadata
	GROUP BY
	  tag_to_group_metadata.taggroup,
	  tag_to_group_metadata.metaID
  ),

  accumulatedLinks AS(
	SELECT
	  resource.id,
	  resource.name,
	  concat(rep.description,',',type.name,',',rep.contentlocation) as link
	FROM 
	  public.resource  
	LEFT JOIN jt_resource_representation as jt_rep ON
	  jt_rep.resource_reference = resource.id
	LEFT JOIN representation as rep ON
	  rep.id = jt_rep.representationid
	LEFT JOIN tag as type ON
	  rep.contenttype::integer = type.id
  ),
  
  tempTabScopeResource AS (
	SELECT 
	  resource.id,
	  tag.name as scope
	FROM
	  public.resource,
	  public.jt_resource_tag,
	  public.taggroup,
	  public.tag
	WHERE 
	  tag.taggroup = taggroup.id AND
	  taggroup.name = 'scope' AND
	  resource.tags = jt_resource_tag.resource_reference AND
	  jt_resource_tag.tagid = tag.id
  ),
  
  tempTabLanguageResource AS (
	SELECT 
	  resource.id,
	  tag.name as language
	FROM
	  public.resource,
	  public.taggroup,
	  public.tag
	WHERE 
	  tag.taggroup = taggroup.id AND
	  taggroup.name = 'language' AND
	  resource.language = tag.id
  ),

  tempTabLanguageMetadata AS (
	SELECT 
	  metadata.id,
	  tag.name as language
	FROM
	  public.metadata,
	  public.taggroup,
	  public.tag
	WHERE 
	  tag.taggroup = taggroup.id AND
	  taggroup.name = 'language' AND
	  metadata.language = tag.id
  ),


  tempTabKeywords AS (
	SELECT 
	  resource.id,
	  accumulatedTags_resource.value as keywords
	FROM
	  accumulatedTags_resource,
	  public.resource,
	  public.taggroup
	WHERE 
	  accumulatedTags_resource.taggroup = taggroup.id AND
	  taggroup.name LIKE 'keywords%' AND
	  resource.id = accumulatedTags_resource.resID
  ),

  tempTabTopic AS (
	SELECT 
	  resource.id,
	  accumulatedTags_resource.value as topiccategory
	FROM
	  accumulatedTags_resource,
	  public.resource,
	  public.taggroup
	WHERE 
	  accumulatedTags_resource.taggroup = taggroup.id AND
	  taggroup.name = 'topic category' AND
	  resource.id = accumulatedTags_resource.resID
  ),

  tempTabOtherConst AS (
	SELECT 
	  resource.id,
	  accumulatedTags_resource.value as otherconstraints
	FROM
	  accumulatedTags_resource,
	  public.resource,
	  public.taggroup
	WHERE 
	  accumulatedTags_resource.taggroup = taggroup.id AND
	  taggroup.name = 'constraints' AND
	  resource.id = accumulatedTags_resource.resID
  ),

  tempTabLinks AS (
	SELECT
	  accumulatedLinks.id,
	  concat('none',',',array_to_string(array_accum( accumulatedLinks.link),', ')) as links
	FROM
	  accumulatedLinks
	GROUP BY
	  accumulatedLinks.id
  ),

  tempTabAccessStuff AS (
	SELECT
	  resource.id,
	  conditions.description as conditions,
	  limitations.description as limitations,
	  resource.licensestatement as other
	FROM
	  resource,
	  tag as conditions,
	  tag as limitations
	WHERE
	  resource.accessconditions = conditions.id AND
	  resource.accesslimitations = limitations.id
),
	  
  fullTableWOAnyText AS ( -- Here, the view is forged (well... except of AnyText). Every every View for other CSW services or changes in the current one are to do here. The last step after forging the view here
			  -- is to add the AnyText column by concatenating all available columns, to ensure an full text search is possible by just query over one column instead of querying over the complete table.
			  -- PLUS: all CSW implementations, I found and tested during the process needed that specific column.
SELECT DISTINCT
  resource.uuid::text AS identifier, 
  null AS parentidentifier,
  resource.name AS title, 
  resource.description AS abstract,
  resource.fromdate as time_begin,
  resource.todate as time_end,
  spatia.geo_field AS wkb_geometry,
  resource.creationdate AS date_creation, 
  resource.publicationdate AS date_publication, 
  resource.lastmodificationdate AS date_modified,
  rescontact.name AS creator,
  rescontact.organisation AS organization,
  rescontact.email AS contact_email,
  sourceResource.uuid as source,
  access.other as conditionapplyingtoaccessanduse,
  resLang.language as resourcelanguage,
  tempTabKeywords.keywords,
  (SELECT st_astext(spatia.geo_field) AS wkt_geometry), --Geometry as PlainText for the bounding Box
  metadata.content AS xml,
  metaLang.language,
  topic.topiccategory,
  access.limitations as accessconstraints,
  NULL as otherconstraints,
  metadata.creationdate as date,
  resConRole.name as responsiblepartyrole,
  tempTabLinks.links,
  NULL as date_revision,
  NULL as insert_date,
  NULL as relation,
  NULL as contributor,
  NULL as mdsource,
  scope.scope as type,
  NULL as schema,
  NULL as format,
  NULL as publisher,
  NULL as title_alternate,
  NULL as typename


  
FROM 
  public.resource
  LEFT JOIN tempTabLanguageResource as resLang ON
	resource.id = resLang."id"
  LEFT JOIN tempTabScopeResource as scope ON
	resource.id = scope.id
  LEFT JOIN tempTabKeywords ON
	resource.id = tempTabKeywords."id"
  LEFT JOIN public.contact as ResContact ON
	resource.contact = ResContact.id
  LEFT JOIN geom as spatia ON
	resource.spatialCoverage = spatia.id
  LEFT JOIN public.jt_metadata_resource ON
	resource.metadata = jt_metadata_resource.resource_reference
  LEFT JOIN public.metadata ON
	jt_metadata_resource.metadataid = metadata.id
  LEFT JOIN public.contact as MetaContact ON
	metadata.contact = MetaContact.id
  LEFT JOIN tempTabLanguageMetadata as metaLang ON
	metadata.id = metaLang."id"
  LEFT JOIN tempTabTopic as topic ON
	resource.id = topic.id
  LEFT JOIN tempTabLinks ON
	resource.id = tempTabLinks.id
  LEFT JOIN relationship ON
	resource.id = relationship.toresource
  LEFT JOIN jt_fromResource_relationship ON
	jt_fromResource_relationship.relationship_reference = relationship.id
  LEFT JOIN resource as sourceResource ON
	jt_fromResource_relationship.resourceID = sourceResource.id
  LEFT JOIN tempTabAccessStuff as access ON
	resource.id = access.id
  LEFT JOIN tag as resConRole ON
	ResContact.role = resConRole.id
)

SELECT DISTINCT
  * ,
  concat(fullTableWOAnyText .*) AS anytext
FROM
  fullTableWOAnyText;
  
ALTER View public.pyCSW_View
  OWNER TO postgres;
GRANT ALL ON TABLE public.pyCSW_View TO postgres;
GRANT ALL ON TABLE public.pyCSW_View TO public;



