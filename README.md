# Streaming Service Analysis Project
## Introduction
## Collecting Data and Cleaning It
## Analyzing Data with SQL
## Data Visualizations

I created all of my data visualizations using Tableau, and they are all posted on my [Tableau profile](https://public.tableau.com/app/profile/jay5937/vizzes). 
![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_FilmLocationsOverTime_full.png)

### Geographical Distribution of Film Locations

The data viz I created for the filming locations of titles includes a slider bar that can filter by range of years. To see a more complete visualization of the film location data, you can access it directly [here](https://public.tableau.com/app/profile/jay5937/viz/GlobalDistributionofFilmLocations/Sheet1). The map presented here shows the cumulative film location distribution across the world from 2006 to 2021. I used a logarithmic color scale to denote how many titles were filmed in each country because the film counts span a few orders of magnitude. Countries like the United States, United Kingdom, and India had thousands of films; countries like China, Mexico, and Australia had hundreds of films; countries like South Africa, Colombia, and Poland had tens of films.

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

Similar to the conclusion about movie runtime trends, this graph demonstrates that the percentages of TV show durations remains approximately constant from 2017 to 2021. This is important to note because it indicates that there seems to be consistent demand for a variety of number of seasons. There don't seem to be trending increases or decreases in a particular category of TV shows, so show producers can take this into account when planning what new shows to roll out. As with the movie runtime trends, there is still wiggle room in the percentages to allow for flexibility in deciding how many shows to create/add for the streaming service platform.

### Comparing Number of Movies to Number of TV Shows

This graph depicts the difference between movies and TV shows added from 2014 to 2021. Just like the in the earlier plot, the data from 2014 to  2-

![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_PercentMoviesTV_full.png)

### Comparing Different Title Content Ratings

![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_PercentRatings_full.png)

### Comparing Actor Distribution Between Movies and TV Shows

![alt text](https://github.com/JaytaAnalysis/StreamingServiceAnalysisProject/blob/main/DataVizzes/DataViz_ActorsRoles_full.png)

## Conclusion
