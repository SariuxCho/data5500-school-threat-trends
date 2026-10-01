-- Daily school-threat coverage, December 2021 TikTok trend (main case)
--
-- What it does : The main case of the project.
-- Output file  : 12_daily_total_2021_tiktok.csv
-- Result       : Baseline about 45 articles/day, peak 1,024 on Dec 17, 2021.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  COUNT(DISTINCT t.DocumentIdentifier) AS articles
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2021-11-15")
  AND t._PARTITIONTIME <  TIMESTAMP("2022-01-15")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
GROUP BY day
ORDER BY day
