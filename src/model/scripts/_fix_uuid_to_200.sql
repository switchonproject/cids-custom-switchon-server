ALTER TABLE public.metadata
   ALTER COLUMN uuid TYPE character varying(200);
ALTER TABLE public.representation
   ALTER COLUMN uuid TYPE character varying(200);

