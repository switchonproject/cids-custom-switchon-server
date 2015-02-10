INSERT INTO taggroup (name, description)
VALUES
('access conditions','License regulating the conditions for access and use of the data (open group with some predefined tags).'),
('access limitations','Limitations on public access in accordance to Article 13 of Directive 2007/2/EC (fixed group with tags from a standard codelist).'),
('application profile','Application that can be used to open or process the resource representation (open group with some predefined tags).'),
('catchments','Catchment of a Level B dataset (open group with some predefined tags).'),
('collection','Assigns the resource to a collection of resources for cataloguing purposes, e.g. SWITCH-ON Experiment Results, etc. (open group with some predefined tags).'),
('conformity','This is a citation of the implementing rules adopted under Article 7(1) of Directive 2007/2/EC or other specification to which a particular resource conforms. (fixed group)'),
('content type','MIME Type of the representation (open group which several predefined tags).'),
('function','Function that can be perfomred following the contentLocation link to the resource representation (fixed group, standard codelist).'),
('geography','Geographical classification of the resource, currently Level A and Level B are defined (open group with some predefined tags).'),
('hydrological concept','Hydrological concept of a Level A Dataset (open group with some predefined tags).'),
('keywords - INSPIRE themes 1.0','Keywords from  Gemet � INSPIREthemes, version 1.0, publication, 2008-06-01 Hydrography (fixed group).'),
('keywords - open','User defined to describe the subject (open group with several predefined tags).'),
('language','The language(s) used within the resource or in which the metadata elements are expressed.  The value domain of this tag is limited to the languages defined in ISO 639-2.'),
('location','Geographic Location of the resource (covered by the data). E.g. Continent, Country, Region, City, etc. Open Group. (open group with some predefined tags).'),
('meta-data standard','Official standard on which the meta-data record is based (open group with some predefined tags).'),
('meta-data type','SIP internal type of the Meta-Data Record (fixed group). '),
('protocol','Protocol of the service that can be accessed at the contentLocation of the resource representation (open group with several predefined tags from standard codelists).'),
('relationship type','SIP internal type of the releationship between resources (fixed group).'),
('representation type','SIP internal type of the representation of the resource (fixed group).'),
('resource type','SIP internal type of the resource (fixed group).'),
('role','Function performed by the responsible party (fixed group, standard codelist).'),
('scope','Scope of the resource. A codelist used in hierarchyLevel, DQ_Scope.level, and updateScope (fixed group with tags from a standard codelist)'),
('srid','The Spatial Reference System Identifier (SRID) of the spatial coverage of the resource EPSG format (open group with some predefined tags).'),
('topic category','High-level classification of resources in accordance with ISO 19115 for grouping and topic-based search (fixed group).'),
('publish type','The publish type is used to determine how an imported file has to be postprocessed in order to publish it to an Andvanced Data Repository.'),
('upload status','The upload status represents a transient property that temporarily stores the status of the upload process to an Advanced Data Repository.'),
('keywords - CUASHI', 'CUASHI Hydrologic Ontology for Discovery');
DO $$
DECLARE tgid integer;
BEGIN
tgid = (SELECT id from taggroup where name = 'access limitations');
INSERT INTO tag (name, description, taggroup)
VALUES
('no limitation','no limitation',tgid),
('(a) confidentiality provided for by law','(a) the confidentiality of the proceedings of public authorities, where such confidentiality is provided for by law',tgid),
('(b) international relations','(b) international relations, public security or national defence',tgid),
('(c) the course of justice','(c) the course of justice, the ability of any person to receive a fair trial or the ability of a public authority to conduct an enquiry of a criminal or disciplinary nature',tgid),
('(d) confidentiality of commercial information','(d) the confidentiality of commercial or industrial information, where such confidentiality is provided for by national or Community law to protect a legitimate economic interest, including the public interest in maintaining statistical confidentiality and tax secrecy',tgid),
('(e) intellectual property rights','(e) intellectual property rights',tgid),
('(f)  confidentiality of personal data','(f) the confidentiality of personal data and/or files relating to a natural person where that person has not consented to the disclosure of the information to the public, where such confidentiality is provided for by national or Community law',tgid),
('(g) information requested on voluntary basis','(g) the interests or protection of any person who supplied the information requested on a voluntary basis without being under, or capable of being put under, a legal obligation to do so, unless that person has consented to the release of the information concerned',tgid),
('(h) protection of the environment','(h) the protection of the environment to which such information relates, such as the location of rare species.',tgid);

