ECHO DO YOU REALLY WANT TO RESTORE SIM_relational_model_data.sql into switchon@switchon.cismet.de?
ECHO PRESS CRTL+C TO CANCEL THE OPERATION
pause
psql --host switchon.cismet.de --port 5434 --username "postgres" --no-password switchon < SIM_relational_model_schema.sql
