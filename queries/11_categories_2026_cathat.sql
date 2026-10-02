-- School-threat coverage by category, 2026 Cat in the Hat trend
--
-- What it does : The categorized version of the 2026 trend.
-- Output file  : 06_daily_categories_2026_cathat.csv
-- Result       : 85% student threats.
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
WHERE t._PARTITIONTIME >= TIMESTAMP("2026-08-01")
  AND t._PARTITIONTIME <  TIMESTAMP("2026-09-20")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
GROUP BY day, category
ORDER BY day, category
