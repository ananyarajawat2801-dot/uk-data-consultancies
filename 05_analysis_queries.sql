-- 05: result tables used in the report

-- Firms by year of incorporation: all matches
SELECT incorp_year, COUNT(*) AS new_firms
FROM longlist
GROUP BY incorp_year ORDER BY incorp_year;

-- Firms by year of incorporation: shared addresses removed
SELECT incorp_year, COUNT(*) AS new_firms
FROM longlist_clean
GROUP BY incorp_year ORDER BY incorp_year;

-- Top 20 registered towns, shared addresses removed
SELECT town, COUNT(*) AS firms
FROM longlist_clean
GROUP BY town ORDER BY firms DESC LIMIT 20;

-- First SIC code among the five core codes (full long list)
SELECT sic1, COUNT(*) AS firms
FROM longlist
WHERE sic1 IN ('62020','70229','62012','63110','62090')
GROUP BY sic1 ORDER BY firms DESC;

-- Pool split used for sampling
SELECT CASE WHEN town = 'LONDON' THEN 'London' ELSE 'Rest of UK' END AS area,
       COUNT(*) AS firms
FROM screen_pool
GROUP BY area;
