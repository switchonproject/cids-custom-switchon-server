INSERT INTO cs_cat_node
VALUES
(1,'Internal',1,19,NULL,'N',FALSE,NULL,'"SELECT 
	-1 as id, 
	tag.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.hydrologicalconcepts(tag.id) as dynamic_children,
	false as sql_sort 
    FROM 
	tag
	LEFT JOIN taggroup ON
		tag.taggroup = taggroup.id,
        cs_class
    WHERE
        cs_class.name = ''tag'' AND
	taggroup.name = ''geography''
    GROUP BY 
	tag.name,
	tag.id,
        cs_class.id',FALSE,NULL,FALSE,NULL,NULL,NULL),
(2,'External',1,19,NULL,'N',FALSE,NULL,'SELECT 
	-1 as id, 
	tag.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.collections(tag.id) as dynamic_children,
	false as sql_sort 
    FROM 
	tag
	LEFT JOIN taggroup ON
		tag.taggroup = taggroup.id,
        cs_class
    WHERE
        cs_class.name = ''tag'' AND
	taggroup.name = ''collection''
    GROUP BY 
	tag.name,
	tag.id,
        cs_class.id',FALSE,NULL,FALSE,NULL,NULL,NULL),
(3,'SWITCH-ON',NULL,NULL,NULL,'N',TRUE,NULL,'"SELECT 
	id, 
	name, 
	class_id, 
	object_id, 
	node_type, 
	null as url,
	dynamic_children,
	sql_sort 
    FROM 
	cs_cat_node
    WHERE
        descr = 1',TRUE,NULL,FALSE,NULL,NULL,NULL),
(4,"Administration",1,NULL,NULL,'N',FALSE,NULL,'SELECT 
	-1 as id, 
	cs_class.name, 
	cs_class.id as class_id, 
	null as object_id, 
	''N'' as node_type, 
	null as url, 
	csdc.cidsobjects(cs_class.id::varchar , cs_class.table_name) as dynamic_children, 
	false as sql_sort 
    FROM 
	cs_class,
	cs_attr
    WHERE cs_class.id = cs_attr.class_id
	AND cs_attr.field_name ilike ''name''',TRUE,NULL,FALSE,NULL,NULL,NULL)
