-------------------------------------------------------------------------------
-- T R I G G E R S
-------------------------------------------------------------------------------

SET TERM !! ;

-------------------------------------------------------------------------------
-- PORT
-------------------------------------------------------------------------------

CREATE GENERATOR PORT_ID !!

CREATE TRIGGER SET_PORT_ID FOR PORT BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(PORT_ID, 1);
END !!

CREATE TRIGGER PORT_INSERT FOR PORT AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'PORT', NEW.ID, 1);
END !!

CREATE TRIGGER PORT_UPDATE FOR PORT AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'PORT', OLD.ID, 2);
END !!

CREATE TRIGGER PORT_DELETE FOR PORT AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'PORT', OLD.ID, 3);
  DELETE FROM PIN WHERE PORTID = OLD.ID;
END !!

-------------------------------------------------------------------------------
-- PIN
-------------------------------------------------------------------------------

CREATE GENERATOR PIN_ID !!

CREATE TRIGGER SET_PIN_ID FOR PIN BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(PIN_ID, 1);
END !!

CREATE TRIGGER PIN_INSERT FOR PIN AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'PIN', NEW.ID, 1);
END !!

CREATE TRIGGER PIN_UPDATE FOR PIN AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'PIN', OLD.ID, 2);
END !!

CREATE TRIGGER PIN_DELETE FOR PIN AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'PIN', OLD.ID, 3);
  DELETE FROM EVENT WHERE PINID = OLD.ID;
END !!

-------------------------------------------------------------------------------
-- EVENT
-------------------------------------------------------------------------------

CREATE GENERATOR EVENT_ID !!

CREATE TRIGGER SET_EVENT_ID FOR EVENT BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(EVENT_ID, 1);
END !!

CREATE TRIGGER EVENT_INSERT FOR EVENT AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'EVENT', NEW.ID, 1);
END !!

CREATE TRIGGER EVENT_UPDATE FOR EVENT AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'EVENT', OLD.ID, 2);
END !!

CREATE TRIGGER EVENT_DELETE FOR EVENT AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'EVENT', OLD.ID, 3);
END !!

-------------------------------------------------------------------------------
-- E N D
-------------------------------------------------------------------------------

SET TERM ; !!

