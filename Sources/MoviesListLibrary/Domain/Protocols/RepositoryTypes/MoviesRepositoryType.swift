
protocol MoviesRepositoryType {
    
    func getTrendingWeekMovies() async throws -> [TrendingMovie]
    
    func getMovieDetails(movieId: Int) async throws -> MovieDetails
    
    func getMovieTrailers(movieId: Int) async throws -> [MovieTrailer]
    
    func getMovieCasts(movieId: Int) async throws -> [MovieCast]
}
