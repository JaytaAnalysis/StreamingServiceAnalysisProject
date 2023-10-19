SELECT 
  COUNT(TRIM(old_countries)) AS num_countries, 
  TRIM(old_countries) AS countries/*,
  COUNTIF(duration_type = 'Seasons') AS num_tv,
  COUNTIF(duration_type = 'min') AS num_movie*/
FROM `asymmetric-moon-377217.streaming_libraries.disney_library`, UNNEST(SPLIT(country,',')) AS old_countries
/* Ignore any titles where the table does not indicate if it is a movie or a tv show */
WHERE old_countries != ''
GROUP BY countries
ORDER BY num_countries DESC
