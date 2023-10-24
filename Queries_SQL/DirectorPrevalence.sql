/*
This query selects the unique directors' names, counts how many movies and tv shows each has directed, and then orders them by the number
of directors in descending order.
The purpose of this query is to see what trends there are in the directors of movies and shows. For instance, it could be useful
to know if directors tend to only make movies or shows but not both.
*/
SELECT 
  COUNT(directors) AS num_directors, 
  directors,
  COUNTIF(duration_type = 'Seasons') AS num_tv,
  COUNTIF(duration_type = 'min') AS num_movie
FROM `asymmetric-moon-377217.streaming_libraries.netflix_library`, UNNEST(SPLIT(director,',')) AS directors
/* 
Ignore any titles where the table does not indicate if it is a movie or a tv show
*/
WHERE duration_type IS NOT NULL
GROUP BY directors
ORDER BY num_directors DESC
