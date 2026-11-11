-- 01: tidy table of ACTIVE companies from the raw Companies House snapshot (1 November 2026)
-- Dates arrive as DD/MM/YYYY text, so they are converted to ISO format.
-- SIC fields hold "code - description", so only the 5-digit code is kept.

DROP TABLE IF EXISTS companies_clean;

CREATE TABLE companies_clean AS
SELECT
  CompanyName AS name,
  CompanyNumber AS number,
  CompanyCategory AS category,
  CompanyStatus AS status,
  substr(IncorporationDate,7,4) || '-' ||
  substr(IncorporationDate,4,2) || '-' ||
  substr(IncorporationDate,1,2) AS incorp_date,
  CAST(substr(IncorporationDate,7,4) AS INTEGER) AS incorp_year,
  "RegAddress.PostTown" AS town,
  substr("SICCode.SicText_1",1,5) AS sic1,
  substr("SICCode.SicText_2",1,5) AS sic2,
  substr("SICCode.SicText_3",1,5) AS sic3,
  substr("SICCode.SicText_4",1,5) AS sic4,
  URI AS uri
FROM companies
WHERE CompanyStatus = 'Active';
