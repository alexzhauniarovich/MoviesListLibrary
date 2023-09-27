import Foundation

struct TrendingMovies: Codable {
    let results: [TrendingMovie]?
}

struct TrendingMovie: Codable {
    let id: Int?
    let posterPath: String?
    let voteAverage: Double?
    let popularity: Float?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case popularity
    }
}