tgid = (SELECT id from taggroup where name = 'application profile');
INSERT INTO tag (name, description, taggroup)
VALUES
('Google Earth','Google Earth Application',tgid),
('WMS Client','WMS Client Application',tgid),
('Web Browser','Web Browser',tgid),
('WFS Client','WFS Client Application',tgid);

tgid = (SELECT id from taggroup where name = 'catchments');
INSERT INTO tag (name, description, taggroup)
VALUES
('Arno','Arno',tgid),
('Broye','Broye',tgid),
('Dyfi','Dyfi',tgid),
('Fluttendorf','luttendorf',tgid),
('Furtmuehle','Furtmuehle',tgid),
('Gadera','Gadera',tgid),
('Grossarl','Grossarl',tgid),
('Hoan','Hoan',tgid),
('Ioisach','Ioisach',tgid),
('Juktan','Juktan',tgid),
('Kreuzbergmauth','Kreuzbergmauth',tgid),
('Nossan','Nossan',tgid),
('South Tyne','South Tyne',tgid),
('Tanaro','Tanaro',tgid),
('Treene','Treene',tgid),
('Vils','Vils',tgid),
('Waveney','Waveney',tgid),
('Wieselburg','Wieselburg',tgid),
('Wylye','Wylye',tgid);

tgid = (SELECT id from taggroup where name = 'collection');

tgid = (SELECT id from taggroup where name = 'content type');
INSERT INTO tag (name, description, taggroup)
VALUES
('application/adrg','ADRG/ARC Digitilized Raster Graphics',tgid),
('application/agr','ESRI ArcGIS Ascii Grid',tgid),
('application/aib','ARC/INFO Coverages',tgid),
('application/dem','USGS DEM/USGS Digital Elevation Model',tgid),
('application/dlg','DLG/Digital Line Graph',tgid),
('application/drg','DRG/Digital raster graphic',tgid),
('application/gml+xml','Geography Markup Language',tgid),
('application/hdf','hdf5/hierachical data format',tgid),
('application/json','Java Script Object Notation',tgid),
('application/netcdf','netCDF-CF/Network Common Data Form',tgid),
('application/ntf','National Imagery Transmission Format',tgid),
('application/octet-stream','General Binary Data',tgid),
('application/sdf','Spatial Data File',tgid),
('application/shp','ESRI Shapefile',tgid),
('application/vnd.geo+json','GeoJSON/JavaScript Object Notation',tgid),
('application/vnd.google-earth.kml+xml','KML/Keyhole Markup Language',tgid),
('application/wkb','WKB/Well-known binary',tgid),
('application/wkt','WKT/Well-known text',tgid),
('application/xhtml+xml','Extensible HyperText Markup Language',tgid),
('application/xml','eXtensible Markup Language',tgid),
('application/x-netcdf','Network Common Data Format',tgid),
('application/zip','zip archive file format',tgid),
('image/ecw','ECW/Enhanced Compressed Wavelet',tgid),
('image/geotiff','GeoTIFF/Tagged Image File Format',tgid),
('image/gif','Graphigs Interchange Format',tgid),
('image/jp2','JPEG2000',tgid),
('image/jpeg','Joint Photographic Experts Group',tgid),
('image/png','Portable Network Graphics',tgid),
('image/tiff','Tagged Image File Format',tgid),
('image/vnd.dwg','AutoCAD DWG',tgid),
('image/vnd.dxf','AutoCAD DXF',tgid),
('image/x-mrsid','MrSID/Multi-Resolution raster format',tgid),
('text/csv','Comma Separated Values',tgid),
('text/html','Hypertext Markup Language',tgid),
('text/plain','raw, ascii text',tgid),
('text/rtf','Rich Text Format',tgid),
('text/tab-separated-values','Tab Separated Values',tgid),
('application/x-java-jnlp-file','Java Network Launching Protocol',tgid);

tgid = (SELECT id from taggroup where name = 'function');
INSERT INTO tag (name, description, taggroup)
VALUES
('information','link provides information about resource',tgid),
('template','link provides template to access resource',tgid),
('download','link will get resource. The function of the link is to get a representation of the resource',tgid),
('service','link is service endpoint',tgid),
('order','link value is URL of web application requiring user interaction to order/request access to the resource',tgid),
('search','link value is URL of web application requiring user interaction to search/browse/subset the resource.',tgid),
('offlineAccess','link points to the local filesystem',tgid),
('application','link points to an application (e.g. downloadable exe or Java Webstart rich internet application) which can be used to get the resource',tgid),
('inline','The actual resource data is provided together with the resource meta-data (in the content attribute of the Representation class)',tgid);


tgid = (SELECT id from taggroup where name = 'geography');
INSERT INTO tag (name, description, taggroup)
VALUES
('Level A','Datasets covering Pan-Europe',tgid),
('Level B','Datasets covering a specific Subcatchment',tgid);

