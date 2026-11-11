-- 04: screening pool and the random sample

DROP TABLE IF EXISTS screen_pool;

CREATE TABLE screen_pool AS
SELECT *
FROM longlist_clean
WHERE sic1 IN ('62020','70229','62012','63110','62090')
  AND incorp_year BETWEEN 2019 AND 2024
  AND (LOWER(name) LIKE '%analytics%'
    OR LOWER(name) LIKE '%consult%'
    OR LOWER(name) LIKE '%advis%'
    OR LOWER(name) LIKE '%insight%'
    OR LOWER(name) LIKE '%intelligence%'
    OR LOWER(name) LIKE '%solutions%'
    OR LOWER(name) LIKE '%partners%'
    OR LOWER(name) LIKE '%labs%');

SELECT COUNT(*) FROM screen_pool;   -- 1,395 (281 London, 1,114 rest of UK)

-- WARNING: RANDOM() in SQLite cannot be seeded, so every run gives a different sample.
-- This was run ONCE. The saved sample is the permanent record; do not rerun.
DROP TABLE IF EXISTS sample_pool;

CREATE TABLE sample_pool AS
SELECT * FROM (
  SELECT * FROM screen_pool WHERE town = 'LONDON'
  ORDER BY RANDOM() LIMIT 30)
UNION ALL
SELECT * FROM (
  SELECT * FROM screen_pool WHERE town <> 'LONDON'
  ORDER BY RANDOM() LIMIT 30);
