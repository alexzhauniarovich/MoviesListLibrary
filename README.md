# MoviesListLibrary

## Overview 

The repository contains an implementation of the test task "Top 5 Trending movies of the week"
There is no git strategy for the reason that the repository doesn't mean any production use.
The implementation represents the iOS application, supports iOS from 15.0, and contains 3 screens.


## The "Top 5 Trending movies list" screen

The screen displays the "Top 5 Trending movies list" which is retrieved from the https://api.themoviedb.org/3/trending/movie/week API endpoint.
The screen implemented a custom ViewPager view to scroll the content with a magnitude effect when scroll stopped the library performs additional requests to retrive the particular movie details, such as:

https://api.themoviedb.org/3/movie/{movie_id}

https://api.themoviedb.org/3/movie/{movie_id}/videos

https://api.themoviedb.org/3/movie/{movie_id}/credits

The details of the movie contain additional data about the movie and a scrollable horizontal list of the actors from this movie. 

<a href="url"><img src="https://github.com/alexzhauniarovich/MoviesListLibrary/assets/77155155/265e81dc-cf01-47ee-85ba-e5b753624eb5"  width="350"></a> 


## The "YouTube trailer video player" screen

<a href="url"><img src="https://github.com/alexzhauniarovich/MoviesListLibrary/assets/77155155/0fcbfd66-90a2-4e28-b5e7-bebdfb40290d"  width="350"></a> 
<a href="url"><img src="https://github.com/alexzhauniarovich/MoviesListLibrary/assets/77155155/a10c5bf6-19fb-450c-944c-04fa0ca46dd3"  width="350"></a> 



## The "Movie actor details" screen

<a href="url"><img src="https://github.com/alexzhauniarovich/MoviesListLibrary/assets/77155155/9107dc4a-0592-4298-b69f-5fd6cab28ec5"  width="350"></a> 