tgid = (SELECT id from taggroup where name = 'hydrological concept');
INSERT INTO tag (name, description, taggroup)
VALUES
('Land-use','n/a',tgid),
('Modelled river discharge','n/a',tgid),
('Observed river discharge','n/a',tgid),
('PotEvapo','n/a',tgid),
('Precipitation','n/a',tgid),
('Soils','n/a',tgid),
('Subbasins','n/a',tgid),
('Temperature','n/a',tgid);

tgid = (SELECT id from taggroup where name = 'keywords - INSPIRE themes 1.0');
INSERT INTO tag (name, description, taggroup)
VALUES
('Addresses','Location of properties based on address identifiers, usually by road name, house number, postal code.',tgid),
('Administrative units','Units of administration, dividing areas where Member States have and/or exercise jurisdictional rights, for local, regional and national governance, separated by administrative boundaries.',tgid),
('Agricultural and aquaculture facilities','Farming equipment and production facilities (including irrigation systems, greenhouses and stables).',tgid),
('Area management/restriction/regulation zones and reporting units','Areas managed, regulated or used for reporting at international, European, national, regional and local levels. Includes dumping sites, restricted areas around drinking water sources, nitrate-vulnerable zones, regulated fairways at sea or large inland waters, areas for the dumping of waste, noise restriction zones, prospecting and mining permit areas, river basin districts, relevant reporting units and coastal zone management areas.',tgid),
('Atmospheric conditions','Physical conditions in the atmosphere. Includes spatial data based on measurements, on models or on a combination thereof and includes measurement locations.',tgid),
('Bio-geographic regions','Areas of relatively homogeneous ecological conditions with common characteristics.',tgid),
('Buildings','Geographical location of buildings.Geographical location of buildings.',tgid),
('Cadastral parcels','Areas defined by cadastral registers or equivalent.',tgid),
('Coordinate reference systems','Systems for uniquely referencing spatial information in space as a set of coordinates (x, y, z) and/or latitude and longitude and height, based on a geodetic horizontal and vertical datum.',tgid),
('Elevation','igital elevation models for land, ice and ocean surface. Includes terrestrial elevation, bathymetry and shoreline.',tgid),
('Energy resources','nergy resources including hydrocarbons, hydropower, bio-energy, solar, wind, etc., where relevant including depth/height information on the extent of the resource.',tgid),
('Environmental monitoring facilities','Location and operation of environmental monitoring facilities includes observation and measurement of emissions, of the state of environmental media and of other ecosystem parameters (biodiversity, ecological conditions of vegetation, etc.) by or on behalf of public authorities.',tgid),
('Geographical grid systems','Harmonised multi-resolution grid with a common point of origin and standardised location and size of grid cells.',tgid),
('Geographical names','Names of areas, regions, localities, cities, suburbs, towns or settlements, or any geographical or topographical feature of public or historical interest.',tgid),
('Geology','Geology characterised according to composition and structure. Includes bedrock, aquifers and geomorphology.',tgid),
('Habitats and biotopes','Geographical areas characterised by specific ecological conditions, processes, structure, and (life support) functions that physically support the organisms that live there. Includes terrestrial and aquatic areas distinguished by geographical, abiotic and biotic features, whether entirely natural or semi-natural.',tgid),
('Human health and safety','Geographical distribution of dominance of pathologies (allergies, cancers, respiratory diseases, etc.), information indicating the effect on health (biomarkers, decline of fertility, epidemics) or well-being of humans (fatigue, stress, etc.) linked directly (air pollution, chemicals, depletion of the ozone layer, noise, etc.) or indirectly (food, genetically modified organisms, etc.) to the quality of the environment.',tgid),
('Hydrography','Hydrographic elements, including marine areas and all other water bodies and items related to them, including river basins and sub-basins. Where appropriate, according to the definitions set out in Directive 2000/60/EC of the European Parliament and of the Council of 23 October 2000 establishing a framework for Community action in the field of water policy (2) and in the form of networks.',tgid),
('Land cover','Physical and biological cover of the earth''s surface including artificial surfaces, agricultural areas, forests, (semi-)natural areas, wetlands, water bodies.',tgid),
('Land use','Territory characterised according to its current and future planned functional dimension or socio-economic purpose (e.g. residential, industrial, commercial, agricultural, forestry, recreational).',tgid),
('Meteorological geographical features','Weather conditions and their measurements; precipitation, temperature, evapotranspiration, wind speed and direction.',tgid),
('Mineral resources','Mineral resources including metal ores, industrial minerals, etc., where relevant including depth/height information on the extent of the resource.',tgid),
('Natural risk zones','Vulnerable areas characterised according to natural hazards (all atmospheric, hydrologic, seismic, volcanic and wildfire phenomena that, because of their location, severity, and frequency, have the potential to seriously affect society), e.g. floods, landslides and subsidence, avalanches, forest fires, earthquakes, volcanic eruptions.',tgid),
('Oceanographic geographical features','Physical conditions of oceans (currents, salinity, wave heights, etc.).',tgid),
('Orthoimagery','eo-referenced image data of the Earth''s surface, from either satellite or airborne sensors.',tgid),
('Population distribution - demography','Geographical distribution of people, including population characteristics and activity levels, aggregated by grid, region, administrative unit or other analytical unit.',tgid),
('Production and industrial facilities','Industrial production sites, including installations covered by Council Directive 96/61/EC of 24 September 1996 concerning integrated pollution prevention and control (1) and water abstraction facilities, mining, storage sites.',tgid),
('Protected sites','Area designated or managed within a framework of international, Community and Member States'' legislation to achieve specific conservation objectives.',tgid),
('Sea regions','Pysical conditions of seas and saline water bodies divided into regions and sub-regions with common characteristics.',tgid),
('Soil','Soils and subsoil characterised according to depth, texture, structure and content of particles and organic material, stoniness, erosion, where appropriate mean slope and anticipated water storage capacity.',tgid),
('Species distribution','Geographical distribution of occurrence of animal and plant species aggregated by grid, region, administrative unit or other analytical unit.',tgid),
('Statistical units','Units for dissemination or use of statistical information.',tgid),
('Transport networks','Road, rail, air and water transport networks and related infrastructure. Includes links between different networks. Also includes the trans-European transport network as defined in Decision No 1692/96/EC of the European Parliament and of the Council of 23 July 1996 on Community Guidelines for the development of the trans-European transport network (1) and future revisions of that Decision.',tgid),
('Utility and govermental services','Includes utility facilities such as sewage, waste management, energy supply and water supply, administrative and social governmental services such as public administrations, civil protection sites, schools and hospitals.',tgid);

