-- Daily school-threat coverage, 2016 Killer Clown period
--
-- What it does : Counts articles per day whose link mentions a school and either a threat or a lockdown.
-- Output file  : 09_daily_total_2016_clowns.csv
-- Result       : Visible rise during the clown panic, but much smaller than the general clown coverage.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  COUNT(DISTINCT t.DocumentIdentifier) AS articles
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2016-09-01")
  AND t._PARTITIONTIME <  TIMESTAMP("2016-11-15")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
GROUP BY day
ORDER BY day
