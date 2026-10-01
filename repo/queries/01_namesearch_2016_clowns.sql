-- Daily articles mentioning clowns, 2016
--
-- What it does : First exploratory query. Counts articles per day where GDELT extracted the word clown as a name.
-- Output file  : 08_daily_namesearch_2016_clowns.csv
-- Result       : 123 days. Baseline around 101 articles/day, peak 839 on Oct 7, 2016.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  COUNT(DISTINCT t.DocumentIdentifier) AS articles
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2016-08-01")
  AND t._PARTITIONTIME <  TIMESTAMP("2016-12-01")
  AND LOWER(t.AllNames) LIKE '%clown%'
GROUP BY day
ORDER BY day
