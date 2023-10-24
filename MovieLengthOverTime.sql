/*
The purpose of this query is to create a table that shows the average and standard devation (to get a good first order sense of what duration
is expected and if there is much spread from that expected value) of movie durations during each month. This can illuminate any trends in how
long movies last over time, which can be helpful when planning lengths for upcoming movies.
*/
SELECT 
  /* 
  Borrowing this function sequence from previous query that gets the month from the date format provided in the data table. The logic is: 
  create a new string from the original date string that only has month and year information, then use PARSE_DATE and DATE_TRUNC to get the 
  date into a standard date fomrat that I can finally extract the month number from (not the month name, that could have been extracted very 
  easily but the date number allows for easy temporal ordering).
  */
  EXTRACT(MONTH FROM DATE_TRUNC(PARSE_DATE('%b %Y', CONCAT(SUBSTR(date_added,1,STRPOS(date_added," ")-1),SUBSTR(date_added,LENGTH(date_added)-4,LENGTH(date_added)))),MONTH)) AS month,
  CAST(SUBSTR(date_added,LENGTH(date_added)-4,LENGTH(date_added)) AS INT64) AS year,
  ROUND(AVG(duration),0) AS avg_time,
  /*
  The following case logic takes into account the fact that the STDDEV function will produce NULL if there is only 1 value for the duration,
  since the duration data is being grouped by year and month. So we need to change the NULL to 0 so that we get a sensible standard deviation.
  */
  CASE
    WHEN STDDEV(duration) IS NULL THEN 0
    WHEN STDDEV(duration) IS NOT NULL THEN ROUND(STDDEV(duration),0)
  END AS stddev_time
FROM 
  `asymmetric-moon-377217.streaming_libraries.full_library`
/* 
Ignore any titles where the table does not indicate if it is a movie or a tv show
*/
WHERE duration_type = 'min' AND date_added IS NOT NULL
GROUP BY 
  year, month
ORDER BY 
  year, month
