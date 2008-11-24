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
	NAME      CHAR(4),
    
	PRIMARY KEY (ID),
	CONSTRAINT PORT_ADDRESS CHECK (ADDRESS BETWEEN 0 AND 65535)
);

-------------------------------------------------------------------------------
-- PIN
-------------------------------------------------------------------------------

CREATE TABLE PIN (
	ID        INT NOT NULL,
	BIT       INT NOT NULL,
	NAME      VARCHAR(60),
	PORTID    INT NOT NULL,
    
	PRIMARY KEY (ID),
	FOREIGN KEY (PORTID) REFERENCES PORT(ID),
	CONSTRAINT PIN_BIT CHECK (BIT BETWEEN 0 AND 7)
);

-------------------------------------------------------------------------------
-- EVENT
-------------------------------------------------------------------------------

CREATE TABLE EVENT (
	ID        INT NOT NULL,
	TS        TIMESTAMP NOT NULL,
	REPEAT    INT DEFAULT 0,
	STATE     INT NOT NULL,
	PINID     INT NOT NULL,
	              
	PRIMARY KEY (ID),
	FOREIGN KEY (PINID) REFERENCES PIN(ID)
);
