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