/*
This query produces a table that counts how many movies and shows actors have been in, then groups those actors with
the same movie/show appearances together in a count. This table thus shows how many actors have appeared in every
realizable combination of movies/shows. The purpose of this query is to investigate whether actors tend to only perform 
in one type of title (movie or show, but not both), whether they tend to only perform in both types of title (movie and
show), or whether there is no preference in actor performances.
*/
SELECT
  COUNT(distinct_grouped_cast.cast_list) AS num_actors,
  distinct_grouped_cast.num_movies AS num_movies,
  distinct_grouped_cast.num_shows AS num_shows,
  distinct_grouped_cast.num_total AS num_total
FROM
  (
  /*
  This subquery creates a table with a column for each distinct cast member, and then columns to count how many movies,
  shows, and total appearances they have made. This table will allow easy creation of the final table that counts how
  many actors have the same movie/show count in common.
  */
    SELECT
      distinct_cast.`cast` AS cast_list,
      COUNTIF(distinct_cast.type = "Movie") AS num_movies,
      COUNTIF(distinct_cast.type = "TV Show") AS num_shows,
      COUNT(distinct_cast.`cast`) AS num_total
    FROM
      (
      /*
      This subquery creates a table which essentially duplicates each title's entry for each cast member involved,
      but it only includes the cast member (with leading/trailing whitespace removed) and title type information.
      The UNNEST flattens the array of individual cast members created by SPLIT.
      */
        SELECT
          *
          EXCEPT(show_id, title, director, country, date_added, release_year, rating, duration, duration_type, listed_in, description, new_cast)
          REPLACE(TRIM(new_cast) AS `cast`)
        FROM
          `asymmetric-moon-377217.full_library.full_library`,
          UNNEST(SPLIT(`cast`)) AS new_cast
      ) AS distinct_cast
    GROUP BY
      cast_list
  ) AS distinct_grouped_cast
  GROUP BY
    num_movies, num_shows, num_total
  ORDER BY
    num_total
