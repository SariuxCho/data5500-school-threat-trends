-- Daily school-threat coverage, 2019 Momo Challenge period (control case)
--
-- What it does : Same query applied to a viral panic that did not involve threats against schools.
-- Output file  : 10_daily_total_2019_momo.csv
-- Result       : Stays flat. Peak 1.6x normal and zero days above 2x, so the measure does not fire on any viral panic.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  COUNT(DISTINCT t.DocumentIdentifier) AS articles
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2019-02-01")
  AND t._PARTITIONTIME <  TIMESTAMP("2019-04-01")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
GROUP BY day
ORDER BY day
