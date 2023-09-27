import Foundation

protocol MoviesUseCaseType {
    
    func getTopTrendingWeekMovies() async throws -> [TrendingMovie]
    
    func getMovieDetails(movieId: Int) async throws -> TrendingMovieDetails
}
