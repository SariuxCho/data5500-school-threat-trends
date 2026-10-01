-- Article-level export, December 2021 TikTok trend (main case)
--
-- What it does : The working corpus for the project.
-- Output file  : 02_articles_2021_tiktok.csv
-- Result       : 4,995 articles from 1,483 sources. 64% of the links still work, which is why this is the main case.
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
WHERE t._PARTITIONTIME >= TIMESTAMP("2021-11-15")
  AND t._PARTITIONTIME <  TIMESTAMP("2022-01-15")
  AND LOWER(t.DocumentIdentifier) LIKE '%school%'
  AND (LOWER(t.DocumentIdentifier) LIKE '%threat%'
       OR LOWER(t.DocumentIdentifier) LIKE '%lockdown%')
ORDER BY day
