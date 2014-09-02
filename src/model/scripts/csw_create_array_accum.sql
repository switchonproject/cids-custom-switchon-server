--To accumulate the tags of one taggroup in a single column, this function is needed and thus has to be implemented
CREATE AGGREGATE array_accum (anyelement)
(
    sfunc = array_append,
    stype = anyarray,
    initcond = '{}'
);