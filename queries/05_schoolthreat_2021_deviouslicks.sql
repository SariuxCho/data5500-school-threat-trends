-- Daily school-threat coverage, 2021 Devious Licks period (control case)
--
-- What it does : Second control case, a TikTok trend about stealing school property rather than threats.
-- Output file  : 11_daily_total_2021_deviouslicks.csv
-- Result       : Rises anyway. Investigating why led to the discovery that 52% of the matched articles were unrelated.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  COUNT(DISTINCT t.DocumentIdentifier) AS articles
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2021-08-20")
  AND t._PARTITIONTIME <  TIMESTAMP("2021-10-20")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
GROUP BY day
ORDER BY day
