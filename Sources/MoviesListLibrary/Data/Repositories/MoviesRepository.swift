
public class MoviesRepository {
    
    // MARK: - Private fields
    
    private let networkRequestManager: NetworkRequestManager
    
    // MARK: - Initialisation
    
    public required init(networkRequestManager: NetworkRequestManager) {
        self.networkRequestManager = networkRequestManager
    }
}

// MARK: - Implementation of Movies Repository Protocol

extension MoviesRepository: MoviesRepositoryType {
    
    func getTrendingWeekMovies() async throws -> [TrendingMovie] {
        try await networkRequestManager.dispatch(
            request: MoviesRequest.requestWeekTrendingMovies,
            responseType: TrendingMovies.self
        ).results ?? []
    }
    
    func getMovieDetails(movieId: Int) async throws -> MovieDetails {
        try await networkRequestManager.dispatch(
            request: MoviesRequest.requestMovieDetails(movieId: movieId),
            responseType: MovieDetails.self
        )
    }
    
    func getMovieTrailers(movieId: Int) async throws -> [MovieTrailer] {
        try await networkRequestManager.dispatch(
            request: MoviesRequest.requestMovieTrailers(movieId: movieId),
            responseType: MovieTrailers.self
        ).results ?? []
    }
    
    func getMovieCasts(movieId: Int) async throws -> [MovieCast] {
        try await networkRequestManager.dispatch(
            request: MoviesRequest.requestMovieCredits(movieId: movieId),
            responseType: MovieCredits.self
        ).cast ?? []
    }
}
