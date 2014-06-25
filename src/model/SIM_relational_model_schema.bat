@ECHO OFF
@pg_dump --host nibbler --port 5432 --username "postgres" --no-password  --format plain --schema-only --create --inserts --verbose --file "SIM_relational_model_schema.sql" "SWITCH-ON_Enrichment-XI"
pause