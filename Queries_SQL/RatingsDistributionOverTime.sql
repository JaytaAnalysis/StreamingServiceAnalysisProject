/* 
The goal of this query is to create a table showing how the percentage of title ratings changes over time. This can be useful information to
understand what maturity levels of content are being produced, which can influence what category of title to produce.
*/
SELECT
  ROUND((100*COUNTIF(my_table.new_rating = "0-6"))/(COUNT(my_table.new_rating)),0) AS youth_percent,
  ROUND((100*COUNTIF(my_table.new_rating = "7-12"))/(COUNT(my_table.new_rating)),0) AS kid_percent,
  ROUND((100*COUNTIF(my_table.new_rating = "13-16"))/(COUNT(my_table.new_rating)),0) AS teen_percent,
  ROUND((100*COUNTIF(my_table.new_rating = "17+"))/(COUNT(my_table.new_rating)),0) AS adult_percent,
  EXTRACT(MONTH FROM DATE_TRUNC(PARSE_DATE('%b %Y', my_table.my_str),MONTH)) AS month_name,
  EXTRACT(YEAR FROM DATE_TRUNC(PARSE_DATE('%b %Y', my_table.my_str),MONTH)) AS year_name
FROM
/*
Use a subquery to create a smaller table that includes only the month and year of the date added, since I am not going to use the day 
information in my analysis. Use string functions like STRPOS and SUBSTR to extract the month/year data based on knowing the format of the 
date as "month day, year". Add a WHERE clause to eliminate any NA values before creating the table.

This subquery also creates a new standardized rating system that works across all the platforms' rating systems. I researched what the
various ratings for shows and movies meant and then reduced the multitude of ratings into four categories whose distinctions seem relevant:
0-6, 7-12, 13-16, and 17+. This subquery enables flexibility to create different standardizations if different categorizations make more
sense than the ones I have chosen here.
*/
  (
  SELECT 
    CONCAT(SUBSTR(date_added,1,STRPOS(date_added," ")-1),SUBSTR(date_added,LENGTH(date_added)-4,LENGTH(date_added))) AS my_str,
    CASE 
      WHEN rating in ("G", "PG", "TV-Y", "TV-G", "TV-PG", "ALL", "ALL_AGES") THEN "0-6" 
      WHEN rating in ("TV-Y7", "TV-Y7-FV", "7+") THEN "7-12" 
      WHEN rating in ("PG-13", "TV-14", "16+", "AGES_16_", "16", "13+") THEN "13-16" 
      WHEN rating in ("R", "TV-MA", "NC-17", "AGES_18_") THEN "17+" 
      ELSE NULL 
    END AS new_rating
  FROM `asymmetric-moon-377217.streaming_libraries.disney_library` 
  WHERE 
    date_added IS NOT NULL AND rating NOT in ("NOT RATED", "NR", "UR", "NOT_RATE", "TV_NR", "UNRATED")
  ) AS my_table
GROUP BY
  year_name, month_name
ORDER BY
  year_name, month_name
