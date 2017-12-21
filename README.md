# 2017IMBd_top100
This is my first web craping by R(using rvest), the reference link is:https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/

This article is scrapping the data for the most popular feature films of 2016 from the IMDb website, while my data is 2017, the problems encountered are slightly different with the original example.

I scraping the following data from this website:
1.  Rank: The rank of the film from 1 to 100 on the list of 100 most popular feature films released in 2017.
2.  Title: The title of the feature film.
3.  Description: The description of the feature film.
4.  Runtime: The duration of the feature film.
5.  Genre: The genre of the feature film,
6.  Rating: The IMDb rating of the feature film.
7.  Votes: Votes cast in favor of the feature film.
8.  Director: The main director of the feature film. Note, in case of multiple directors, I’ll take only the first.
9.  Actor: The main actor of the feature film. Note, in case of multiple actors, I’ll take only the first.
