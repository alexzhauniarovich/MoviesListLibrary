import Foundation

class MoviesListViewModel: ObservableObject {
    
    // MARK: - Publishers
    
    @Published var movies: [TrendingMovieViewData] = []
    @Published var movieDetails: MovieDetailsViewData? = nil
    
    // MARK: - Private fields
    
    private let moviesUseCase: MoviesUseCaseType
    
    // MARK: - Initialisation
    
    required init(moviesUseCase: MoviesUseCaseType) {
        self.moviesUseCase = moviesUseCase
    }
    
    // MARK: - Public functions
    
    func viewWillAppear() {
        Task.detached(priority: .userInitiated) {
            do {
                let trendingWeekMovies = try await self.moviesUseCase.getTopTrendingWeekMovies()
                await MainActor.run {
                    self.movies = trendingWeekMovies.map(self.mapTrendingMovie)
                    self.didRequestMovieDetails(at: 0)
                }
                
            } catch let error {
                await MainActor.run {
                    //TODO: Error handling
                }
            }
        }
    }
    
    func didRequestMovieDetails(at position: Int) {
        guard let movieId = movies[safe: position]?.id else { return }
        
        movieDetails = nil
        Task.detached(priority: .userInitiated) {
            do {
                let movieDetails = try await self.moviesUseCase.getMovieDetails(movieId: movieId)
                await MainActor.run {
                    self.movieDetails = MovieDetailsViewData(
                        movieParams: self.getMovieParamsDescription(movieDetails: movieDetails),
                        isPlayButtonVisible: movieDetails.trailerUrl != nil,
                        isActorDetailsAvailable: movieDetails.trailerUrl != nil,
                        trailerUrl: movieDetails.trailerUrl,
                        movieDescription: movieDetails.overview ?? "",
                        actors: movieDetails.actors?.map {
                            MovieActorViewData(
                                actorId: $0.id ?? 0,
                                actorName: $0.name ?? "",
                                actorAvatar: $0.avatarUrl
                            )
                        } ?? []
                    )
                }
                
            } catch let error {
                await MainActor.run {
                    //TODO: Error handling
                }
            }
        }
    }
    
    // MARK: - Private functions
    
    private func mapTrendingMovie(model: TrendingMovie) -> TrendingMovieViewData {
        TrendingMovieViewData(
            id: model.id ?? 0,
            posterImage: URL(string: model.posterPath ?? ""),
            rating: String(format: "%.1f", (model.voteAverage ?? 0))
        )
    }
    
    private func getMovieParamsDescription(movieDetails: TrendingMovieDetails) -> String {
        var description = ""
        let releaseYear: String? = {
            guard let releaseDate = movieDetails.releaseDate else { return nil }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            return formatter.string(from: releaseDate)
        }()
        
        if let country = movieDetails.country {
            description = country
        }
        if let releaseYear = releaseYear {
            if !description.isEmpty {
                description = "\(description) • \(releaseYear)"
            } else {
                description = releaseYear
            }
        }
        if let duration = movieDetails.durationMin {
            description = "\(description) • \(duration) min"
        }
        return description
    }
}
