# Streaming Service Analysis Project

## Introduction

Streaming services have gained incredible popularity in the last two decades, and they have accrued tens of thousands of titles in this time. Understanding how certain aspects of these titles have changed over time provides predictive power for what to expect in future title releases and can help companies plan out future movie and television projects. This project will analyze all the titles released by four major streaming services (Disney+, Hulu, Netflix, and Prime) from July 2006 to November 2021.

## Data Cleaning and Analysis using SQL

I obtained my data for the major streaming services that I was going to analyze from Kaggle user [Shivam Basal](https://www.kaggle.com/datasets/shivamb/netflix-shows) The datasets consist of 1450 Disney+ titles, 3073 Hulu titles, 8807 Netflix titles, and 9668 Prime Titles - a total of 22,998 titles. The datasets provided were clean for the most part, but there were a few important changes I had to make before I could start analyzing. I opened up the datasets in Sheets to inspect the data and see what edits I needed to make until it was properly formatted and free of errors. One observation I made was that there are repeated movie titles across the streaming services. It seemed some of them were the same visual media, but they were actually different media with the same name. I performed a separate check in each spreadsheet to verify there were no repeated titles in each streaming service by comparing number of unique show_id to number of titles. It also appeared that some data was inputted in the wrong columns, so I had to identify the extent to which this was happening and remedy it if possible. Most notably, this occurred with the duration and rating data where many duration entries seemed to have shifted one column over to the rating column.

The other significant change I made was to split the duration column into two columns: one column to contain the actual length number and one column to include whether that length is minutes or seasons. This split would enable me to more easily analyze the duration of movies and shows, which is part of my analysis later. One complication in this process was that the movie length was only expressed as "min" while the show length was expressed with "Season" and "Seasons". So I had to find and replace all "Season" with "Seasons" so that I would only have two types of duration, which would be useful when I analyzed various trends about the differences between movies and shows.

After cleaning the data (the cleaned data can be found in the ["StreamingServiceData" folder](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/tree/main/Queries_SQL) of my project), I moved on to the data analysis portion of my project. I uploaded my clean datasets to BigQuery where I composed queries in SQL to extract the data required to answer the questions I had about these major streaming service titles. The queries I used to create the tables that I produced visualizations from are located in the ["Queries_SQL"](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/tree/main/Queries_SQL) folder of my project.

## Data Visualizations

I created all of my data visualizations using Tableau, and they are all posted on my [Tableau profile](https://public.tableau.com/app/profile/jay5937/vizzes).

### Geographical Distribution of Film Locations

![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_FilmLocationsOverTime_full.png)

The data viz I created for the filming locations of titles includes a slider bar that can filter by range of years. To see a more complete visualization of the film location data, you can access it directly [here](https://public.tableau.com/app/profile/jay5937/viz/GlobalDistributionofFilmLocations/Sheet1). The map presented here shows the cumulative film location distribution across the world from 2006 to 2021. I used a logarithmic color scale to denote how many titles were filmed in each country because the film counts span a few orders of magnitude. Countries like the United States, United Kingdom, and India had thousands of titles; countries like China, Mexico, and Australia had hundreds of titles; countries like South Africa, Colombia, and Poland had tens of titles.

This film location data can be useful because they indicate what countries are popular to create films in. For companies or filmmakers deciding on film locations, examining this data can help them decide where to film. In addition, there are more avenues of research that could explore the significance of film locations: examining the relationship between film locations and various indicators of success of the film, examining correlations between film locations and geopolitical alliances and hostilities, and examining correlations between film locations and countries' GDP. One important thing to note is that about 50% of all the titles in my data did not have any film location information. Since that is substantial amount of information, any conclusions needs to be made tentatively, but further research could be done to gather that film location information to arrive at safer conclusions.

### Number of Titles Over Time

![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_NumTitlesOverTime_full.png)

In these graphs, we can see how the number of additional titles changes over time, as well as how the total number of titles changes over time. By looking at the graphs, we can see that the growth of additional titles appears linear and the growth of total title appears roughly quadratic. This prompted me to calculate curves of best fit (plotted along with the data), and I found that the curves are linear and quadratic with $R^2$ values of 0.864 and 0.999 respectively. The slope of the linear fit is about 4, which means that we expect the number of added titles to increase by 4 each month. If there were 10 titles released in December, then we would expect 14 titles to be released in January, then 18 titles in February, and so on. This result is significant because it means that the equations for the best fit curves can reasonably be used to predict how many new titles will be added! This knowledge is useful for a few reasons. Consumers can know that their streaming services are consistently adding more titles each month, and that growth is also consistently increasing. It seems that the streaming service market has an evergrowing number of titles without a monthly cap (or at least a cap that is always growing). If further research was done to compare this title growth to an analgous growth in another industry (new characters/features added in video games, new features/technological changes to smartphones, etc), it could be useful to see how the growths compare and whether other industries could benefit by adapting to the streaming service growth model, which has seen much success.

#### Important Filtering Information

I excluded all data points prior to 2014 mainly because there are many months where no titles were added at all. From 2006-2014, streaming services were still young and gaining market traction, so they were not consistently or significantly adding titles. The goal of this graph is not only to convey information about how the major streaming services grow, but also to create a best fit curve to show how they are growing. Exclusion of those early data points allows for a better understanding of how the services have been growing their titles once they gained more traction. I chose 2014 as the cutoff based on the criterion that it is the first year where titles were released every month. I think there are other criteria that could accomplish my same goal, but the conlcusion about linear and quadratic growth would not change.

In my analysis, I did exclude two data points that are in the linear graph. The first data point I excluded was for 11/2019 because that is when Disney+ launched. So that data point, which has more than twice the number of titles than any other month and about five times the number of titles to be expected in that month, is an outlier based on its broader context and is a statistical outlier as well. The second data point I excluded was for 11/2021 because in that month my data only has title entries from Disney+. Since this graph is supposed to show trends in the four main streaming services I am considering, it does not make sense to show this data point from only one streaming service.

### Movie Length Over Time

![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_MovieLengthOverTime_full.png)

This graph shows the monthly average movie runtime in major streaming services from 2017 to 2021. The monthly average movie runtime does not seem to vary much during this time, and I performed a best fit analysis to confirm this. The best fit line has a slope of about 0.05, correpsonding with an increase of 3 seconds of runtime per month; however, this amount is so small (in 10 years the average monthly movie runtime would only increase by 6 minutes) it is reasonable to conclude that there is no appreciable change in movie runtime. Additionally, using SQL, I calculated that the average movie runtime between 2017 and 2021 was 96 minutes, and the standard deviation was 31 minutes. The combination of these results leads to important conclusions. First of all, the fact that the average movie runtime is not changing indicates that movie producers can plan on creating movies that are around one and a half hours long without worrying about going against the dominant trends. This stability shown by the data also hints at a sweet spot in runtime that the movie industry has found, although to formally make that conclusion we would need to examine how success indicators correlate with movie runtime. While the average movie runtime is stably 96 minutes, the standard deviation of 31 minutes adds another layer of nuance. We would expect the majority of movie runtimes to be approximately between 60 and 120 minutes (roughly within one standard deviation of the average), which is basically one entire hour of runtime that move producers can play around with and still remain within the runtime trend. This is important for movie producers to know because it means they can still have flexibility when it comes to executing their creative vision and remain on trend with the rest of the movies.

#### Important Filtering Information

I only included data from 2017 to 2021 because 2017 is the first year that every month includes movie releases. If I included previous years, then the resultant trendline would have been more significantly positively sloped, which is actually what I concluded originally. Upon further analysis of the data, I realized that there were many months without any (or just one) movie releases interspersed between small numbers of movie releases. These data skew the trends of the majority of the data, which occur around the start of 2017.

### Number of TV Seasons Over Time

![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_NumTVSeasonsOverTime_full.png)

This graph shows how the number of seasons of added TV shows changes over time. I divided the number of TV seasons into five categories where each one directly corresponds with the number of seasons in that TV show except the last category, which inlcudes all TV shows with 5 or more seasons. Even though the data has been filtered so that there is at least one TV show per month, the graph is more erratic during the earlier months. This variation can be explained by the low total number of TV shows released: small changes in the number of TV shows in a category create large changes in the percentage of that category when the total number of TV shows is small. Until around 2017, the total number of TV shows released was too small to permit consistent values. From 2017 onwards, the percentage of categories does seem to equilibrate around particular values: 63% are 1 season, 16% are 2 seasons, 7% are 3 seasons, 5% are 4 seasons, and 9% are 5 or more seasons.

Similar to the conclusion about movie runtime trends, this graph demonstrates that the percentages of TV show durations remains approximately constant from 2017 to 2021. This is important to note because it indicates that there seems to be consistent demand for a variety of number of seasons. There don't seem to be trending increases or decreases in a particular category of TV shows, so show producers can take this into account when planning what new shows to roll out. As with the movie runtime trends, there is still wiggle room in the percentages to allow for flexibility in deciding how many shows to create/add for the streaming service platform. Further research could be done to determine what proportion of these added shows are new shows compared to extant shows being added to the platform. Investigating newly created shows (especially ones created for the streaming service) would help understand to what degree all new shows are still following the trends observed in my graph and to what degree show producers might want to consider producing different number of seasons in their shows.

### Comparing Number of Movies to Number of TV Shows

![alt text]

This graph depicts the difference between movies and TV shows added from 2014 to 2021 and shows a reference line at 50%, where we would expect the data to be around if new movies and TV shows were equally likely. Just like the in the previous graphs, the data from 2017 to 2021 demonstrates a more consistent trend than from 2014 to 2017. The average percentage of movies and TV shows are 65% and 35%, each with a standard deviation of 6.5%. This is signifcantly different than a 50% split between movies and TV shows, so there is a clear preference (almost two movies for each TV show) to add movies instead of TV shows. Further research could be done to explore the reason why this split exists. For instance, there could be an exploration of the profit differences between shows and movies, a dive into polls about peoples' movie and show preferences, and an investigation into the resources necessary to create a movie versus a show. These avenues of research should illuminate this intriguing split in the number of movies and shows that my graph demonstrates.


### Comparing Different Title Content Ratings

![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_PercentRatings_full.png)

This graph shows the relative number of titles that fit into different categoires of content rating from 2014 to 2021. I created a standardized system (explained in more detail below) in order to have a less cumbersome number of categories that still accurately reflects important differences across the multitude of ratings. My system splits movies and shows into four categories: young kids (0-6 years old), kids (7-12 years old), teens (13-16 years old), and adults (17+ years old). Similar to the previous two graphs, the data from 2017 to 2021 generally demonstrates a more consistent trend than the data from 2014 to 2017; however, there is a notable departure from the trend in 11/2019. This month is significant because that is when Disney+ launched and it flooded that month with a great number of titles that are aimed at younger audiences, especially those in my "Young Kids" category. The addition of Disney+ titles also creates a noticeable shift in the percentages of ratings categories of added titles from 11/2019 onwards. The average percentage changes from 1/2017-10/2019 to 12/2019-10/2021 are: 20% -> 29% (Young Kids), 3% -> 4% (Kids), 32% -> 28% (Teens), and 45% -> 39% (Adults). The change in percentages likely primarily came from the Disney+ launch that introduced more "Young Kids" and "Kids" titles.

While there are percentage variations during the pre-Disney+ and post-Disney+ time periods, overall these variations do not trend upward/downward but rather stay near their average value - this is indicated by their standard deviations being around 2-4%. This shows that among the major streaming services there is an established trend for how many titles are produced for each content rating. Further research can be done to find out reasons why this might be true. Examining trends among movies and shows outside of streaming services could demonstrate if this trend is part of a larger trend or if it is special to streaming services. Investigating polling data from people expressing what maturity of content they want can inform whether this trend is based in public desire. It is possible that these percentages reflect an industry equilibrium where profits have been maximized with respect to representation of content maturity level, so analyzing profits could provide great insight.

#### Content Ratings Information

Across the four streaming services I analyzed in my project, there were  different ratings used. All of these ratings recommend the minimum age of viewers of the movie or show in order to avoid exposing particular age groups to inappropriate content. I researched what the various standard ratings meant or made educated guesses for some that did not seem as official. Once I assembled that information, I created my standardized rating categories by attempting to equally distribute the original ratings into new categories. I will now show how the old and new categories relate:

Young Kids: G, PG, TV-Y, TV-G, TV-PG, ALL, ALL_AGES

Kids: TV-Y7, TV-Y7-FV, 7+

Teens: PG-13, TV-14, 16+, AGES_16_, 16, 13+

Adults: R, TV-MA, NC-17, AGES_18_

### Comparing Actor Distribution Between Movies and TV Shows

![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_ActorsRoles_full.png)

This graph shows a breakdown of how many movies and shows that actors performed in from 2006 to 2021. Each point on the graph corresponds with a particular combination of movies and shows that actors performed in their careers so far, and the size of the point indicates how many actors fit into that combination of performances. Since there were tens of thousands of actors to plot and there were several orders of magnitude to display across the movie/show combinations, it was important to use a logarithmic scale for the size. Not surprisingly, most the data points occur when the total number of titles is small. More surpisingly, a majority of the data points lie in regions of the graph where at least 85% of the titles were movies or shows, but not both. I will refer to actors who have performed in only movies or shows 85% of the time movie-actors and TV-actors respectively in order to simplify the language. The graph shows some dotted reference lines to split the area into relevant regions. The region above the orange line contains all of the movie-actors, the region below the red line contains all the TV-actors, and the region between the lines conains the rest of the actors. We can see that 56% of actors are movie-actors, 11% are TV-actors, and therefore 2 out of every 3 actors are either movie-actors or TV-actors. This is a rather significant result since it indicates that there are relatively few actors who act more equally in movies and shows.

Further research could be done to investigate the cause of why actors seems to be either movie-actors or TV-actors. There are many industry-specific reasons that could lead to this discrepancy, or perhaps the driving factor is financial. We can see that more than half the actors are movie-actors, so it could be the case that being an actor in a movie is more profitable for the actors or that there is quicker turnover of movies that allows actors to be paid frequently. Research into the acting industry itself, as well as research into the profits of movies versus shows should help reveal the discrepancy in how actors' roles are distributed between movies and shows.

#### Important Filtering Information

In making this graph, I have filtered out any data points where less than 10 actors had that particular movie/show combination. I filtered them out because they greatly extended the graph to the point where it was hard to see the other, more relevant data that accounted for more than 99% of the actors in the data. While it is certainly interesting that some actors have been in more than 30 movies/shows, their presence on the graph only detracts from the trends I am trying to highlight. Additionally, I filtered out any actors who were only in one title. Actors who were only in one title comprised more than half of all actors and they automatically meet any threshold I could make for movie-actor or show-actor since 100% of the titles they were in were only a movie or a show. Since this would have skewed my conclusion by making any threshold I set much easier to meet, I excluded the data from the graph and its analysis. 

## Conclusion

