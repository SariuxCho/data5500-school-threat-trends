-- Article-level export, 2016 Killer Clown period
--
-- What it does : One row per article with its source, link, locations and category. Used to study the structure of the data.
-- Output file  : 01_articles_2016_clowns.csv
-- Result       : 6,392 articles from 2,105 sources. Only 33% of the links still work.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  t.SourceCommonName AS source,
  t.DocumentIdentifier AS url,
  t.V2Locations AS locations,
  CASE
    WHEN REGEXP_CONTAINS(LOWER(t.DocumentIdentifier), r'school-board|board-group') THEN 'school_board'
    WHEN REGEXP_CONTAINS(LOWER(t.DocumentIdentifier), r'covid|coronavirus|lockdowns|reopen|pandemic') THEN 'pandemic'
    WHEN REGEXP_CONTAINS(LOWER(t.DocumentIdentifier), r'threat|bomb|snapchat|social-media|tiktok') THEN 'student_threat'
    WHEN REGEXP_CONTAINS(LOWER(t.DocumentIdentifier), r'shoot|gunman|active-shooter') THEN 'shooting_event'
    ELSE 'other'
  END AS category,
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2016-09-01")
  AND t._PARTITIONTIME <  TIMESTAMP("2016-11-15")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
ORDER BY day
