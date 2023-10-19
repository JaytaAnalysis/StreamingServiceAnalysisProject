/* 
The goal of this query is to create a table showing how the percentage of movies/TV shows 
*/
SELECT
  ROUND((100*COUNTIF(my_table.media_type = "Seasons"))/(COUNTIF(my_table.media_type = "Seasons")+COUNTIF(my_table.media_type = "min")),0) AS percent_tv,
  ROUND((100*COUNTIF(my_table.media_type = "min"))/(COUNTIF(my_table.media_type = "Seasons")+COUNTIF(my_table.media_type = "min")),0) AS percent_movies,
  EXTRACT(MONTH FROM DATE_TRUNC(PARSE_DATE('%b %Y', my_table.my_str),MONTH)) AS month_name,
  EXTRACT(YEAR FROM DATE_TRUNC(PARSE_DATE('%b %Y', my_table.my_str),MONTH)) AS year_name
FROM
/*
Use a subquery to create a smaller table that includes only the month and year of the date added, since I am not going to use the day information in my analysis. Use string functions like STRPOS and SUBSTR to extract the month/year data based on knowing the format of the date as "month day, year". Add a WHERE clause to eliminate any NA values before creating the table.

I will also include the various libraries that you can perform this query on, since it should work for each streaming service's library as well as the cumulative library.

`asymmetric-moon-377217.streaming_libraries.disney_library`
`asymmetric-moon-377217.streaming_libraries.hulu_library`
`asymmetric-moon-377217.streaming_libraries.netflix_library`
`asymmetric-moon-377217.streaming_libraries.prime_library`
`asymmetric-moon-377217.streaming_libraries.full_library`
*/

  (SELECT CONCAT(SUBSTR(date_added,1,STRPOS(date_added," ")-1),SUBSTR(date_added,LENGTH(date_added)-4,LENGTH(date_added))) AS my_str, duration_type AS media_type
  FROM `asymmetric-moon-377217.streaming_libraries.disney_library` WHERE date_added IS NOT NULL) AS my_table
GROUP BY
  year_name, month_name
ORDER BY
  year_name, month_name