tgid = (SELECT id from taggroup where name = 'keywords - open');
INSERT INTO tag (name, description, taggroup)
VALUES
('edc','n/a',tgid),
('hydrosphere','n/a',tgid),
('topography','n/a',tgid),
('gis','n/a',tgid),
('hydropattern','n/a',tgid),
('digital','elevation model	n/a',tgid),
('rivers','n/a',tgid),
('mapping','n/a',tgid),
('terrain elevation','n/a',tgid),
('land surface','n/a',tgid),
('cartography','n/a',tgid),
('streams','n/a',tgid),
('usgs','n/a',tgid),
('drainage','n/a',tgid),
('eros','n/a',tgid),
('surface water','n/a',tgid),
('3-arc-second dem','n/a',tgid),
('watershed characteristics','n/a',tgid),
('earth science','n/a',tgid);

tgid = (SELECT id from taggroup where name = 'language');
INSERT INTO tag (name, description, taggroup)
VALUES
('bul','Bulgarian',tgid),
('cze','Czech',tgid),
('dan','Danish',tgid),
('dut','Dutch',tgid),
('eng','English',tgid),
('fin','Finnish',tgid),
('fre','French',tgid),
('ger','German',tgid),
('gre','Greek',tgid),
('hun','Hungarian',tgid),
('gle','Irish',tgid),
('ita','Italian',tgid),
('pol','Polish',tgid),
('por','Portuguese',tgid),
('slo','Slovak',tgid),
('spa','Spanish',tgid),
('swe','Swedish',tgid);

tgid = (SELECT id from taggroup where name = 'access conditions');
INSERT INTO tag (name, description, taggroup)
VALUES
('CC BY','Creative Commons Attribution 4.0 International (CC BY 4.0) http://creativecommons.org/licenses/by/4.0/legalcode',tgid),
('CC BY-SA','Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) http://creativecommons.org/licenses/by-sa/4.0/legalcode',tgid),
('CC BY-ND','Creative Commons Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0) http://creativecommons.org/licenses/by-nd/4.0/legalcode',tgid),
('CC BY-NC','Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) http://creativecommons.org/licenses/by-nc/4.0/',tgid),
('CC BY-NC-SA','Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode',tgid),
('CC BY-NC-ND','Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0) http://creativecommons.org/licenses/by-nc-nd/4.0/legalcode',tgid),
('ODbL','Open Database License (ODbL) v1.0 http://opendatacommons.org/licenses/odbl/1.0/',tgid),
('DbCL','Database Contents License (DbCL) v1.0 http://opendatacommons.org/licenses/dbcl/1.0/',tgid),
('PDDL','ODC Public Domain Dedication and Licence (PDDL) http://opendatacommons.org/licenses/pddl/1.0/',tgid),
('ODC-By','Open Data Commons Attribution License (ODC-By) v1.0 http://opendatacommons.org/licenses/by/1.0/',tgid),
('proprietary','Proprietary License.',tgid),
('No conditions apply','No conditions apply',tgid),
('Conditions unknown','Conditions unknown',tgid);


