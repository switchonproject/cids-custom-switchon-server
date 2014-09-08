CREATE FUNCTION createtag (Fname character varying, Ftaggroup integer) RETURNS integer  AS $creatag$
Begin
INSERT INTO tag (name, description, taggroup) VALUES (Fname, 'n/a', Ftaggroup);
RETURN currval('tag_seq'); 
End;
$creatag$
language plpgsql;

CREATE FUNCTION createtag (Fname character varying, Fdescription character varying, Ftaggroup integer) RETURNS integer AS $createtagwithdesc$
Begin
INSERT INTO tag (name, description, taggroup) VALUES (Fname, Fdescription, Ftaggroup);
RETURN currval('tag_seq');
End;
$createtagwithdesc$
language plpgsql

--drop FUNCTION createtag (character varying, integer) 
--drop FUNCTION createtag (character varying, character varying, integer) 