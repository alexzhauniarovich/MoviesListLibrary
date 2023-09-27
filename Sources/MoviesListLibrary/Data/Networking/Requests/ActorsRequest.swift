import Foundation

enum ActorsRequest: Requestable {
    
    case requestActorDetails(personId: Int)
    
    var path: String {
        switch self {
        case .requestActorDetails(let personId): return "/person/\(personId)"
        }
    }
    
    var method: HTTPMethod { .get }
    
    var params: RequestParameter { .none }
}
