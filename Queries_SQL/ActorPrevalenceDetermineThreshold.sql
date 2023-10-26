/*
This query's purpose is to investigate what percentage of actors are mostly movie/show actors (i.e. they only appear 
in movies or shows, not both). Specifically, by examining what percent of actors have their num_movies/num_total OR 
their num_shows/num_total >= 0.85, we can see what percent of actors are "85%+" movie/show actors.
The 85% is a semiarbitrary threshold, but I found that 2/3 of all actors are classified as movie/show actors when
the threshold is 85% (for data from the full library of titles, and with a couple important filters applied, which 
are described more below). 2/3 is a significant proportion of all actors, especially with a high threshold like 85%.
*/

/*
The following SUMs use CASE WHEN statements to perform a conditional sum over the table. We are only interested in
the actors who are movie/show actors, so we only want to include those in the sum that meet a particular threshold 
(I used 85% for my data viz in the project). Furthermore, I decided to filter out actors with only 1 title appearance 
for two reasons. Firstly, it seems reasonable to exclude actors with only one appearance since I am trying to draw 
conclusions about movie/show actors who presumably would appear in multiple titles (and appearing in one title 
hardly feels like enough information to classify an actor as a movie/show actor). Secondly, if those two data points 
are included, they will account for more than 50% of all the actors represented by the data and will automatically 
meet any threshold. Inclusion of these data points will thus make higher threshold percentages possible without really 
including movie/show actors, which seems to create a misleading conclusion about the broader pool of actors. 
Additionally, I decided to filter out actors who were part of a movie/show combination that had less than 10 actors 
representing it. The main justification was to make the scatterplot clearer, as these small data points zoom the graph 
away from where the vast majority of the data actually is; furthermore, removal of these points does not appreciably 
affect the analysis as they represent less than 1% of the actors remaining after removing the 1 title actors.
*/

SELECT
    100*SUM(
    CASE
     WHEN num_movies/num_total >= 0.85 AND num_total > 1 AND num_actors > 10 THEN num_actors
     WHEN num_shows/num_total >= 0.85 AND num_total > 1 AND num_actors > 10 THEN num_actors
     ELSE 0
    END
    )
    /SUM(
    CASE
     WHEN num_total > 1 AND num_actors > 10 THEN num_actors
     WHEN num_total = 1 OR num_actors <= 10 THEN 0
    END
    ) AS pct,
FROM
`asymmetric-moon-377217.full_library.grouped_distinct_actors_full`
