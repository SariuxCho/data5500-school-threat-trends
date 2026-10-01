-- Daily school-threat coverage, 2026 Cat in the Hat trend
--
-- What it does : The 2026 trend, measured by consequence rather than by character name.
-- Output file  : 13_daily_total_2026_cathat.csv
-- Result       : Clear rise in late August 2026, peak 81 articles on Aug 26, about 6.5x the normal level.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  COUNT(DISTINCT t.DocumentIdentifier) AS articles
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2026-08-01")
  AND t._PARTITIONTIME <  TIMESTAMP("2026-09-20")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
GROUP BY day
ORDER BY day
