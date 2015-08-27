RENAME TABLE CODE_TEMPLATE TO OLD_CODE_TEMPLATE

CREATE TABLE CODE_TEMPLATE_LIBRARY
	(ID VARCHAR(255) NOT NULL PRIMARY KEY,
	NAME VARCHAR(255) NOT NULL UNIQUE,
	REVISION INTEGER,
	LIBRARY CLOB)

CREATE TABLE CODE_TEMPLATE
	(ID VARCHAR(255) NOT NULL PRIMARY KEY,
	NAME VARCHAR(255) NOT NULL UNIQUE,
	REVISION INTEGER,
	CODE_TEMPLATE CLOB)