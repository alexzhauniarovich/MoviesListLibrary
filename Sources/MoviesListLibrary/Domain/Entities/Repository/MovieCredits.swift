import Foundation

struct MovieCredits: Codable {
    let cast: [MovieCast]?
}

struct MovieCast: Codable {
    let id: Int
    let name: String?
    let profileAvatar: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileAvatar = "profile_path"
    }
}
