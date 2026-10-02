-- Daily articles mentioning the Cat in the Hat, 2026
--
-- What it does : Same approach applied to the 2026 trend, to see whether searching by character name works.
-- Output file  : 07_daily_namesearch_2026_cathat.csv
-- Result       : Almost nothing, 1 to 5 articles per day, and all of it about Dr. Seuss books and exhibitions. This is why the project searches for the consequence instead of the name of the trend.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  COUNT(DISTINCT t.DocumentIdentifier) AS articles
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2026-07-15")
  AND t._PARTITIONTIME <  TIMESTAMP("2026-09-20")
  AND LOWER(t.AllNames) LIKE '%cat in the hat%'
GROUP BY day
ORDER BY day
