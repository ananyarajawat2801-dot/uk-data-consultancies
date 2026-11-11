# UK data and analytics consultancies: a landscape study

**Question:** How many UK data and analytics consultancies are being set up, where are they registered, and how many of a random sample show a verifiable working business?

**Data:** Companies House Free Company Data Product, snapshot dated 1 November 2026 (live companies only).
**Tools:** Python (pandas) and SQLite for loading and cleaning, SQL (DB Browser for SQLite) for analysis, Excel for manual screening, Power BI for the report.

---

## Headline findings

1. **Firm formation rose about threefold between 2019 and 2025.** After removing shared-address registrations, surviving matching firms went from 331 (2019) to 992 (2025), and 1,056 in 2026 up to 1 November.
2. **Shared addresses inflate the raw counts.** 1,377 of 6,060 initial matches (22.7%) were registered at postcodes shared by 10 or more matching firms. That share rose from about 14% of 2019 firms to about 32% of 2026 firms. I describe this pattern but do not explain it.
3. **London accounts for about one in five matching firms** (923 of 4,683, 19.7%). Manchester is next with 102. This is the registered address, not where people work.
4. **In a random sample of 60 firms, 19 (32%) showed a verifiable working data or analytics business**, and 17 of those were independent small firms. London: 14 of 30. Rest of UK: 5 of 30. With 30 firms per group the 95% ranges overlap (roughly 30 to 64% and 7 to 34%), so I do not claim a real difference between the two.

---

## Method

### 1. Load and filter
- Loaded 5,711,779 rows from the snapshot into SQLite. 5,179,256 are marked Active.
- **Long list (6,060 firms):** active private limited companies incorporated from 2019, with at least one of six SIC codes (62020, 62090, 63110, 63990, 70229, 73200) in the first or second SIC field, and a name containing "data", "analytic", "insight" or "intelligence".

### 2. Remove shared addresses
- Counted long-list firms per registered postcode. Excluded postcodes shared by **10 or more** firms as likely shared or virtual-office addresses. This left **4,683** firms.
- The threshold is a judgement call. Thresholds of 5, 10 and 20 would have removed 1,560, 1,377 and 1,233 firms respectively (20 to 26% of the long list), so the size of the exclusion is not sensitive to the exact cutoff. I did not rerun every chart at the other thresholds.
- Some genuine startups use virtual offices, so this step also removes a small number of real firms.

### 3. Screening pool and sample
- **Screening pool (1,395 firms):** from the 4,683, first SIC code in 62020, 70229, 62012, 63110 or 62090; incorporated 2019 to 2024; name containing one of: analytics, consult, advis, insight, intelligence, solutions, partners, labs.
- **Sample:** one random draw using SQLite's `RANDOM()`: **30 London and 30 rest of UK**. The pool has 281 London and 1,114 rest-of-UK firms, so London is deliberately oversampled and the two groups are reported separately. The draw cannot be seeded and was run once; the saved sample is the permanent record.

### 4. Manual screening
Each of the 60 firms was checked against four criteria, fixed before screening began:

| Criterion | Rule |
|---|---|
| Website found | A real website for this company, not a directory listing. Identity checked against the registered company number where shown |
| Describes data or analytics services | The site says what data or analytics work the firm does |
| 2+ named people | Two or more current, named people (Companies House officers, website or LinkedIn) |
| Appears active | A sign of recent activity (post, news item, job listing) |

A firm **qualifies** only if all four are Yes. Firms that qualified were then typed as *Independent small firm*, *Subsidiary of larger group* or *Not a data business*. Firms typed as not a data business were set to fail the services criterion.

---

## Limitations

- **Survivorship bias:** the snapshot contains live companies only, so firms that have already been dissolved are invisible, and recent years look stronger than older ones.
- **SIC codes are self-reported** by founders and are often loose. The name-keyword filter will miss firms with other names and match some unrelated businesses.
- **Registered town is not where people work.** "Rest of UK" includes outer-London towns such as Ilford and Harrow.
- **The screening pool covers firms incorporated 2019 to 2024.** Firms from 2025 and 2026, the fastest-growing cohorts, were excluded because very new companies have little web presence.
- **Small sample and one reviewer.** 60 firms, screened and typed by one person using judgement on "appears active" and the Type labels.
- **Point in time:** results describe the 1 November 2026 snapshot only.

---

## Repository contents

| File | Purpose |
|---|---|
| `load_data.py` | Loads the snapshot into SQLite |
| `sql/` | Cleaning, filtering, shared-address and sampling queries |
| `outputs/` | Aggregated result tables used in the report |
| `screening_final.csv` | Screening results for the 60 sampled firms by anonymised firm ID (company names and numbers withheld) |
| `report/uk_data_consultancies.pdf` | Export of the Power BI report |

The raw snapshot is not included. Download it from the Companies House Free Company Data Product page and check the licence terms there.

## How to reproduce
1. Download the snapshot and place the zip in `data/`.
2. Run `py load_data.py`.
3. Run the SQL files in `sql/` in the order they are numbered.
4. Open the Power BI file and refresh.

*Author: [your name]. Last updated: November 2026.*
