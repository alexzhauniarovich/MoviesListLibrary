# MoviesListLibrary

## Overview 

The repository contains an SPM package library with the implementation of the test task "Top 5 Trending movies of the week"
There is no git strategy for the reason that the repository doesn't mean any production use.
The implementation represents the iOS application, supports iOS from 15.0, and contains 3 screens. 

The package was created using xCode 14.3.1. The library represents a "package" of Swift Package Manager technology.
There is implementation of the MVVM architecture approach, using a native data binding mechanism, with respect to Clean Architecture rules, SOLID and GRASP principles.

The library is separated into 3 separate levels: Domain, Data, and Presentation, which separate the logic layer with one direction depending on the levels of each self, the layers communicated encapsulated using protocols.
To achieve asynchronous workflow through the app, the Swift Concurrency (async/await) technology was used, and the native NSSession mechanism provided the networking processing. 
The dependency injection was achieved in a native Swift way, without any 3rd party frameworks.

There were no any 3rd party dependencies used!


## The "Top 5 Trending movies list" screen

<a href="url"><img src="https://github.com/alexzhauniarovich/MoviesListLibrary/assets/77155155/265e81dc-cf01-47ee-85ba-e5b753624eb5"  width="350"></a> 

The screen displays the "Top 5 Trending movies list" which is retrieved from the https://api.themoviedb.org/3/trending/movie/week API endpoint.
The screen implemented a custom ViewPager view to scroll the content with a magnitude effect when the scroll stopped the library performs additional requests to retrive the particular movie details, such as:

`https://api.themoviedb.org/3/movie/{movie_id}`

`https://api.themoviedb.org/3/movie/{movie_id}/videos`

`https://api.themoviedb.org/3/movie/{movie_id}/credits`

The details of the movie contain additional data about the movie and a scrollable horizontal list of the actors from this movie. 
In case the trailer video exists, the users are allowed to open the video in an embedded video player and open the details of the particular actor from the description. 



## The "Movie actor details" screen

<a href="url"><img src="https://github.com/alexzhauniarovich/MoviesListLibrary/assets/77155155/9107dc4a-0592-4298-b69f-5fd6cab28ec5"  width="350"></a> 

The screen contains details of the particular person who was patented to the movie, the data requesting from the API call 

`https://api.themoviedb.org/3/person/{person_id}`



## !EXTRA FEATURE! The "YouTube trailer video player" screen

<a href="url"><img src="https://github.com/alexzhauniarovich/MoviesListLibrary/assets/77155155/0fcbfd66-90a2-4e28-b5e7-bebdfb40290d"  width="350"></a> 
<a href="url"><img src="https://github.com/alexzhauniarovich/MoviesListLibrary/assets/77155155/a10c5bf6-19fb-450c-944c-04fa0ca46dd3"  width="350"></a> 

As additional functionality the opening and playing of YouTube trailer videos was implemented through WebView. 


## Usage

The library target is to be used/reused in any iOS application project with a deployment version of iOS 15. 
To bring it into your project, just add the package dependency to the app project: 

`https://github.com/alexzhauniarovich/MoviesListLibrary.git`


The functionality of the library is represented as SwiftUI view entry point. Add the following code in the place where you want to get this functionality:

```
import SwiftUI
import MoviesListLibrary

struct ContentView: View {
    
    var body: some View {
        // Showing "Top 5 Trending movies of the week"
        MoviesListLibrary.MoviesListView
    }
}
```


The automation tests coverage of this library is not implemented yet, but there is all necessary preparations have been implemented. 
