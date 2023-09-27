import Foundation

struct MovieDetails: Codable {
    let id: Int
    let overview: String?
    let releaseDate: String?
    let runtime: Int?
    let productionCountries: [ProductionCountry]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case overview
        case releaseDate = "release_date"
        case runtime
        case productionCountries = "production_countries"
    }
}

struct ProductionCountry: Codable {
    let shortName: String?
    
    private enum CodingKeys: String, CodingKey {
        case shortName = "iso_3166_1"
    }
}
