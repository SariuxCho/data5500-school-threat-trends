-- School-threat coverage by category, 2016
--
-- What it does : Same as query 03 but each article is sorted into a category using words in its link.
-- Output file  : 03_daily_categories_2016_clowns.csv
-- Result       : 81% student threats, 19% unrelated.
--
-- Note: the _PARTITIONTIME filter is required. Without it the query scans the whole
-- table (hundreds of GB) instead of only the days we asked for.

SELECT
  SUBSTR(CAST(t.DATE AS STRING), 1, 8) AS day,
  CASE
    WHEN REGEXP_CONTAINS(LOWER(t.DocumentIdentifier), r'school-board|board-group') THEN 'school_board'
    WHEN REGEXP_CONTAINS(LOWER(t.DocumentIdentifier), r'covid|coronavirus|lockdowns|reopen|pandemic') THEN 'pandemic'
    WHEN REGEXP_CONTAINS(LOWER(t.DocumentIdentifier), r'threat|bomb|snapchat|social-media|tiktok') THEN 'student_threat'
    WHEN REGEXP_CONTAINS(LOWER(t.DocumentIdentifier), r'shoot|gunman|active-shooter') THEN 'shooting_event'
    ELSE 'other'
  END AS category,
  COUNT(DISTINCT t.DocumentIdentifier) AS articles
FROM `gdelt-bq.gdeltv2.gkg_partitioned` AS t
WHERE t._PARTITIONTIME >= TIMESTAMP("2016-09-01")
  AND t._PARTITIONTIME <  TIMESTAMP("2016-11-15")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
GROUP BY day, category
ORDER BY day, category
