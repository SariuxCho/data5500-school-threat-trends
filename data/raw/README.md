# Raw data

CSV files exported directly from BigQuery. Each file was produced by the query of the same
number in `queries/`, with no editing afterwards.

| File | Produced by | What it contains |
|---|---|---|
| 01_articles_2016_clowns.csv | 13_articles_2016_clowns.sql | One row per article, 2016 period |
| 02_articles_2021_tiktok.csv | 14_articles_2021_tiktok.sql | One row per article, main case |
| 03_daily_categories_2016_clowns.csv | 08_categories_2016_clowns.sql | Daily counts by category |
| 04_daily_categories_2021_deviouslicks.csv | 09_categories_2021_deviouslicks.sql | Daily counts by category |
| 05_daily_categories_2021_tiktok.csv | 10_categories_2021_tiktok.sql | Daily counts by category, main case |
| 06_daily_categories_2026_cathat.csv | 11_categories_2026_cathat.sql | Daily counts by category |
| 07_daily_namesearch_2026_cathat.csv | 02_namesearch_2026_cathat.sql | Name search, almost empty on purpose |
| 08_daily_namesearch_2016_clowns.csv | 01_namesearch_2016_clowns.sql | Name search, first exploratory query |
| 09_daily_total_2016_clowns.csv | 03_schoolthreat_2016_clowns.sql | Daily totals |
| 10_daily_total_2019_momo.csv | 04_schoolthreat_2019_momo.sql | Daily totals, control case |
| 11_daily_total_2021_deviouslicks.csv | 05_schoolthreat_2021_deviouslicks.sql | Daily totals, control case |
| 12_daily_total_2021_tiktok.csv | 06_schoolthreat_2021_tiktok.sql | Daily totals, main case |
| 13_daily_total_2026_cathat.csv | 07_schoolthreat_2026_cathat.sql | Daily totals |
| 14_urls_2021_spikecheck.csv | 12_urls_2021_spikecheck.sql | Article links for one week |

## Columns

**Daily count files:** `day` (YYYYMMDD), `articles`, and `category` where present.

**Article-level files:** `day`, `source` (the news outlet), `url`, `locations` (the places
GDELT found in the article, including US state codes), and `category` (the rule-based first pass).
