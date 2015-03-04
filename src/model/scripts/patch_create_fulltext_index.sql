CREATE INDEX resource_fulltext_ftidx ON public.resource USING gin (to_tsvector('english',  name || ' ' || description));
CREATE INDEX resource_name_ftidx ON public.resource USING gin (to_tsvector('english',  name));
CREATE INDEX resource_description_ftidx ON public.resource USING gin (to_tsvector('english',  description));
CREATE INDEX tag_name_ftidx ON public.tag USING gin (to_tsvector('english',  name));
CREATE INDEX taggroup_name_ftidx ON public.taggroup USING gin (to_tsvector('english',  name));


