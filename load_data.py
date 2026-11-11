import pandas as pd, sqlite3, zipfile

con = sqlite3.connect("companies.db")
keep = ["CompanyName", "CompanyNumber", "CompanyCategory", "CompanyStatus",
        "IncorporationDate", "RegAddress.PostTown", "RegAddress.PostCode",
        "SICCode.SicText_1", "SICCode.SicText_2",
        "SICCode.SicText_3", "SICCode.SicText_4", "URI"]

total = 0
with zipfile.ZipFile("data/BasicCompanyDataAsOneFile-2026-11-01.zip") as z:
    with z.open(z.namelist()[0]) as f:
        for chunk in pd.read_csv(f, chunksize=200_000, dtype=str):
            chunk.columns = chunk.columns.str.strip()
            chunk[keep].to_sql("companies", con, if_exists="append", index=False)
            total += len(chunk)
            print(f"{total:,} rows loaded", flush=True)
print("done")