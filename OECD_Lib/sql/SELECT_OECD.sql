USE qnia;
CREATE view qnia_info AS
SELECT databank, name, db_table, db_code, desc_e, desc_c, freq, start, last, unit, name_ord, snl, book, form_e, form_c 
FROM qnia_key;

SELECT min(start) FROM qnia_info;
SELECT max(last) FROM qnia_info;
SELECT * FROM qnia_info LIMIT 0, 20;
SELECT * FROM qnia_info ORDER BY book DESC LIMIT 0, 20;
SELECT * FROM qnia_info ORDER BY form_e LIMIT 0, 20;
SELECT * FROM qnia_info ORDER BY name DESC LIMIT 0, 20;
SELECT * FROM qnia_info ORDER BY desc_e LIMIT 0, 20;
SELECT * FROM qnia_info ORDER BY freq LIMIT 0, 20;
SELECT count(*) AS size FROM qnia_info;
SELECT book AS country, name_ord AS countryCode FROM qnia_info GROUP BY country;
SELECT form_e AS subject FROM qnia_info GROUP BY form_e;
SELECT freq AS frequency FROM qnia_info GROUP BY freq;

SELECT * FROM qnia_info WHERE (name LIKE '%158%' OR desc_e LIKE '%158%' OR name_ord LIKE '%158%' OR book LIKE '%158%' OR form_e LIKE '%158%') ORDER BY name DESC LIMIT 0, 20;
SELECT count(*) AS size FROM qnia_info  WHERE name LIKE '%158%' OR desc_e LIKE '%158%' OR name_ord LIKE '%158%' OR book LIKE '%158%' OR form_e LIKE '%158%';

SELECT * FROM qnia_info WHERE name_ord='ARG';
SELECT count(*) AS size FROM qnia_info WHERE name_ord='ARG';

USE mei;
CREATE view mei_info AS
SELECT databank, name, db_table, db_code, desc_e, desc_c, freq, start, last, unit, name_ord, snl, book, form_e, form_c 
FROM mei_key;

SELECT * FROM mei_info LIMIT 20, 20;
SELECT count(*) AS size FROM mei_info;
SELECT book AS country, name_ord AS countryCode FROM mei_info GROUP BY country;
SELECT form_e AS subject FROM mei_info GROUP BY form_e;
SELECT freq AS frequency FROM mei_info GROUP BY freq;

SELECT * FROM db_a_0001;
SELECT db_table, db_code FROM qnia_info WHERE name='A111B11CAR.a';
SELECT db_a_0001.index, data001 FROM qnia.db_a_0001;
SELECT db_a_0001.index, data001 FROM qnia.db_a_0001 WHERE db_a_0001.index>='2000' and db_a_0001.index<='2022';

SELECT db_table, db_code FROM mei_info 
WHERE name='A132CCRT01IOB.a' or name='A132PWCP02AL.a' or name='A132PWCP03AL.a'
or name='M132CCRT01IOB.m' or name='Q132CCRT01IOB.q' or name='A111NEKP03STS.a';
SELECT db_a_0004.index, data136 FROM mei.db_a_0004 WHERE db_a_0004.index>='1947' and db_a_0004.index<='2022';
SELECT db_a_0035.index, data028 FROM mei.db_a_0035 WHERE db_a_0035.index>='2000' and db_a_0035.index<='2022';
SELECT db_a_0039.index, data183 FROM mei.db_a_0039 WHERE db_a_0039.index>='2000' and db_a_0039.index<='2022';
SELECT db_a_0039.index, data184 FROM mei.db_a_0039 WHERE db_a_0039.index>='2000' and db_a_0039.index<='2022';
SELECT db_m_0016.index, data081 FROM mei.db_m_0016 WHERE db_m_0016.index>='2000-01' and db_m_0016.index<='2022-12';
SELECT db_q_0030.index, data094 FROM mei.db_q_0030 WHERE db_q_0030.index>='2000-Q1' and db_q_0030.index<='2022-Q4';