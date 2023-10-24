/* 
The goal of this query is to create a table showing the number of movie release dates in each month over time. This is useful because
showing that certain months are more popular can influence when to release a new movie.
*/
SELECT
  COUNT(*) AS num_titles,
  EXTRACT(MONTH FROM DATE_TRUNC(PARSE_DATE('%b %Y', my_table.my_str),MONTH)) AS month_name,
  EXTRACT(YEAR FROM DATE_TRUNC(PARSE_DATE('%b %Y', my_table.my_str),MONTH)) AS year_name
FROM
/*
Use a subquery to create a smaller table that includes only the month and year of the date added, since I am not going to use the day 
information in my analysis. Use string functions like STRPOS and SUBSTR to extract the month/year data based on knowing the format of the 
date as "month day, year". Add a WHERE clause to eliminate any NA values before creating the table.
*/
  (
  SELECT CONCAT(SUBSTR(date_added,1,STRPOS(date_added," ")-1),SUBSTR(date_added,LENGTH(date_added)-4,LENGTH(date_added))) AS my_str
  FROM `asymmetric-moon-377217.streaming_libraries.disney_library` 
  WHERE date_added IS NOT NULL
  ) AS my_table
GROUP BY
  year_name, month_name
ORDER BY
  year_name, month_name
