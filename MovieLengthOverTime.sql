SELECT 
  /* Borrowing this function sequence from previous query that gets the month from the date format provided in the data table. The logic is: create a new string from the original date string that only has month and year information, then use PARSE_DATE and DATE_TRUNC to get the date into a standard date fomrat that I can finally extract the month number from (not the month name, that could have been extracted very easily but the date number allows for easy temporal ordering*/
  EXTRACT(MONTH FROM DATE_TRUNC(PARSE_DATE('%b %Y', CONCAT(SUBSTR(date_added,1,STRPOS(date_added," ")-1),SUBSTR(date_added,LENGTH(date_added)-4,LENGTH(date_added)))),MONTH)) AS month,
  CAST(SUBSTR(date_added,LENGTH(date_added)-4,LENGTH(date_added)) AS INT64) AS year,
  ROUND(AVG(duration),0) AS avg_time,
  CASE
    WHEN STDDEV(duration) IS NULL THEN 0
    WHEN STDDEV(duration) IS NOT NULL THEN ROUND(STDDEV(duration),0)
  END AS stddev_time
FROM 
  `asymmetric-moon-377217.streaming_libraries.full_library`
/* Ignore any titles where the table does not indicate if it is a movie or a tv show */
WHERE duration_type = 'min' AND date_added IS NOT NULL
GROUP BY year, month
ORDER BY year, month
