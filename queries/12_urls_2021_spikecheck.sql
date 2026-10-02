-- Article links for one week, Sep 29 to Oct 7, 2021
--
-- What it does : Lists the actual links behind an unexplained spike, instead of counting them.
-- Output file  : 14_urls_2021_spikecheck.csv
-- Result       : Showed that most of the spike was national coverage of threats against school board members.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  t.DocumentIdentifier
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2021-09-29")
  AND t._PARTITIONTIME <  TIMESTAMP("2021-10-08")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
ORDER BY day
LIMIT 300
