/* PRIMARY ID SEQUENCE */
DROP SEQUENCE SEQ_CONFIGURATION IF EXISTS;
CREATE SEQUENCE SEQ_CONFIGURATION START WITH 1 INCREMENT BY 1;

/* MESSAGES */
DROP TABLE MESSAGES IF EXISTS;
CREATE CACHED TABLE MESSAGES
	(ID VARCHAR(255) NOT NULL PRIMARY KEY,
	CHANNEL_ID VARCHAR(255) NOT NULL,
	DATE_CREATED TIMESTAMP NOT NULL,
	ENCRYPTED BOOLEAN NOT NULL,
	STATUS VARCHAR(40),
	RAW_DATA LONGVARCHAR,
	RAW_DATA_PROTOCOL VARCHAR(40),
	TRANSFORMED_DATA LONGVARCHAR,
	TRANSFORMED_DATA_PROTOCOL VARCHAR(40),
	ENCODED_DATA LONGVARCHAR,
	ENCODED_DATA_PROTOCOL VARCHAR(40),
	VARIABLE_MAP LONGVARCHAR,
	CONNECTOR_NAME VARCHAR(255),
	ERRORS LONGVARCHAR);

/* EVENTS */
DROP TABLE EVENTS IF EXISTS;
CREATE TABLE EVENTS
	(ID INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
	DATE_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	EVENT VARCHAR(4000) NOT NULL,
	EVENT_LEVEL VARCHAR(40) NOT NULL,
	DESCRIPTION VARCHAR(4000),
	ATTRIBUTES VARCHAR(4000));

/* CHANNELS */
DROP TABLE CHANNELS IF EXISTS CASCADE;
CREATE TABLE CHANNELS
	(ID VARCHAR(255) NOT NULL PRIMARY KEY,
	CHANNEL_NAME VARCHAR(255) NOT NULL,
	DATE_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CHANNEL_DATA LONGVARCHAR NOT NULL);

/* CHANNEL STATISTICS */
DROP TABLE CHANNEL_STATISTICS IF EXISTS;
CREATE TABLE CHANNEL_STATISTICS
	(CHANNEL_ID VARCHAR(255) NOT NULL,
	RECEIVED INTEGER NOT NULL,
	SENT INTEGER NOT NULL,
	ERRORS INTEGER NOT NULL,
	FOREIGN KEY (CHANNEL_ID) REFERENCES CHANNELS(ID) ON DELETE CASCADE); 

/* USERS */
DROP TABLE USERS IF EXISTS;
CREATE TABLE USERS
	(ID INTEGER NOT NULL PRIMARY KEY,
	USERNAME VARCHAR(40) NOT NULL,
	PASSWORD VARCHAR(40) NOT NULL);

/* TRANSPORTS */
DROP TABLE TRANSPORTS IF EXISTS;
CREATE TABLE TRANSPORTS
	(NAME VARCHAR(255) NOT NULL PRIMARY KEY,
	CLASS_NAME VARCHAR(255) NOT NULL,
	PROTOCOL VARCHAR(255) NOT NULL,
	TRANSFORMERS VARCHAR(255) NOT NULL,
	TYPE VARCHAR(255) NOT NULL,
	INBOUND BOOLEAN NOT NULL,
	OUTBOUND BOOLEAN NOT NULL);

/* CONFIGURATIONS */
DROP TABLE CONFIGURATIONS IF EXISTS;
CREATE TABLE CONFIGURATIONS
	(ID INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
	DATE_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	DATA LONGVARCHAR NOT NULL);
	
/* ENCRYPTION KEYS */
DROP TABLE KEYS IF EXISTS;
CREATE TABLE KEYS
	(DATA LONGVARCHAR NOT NULL);
	
/* ADD ADMIN ACCOUNT */
INSERT INTO USERS VALUES(0, 'admin', 'admin');

/* ADD TRANSPORTS */

INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('LLP Listener', 'org.mule.providers.tcp.TcpConnector', 'tcp', 'ByteArrayToString', 'LISTENER', true, false);
INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('Database Reader', 'org.mule.providers.jdbc.JdbcConnector', 'jdbc', 'ResultMapToXML', 'LISTENER', true, true);
INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('File Reader', 'org.mule.providers.file.FileConnector', 'file', 'ByteArrayToString', 'LISTENER', true, false);

INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('LLP Sender', 'org.mule.providers.tcp.TcpConnector', 'tcp', '', 'SENDER', true, true);
INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('Database Writer', 'org.mule.providers.jdbc.JdbcConnector', 'jdbc', '', 'SENDER', true, false);
INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('File Writer', 'org.mule.providers.file.FileConnector', 'file', '', 'SENDER', true, true);

/* INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('JMS Writer', 'org.mule.providers.jms.JmsConnector', 'jms', '', 'SENDER'); */
/* INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('HTTP Listener', 'org.mule.providers.http.HttpsConnector', 'http', 'HttpRequestToString', 'LISTENER'); */
/* INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('HTTPS Listener', 'org.mule.providers.http.HttpConnector', 'https', 'HttpRequestToString', 'LISTENER'); */
/* INSERT INTO TRANSPORTS (NAME, CLASS_NAME, PROTOCOL, TRANSFORMERS, TYPE, INBOUND, OUTBOUND) VALUES ('Email Sender', 'org.mule.providers.smtp.SmtpConnector', 'smtp', '', 'SENDER'); */
