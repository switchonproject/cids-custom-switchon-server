make shure, all editors used in the process are set to UTF-8 encoding.

1: Mark the actual table Data on the Google drive spreadsheet (Without column description and other stuff, outside of the table)
2: Copy it into an text document (i.E. a .txt)
3: Now you have the table data as tabulator seperated values
4: In Postgres, create a table containing the same columns as the Excel sheet. ("import_create_importTable.sql")
5: If using PGAdmin Select to import on this table and using following configurations:

File Options:
Filename: 	the in task 2 created file.
Format: 	.csv
encoding:	(if left blank. UTF-8 will be used, or choose UTF-8)

Collums:
all active

Misc. Options
OID: []
Header: []
Seperator: [tab] (Choosable in the dropdown menu)
Quote Options:
Nothing

NULL options:
Nothing

6: Import into the cids structure with the "import_importtable_to_cids.sql" script.
