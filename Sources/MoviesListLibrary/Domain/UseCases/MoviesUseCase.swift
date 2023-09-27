import Foundation

private enum Constants {
    static let maxMoviesCount = 5
}

public class MoviesUseCase {
    
    // MARK: - Private fields
    
    private let moviesRepository: MoviesRepositoryType
    
    // MARK: - Initialisation
    
    required init(moviesRepository: MoviesRepositoryType) {
        self.moviesRepository = moviesRepository
    }
}

// MARK: - Implementation of App Info UseCase protocol

extension MoviesUseCase: MoviesUseCaseType {
    
    func getTopTrendingWeekMovies() async throws -> [TrendingMovie] {
        Array(try await moviesRepository
            .getTrendingWeekMovies()
            .sorted(by: { $0.popularity ?? 0 > $1.popularity ?? 0 })
            .prefix(Constants.maxMoviesCount)
            .map {
                TrendingMovie(
                    id: $0.id,
                    posterPath: "\(NetworkConstants.imagesHostUrl)\(RemotePosterSize.w342.rawValue)\($0.posterPath ?? "")",
                    voteAverage: $0.voteAverage,
                    popularity: $0.popularity
                )
            }
        )
    }
    
    func getMovieDetails(movieId: Int) async throws -> TrendingMovieDetails {
        let movieDetails = try await moviesRepository.getMovieDetails(movieId: movieId)
        let movieTrailers = try await moviesRepository.getMovieTrailers(movieId: movieId)
        let movieCasts = try await moviesRepository.getMovieCasts(movieId: movieId)
        
        let youTubeUrl: URL? = {
            guard let trailerVideoKey = movieTrailers.first(where: { $0.site == "YouTube" })?.key
            else { return nil }
            
            return URL(string: "https://www.youtube.com/embed/\(trailerVideoKey)")
        }()

        return TrendingMovieDetails(
            id: movieId,
            trailerUrl: youTubeUrl,
            country: movieDetails.productionCountries?.first?.shortName,
            durationMin: movieDetails.runtime,
            releaseDate: movieDetails.releaseDate?.toDate(),
            overview: movieDetails.overview,
            actors: movieCasts.map {
                MovieActor(
                    id: $0.id,
                    name: $0.name,
                    avatarUrl: URL(string: "\(NetworkConstants.imagesHostUrl)\(RemotePosterSize.w154.rawValue)\($0.profileAvatar ?? "")")
                )
            }
        )
    }
}
