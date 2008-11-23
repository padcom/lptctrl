-------------------------------------------------------------------------------
-- R O O T   D A T A
-------------------------------------------------------------------------------

INSERT INTO Port (ID, ADDRESS, NAME) VALUES (1, 888, 'LPT1');
SET GENERATOR PORT_ID TO 2;

INSERT INTO Pin (ID, PORTID, BIT, NAME) VALUES (1, 1, 0, '(wolne)');
INSERT INTO Pin (ID, PORTID, BIT, NAME) VALUES (2, 1, 1, '(wolne)');
INSERT INTO Pin (ID, PORTID, BIT, NAME) VALUES (3, 1, 2, '(wolne)');
INSERT INTO Pin (ID, PORTID, BIT, NAME) VALUES (4, 1, 3, '(wolne)');
INSERT INTO Pin (ID, PORTID, BIT, NAME) VALUES (5, 1, 4, '(wolne)');
INSERT INTO Pin (ID, PORTID, BIT, NAME) VALUES (6, 1, 5, '(wolne)');
INSERT INTO Pin (ID, PORTID, BIT, NAME) VALUES (7, 1, 6, '(wolne)');
INSERT INTO Pin (ID, PORTID, BIT, NAME) VALUES (8, 1, 7, '(wolne)');
SET GENERATOR PIN_ID TO 9;

SET GENERATOR EVENT_ID TO 1;
INSERT INTO Event (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:10', 1);
INSERT INTO Event (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:15', 0);
INSERT INTO Event (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:20', 1);
INSERT INTO Event (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:25', 0);
INSERT INTO Event (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:30', 1);
INSERT INTO Event (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:35', 0);

select * from event;
