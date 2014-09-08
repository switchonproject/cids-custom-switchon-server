﻿--DROP TABLE import_tables.importer

CREATE TABLE import_tables.importer
(
LoginRequired character varying,
directDownload character varying,
mimeContentType character varying,
emmasDataset character varying,
resourceTitle character varying,
uniqueResourceIdentify character varying,
codespace character varying,
resourceAbstraction character varying,
resourceLocation character varying,
resourceLanguage character varying,
topicCategory character varying,
keywordValue character varying,
westBoundLong character varying,
eastBoundLong character varying,
northBoundLat character varying,
southBoundLat character varying,
fromTime character varying,
toTime character varying,
lineage character varying,
spatialresolution character varying,
conformity character varying,
constraintsRelatedToAAU character varying,
limitationsOnPublicAccess character varying,
rpOrganisation character varying,
rpRole character varying,
rpEmail character varying,
metadataDate character varying,
metadataPointOfContact character varying,
metadataLanguage character varying,
spatialScale character varying,
batch character varying,
CONSTRAINT identifyx PRIMARY KEY (uniqueResourceIdentify)
)