tgid = (SELECT id from taggroup where name = 'location');
INSERT INTO tag (name, description, taggroup)
VALUES
('Africa','n/a',tgid),
('Europe','n/a',tgid);

tgid = (SELECT id from taggroup where name = 'meta-data standard');
INSERT INTO tag (name, description, taggroup)
VALUES
('ISO19115','Geographic information -- Metadata',tgid),
('ISO19119','Geographic information -- Services',tgid),
('FGDC-STD-001-1998','Standard for Digital Geospatial Metadata',tgid),
('DublinCore','Dublin Core Metadata Element Set',tgid);

tgid = (SELECT id from taggroup where name = 'meta-data type');
INSERT INTO tag (name, description, taggroup)
VALUES
('basic meta-data','Type of the Meta-Data Record. "basic meta-data" refers to meta-data collected by switch-on according to the SIM meta-data schema. In fact, this meta-meta-data record refers to enclosing resource meta-data record.',tgid),
('origin meta-data','Type of the Meta-Data Record. "origin meta-data" refers to meta-data available at the origin (e.g. website) of the resource. It could refer to a webpage which provides information on the resource or, if available, a meta-data catalogue entry. There may be multiple entries of this meta-data record.',tgid),
('quality meta-data','Type of the Meta-Data Record. "quality meta-data" refers to meta-data on data quality either available at the origin (e.g. website) of the resource or provided by SWITCH-ON. Since no default schema for meta-data on data quality has been defined yet, the content of this meta-data record will be limited to a short statement by the person collecting the meta-data.',tgid),
('lineage meta-data','Type of the Meta-Data Record. "lineage meta-data" refers to meta-data about the lineage of the resource, e.g. a protocol of an experiment.',tgid),
('relationship meta-data','Refers to meta-data about the relationship of the resource to other resources in the SIP, e.g. a protocol of an experiment.',tgid),
('none',NULL,tgid);


tgid = (SELECT id from taggroup where name = 'protocol');
INSERT INTO tag (name, description, taggroup)
VALUES
('OGC:CSW','OGC Catalogue Service for the Web',tgid),
('OGC:SOS','OGC Sensor Observation Service',tgid),
('OGC:WCS','OGC Web Coverage Service',tgid),
('OGC:WFS','OGC Web Feature Service',tgid),
('OGC:WMS','OGC Web Map Service',tgid),
('OGC:WPS','OGC Web Processing Service',tgid),
('ESRI:ArcIMS','ESRI ArcIMS Service',tgid),
('ESRI:ArcGIS','ESRI ArcGIS Service',tgid),
('ESRI:MPK','ArcGIS Map Package',tgid),
('OPeNDAP:OPeNDAP','OPeNDAP root URL',tgid),
('UNIDATA:NCSS','NetCDF Subset Service',tgid),
('UNIDATA:CDM','Common Data Model Remote Web Service',tgid),
('UNIDATA:CdmRemote','Common Data Model index subsetting',tgid),
('UNIDATA:CdmrFeature','Common Data Model coordinate subsetting',tgid),
('OGC:GML','OGC Geography Markup Language',tgid),
('WWW:LINK','Web Address (URL)',tgid),
('WWW:WSDL','Web Service Description Language XML document describing service operation',tgid),
('OpenSearch1.1','OpenSearch template',tgid),
('OpenSearch1.1:Description','OpenSearch description document',tgid),
('ZIP:application/x-netcdf','Compressed netCDF-CF/Network Common Data Form dataset',tgid),
('WWW:RIA','Rich Internet Application (JavaScript/HTML5 application)',tgid),
('WWW:FORM','Web form',tgid),
('WWW:TILESERVER','...',tgid);


tgid = (SELECT id from taggroup where name = 'realtionship type');
INSERT INTO tag (name, description, taggroup)
VALUES
('repurposed','The target resource has been repurposed from the origin resource(s).',tgid),
('aggregated','The target resource has been aggregated from the origin resource(s).',tgid),
('experiment','The target resource is a result of an experiment that used the origin resource(s) as input data.',tgid),
('derived','The target resource has been derived from the origin resource(s).',tgid),
('transformed','The target resource has been transformed from the origin resource(s).',tgid),
('unknown','The type of the reltionship is unknown or no source resources are available in the SIP',tgid);

