import Foundation

struct ActorDetails: Codable {
    let id: Int?
    let name: String?
    let biography: String?
    let actorImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case biography
        case actorImage = "profile_path"
    }
}
