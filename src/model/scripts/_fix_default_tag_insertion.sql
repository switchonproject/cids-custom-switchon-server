INSERT INTO tag (name, description, taggroup)
VALUES ('none',NULL,(SELECT id from tagGroup where name = 'meta-data standard'));
INSERT INTO tag (name, description, taggroup)
VALUES ('Web Browser',NULL,(SELECT id from tagGroup where name = 'application profile'));
UPDATE tag set name = 'application/octet-stream' WHERE name ilike '%oct%'
UPDATE taggroup set name = 'relationship type' WHERE name ilike '%ship%'