tgid = (SELECT id from taggroup where name = 'representation type');
INSERT INTO tag (name, description, taggroup)
VALUES
('original data','The representation holds the original data of the resource',tgid),
('aggregated data','The representation holds aggregated data of the resource, e.g. average mean values',tgid),
('preview data','The representation holds preview data of the resource, e.g. an image',tgid);

tgid = (SELECT id from taggroup where name = 'role');
INSERT INTO tag (name, description, taggroup)
VALUES
('resourceProvider','Party that supplies the resource. Person or organisation responsible for the availability of the data resource. Different form data distributor, who actively distributes the data resource at user�s request.',tgid),
('custodian','Party that accepts accountability for the data and ensures appropriate care and maintenance of the resource. Person or organisation responsible for care and maintenance of the data resource.',tgid),
('owner','Party that owns the resource. Person or organization with the title to intellectual property rights.',tgid),
('user','Party that uses the resource. Person or organization that is, or can be, the key user of the resource.',tgid),
('distributor','Party that distributes the resource. Person or organisation responsible for the distribution of the data resource. Data distributor is not necessarily the owner of data.',tgid),
('originator','Party that created the resource. Person of organization that created the data resource. Can be the same as author, but in cases when a data resource is based on other resources, the creator cannot be the author.',tgid),
('pointOfContact','Party that can be contacted for acquiring knowledge about or acquisition of the data resource. Person or organization that can be contacted to acquire data on the resource.',tgid),
('principalInvestigator','Key party responsible for gathering information and conducting research. Key person responsible for gathering information and conducting research resulting in the data resource. Appointed principal investigator or project manager or leading researcher.',tgid),
('processor','Party that has processed the data in a manner that the resource has been modified. Person or organization processing the data in the described form. Applicable only if the data has been subsequently processed or modified.',tgid),
('publisher','Party that publishes the resource. Person of organization that published the data resource.',tgid),
('author','Party that authorized the resource. Party that created the resource. More often, the party that published the data resource is listed than the party author of "raw" data. For instance, the person or group of persons or the organization is listed that created the dataset (collected data from multiple resources and created a data resource) or published the reviewing service.',tgid);

tgid = (SELECT id from taggroup where name = 'srid');
INSERT INTO tag (name, description, taggroup)
VALUES
('EPSG:4326','WGS 84 / World Geodetic System 1984',tgid);

tgid = (SELECT id from taggroup where name = 'topic category');
INSERT INTO tag (name, description, taggroup)
VALUES
('farming','rearing of animals and/or cultivation of plants Examples: agriculture, irrigation, aquaculture, plantations, herding, pests and diseases affecting crops and livestock',tgid),
('biota','flora and/or fauna in natural environment Examples: wildlife, vegetation, biological sciences, ecology, wilderness, sealife, wetlands, habitat',tgid),
('boundaries','legal land descriptions Examples: political and administrative boundaries',tgid),
('climatologyMeteorologyAtmosphere','processes and phenomena of the atmosphere. Examples: cloud cover, weather, climate, atmospheric conditions, climate change, precipitation',tgid),
('economy','economic activities, conditions and employment. Examples: production, labour, revenue, commerce, industry, tourism and ecotourism, forestry, fisheries, commercial or subsistence hunting, exploration and exploitation of resources such as minerals, oil and gas',tgid),
('elevation','height above or below sea level Examples: altitude, bathymetry, digital elevation models, slope, derived products',tgid),
('environment','environmental resources, protection and conservation Examples: environmental pollution, waste storage and treatment, environmental impact assessment, monitoring environmental risk, nature reserves, landscape',tgid),
('geoscientificInformation','information pertaining to earth sciences Examples: geophysical features and processes, geology, minerals, sciences dealing with the composition, structure and origin of the earth�s rocks, risks of earthquakes, volcanic activity, landslides, gravity information, soils, permafrost, hydrogeology, erosion',tgid),
('health','health, health services, human ecology, and safety Examples: disease and illness, factors affecting health, hygiene, substance abuse, mental and physical health, health services',tgid),
('imageryBaseMapsEarthCover','base maps Examples: land cover, topographic maps, imagery, unclassified images, annotations',tgid),
('intelligenceMilitary','military bases, structures, activities Examples: barracks, training grounds, military transportation, information collection',tgid),
('inlandWaters','inland water features, drainage systems and their characteristics Examples: rivers and glaciers, salt lakes, water utilization plans, dams, currents, floods, water quality, hydrographic charts',tgid),
('location','positional information and services Examples: addresses, geodetic networks, control points, postal zones and services, place names',tgid),
('oceans','features and characteristics of salt water bodies (excluding inland waters) Examples: tides, tidal waves, coastal information, reefs',tgid),
('planningCadastre','information used for appropriate actions for future use of the land Examples: land use maps, zoning maps, cadastral surveys, land ownership',tgid),
('society','characteristics of society and cultures Examples: settlements, anthropology, archaeology, education, traditional beliefs, manners and customs, demographic data, recreational areas and activities, social impact assessments, crime and justice, census information',tgid),
('structure','man-made construction Examples: buildings, museums, churches, factories, housing, monuments, shops, towers',tgid),
('transportation','means and aids for conveying persons and/or goods Examples: roads, airports/airstrips, shipping routes, tunnels, nautical charts, vehicle or vessel location, aeronautical charts, railways',tgid),
('utilitiesCommunication','energy, water and waste systems and communications infrastructure and services Examples: hydroelectricity, geothermal, solar and nuclear sources of energy, water purification and distribution, sewage collection and disposal, electricity and gas distribution, data communication, telecommunication, radio, communication networks',tgid);


