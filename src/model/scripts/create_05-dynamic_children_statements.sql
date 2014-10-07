INSERT INTO "public".cs_dynamic_children_helper (id, "name", code) 
	VALUES (1, 'CidsObjects(class_id varchar, table_name varchar)', 'SELECT -1 AS id,
 	null AS name,
 	<ds::param name=''class_id''>1</ds::param> AS class_id,
 	id AS object_id,
 	''O'' AS node_type,
 	null AS url,
 	null AS dynamic_children,
 	false AS sql_sort,
 	true AS derive_permissions_from_class
 	from <ds::param name=''table_name''>2</ds::param>
 	order by name');
  
INSERT INTO "public".cs_dynamic_children_helper (id, "name", code) 
	VALUES (2, 'HydrologicalConcepts(level_id integer)', 'SELECT -1 AS id,
	tag.name AS name,
	cs_class.id AS class_id,
	NULL AS object_id,
	''N'' AS node_type,
	null AS url,
        csdc.entities(<ds::param name=''level_id''>1</ds::param> , tag.id) as dynamic_children, 
	false AS sql_sort,
	true AS derive_permissions_from_class
    FROM
	tag
	LEFT JOIN  taggroup ON
		tag.taggroup = taggroup.id,
        cs_class
    WHERE
        cs_class.name = ''tag'' AND
	taggroup.name = ''hydrological concept''
    GROUP BY 
	tag.name,
	tag.id,
        cs_class.id;');
        
INSERT INTO "public".cs_dynamic_children_helper (id, "name", code) 
	VALUES (3, 'Entities(level_id integer, hydroCon_id integer)', 'SELECT DISTINCT -1 AS id,
	resource.name AS name,
	cs_class.id AS class_id,
	resource.id AS object_id,
	''O'' AS node_type,
	null AS url,
	NULL as dynamic_children,
	false AS sql_sort,
	true AS derive_permissions_from_class
    FROM 
	resource
	LEFT JOIN tag as tag_1 ON
		resource.geography = tag_1.id
	LEFT JOIN jt_resource_tag as jtrt_2 ON
		jtrt_2.resource_reference = resource.id
	LEFT JOIN tag as tag_2 ON
		jtrt_2.tagid = tag_2.id,
        tag as rType,
        cs_class
    WHERE
        cs_class.name = ''resource'' AND
	tag_1.id = <ds::param name=''level_id''>1</ds::param> AND
	tag_2.id = <ds::param name=''hydroCon_id''>2</ds::param> AND
        resource.type = rType.id AND
        rType.name != ''external data''
      Group by
	resource.name,
	resource.id,
        cs_class.id;');
        
INSERT INTO "public".cs_dynamic_children_helper (id, "name", code) 
	VALUES (4, 'collectionsExternal(collection_id integer)', 'SELECT -1 AS id,
	resource.name AS name,
	cs_class.id AS class_id,
	resource.id AS object_id,
	''O'' AS node_type,
	null AS url,
	NULL as dynamic_children,
	false AS sql_sort,
	true AS derive_permissions_from_class
    FROM 
	resource,
        tag as rType,
        cs_class
    WHERE
        cs_class.name = ''resource'' AND
	collection = <ds::param name=''collection_id''>1</ds::param> AND
        resource.type = rType.id AND
        rType.name = ''external data''
      Group by
	resource.name,
	resource.id,
        cs_class.id
	ORDER BY resource.name;
');

INSERT INTO "public".cs_dynamic_children_helper (id, "name", code) 
	VALUES (5, 'tags(taggroup_id integer)', 'SELECT 
  -1 as id, 
	tag.name, 
	cs_class.id as class_id, 
	tag.id as object_id, 
	''O'' as node_type, 
	null as url, 
	null dynamic_children,
	false as sql_sort 
FROM 
	tag
	LEFT JOIN taggroup ON
		tag.taggroup = taggroup.id,    
  cs_class
WHERE
  cs_class.name = ''tag'' AND
	taggroup.id = 	<ds::param name=''taggroup_id''>1</ds::param> 
GROUP BY 
  	tag.name,
  	tag.id,
    cs_class.id 
ORDER BY tag.name ASC;');

SELECT (cs_refresh_dynchilds_functions());
