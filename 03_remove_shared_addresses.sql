-- 03: attach postcodes and drop likely shared / virtual-office addresses
-- Rule (a judgement call): exclude postcodes shared by 10 or more long-list firms.

CREATE INDEX IF NOT EXISTS idx_companies_number ON companies(CompanyNumber);

DROP TABLE IF EXISTS longlist_pc;

CREATE TABLE longlist_pc AS
SELECT l.*, c."RegAddress.PostCode" AS postcode
FROM longlist l
JOIN companies c ON c.CompanyNumber = l.number;

DROP TABLE IF EXISTS longlist_clean;

CREATE TABLE longlist_clean AS
SELECT *
FROM longlist_pc
WHERE postcode IS NOT NULL
  AND postcode NOT IN (
        SELECT postcode FROM longlist_pc
        WHERE postcode IS NOT NULL
        GROUP BY postcode HAVING COUNT(*) >= 10);

SELECT COUNT(*) FROM longlist_clean;   -- 4,683

-- Sensitivity check: firms removed at thresholds of 5, 10 and 20
WITH pc AS (
  SELECT postcode, COUNT(*) AS n
  FROM longlist_pc
  WHERE postcode IS NOT NULL
  GROUP BY postcode
)
SELECT 'threshold 5' AS rule, SUM(n) AS firms_removed FROM pc WHERE n >= 5
UNION ALL
SELECT 'threshold 10', SUM(n) FROM pc WHERE n >= 10
UNION ALL
SELECT 'threshold 20', SUM(n) FROM pc WHERE n >= 20;   -- 1,560 / 1,377 / 1,233
