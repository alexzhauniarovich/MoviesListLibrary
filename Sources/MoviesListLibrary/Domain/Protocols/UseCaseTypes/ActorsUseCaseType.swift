import Foundation

protocol ActorsUseCaseType {
    
    func getActorDetails(personId: Int) async throws -> MovieActorDetails
}
