/*
The purpose of this query is to create a table that shows how the number of seasons of a show added to a streaming service changed over time.
This can be helpful to know because it can influence decision-making on what shows to add to streaming services, and even what length of shows
that studios should consider making.
*/
SELECT 
  /* 
  Borrowing this function sequence from previous query that gets the month from the date format provided in the data table. The logic is: 
  create a new string from the original date string that only has month and year information, then use PARSE_DATE and DATE_TRUNC to get the 
  date into a standard date fomrat that I can finally extract the month number from (not the month name, that could have been extracted very
  easily but the date number allows for easy temporal ordering.
  */
  EXTRACT(MONTH FROM DATE_TRUNC(PARSE_DATE('%b %Y', CONCAT(SUBSTR(date_added,1,STRPOS(date_added," ")-1),SUBSTR(date_added,LENGTH(date_added)-4,LENGTH(date_added)))),MONTH)) AS month,
  CAST(SUBSTR(date_added,LENGTH(date_added)-4,LENGTH(date_added)) AS INT64) AS year,
  ROUND((100*COUNTIF(CAST(duration AS INT64) = 1))/COUNT(duration),0) AS pct_one,
  ROUND((100*COUNTIF(CAST(duration AS INT64) = 2))/COUNT(duration),0) AS pct_two,
  ROUND((100*COUNTIF(CAST(duration AS INT64) = 3))/COUNT(duration),0) AS pct_three,
  ROUND((100*COUNTIF(CAST(duration AS INT64) = 4))/COUNT(duration),0) AS pct_four,
  ROUND((100*COUNTIF(CAST(duration AS INT64) > 4))/COUNT(duration),0) AS pct_large
FROM 
  `asymmetric-moon-377217.streaming_libraries.disney_library`
/*
Ignore any titles where the table does not indicate if it is a movie or a tv show 
*/
WHERE duration_type = 'Seasons' AND date_added IS NOT NULL
GROUP BY year, month
ORDER BY year, month
