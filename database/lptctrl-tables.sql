-------------------------------------------------------------------------------
-- T A B L E S
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Table holding information about database modifications
-------------------------------------------------------------------------------

CREATE TABLE UPDATES (
	DATA      TIMESTAMP,
	TABLENAME VARCHAR(50),
	ID        INT,
	OPERATION INT
);

CREATE INDEX IDX_UPDATES_BY_DATE ON UPDATES(DATA);

-------------------------------------------------------------------------------
-- PORT
-------------------------------------------------------------------------------

CREATE TABLE PORT (
	ID        INT NOT NULL,
	ADDRESS   INT NOT NULL,
	NAME      CHAR(5),
    
	PRIMARY KEY (ID)
);

CREATE GENERATOR PORT_ID; 

-------------------------------------------------------------------------------
-- PIN
-------------------------------------------------------------------------------

CREATE TABLE PIN (
	ID        INT NOT NULL,
	BIT       INT NOT NULL,
	NAME      CHAR(255),
	PORTID    INT,
    
	PRIMARY KEY (ID),
	FOREIGN KEY (PORTID) REFERENCES PORT(ID)
);

CREATE GENERATOR PIN_ID;

-------------------------------------------------------------------------------
-- EVENT
-------------------------------------------------------------------------------

CREATE TABLE EVENT (
	ID        INT NOT NULL,
	TS        TIMESTAMP NOT NULL,
	STATE     INT NOT NULL,
	PINID     INT,
    
	PRIMARY KEY (ID),
	FOREIGN KEY (PINID) REFERENCES PIN(ID)
);

CREATE GENERATOR EVENT_ID;

