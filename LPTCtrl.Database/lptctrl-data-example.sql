-------------------------------------------------------------------------------
-- E X A M P L E   E V E N T S
-------------------------------------------------------------------------------

INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-24 20:57:10', 1);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-24 20:57:15', 0);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-24 20:57:20', 1);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-24 20:57:25', 0);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-24 20:57:30', 1);
INSERT INTO EVENT (ID, PINID, TS, STATE) VALUES (0, 1, '2008-11-24 20:57:35', 0);

SELECT * FROM PORT;
SELECT * FROM PIN;
SELECT * FROM EVENT;

