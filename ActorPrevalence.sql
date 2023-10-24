/*
This query selects the unique actors' names, counts how many movies and tv shows each has directed, and then orders them by the number
of actors in descending order.
The purpose of this query is to see what trends there are in the actors of movies and shows. For instance, it could be useful
to know if actors tend to only act in movies or shows but not both.
*/
SELECT 
  COUNT(actors) AS num_actors, 
  actors,
  COUNTIF(duration_type = 'Seasons') AS num_tv,
  COUNTIF(duration_type = 'min') AS num_movie
FROM 
  `asymmetric-moon-377217.streaming_libraries.full_library`, 
  UNNEST(SPLIT(`cast`,',')) AS actors
/* 
Ignore any titles where the table does not indicate if it is a movie or a tv show 
*/
WHERE duration_type IS NOT NULL
GROUP BY actors
ORDER BY num_actors DESC
