import Foundation

struct MovieTrailers: Codable {
    let results: [MovieTrailer]?
}

struct MovieTrailer: Codable {
    let key: String?
    let site: String?
}
