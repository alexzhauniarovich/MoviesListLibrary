import Foundation

struct TrendingMovieDetails {
    let id: Int?
    let trailerUrl: URL?
    let country: String?
    let durationMin: Int?
    let releaseDate: Date?
    let overview: String?
    let actors: [MovieActor]?
}

struct MovieActor {
    let id: Int?
    let name: String?
    let avatarUrl: URL?
}