tgid = (SELECT id from taggroup where name = 'conformity');
INSERT INTO tag (name, description, taggroup)
VALUES
('Commission Regulation No 1205/2008','COMMISSION REGULATION (EC) No 1205/2008 of 3 December 2008 implementing Directive 2007/2/EC of the European Parliament and of the Council as regards metadata;2008-12-04',tgid),
('Corringendum to INSPIRE Metadata Regulation','Corrigendum to INSPIRE Metadata Regulation published in the Official Journal of the European Union, L 328, page 83;2009-12-15',tgid),
('Commission Regulation No 1089/2010','Commission Regulation (EU) No 1089/2010 of 23 November 2010 implementing Directive 2007/2/EC of the European Parliament and of the Council as regards interoperability of spatial data sets and services;2010-12-08',tgid),
('Commission Regulation No 1088/2010','COMMISSION REGULATION (EU) No 1088/2010 of 23 November 2010 amending Regulation (EC) No 976/2009 as regards download services and transformation services;2010-12-08',tgid),
('Commission Regulation No 967/2009','COMMISSION REGULATION (EC) No 976/2009 of 19 October 2009 implementing Directive 2007/2/EC of the European Parliament and of the Council as regards the Network Services;2009-10-20',tgid),
('Commission Regulation No 268/2010','COMMISSION REGULATION (EU) No 268/2010 of 29 March 2010 implementing Directive 2007/2/EC of the European Parliament and of the Council as regards the access to spatial data sets and services of the Member States by Community institutions and bodies under harmonised conditions;2010-03-30',tgid),
('Commission Decision of 5 June 2009','Commission Decision of 5 June 2009 implementing Directive 2007/2/EC of the European Parliament and of the Council as regards monitoring and reporting (notified under document number C(2009) 4199) (2009/442/EC);2009-06-11',tgid),
('Not evaluated','Conformity to EU Commission regulations was not evaluated',tgid);

tgid = (SELECT id from taggroup where name = 'resource type');
INSERT INTO tag (name, description, taggroup)
VALUES
('external data','This is data available as open data from any source on the Internet in a format, which can be directly used in experiments in the Laboratory.',tgid),
('repurposed data','This is any data which has been adjusted or recalculated to be used in hydrological modelling or in a hydrological experiment.',tgid),
('experiment result data','New datasets originating  from hydrological experiments.',tgid),
('repurposed experiment result data','This is basically the same as repurposed data, however, they are explicitly mentioned here to highlight that the fact that a result might need repurposing to be reused in a new experiment.',tgid);

tgid = (SELECT id from taggroup where name = 'scope');
INSERT INTO tag (name, description, taggroup)
VALUES
('attribute','information applies to the attribute class',tgid),
('attributeType','information applies to the characteristic of a feature',tgid),
('collectionHardware','information applies to the collection hardware class',tgid),
('collectionSession','information applies to the collection session',tgid),
('dataset','information applies to the dataset',tgid),
('series','information applies to the series',tgid),
('nonGeographicDataset','information applies to non-geographic data',tgid),
('dimensionGroup','information applies to a dimension group',tgid),
('feature','information applies to a feature',tgid),
('featureType','information applies to a feature type',tgid),
('propertyType','information applies to a property type',tgid),
('fieldSession','information applies to a field session',tgid),
('software','information applies to a computer program or routine',tgid),
('service','information applies to a capability which a service provider entity makes available to a service user entity through a set of interfaces that define a behaviour, such as a use case',tgid),
('model','information applies to a copy or imitation of an existing or hypothetical object',tgid),
('tile','information applies to a tile, a spatial subset of geographic data',tgid);

