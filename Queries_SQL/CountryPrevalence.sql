/*
This query generates a table where each row shows how many total titles were produced in each country over the whole time period.
The purpose of this query is to see what countries are the most popular choices to film titles for popular streaming services.
This can provide insight as to where filming is more popular or economic, which can influence where to film a title.
*/
SELECT 
  COUNT(TRIM(old_countries)) AS num_countries, 
  TRIM(old_countries) AS countries
FROM `asymmetric-moon-377217.streaming_libraries.disney_library`, UNNEST(SPLIT(country,',')) AS old_countries
/* 
Ignore any titles where the table does not indicate if it is a movie or a tv show 
*/
WHERE old_countries != ''
GROUP BY countries
ORDER BY num_countries DESC
