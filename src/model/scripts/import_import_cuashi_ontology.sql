-- import the CUAHSI Tabluar Ontology into new CUAHSI keyword list.
-- skip duplicate keywords
INSERT INTO taggroup
(name, description)
SELECT 'keywords - CUAHSI', 'CUAHSI Hydrologic Ontology for Discovery'
WHERE
    NOT EXISTS (
        SELECT name FROM taggroup WHERE name = 'keywords - CUAHSI'
    );
DO $$
DECLARE tag_raw character varying;
DECLARE tag_trimmed character varying;
DECLARE tagID integer;
DECLARE taggroupID integer = NULL;
DECLARE tagname character varying;
DECLARE tagdescription character varying;
BEGIN
    taggroupID = (SELECT id FROM taggroup WHERE name = 'keywords - CUAHSI');
    FOREACH tag_raw IN ARRAY (SELECT ARRAY['Area, atmosphere', 'Area, ice', 'Benthic', 'Benthic species', 'Biological community', 'Biomass, phytoplankton', 'Biomass, zooplankton', 'Carbon', 'Crop property', 'Crop type', 'Delineation', 'Delineation, catchment', 'Delineation, drainage lines', 'Density', 'Derived variable', 'Descriptive', 'Dissolved Gas', 'Dissolved Solids', 'Energy, flux', 'Fertilisation', 'Fish', 'Fish species', 'Flux, discharge', 'Flux, dissolved gas', 'Flux, evaporation', 'Flux, precipitation', 'Flux, wind', 'Geology', 'Indicator Organisms', 'Land management', 'Land surface', 'Land surface classification', 'Length', 'Level', 'Level, ice', 'Level, lake', 'Level, ocean', 'Level, snow', 'Level, stream', 'Macrophyte species', 'Major', 'Minor', 'Nekton', 'Nekton species', 'Nitrogen', 'Optical, water', 'Other organic chemical', 'Oxygen Demand', 'PCBs', 'Pesticide', 'Phosphorus', 'Phytoplankton species', 'Pigment', 'Population, human', 'Population, livestock', 'Pressure, air', 'Pressure, water', 'Radiochemical', 'Soil', 'soil depth', 'Soil type', 'Stable Isotopes', 'Surface', 'Surface, elevation', 'Surface, slope', 'Temperature', 'Temperature, air', 'Temperature, soil', 'Temperature, water', 'Velocity', 'Velocity, wind', 'Volume, lake', 'Water body', 'Water body, aquifer', 'Water body, lake', 'Water body, river', 'Water content, air', 'Water content, snow', 'Water content, soil', 'Water, descriptive', 'Water, dissolved solids', 'Water, suspended solids', 'Zooplankton species'])
    LOOP
            tag_trimmed = trim(tag_raw);
            IF (tag_trimmed IS NOT NULL) THEN
                    IF (EXISTS (SELECT 1 FROM tag, taggroup as tgroup WHERE tag.name ilike tag_trimmed AND taggroup = taggroupID)) THEN
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