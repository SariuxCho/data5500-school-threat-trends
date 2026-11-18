# Data

The repository keeps data in two folders.

- `data/raw/` holds what no code can rebuild: BigQuery exports and work people did by hand.
- `data/processed/` holds what the notebooks and scripts produce. Some hand-made label files also sit there for historical reasons; the tables below list where each file really comes from.

## BigQuery exports (data/raw)

Each file was produced by the query named next to it in `queries/`, with no editing afterwards.

| File | Produced by | What it contains | Used by |
|---|---|---|---|
| 01_articles_2016_clowns.csv | 13_articles_2016_clowns.sql | One row per article, 2016 period | link_test.py only |
| 02_articles_2021_tiktok.csv | 14_articles_2021_tiktok.sql | One row per article, main case | 02, 10 |
| 03_daily_categories_2016_clowns.csv | 08_categories_2016_clowns.sql | Daily counts by category | 05 |
| 04_daily_categories_2021_deviouslicks.csv | 09_categories_2021_deviouslicks.sql | Daily counts by category | 00 |
| 05_daily_categories_2021_tiktok.csv | 10_categories_2021_tiktok.sql | Daily counts by category, main case | 05, 10 |
| 06_daily_categories_2026_cathat.csv | 11_categories_2026_cathat.sql | Daily counts by category | 05 |
| 07_daily_namesearch_2026_cathat.csv | 02_namesearch_2026_cathat.sql | Name search, almost empty on purpose | early exploration, not used |
| 08_daily_namesearch_2016_clowns.csv | 01_namesearch_2016_clowns.sql | Name search, first exploratory query | early exploration, not used |
| 09_daily_total_2016_clowns.csv | 03_schoolthreat_2016_clowns.sql | Daily totals | 00, 05 |
| 10_daily_total_2019_momo.csv | 04_schoolthreat_2019_momo.sql | Daily totals, control case | 00, 05 |
| 11_daily_total_2021_deviouslicks.csv | 05_schoolthreat_2021_deviouslicks.sql | Daily totals | 00 |
| 12_daily_total_2021_tiktok.csv | 06_schoolthreat_2021_tiktok.sql | Daily totals, main case | 00, 05 |
| 13_daily_total_2026_cathat.csv | 07_schoolthreat_2026_cathat.sql | Daily totals | 00, 05 |
| 14_urls_2021_spikecheck.csv | 12_urls_2021_spikecheck.sql | Article links for one week | early exploration, not used |
| 15_daily_baseline_notrend.csv | BigQuery export | Same weeks in years with no known trend, the normal level | 05 |
| 16_daily_categories_2019_momo.csv | BigQuery export | Daily counts by category, Momo control case | 05 |

## Made by hand

| File | Folder | What it contains | Used by |
|---|---|---|---|
| labels_review_done.xlsx | processed | Round 1 labels from the three annotators (100 articles). Notebook 04 adds agreement columns to it | 04, 06, 07 |
| pilot2_mine.xlsx, pilot2_female.xlsx, pilot2_male.xlsx | raw | Round 2 labels from the three annotators (40 articles) | 06 |
| disputed_labels.xlsx | processed | The 41 disputed articles, each decided by hand with the codebook rule applied | source of labels_final.csv |
| labels_final.csv | processed | Final label per article: 97 by majority, 41 decided in disputed_labels.xlsx | 07 |
| 09_verification_sample.xlsx | raw | The blind reading of 58 predicted articles (50 plus 8 repeats) | 09 |

## Produced by code

| File | Folder | Produced by | Used by |
|---|---|---|---|
| 01_articles_2016_clowns_linktest.csv, 02_articles_2021_tiktok_linktest.csv | raw | link_test.py | used to choose the main case |
| articles_2021_text.csv | not in the repo (9 MB) | 02 | 03 |
| articles_2021_linkstatus.csv | processed | 02 | none |
| articles_2021_clean.csv | processed | 03 | 07, 09 |
| labels_round2.csv | processed | 06 | 07 |
| training_set.csv | raw | 07 | 08, 09, 11 |
| 08_model_results.csv | processed | 08 | none |
| labels_predicted_full.csv | processed | 09 | 10 |
| 09_verification_sample_key.csv | processed | 09 | 09 |

## Columns

**Daily count files:** `day` (YYYYMMDD), `articles`, and `category` where present.

**Article-level files:** `day`, `source` (the news outlet), `url`, `locations` (the places GDELT found in the article, including US state codes), and `category` (the rule-based first pass).
