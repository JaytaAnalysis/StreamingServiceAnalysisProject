/* 
The goal of this query is to create a table showing the top 100 directors/actors by count of movies/TV/both directed/acted in.
*/

DECLARE x INT64 DEFAULT 0;
DECLARE y DEFAULT (SELECT MAX(ARRAY_LENGTH(SPLIT(director,","))) FROM `asymmetric-moon-377217.streaming_libraries.disney_library`);
DECLARE director_array DEFAULT ARRAY<STRING>["XXX"];
LOOP
  SET director_array = ARRAY_CONCAT(director_array,(SELECT ARRAY_AGG(SPLIT(director,", ")[safe_offset(x)] IGNORE NULLS) AS directors FROM `asymmetric-moon-377217.streaming_libraries.disney_library`));
  SET x = x + 1;
  IF x > y THEN
     LEAVE;
  END IF;
END LOOP;



SELECT
  COUNT(*) AS num_titles,
  my_table.directors AS director_name

FROM
  UNNEST(director_array) as my_table
/*
Use a subquery to create a table of directors/actors for each title. Since the data in the table is a list of directors/actors separated by commas, I will need to split up the string so I know all the names of the directors/actors. Furthermore I need a way to know the max number of directors/actors for the titles. I used Sheets to help accomplish this (used SPLIT to create columns of directors/actors and then used COUNTA to determine how many were in each generated column. It looks like there are a max of 13 directors and 68 actors listed for any given title, notably Hulu does not have any directors/actors listed).
*/
GROUP BY
  director_name
ORDER BY
  num_titles DESC