tgid = (SELECT id from taggroup where name = 'publish type');
INSERT INTO tag (name, description, taggroup)
VALUES
('Geoserver','The imported representation is published as WMS or WFS Layer to a Geoserver instance. Supported file types are for example SHP and GeoTIFF.',tgid),
('THREDDS','The imported representation is published to a THREDDS Data Server. A supported file type is for example NetCDF.',tgid);

tgid = (SELECT id from taggroup where name = 'upload status');
INSERT INTO tag (name, description, taggroup)
VALUES
('uploading','The newly imported representation is currently being uploaded to an Advanced Data Repository like Geoserver or THREDDS.',tgid),
('finished','The upload of the newly imported representation to an Advanced Data Repository like Geoserver or THREDDS has been completed successfully.',tgid),
('failed','The upload of the newly imported representation to an Advanced Data Repository like Geoserver or THREDDS has failed.',tgid);

tgid = (SELECT id from taggroup where name = 'CUASHI');
INSERT INTO tag (name, description, taggroup)
VALUES
('Area','Area',tgid),
('Area, atmosphere','Area, atmosphere',tgid),
('Area, ice','Area, ice',tgid),
('Benthic','Benthic',tgid),
('Benthic species','Benthic species',tgid),
('Biological','Biological',tgid),
('Biological community','Biological community',tgid),
('Biological taxa','Biological taxa',tgid),
('Biomass, phytoplankton ','Biomass, phytoplankton ',tgid),
('Biomass, zooplankton','Biomass, zooplankton',tgid),
('Carbon','Carbon',tgid),
('Chemical','Chemical',tgid),
('Density','Density',tgid),
('Descriptive','Descriptive',tgid),
('Dissolved Gas','Dissolved Gas',tgid),
('Dissolved Solids','Dissolved Solids',tgid),
('Energy','Energy',tgid),
('Energy, flux','Energy, flux',tgid),
('Fish','Fish',tgid),
('Fish species','Fish species',tgid),
('Flux','Flux',tgid),
('Flux, discharge','Flux, discharge',tgid),
('Flux, dissolved gas','Flux, dissolved gas',tgid),
('Flux, evaporation','Flux, evaporation',tgid),
('Flux, precipitation','Flux, precipitation',tgid),
('Flux, wind','Flux, wind',tgid),
('Indicator Organisms','Indicator Organisms',tgid),
('Inorganic','Inorganic',tgid),
('Length','Length',tgid),
('Level','Level',tgid),
('Level, ice','Level, ice',tgid),
('Level, lake','Level, lake',tgid),
('Level, ocean','Level, ocean',tgid),
('Level, snow','Level, snow',tgid),
('Level, stream','Level, stream',tgid),
('Macrophyte species','Macrophyte species',tgid),
('Major','Major',tgid),
('Minor','Minor',tgid),
('Nekton','Nekton',tgid),
('Nekton species','Nekton species',tgid),
('Nitrogen','Nitrogen',tgid),
('Nutrient','Nutrient',tgid),
('Optical','Optical',tgid),
('Optical, water','Optical, water',tgid),
('Organic','Organic',tgid),
('Other organic chemical','Other organic chemical',tgid),
('Oxygen Demand','Oxygen Demand',tgid),
('PCBs','PCBs',tgid),
('Pesticide','Pesticide',tgid),
('Phosphorus','Phosphorus',tgid),
('Physical','Physical',tgid),
('Phytoplankton species','Phytoplankton species',tgid),
('Pigment','Pigment',tgid),
('Pressure','Pressure',tgid),
('Pressure, air','Pressure, air',tgid),
('Pressure, water','Pressure, water',tgid),
('Radiochemical ','Radiochemical ',tgid),
('Stable Isotopes','Stable Isotopes',tgid),
('Temperature','Temperature',tgid),
('Velocity','Velocity',tgid),
('Velocity, wind','Velocity, wind',tgid),
('Volume','Volume',tgid),
('Volume, lake','Volume, lake',tgid),
('Water','Water',tgid),
('Water content','Water content',tgid),
('Water content, air','Water content, air',tgid),
('Water content, snow','Water content, snow',tgid),
('Water content, soil','Water content, soil',tgid),
('Water, descriptive','Water, descriptive',tgid),
('Water, dissolved solids','Water, dissolved solids',tgid),
('Water, suspended solids','Water, suspended solids',tgid),
('Zooplankton species','Zooplankton species',tgid);

END;
$$
