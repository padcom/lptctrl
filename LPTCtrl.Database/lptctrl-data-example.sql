-------------------------------------------------------------------------------
-- E X A M P L E   E V E N T S
-------------------------------------------------------------------------------

INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:10', 1);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:15', 0);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:20', 1);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:25', 0);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:30', 1);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-23 03:40:35', 0);

SELECT * FROM PORT;
SELECT * FROM PIN;
SELECT * FROM EVENT;

