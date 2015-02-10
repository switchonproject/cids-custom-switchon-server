-- import the CUASHI Tabluar Ontology into new CUASHI keyword list.
-- skip duplicate keywords
INSERT INTO taggroup
(name, description)
SELECT 'keywords - CUASHI', 'CUASHI Hydrologic Ontology for Discovery'
WHERE
    NOT EXISTS (
        SELECT name FROM taggroup WHERE name = 'keywords - CUASHI'
    );
DO $$
DECLARE tag_raw character varying;
DECLARE tag_trimmed character varying;
DECLARE tagID integer;
DECLARE taggroupID integer = NULL;
DECLARE tagname character varying;
DECLARE tagdescription character varying;
BEGIN
    taggroupID = (SELECT id FROM taggroup WHERE name = 'keywords - CUASHI');
    FOREACH tag_raw IN ARRAY (SELECT ARRAY['Area', 'Area, atmosphere', 'Area, ice', 'Benthic', 'Benthic species', 'Biological', 'Biological community', 'Biological taxa', 'Biomass, phytoplankton ', 'Biomass, zooplankton', 'Carbon', 'Chemical', 'Density', 'Descriptive', 'Dissolved Gas', 'Dissolved Solids', 'Energy', 'Energy, flux', 'Fish', 'Fish species', 'Flux', 'Flux, discharge', 'Flux, dissolved gas', 'Flux, evaporation', 'Flux, precipitation', 'Flux, wind', 'Indicator Organisms', 'Inorganic', 'Length', 'Level', 'Level, ice', 'Level, lake', 'Level, ocean', 'Level, snow', 'Level, stream', 'Macrophyte species', 'Major', 'Minor', 'Nekton', 'Nekton species', 'Nitrogen', 'Nutrient', 'Optical', 'Optical, water', 'Organic', 'Other organic chemical', 'Oxygen Demand', 'PCBs', 'Pesticide', 'Phosphorus', 'Physical', 'Phytoplankton species', 'Pigment', 'Pressure', 'Pressure, air', 'Pressure, water', 'Radiochemical ', 'Stable Isotopes', 'Temperature', 'Velocity', 'Velocity, wind', 'Volume', 'Volume, lake', 'Water', 'Water content', 'Water content, air', 'Water content, snow', 'Water content, soil', 'Water, descriptive', 'Water, dissolved solids', 'Water, suspended solids', 'Zooplankton species'])
    LOOP
            tag_trimmed = trim(tag_raw);
            IF (tag_trimmed IS NOT NULL) THEN
                    IF (EXISTS (SELECT 1 FROM tag, taggroup as tgroup WHERE tag.name ilike tag_trimmed AND taggroup = tgroup.id AND tgroup.name ilike 'keyword%')) THEN
                            raise notice 'Tag % exists. not inserted',tag_trimmed;
                    ELSE
                            raise notice 'Tag % does not exist. insert into taggroup %',tag_trimmed,taggroupID;
                            PERFORM createtag(tag_trimmed, taggroupID);
                    END IF;
            END IF;
    END LOOP;	-- Next Taggroup: scope
END
$$
LANGUAGE plpgsql;