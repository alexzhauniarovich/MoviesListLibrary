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

// MARK: - Implementation of Movies UseCase protocol

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
        async let movieDetails = try await moviesRepository.getMovieDetails(movieId: movieId)
        async let movieCasts = try await moviesRepository.getMovieCasts(movieId: movieId)
        
        var youTubeUrl: URL? {
            get async throws {
                guard let trailerVideoKey = try await moviesRepository
                    .getMovieTrailers(movieId: movieId)
                    .first(where: { $0.site == "YouTube" })?.key
                else { return nil }
                
                return URL(string: "https://www.youtube.com/embed/\(trailerVideoKey)")
            }
        }

        return await TrendingMovieDetails(
            id: movieId,
            trailerUrl: try youTubeUrl,
            country: try movieDetails.productionCountries?.first?.shortName,
            durationMin: try movieDetails.runtime,
            releaseDate: try movieDetails.releaseDate?.toDate(),
            overview: try movieDetails.overview,
            actors: try movieCasts.map {
                MovieActor(
                    id: $0.id,
                    name: $0.name,
                    avatarUrl: URL(string: "\(NetworkConstants.imagesHostUrl)\(RemotePosterSize.w154.rawValue)\($0.profileAvatar ?? "")")
                )
            }
        )
    }
}
