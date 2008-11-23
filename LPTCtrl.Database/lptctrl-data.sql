-------------------------------------------------------------------------------
-- R O O T   D A T A
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- RESET GENERATORS
-------------------------------------------------------------------------------

SET GENERATOR PORT_ID TO 0;
SET GENERATOR PIN_ID TO 0;
SET GENERATOR EVENT_ID TO 0;

-------------------------------------------------------------------------------
-- PORT
-------------------------------------------------------------------------------

INSERT INTO PORT (ID, ADDRESS, NAME) VALUES (0, 888, 'LPT1');

-------------------------------------------------------------------------------
-- PIN
-------------------------------------------------------------------------------

INSERT INTO PIN (ID, PORTID, BIT, NAME) VALUES (0, 1, 0, '(wolne)');
INSERT INTO PIN (ID, PORTID, BIT, NAME) VALUES (0, 1, 1, '(wolne)');
INSERT INTO PIN (ID, PORTID, BIT, NAME) VALUES (0, 1, 2, '(wolne)');
INSERT INTO PIN (ID, PORTID, BIT, NAME) VALUES (0, 1, 3, '(wolne)');
INSERT INTO PIN (ID, PORTID, BIT, NAME) VALUES (0, 1, 4, '(wolne)');
INSERT INTO PIN (ID, PORTID, BIT, NAME) VALUES (0, 1, 5, '(wolne)');
INSERT INTO PIN (ID, PORTID, BIT, NAME) VALUES (0, 1, 6, '(wolne)');
INSERT INTO PIN (ID, PORTID, BIT, NAME) VALUES (0, 1, 7, '(wolne)');
