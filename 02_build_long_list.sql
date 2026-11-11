-- 02: long list (6,060 firms)
-- Active private limited companies incorporated from 2019, with one of six SIC codes
-- in the first or second SIC field, and a name containing a data/analytics keyword.

DROP TABLE IF EXISTS longlist;

CREATE TABLE longlist AS
SELECT *
FROM companies_clean
WHERE incorp_year >= 2019
  AND category = 'Private Limited Company'
  AND (sic1 IN ('62020','62090','63110','63990','70229','73200')
    OR sic2 IN ('62020','62090','63110','63990','70229','73200'))
  AND (LOWER(name) LIKE '%data%'
    OR LOWER(name) LIKE '%analytic%'
    OR LOWER(name) LIKE '%insight%'
    OR LOWER(name) LIKE '%intelligence%');

SELECT COUNT(*) FROM longlist;   -- 6,060
